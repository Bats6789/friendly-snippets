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
		},
		fmt([[
		#{} {}
		{}
		#endif /* {} {} */
		]], {
			c(1, {
				t('if'),
				t('ifdef'),
				t('ifndef')
			}),
			i(2, '0'),
			i(0, '/* TODO */'),
			rep(1),
			rep(2)
		})
	),

	s({
			trig = '#once',
			name = 'Include once',
			desc = 'Header guard'
		},
		fmt([[
			#ifndef __{header_name}_H__
			#define __{header_name}_H__
			{start}

			#endif /* end of header guard: __{header_name}_H__ */
			]], {
			header_name = f(function(_, _, _)
				return string.upper(vim.fn.expand('%:t:r'))
			end, {}, {}),
			start = i(0),
		}, {
			repeate_duplicate = true
		})
	),

	s({
			trig = '#nocpp',
			name = 'extern C',
			desc = 'Disable C++ name mangling in C headers'
		},
		fmta([[
		#ifdef __cplusplus
		extern "C" {
		#endif
		<>

		#ifdef __cplusplus
		} /* extern "C" */
		#endif
			]], { i(0) })
	),

	s({
		trig = '#err',
		name = '#error',
		desc = '#error snippet'
	}, {
		t('#error "'),
		i(0, 'MSG'),
		t('"')
	}),

	s({
		trig = '#warn',
		name = '#warning',
		desc = '#warning snippet'
	}, {
		t('#warning "'),
		i(0, 'MSG'),
		t('"')
	}),

	s({
			trig = 'if',
			name = 'if',
			desc = '"if" snippet',
		},
		fmta([[
		if (<>) {
		<>
		}<>
			]], {
			i(1, 'true'),
			i(2),
			i(0)
		})
	),

	s({
			trig = 'else',
			name = 'else',
			desc = '"else" snippet',
		},
		fmta([[
		<> {
		<>
		}<>
			]], {
			c(1, {
				t('else'),
				sn(1, {
					t('else if ('),
					i(1, 'true'),
					t(')')
				})
			}),
			i(2),
			i(0)
		})
	),

	s({
			trig = 'switch',
			name = 'switch',
			desc = '"switch" snippet',
		},
		fmta([[
		switch (<>) {<>
		}
			]], {
			i(1, 'expression'),
			i(0)
		})
	),

	s({
			trig = 'case',
			name = 'case',
			desc = '"case" branch'
		},
		fmta([[
		case <>:<>
			]], {
			i(1, '0'),
			i(0)
		})
	),

	s({
			trig = 'default',
			name = 'default',
			desc = '"default" branch'
		},
		t('default:')
	),

	s({
			trig = 'while',
			name = 'while',
			desc = '"while" loop snippet'
		},
		fmta([[
		while (<>) {<>
		}
			]], {
			i(1, 'true'),
			i(0)
		})
	),

	s({
			trig = 'do',
			name = 'do ... while',
			desc = '"do ... while" loop snippet'
		},
		fmta([[
		do {<>
		} while (<>);
			]], {
			i(0),
			i(1, 'false'),
		})
	),

	s({
		trig = 'return',
		name = 'return',
		desc = '"return" snippet',
	}, {
		t('return '),
		i(1, '0'),
		t(';')
	}),

	s({
		trig = 'exit',
		name = 'exit',
		desc = '"exit" snippet',
	}, {
		t('exit('),
		i(1, 'EXIT_FAILURE'),
		t(');')
	}),

	s({
			trig = 'for',
			name = 'for',
			desc = '"for" loop snippets'
		},

		fmta([[
		for (<>) {<>
		}
		]], {
			c(1, {
				sn(nil, fmta('<>;<>;<>', {
					i(1),
					i(2),
					i(3)
				})),
				sn(nil, fmta('<> <> = <>; <> <> <>; <><>', {
					i(1, 'size_t'),
					i(2, 'i'),
					i(3, '0'),
					rep(2),
					c(4, {
						t('<'),
						t('<='),
						t('>'),
						t('>=')
					}),
					i(5, 'count'),
					m(4, '^<.*', '++', '--'),
					rep(2),
				})),
				sn(nil, fmta('<> <> = <>; <> <> <>; <> <> <>', {
					i(1, 'size_t'),
					i(2, 'i'),
					i(3, '0'),
					rep(2),
					c(4, {
						t('<'),
						t('<='),
						t('>'),
						t('>=')
					}),
					i(5, 'count'),
					rep(2),
					m(4, '^<.*', '+=', '-='),
					i(6, '1'),
				})),
			}),
			i(0),
		})
	),

	s({
			trig = 'args',
			name = 'Argument loop',
			desc = '"for" loop for cmdline arguments'
		},
		fmta([[
		for (int <> = <>; <> << argc; ++<>) {<>
		}
			]], {
			i(1, 'i'),
			i(2, '1'),
			rep(1),
			rep(1),
			i(0)
		})
	),

	s({
			trig = 'fun',
			name = 'Function',
			desc = 'Make a function declaration/definition/pointer'
		},
		c(1, {
			sn(nil, fmt('{} {}({})', {
				i(2, 'void'),
				i(1, 'fun'),
				i(3, 'void')
			})),
			sn(nil,
				fmt([[
					{doc}
					{return_type} {name}({params})
					]], {
					return_type = i(2, 'void'),
					name = i(1, 'fun'),
					params = i(3, 'void'),
					doc = d(4, function (args)
							-- local splitArgs = {}
							-- for str in string.gmatch(args, ',') do
							-- 	str = string.gsub(str, "%s+", "")
							-- 	table.insert(splitArgs, str)
							-- end
							--
							-- local nodes = {
							-- 	t({'/**', '* '}),
							-- 	i(1, 'basic description'),
							-- 	t({'', '*'})
							-- }
							--
							-- for index, arg in ipairs(splitArgs) do
							-- 	nodes.insert(t('* @param '..arg))
							-- 	nodes.insert(index + 1)
							-- 	nodes.insert(t({'', ''}))
							-- end
							--
							-- nodes.insert(t('*/'))

							-- return sn(nil, nodes)
							return sn(nil, t(args))
					end, {3}),
				})
			)
		})
	)
}
