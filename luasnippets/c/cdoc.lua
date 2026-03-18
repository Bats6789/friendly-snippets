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

return {
	s({
			trig = "/**",
			desc = "A C comment block for functions in doxygen format.",
			name = "comment"
		},
		fmta([[
		/**
		 <>
		 */
		]], {
			c(1, {
				sn(nil, fmta([[
				* <>
				]], {
					i(0)
				}))
			}),
			c(1, {
				sn(nil, fmta([[
				* <>
				*
				* <><>
				]], {
					i(1, 'A one-line summary.'),
					i(2, 'Description'),
					i(0)
				}))
			}),
			c(1, {
				sn(nil, fmta([[
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
					]], {
					i(1, 'A one-line summary.'),
					i(2, 'Description'),
					i(0),
					i(4, 'name'),
					i(5, 'Type and description of the parameter.'),
					i(3, 'Type and description of the returned value.'),
					i(6, 'Description of my example.'),
					i(7, 'Write me later')
				}))
			})
		})
	),
	s(
	),
}
