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
	}, {
		fmta([[
			/**
			 * <>
			 */<>
			 ]], {
			c(1, {
				sn(nil, fmta([[
						* <>
					]], { i(1) }
				)),
				sn(nil, fmta([[
					* <>
					*
					* <><>
					]],
					{
						i(2, 'A one-line summary.'),
						i(3, 'Description'),
						i(1)
					}
				)),
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
		})
	}),
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
