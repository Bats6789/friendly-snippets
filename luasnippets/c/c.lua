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
					doc = d(4, function(args)
						local splitArgs = {}
						for str in string.gmatch(args[1][1], '[a-z0-9]+%s+[a-z0-9]+') do
							local matches = string.gmatch(str, '%S+')
							local _ = matches()
							str = matches()
							table.insert(splitArgs, str)
						end

						local nodes = {
							t({ '/**', '* ' }),
							i(1, 'basic description'),
							t({ '', '*', '' })
						}

						local jumpCount = 1

						for index, arg in ipairs(splitArgs) do
							table.insert(nodes, t('* @param ' .. arg))
							table.insert(nodes, i(index + 1))
							table.insert(nodes, t({ '', '' }))
							jumpCount = jumpCount + 1;
						end

						if args[2][1] ~= 'void' then
							table.insert(nodes, t('* @returns '))
							table.insert(nodes, i(jumpCount + 1, 'a value'))
							table.insert(nodes, t({ '', '' }))
						end

						table.insert(nodes, t('*/'))

						return sn(nil, nodes)
					end, { 3, 2 }),
				})
			)
		})
	),

	s({
			trig = 'typedef',
			name = 'typedef',
			desc = '"typedef" snippet'
		},
		fmta('typedef <> <>;', { i(1, 'void'), i(2, 'Emptiness') })
	),

	s({
			trig = 'struct',
			name = 'struct',
			desc = '"struct" snippets'
		},
		c(1, {
			sn(nil, fmta('struct <>{ <> };', {
				i(1, 'name_t'),
				i(0, '/* TODO */'),
			})),
			sn(nil, fmta([[
						typedef struct {
						<>
						} <>;
						]], {
				i(0, '/* TODO */'),
				i(1, 'name_t')
			}))
		})
	),

	s({
			trig = 'union',
			name = 'union',
			desc = '"union" snippets'
		},
		c(1, {
			sn(nil, fmta('union <>{ <> };', {
				i(1, 'name_t'),
				i(0, '/* TODO */'),
			})),
			sn(nil, fmta([[
						typedef union {
						<>
						} <>;
						]], {
				i(0, '/* TODO */'),
				i(1, 'name_t')
			}))
		})
	),

	s({
			trig = 'enum',
			name = 'enum',
			desc = '"enum" snippets'
		},
		c(1, {
			sn(nil, fmta('enum <>{ <> };', {
				i(1, 'name_t'),
				i(0, '/* TODO */'),
			})),
			sn(nil, fmta([[
						typedef enum {
						<>
						} <>;
						]], {
				i(0, '/* TODO */'),
				i(1, 'name_t')
			}))
		})
	),

	s({
			trig = 'allocate',
			name = 'allocate',
			desc = 'allocates memory and checks it.'
		},
		c(1, {
			sn(nil, fmta('<> = malloc(sizeof(*<>) * <>);', {
				r(1, 'variable'),
				rep(1),
				r(2, 'size')
			})),
			sn(nil, fmta([[
				<> = malloc(sizeof(*<>) * <>);
				if (<> == NULL) {
					<>
				}
				]], {
				r(1, 'variable'),
				rep(1),
				r(2, 'size'),
				rep(1),
				c(3, {
					sn(nil, i(1, '/* ERROR */')),
					sn(nil, fmta('perror("<>");', r(1, 'err_msg'))),
					sn(nil, fmta('fprintf(<>, "<>");', {
						r(1, 'stream'),
						r(2, 'err_msg')
					})),
					isn(nil, fmta([[
								perror("<>");

									return <>;
							]], {
						r(1, 'err_msg'),
						r(2, 'return_value')
					}), "$PARENT_INDENT"),
					isn(nil, fmta([[
								fprintf(<>, "<>");

									return <>;
							]], {
						r(1, 'stream'),
						r(2, 'err_msg'),
						r(3, 'return_value')
					}), "$PARENT_INDENT"
					),
				})
			}))
		}), {
			stored = {
				['variable'] = i(1, 'var'),
				['size'] = i(1, 'size'),
				['err_msg'] = i(1, 'ERROR'),
				['stream'] = i(1, 'stderr'),
				['return_value'] = i(1, 'EXIT_FAILURE')
			}
		}
	),

	s({
			trig = 'file',
			name = 'File',
			desc = 'File I/O snippet'
		},
		fmta('<> = fopen("<>", "<>");<>', {
			r(1, 'file_pointer', { key = 'file_pointer_key' }),
			r(2, 'file_name'),
			r(3, 'mode'),
			c(4, {
				t(''),
				sn(nil, fmta([[
					<>
					if (<> == NULL) {
						<>
					}
					]], {
					t(''),
					f(function(args)
						return args[1]
					end, k('file_pointer')),
					c(1, {
						sn(nil, i(1, '/* ERROR */')),
						sn(nil, fmta('perror("<>");', r(1, 'err_msg'))),
						sn(nil, fmta('fprintf(<>, "<>");', {
							r(1, 'stream'),
							r(2, 'err_msg')
						})),
						isn(nil, fmta([[
								perror("<>");

									return <>;
							]], {
							r(1, 'err_msg'),
							r(2, 'return_value')
						}), "$PARENT_INDENT"),
						isn(nil, fmta([[
								fprintf(<>, "<>");

									return <>;
							]], {
							r(1, 'stream'),
							r(2, 'err_msg'),
							r(3, 'return_value')
						}), "$PARENT_INDENT"
						),
					})
				}))
			})
		}),
		{
			stored = {
				['file_pointer'] = i(1, 'file'),
				['file_name'] = i(1, 'FILE_NAME'),
				['mode'] = c(1, { t('r'), t('r'), t('w'), t('a'), t('r+'), t('w+'), t('a+') }),
				['err_msg'] = i(1, 'ERROR'),
				['stream'] = i(1, 'stderr'),
				['return_value'] = i(1, 'EXIT_FAILURE')
			}
		}
	)
}
