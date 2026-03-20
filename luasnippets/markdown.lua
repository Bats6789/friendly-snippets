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
		trig = "h1",
		name = "header 1",
		desc = "Add header level 1"
	}, {
		t("# "), i(0),
	}),
	s({
		trig = "h2",
		name = "header 2",
		desc = "Add header level 2"
	}, {
		t("## "), i(0),
	}),
	s({
		trig = "h3",
		name = "header 3",
		desc = "Add header level 3"
	}, {
		t("### "), i(0),
	}),
	s({
		trig = "h4",
		name = "header 4",
		desc = "Add header level 4"
	}, {
		t("#### "), i(0),
	}),
	s({
		trig = "h5",
		name = "header 5",
		desc = "Add header level 5"
	}, {
		t("##### "), i(0),
	}),
	s({
		trig = "h6",
		name = "header 6",
		desc = "Add header level 6"
	}, {
		t("###### "), i(0),
	}),
	s({
			trig = "link",
			name = "Links",
			desc = "Add links"
		},
		fmt("[{}]({}) {}", { i(1, 'text'), i(2, 'url'), i(0) })
	),
	s({
			trig = "url",
			name = "URLS",
			desc = "Add urls"
		},
		fmt("<{}> {}", { i(1), i(0) })
	),
	s({
			trig = "img",
			name = "Images",
			desc = "Add images"
		},
		fmt("![{}]({}) {}", { i(1, 'alt text'), i(2, 'path'), i(0) })
	),
	s({
			trig = "strikethrough",
			name = "Insert strikethrough",
			desc = "Insert strikethrough"
		},
		fmt("~~{}~~ {}", { i(1), i(0) })
	),
	s({
			trig = "bold",
			name = "Insert bold text",
			desc = "Insert bold text"
		},
		fmt("**{}** {}", { i(1), i(0) })
	),
	s({
			trig = "italic",
			name = "Insert italic text",
			desc = "Insert italic text"
		},
		fmt("*{}* {}", { i(1), i(0) })
	),
	s({
			trig = "bold and italic",
			name = "Insert bold and italic text",
			desc = "Insert bold and italic text"
		},
		fmt("***{}*** {}", { i(1), i(0) })
	),
	s({
			trig = "quote",
			name = "Insert quoted text",
			desc = "Insert quoted text"
		},
		t("> "), i(0)
	),
	s({
			trig = "code",
			name = "Insert code",
			desc = "Insert code"
		},
		fmt("`${}` {}", { i(1), i(0) })
	),
	s({
		trig = "codeblock",
		name = "Insert code block",
		desc = "Insert fenced code block"
	}, fmt([[
		```{}
		{}
		```{}
		]], {
		i(1, 'language'), i(2), i(0)
	})),
	s({
		trig = "unordered list",
		name = "Insert unordered list",
		desc = "Insert unordered list"
	}, fmt([[
		- {}
		- {}
		- {}
		{}
		]], {
		i(1, 'first'),
		i(2, 'second'),
		i(3, 'third'),
		i(0)
	})),
	s({
		trig = "ordered list",
		name = "Insert ordered list",
		desc = "Insert ordered list"
	}, fmt([[
			1. {}
			2. {}
			3. {}
			{}
		]], {
		i(1, 'first'),
		i(2, 'second'),
		i(3, 'third'),
		i(0)
	})),
	s({
		trig = "horizontal rule",
		name = "Insert horizontal rule",
		desc = "Insert horizontal rule"
	}, t({ "----------", "" })),
	s({
			trig = "task",
			name = "Insert task list",
			desc = "Insert task list"
		},
		fmt([[
			- [{}] {}
			{}
		]], {
			c(1, { t(' '), t('x') }),
			i(2, 'text'),
			i(0)
		})
	),
	s({
			trig = "task2",
			name = "Insert task list 2",
			desc = "Insert task list with 2 tasks"
		},
		fmt([[
			- [{}] {}
			- [{}] {}
			{}
		]], {
			c(1, { t(' '), t('x') }),
			i(2, 'text'),
			c(3, { t(' '), t('x') }),
			i(4, 'text'),
			i(0)
		})
	),
	s({
			trig = "task3",
			name = "Insert task list 3",
			desc = "Insert task list with 3 tasks"
		},
		fmt([[
			- [{}] {}
			- [{}] {}
			- [{}] {}
			{}
		]], {
			c(1, { t(' '), t('x') }),
			i(2, 'text'),
			c(3, { t(' '), t('x') }),
			i(4, 'text'),
			c(5, { t(' '), t('x') }),
			i(6, 'text'),
			i(0)
		})
	),
	s({
			trig = "task4",
			name = "Insert task list 4",
			desc = "Insert task list with 4 tasks"
		},
		fmt([[
			- [{}] {}
			- [{}] {}
			- [{}] {}
			- [{}] {}
			{}
		]], {
			c(1, { t(' '), t('x') }),
			i(2, 'text'),
			c(3, { t(' '), t('x') }),
			i(4, 'text'),
			c(5, { t(' '), t('x') }),
			i(6, 'text'),
			c(7, { t(' '), t('x') }),
			i(8, 'text'),
			i(0)
		})
	),
	s({
			trig = "task5",
			name = "Insert task list 5",
			desc = "Insert task list with 5 tasks"
		},
		fmt([[
			- [{}] {}
			- [{}] {}
			- [{}] {}
			- [{}] {}
			- [{}] {}
			{}
		]], {
			c(1, { t(' '), t('x') }),
			i(2, 'text'),
			c(3, { t(' '), t('x') }),
			i(4, 'text'),
			c(5, { t(' '), t('x') }),
			i(6, 'text'),
			c(7, { t(' '), t('x') }),
			i(8, 'text'),
			c(9, { t(' '), t('x') }),
			i(10, 'text'),
			i(0)
		})
	),
	s({
			trig = "table",
			name = "Insert table",
			desc = "Insert table with 2 rows and 3 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} |
			| ------------- | -------------- | -------------- |
			| {} | {} | {} |
			{}
			]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'),
			i(4, 'Item1'), i(5, 'Item1'), i(6, 'Item1'),
			i(0)
		})
	),
	s({
			trig = "2x1table",
			name = "Insert 2x1 table",
			desc = "Insert table with 2 rows and 1 column. First row is heading."
		},
		fmt([[
			| {} |
			| ------------- |
			| {} |
			{}
			]], {
			i(1, 'Column1'),
			i(2, 'Item1'),
			i(0)
		})
	),
	s({
			trig = "3x1table",
			name = "Insert 3x1 table",
			desc = "Insert table with 3 rows and 1 column. First row is heading."
		},
		fmt([[
			| {} |
			| ------------- |
			| {} |
			| {} |
			{}
			]], {
			i(1, 'Column1'),
			i(2, 'Item1'),
			i(3, 'Item2'),
			i(0)
		})
	),
	s({
			trig = "4x1table",
			name = "Insert 4x1 table",
			desc = "Insert table with 4 rows and 1 column. First row is heading."
		},
		fmt([[
			| {} |
			| ------------- |
			| {} |
			| {} |
			| {} |
			{}
			]], {
			i(1, 'Column1'),
			i(2, 'Item1'),
			i(3, 'Item2'),
			i(4, 'Item3'),
			i(0)
		})),
	s({
			trig = "5x1table",
			name = "Insert 5x1 table",
			desc = "Insert table with 5 rows and 1 column. First row is heading."
		},
		fmt([[
			| {} |
			| ------------- |
			| {} |
			| {} |
			| {} |
			| {} |
			{}
			]], {
			i(1, 'Column1'),
			i(2, 'Item1'),
			i(3, 'Item2'),
			i(4, 'Item3'),
			i(5, 'Item4'),
			i(0)
		})),
	s({
			trig = "2x2table",
			name = "Insert 2x2 table",
			desc = "Insert table with 2 rows and 2 columns. First row is heading."
		},
		fmt([[
			| {} | {} |
			| -------------- | --------------- |
			| {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'),
			i(3, 'Item1.1'), i(4, 'Item2.1'),
			i(0)
		})),
	s({
			trig = "3x2table",
			name = "Insert 3x2 table",
			desc = "Insert table with 3 rows and 2 columns. First row is heading."
		},
		fmt([[
			| {} | {} |
			| -------------- | --------------- |
			| {} | {} |
			| {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'),
			i(3, 'Item1.1'), i(4, 'Item2.1'),
			i(5, 'Item1.2'), i(6, 'Item2.2'),
			i(0)
		})),
	s({
			trig = "4x2table",
			name = "Insert 4x2 table",
			desc = "Insert table with 4 rows and 2 columns. First row is heading."
		},
		fmt([[
			| {} | {} |
			| -------------- | --------------- |
			| {} | {} |
			| {} | {} |
			| {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'),
			i(3, 'Item1.1'), i(4, 'Item2.1'),
			i(5, 'Item1.2'), i(6, 'Item2.2'),
			i(7, 'Item1.3'), i(8, 'Item2.3'),
			i(0)
		})),
	s({
		trig = "5x2table",
		name = "Insert 5x2 table",
		desc = "Insert table with 5 rows and 2 columns. First row is heading."
	}, fmt([[
			| {} | {} |
			| -------------- | --------------- |
			| {} | {} |
			| {} | {} |
			| {} | {} |
			| {} | {} |
			{}
		]], {
		i(1, 'Column1'), i(2, 'Column2'),
		i(3, 'Item1.1'), i(4, 'Item2.1'),
		i(5, 'Item1.2'), i(6, 'Item2.2'),
		i(7, 'Item1.3'), i(8, 'Item2.3'),
		i(9, 'Item1.4'), i(10, 'Item2.4'),
		i(0)
	})),
	s({
			trig = "2x3table",
			name = "Insert 2x3 table",
			desc = "Insert table with 2 rows and 3 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} |
			| --------------- | --------------- | --------------- |
			| {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'),
			i(4, 'Item1.1'), i(5, 'Item2.1'), i(6, 'Item3.1'),
			i(0)
		})),
	s({
			trig = "3x3table",
			name = "Insert 3x3 table",
			desc = "Insert table with 3 rows and 3 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} |
			| --------------- | --------------- | --------------- |
			| {} | {} | {} |
			| {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'),
			i(4, 'Item1.1'), i(5, 'Item2.1'), i(6, 'Item3.1'),
			i(7, 'Item1.2'), i(8, 'Item2.2'), i(9, 'Item3.2'),
			i(0)
		})),
	s({
			trig = "4x3table",
			name = "Insert 4x3 table",
			desc = "Insert table with 4 rows and 3 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} |
			| --------------- | --------------- | --------------- |
			| {} | {} | {} |
			| {} | {} | {} |
			| {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'),
			i(4, 'Item1.1'), i(5, 'Item2.1'), i(6, 'Item3.1'),
			i(7, 'Item1.2'), i(8, 'Item2.2'), i(9, 'Item3.2'),
			i(10, 'Item1.3'), i(11, 'Item2.3'), i(12, 'Item3.3'),
			i(0)
		})),
	s({
			trig = "5x3table",
			name = "Insert 5x3 table",
			desc = "Insert table with 5 rows and 3 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} |
			| --------------- | --------------- | --------------- |
			| {} | {} | {} |
			| {} | {} | {} |
			| {} | {} | {} |
			| {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'),
			i(4, 'Item1.1'), i(5, 'Item2.1'), i(6, 'Item3.1'),
			i(7, 'Item1.2'), i(8, 'Item2.2'), i(9, 'Item3.2'),
			i(10, 'Item1.3'), i(11, 'Item2.3'), i(12, 'Item3.3'),
			i(13, 'Item1.4'), i(14, 'Item2.4'), i(15, 'Item3.4'),
			i(0)
		})),
	s({
			trig = "2x4table",
			name = "Insert 2x4 table",
			desc = "Insert table with 2 rows and 4 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'),
			i(5, 'Item1.1'), i(6, 'Item2.1'), i(7, 'Item3.1'), i(8, 'Item4.1'),
			i(0)
		})),
	s({
		trig = "3x4table",
		name = "Insert 3x4 table",
		desc = "Insert table with 3 rows and 4 columns. First row is heading."
	}, fmt([[
			| {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			{}
		]], {
		i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'),
		i(5, 'Item1.1'), i(6, 'Item2.1'), i(7, 'Item3.1'), i(8, 'Item4.1'),
		i(9, 'Item1.2'), i(10, 'Item2.2'), i(11, 'Item3.2'), i(12, 'Item4.2'),
		i(0)
	})),
	s({
			trig = "4x4table",
			name = "Insert 4x4 table",
			desc = "Insert table with 4 rows and 4 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'),
			i(5, 'Item1.1'), i(6, 'Item2.1'), i(7, 'Item3.1'), i(8, 'Item4.1'),
			i(9, 'Item1.2'), i(10, 'Item2.2'), i(11, 'Item3.2'), i(12, 'Item4.2'),
			i(13, 'Item1.3'), i(14, 'Item2.3'), i(15, 'Item3.3'), i(16, 'Item4.3'),
			i(0)
		})),
	s({
			trig = "5x4table",
			name = "Insert 5x4 table",
			desc = "Insert table with 5 rows and 4 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			| {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'),
			i(5, 'Item1.1'), i(6, 'Item2.1'), i(7, 'Item3.1'), i(8, 'Item4.1'),
			i(9, 'Item1.2'), i(10, 'Item2.2'), i(11, 'Item3.2'), i(12, 'Item4.2'),
			i(13, 'Item1.3'), i(14, 'Item2.3'), i(15, 'Item3.3'), i(16, 'Item4.3'),
			i(17, 'Item1.4'), i(18, 'Item2.4'), i(19, 'Item3.4'), i(20, 'Item4.4'),
			i(0)
		})),
	s({
			trig = "2x5table",
			name = "Insert 2x5 table",
			desc = "Insert table with 2 rows and 5 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'), i(5, 'Column5'),
			i(6, 'Item1.1'), i(7, 'Item2.1'), i(8, 'Item3.1'), i(9, 'Item4.1'), i(10, 'Item5.1'),
			i(0)
		})),
	s({
			trig = "3x5table",
			name = "Insert 3x5 table",
			desc = "Insert table with 3 rows and 5 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'), i(5, 'Column5'),
			i(6, 'Item1.1'), i(7, 'Item2.1'), i(8, 'Item3.1'), i(9, 'Item4.1'), i(10, 'Item5.1'),
			i(11, 'Item1.2'), i(12, 'Item2.2'), i(13, 'Item3.2'), i(14, 'Item4.2'), i(15, 'Item5.2'),
			i(0)
		})),
	s({
			trig = "4x5table",
			name = "Insert 4x5 table",
			desc = "Insert table with 4 rows and 5 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'), i(5, 'Column5'),
			i(6, 'Item1.1'), i(7, 'Item2.1'), i(8, 'Item3.1'), i(9, 'Item4.1'), i(10, 'Item5.1'),
			i(11, 'Item1.2'), i(12, 'Item2.2'), i(13, 'Item3.2'), i(14, 'Item4.2'), i(15, 'Item5.2'),
			i(16, 'Item1.3'), i(17, 'Item2.3'), i(18, 'Item3.3'), i(19, 'Item4.3'), i(20, 'Item5.3'),
			i(0)
		})),
	s({
			trig = "5x5table",
			name = "Insert 5x5 table",
			desc = "Insert table with 5 rows and 5 columns. First row is heading."
		},
		fmt([[
			| {} | {} | {} | {} | {} |
			| --------------- | --------------- | --------------- | --------------- | --------------- |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			| {} | {} | {} | {} | {} |
			{}
		]], {
			i(1, 'Column1'), i(2, 'Column2'), i(3, 'Column3'), i(4, 'Column4'), i(5, 'Column5'),
			i(6, 'Item1.1'), i(7, 'Item2.1'), i(8, 'Item3.1'), i(9, 'Item4.1'), i(10, 'Item5.1'),
			i(11, 'Item1.2'), i(12, 'Item2.2'), i(13, 'Item3.2'), i(14, 'Item4.2'), i(15, 'Item5.2'),
			i(16, 'Item1.3'), i(17, 'Item2.3'), i(18, 'Item3.3'), i(19, 'Item4.3'), i(20, 'Item5.3'),
			i(21, 'Item1.4'), i(22, 'Item2.4'), i(23, 'Item3.4'), i(24, 'Item4.4'), i(25, 'Item5.4'),
			i(0)
		})),
	s({
		trig = "sub",
		name = "Insert subscript",
		desc = "Create a subscript."
	}, {
		i(1), t("<sub>"), i(0),
	}),
	s({
		trig = "sup",
		name = "Insert superscript",
		desc = "Create a superscript."
	}, {
		i(1), t("<sup>"), i(0),
	}),
	s({
			trig = "note",
			name = "Insert Note",
			desc = "Insert Note"
		},
		t({ "> [!NOTE]", "> " })
	),
	s({
			trig = "tip",
			name = "Insert Tip",
			desc = "Insert Tip"
		},
		t({ "> [!TIP]", "> " })
	),
	s({
			trig = "important",
			name = "Insert Important",
			desc = "Insert Important"
		},
		t({ "> [!IMPORTANT]", "> " })
	),
	s({
		trig = "warning",
		name = "Insert Warning",
		desc = "Insert Warning"
	}, t({ "> [!WARNING]", "> " })),
	s({
			trig = "caution",
			name = "Insert Caution",
			desc = "Insert Caution"
		},
		t({ "> [!CAUTION]", "> " })
	)
}
