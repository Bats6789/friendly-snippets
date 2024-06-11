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
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
	s({
			trig = '/',
			name = 'Comment block',
			desc = 'Convenient comment block'
		},
		fmt('/*{} */', { i(0) })
	),

	s({
			trig = '//',
			name = 'Multiline comment',
			desc = 'Convenient multiline comment'
		},
		fmt([[
		/*{}
		*/
			]], { i(0) })
	),

	s({
			trig = 'st',
			name = 'Starter Template',
			desc = 'Standard starter templates'
		},
		fmta([[
			<>

			int main(<>) {
				<>
				return <>;
			}
			]],
			{ c(1, {
				t('#include <stdio.h>'),
				t({ '#include <stdio.h>', '#include <stdlib.h>' })
			}),
				c(2, {
					t('int argc, char **argv'),
					t('void')
				}),
				i(0),
				m(1, '.*stdlib.*', 'EXIT_SUCCESS', '0')
			}
		)
	),

	s({
			trig = 'main',
			name = 'main template',
			desc = 'Standard main template'
		},
		fmta([[
		int main(<>) {
			<>
			return <>;
		}
	]],
			{
				c(1, {
					t('int argc, char **argv'),
					t('void')
				}),
				i(0),
				c(2, {
					t('0'),
					t('EXIT_SUCCESS')
				}),
				-- f(function(_, _, _)
				-- 	return 'todo'
				-- end, {}, {})
			}
		)
	),

	s({
		trig = '#inc',
		name = '#Include',
		desc = '#Include snippet',
	}, {
		t('#include '),
		c(1, {
			sn(nil, { t('<'), r(1, 'header_name'), t('>') }),
			sn(nil, { t('"'), r(1, 'header_name'), t('"') }),
		}),
	}, {
		stored = {
			['header_name'] = i(1, '...')
		}
	}),

	s({
		trig = '#def',
		name = '#define macro',
		desc = 'Macro snippet'
	}, {
		t('#define '),
		c(1, {
			sn(nil, { r(1, 'macro_name') }),
			sn(nil, { r(1, 'macro_name'), t('('), i(2), t(') ('), i(3), t(')') })
		})
	}, {
		stored = {
			['macro_name'] = i(1, 'MACRO')
		}
	}),

	s({
		trig = '#if',
		name = '#if macro',
		desc = '#if snippet'
	}, {
		fmt([[
		#if {cond}
		{statement}
		#endif /* if {cond} */
		]], {
			cond = i(1, '0'),
			statement = i(0, '/* TODO */')
		}, {
			repeat_duplicate = true
		})
	})
}
