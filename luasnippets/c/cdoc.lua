local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep
local m = extras.match
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local k = require("luasnip.nodes.key_indexer").new_key

local param_count = 0;

local function get_nearest_func_node()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local query = vim.treesitter.query.parse(vim.bo.filetype, [[
	  (function_declarator) @function
	]])

	local node = vim.treesitter.get_node()

	if not node then
		return nil
	end

	for id, captured_node in query:iter_captures(node, 0, row) do
		local capture_name = query.captures[id]
		if capture_name == 'function' then
			return captured_node
		end
	end

	return nil
end

local function get_identifier_name(node)
	local query = vim.treesitter.query.parse(vim.bo.filetype, [[
		(identifier) @name
	]])

	for id, captured_node in query:iter_captures(node, 0) do
		local capture_name = query.captures[id]
		if capture_name == 'name' then
			return vim.treesitter.get_node_text(captured_node, 0)
		end
	end
end

local function get_ts_func_name()
	local node = get_nearest_func_node()
	if node then
		return get_identifier_name(node)
	else
		return "function_name"
	end
end

local function get_ts_param_names()
	local results = {}
	local query = vim.treesitter.query.parse(vim.bo.filetype, [[
		  (parameter_declaration) @param
	]])

	local node = get_nearest_func_node()

	if not node then
		return results
	end

	for id, captured_node in query:iter_captures(node, 0) do
		local capture_name = query.captures[id]
		if capture_name == 'param' then
			local name = get_identifier_name(captured_node)
			table.insert(results, name)
		end
	end

	return results
end

local function get_ts_func_type_name()
	local node = get_nearest_func_node()

	if not node then
		return ''
	end

	local check_node = node:prev_sibling();

	if not check_node then
		return ''
	end

	local name = vim.treesitter.get_node_text(check_node, 0)
	if name ~= 'void' then
		return name
	end

	return ''
end

return {
	s({
			trig = "/**",
			desc = "A C comment block for functions in doxygen format.",
			name = "comment"
		},
		{
			c(1, {
				sn(nil, fmta([[
					/**
					 * <>
					 */
					]], { i(1) }
				)),
				sn(nil, fmta([[
					/**
					 * @brief <>
					 *
					 * <><><>
					 */
				]], {
					i(1, 'Brief description of the function'),
					i(2, 'Description'),
					d(3, function()
						local params = get_ts_param_names()
						local nodes = {}
						param_count = #params

						if param_count == 0 then
							return sn(nil, t(''))
						end

						table.insert(nodes, t({'', ' * '}))

						for index = 1, param_count do
							local param = params[index]
							table.insert(nodes, t({'', ' * @param ' .. param .. ' '}))
							table.insert(nodes, i(index, 'Details for param: ' .. param))
						end

						return sn(nil, nodes)
					end, {}),
					d(4, function()
						local type_name = get_ts_func_type_name()
						local nodes = {}

						if type_name ~= '' then
							if param_count == 0 then
								table.insert(nodes, t({'', ' * '}))
							end

							table.insert(nodes, t({'', ' * @return '}))
							table.insert(nodes, i(1, 'Description of return value'))

							return sn(nil, nodes)
						end

						return sn(nil, t(''))
					end, {})
				})),
				sn(nil, fmta([[
						/**
						 * <>
						 *
						 * <><>
						 */
					]],
					{
						i(2, 'A one-line summary.'),
						i(3, 'Description'),
						i(1)
					}
				)),
				sn(nil, fmta([[
						/**
						 * <>
						 *
						 * <><>
						 *
						 * @param <> <>
						 * @return <>
						 *
						 * @example
						 * // <>
						 * <>
						 */
					]],
					{
						i(2, 'A one-line summary.'),
						i(3, 'Description'),
						i(1),
						i(5, 'name'),
						i(6, 'Type and description of the parameter.'),
						i(4, 'Type and description of the returned value.'),
						i(7, 'Description of my example.'),
						i(8, 'Write me later')
					}
				))
			}),
			i(0),
		}
	),
	s({
			trig = "@param",
			desc = "Type and description of a function parameter.",
			name = "@param"
		},
		fmta('@param <> <><>', {
			i(1, 'name'), i(2, 'Type and description of the parameter.'), i(0)
		})
	),
	s({
			trig = "@return",
			desc = "Type and description of the returned value.",
			name = "@return"
		},
		fmta('@return <><>', {
			i(1, 'Type and description'), i(0)
		})
	),
	s({
			trig = "@example",
			desc = "Example that demostrates how to use a function. It can be used several times.",
			name = "@example"
		},
		fmta([[
		* @example
		* // <><>
		* <>
		]], {
			i(1, 'Description of my example.'), i(2, 'Write me later'), i(0)
		})
	),
	s({
			trig = "@note",
			desc = "Anything worth mentioning that wouldn't fit in the description, or other documentation tags.",
			name = "@note"
		},
		fmta('@note <><>', {
			i(1, 'Text.'), i(0)
		})
	),
	s({
			trig = "@warning",
			desc = "Indicates special considerations when using the function.",
			name = "@warning"
		},
		fmta('@warning <><>', {
			i(1, 'Text.'), i(0)
		})
	),
	s({
			trig = "@see",
			desc = "References another function, or piece of documentation.",
			name = "@see"
		},
		fmta('@see <><>', {
			i(1, 'Text.'), i(0)
		})
	),
	s({
			trig = "@deprecated",
			desc = "Marks the function as deprecated, and no longer recommended for use.",
			name = "@deprecated"
		},
		fmta('@deprecated <><>', {
			i(1, 'Text.'), i(0)
		})
	),
	s({
			trig = "@todo",
			desc = "Used to mark areas of the code that require improvement.",
			name = "@todo"
		},
		fmta('@todo <><>', {
			i(1, 'Text.'), i(0)
		})
	),
	s({
			trig = "@fixme",
			desc = "Used to mark areas of the code that require fixing.",
			name = "@fixme"
		},
		fmta('@fixme <><>', {
			i(1, 'Text.'), i(0)
		})
	),
}
