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
			trig = 'doctype',
			name = 'doctype',
			desc = 'HTML - Defines the document type'
		},
		c(1, {
			t('<!DOCTYPE>'),
			sn(nil, fmt('<!DOCTYPE {}>', i(1, 'html')))
		})
	),

	s({
			trig = 'a',
			name = 'a',
			desc = 'HTML - Defines a hyperlink',
		},
		c(1, {
			sn(nil, fmt('<a>{}</a>', i(1))),
			sn(nil, fmt('<a href="{}">{}</a>', { i(1), i(2, 'link') }))
		})
	),

	s({
			trig = 'abbr',
			name = 'abbr',
			desc = 'HTML - Defines an abbreviation'
		},
		c(1, {
			sn(nil, fmt('<abbr>{}</abbr>', i(1))),
			sn(nil, fmt('<abbr title="{}">{}</abbr>', { i(1), i(2) }))
		})
	),

	s({
			trig = 'address',
			name = 'address',
			desc = 'HTML - Defines an addresss element'
		},
		fmt([[
			<address>
			{}
			</address>
			]], i(1))
	),

	s({
			trig = 'area',
			name = 'area',
			desc = 'HTML - Defines an area inside an image map'
		},
		c(1, {
			sn(nil, fmt('<area{}>', i(1))),
			sn(nil, fmt('<area shape="{}" coords="{}" href="{}" alt="{}">', {
				i(1),
				i(2),
				i(3),
				i(4)
			}))
		})
	),

	s({
			trig = 'article',
			name = 'article',
			desc = 'HTML - Defines an article',
		},
		fmt([[
			<article>
			{}
			</article>
			]], i(1))
	),

	s({
			trig = 'aside',
			name = 'aside',
			desc = 'HTML - Defines content aside from the page content'
		},
		fmt([[
			<aside>
			{}
			</aside>
			]], i(1))
	),


	s({
			trig = 'audio',
			name = 'audio',
			desc = 'HTML - Defines sounds content',
		},
		fmt([[
				<audio controls>
				{}
				</audio>
				]], i(1))
	),

	s({
			trig = 'b',
			name = 'b',
			desc = 'HTML - Defines bold text',
		},
		fmt('<b>{}</b>', i(1))
	),

	s({
			trig = 'base',
			name = 'base',
			desc = 'HTML - Defines a base URL for all the links in a page',
		},
		c(1, {
			sn(nil, fmt('<base{}>', i(1))),
			sn(nil, fmt('<base href="{}" target="{}">', { i(1), i(2) }))
		})
	),

	s({
			trig = 'bdi',
			name = 'bdi',
			desc = 'HTML - Used to isolate text that is of unknown directionality',
		},
		fmt('<bdi>{}</bdi>', i(1))
	),

	s({
			trig = 'bdo',
			name = 'bdo',
			desc = 'HTML - Defines the direction of text display',
		},
		fmt([[
			<bdo dir="{}">
				{}
			</bdo>
			]], { i(1), i(2) })
	),

	s({
			name = 'big',
			trig = 'big',
			desc = 'HTML - Used to make text bigger',
		},
		fmt('<big>{}</big>', i(1))
	),

	s({
			trig = 'blockquote',
			name = 'blockquote',
			desc = 'HTML - Defines a long quotation',
		},
		c(1, {
			fmt([[
					<blockquote{}>
						{}
					</blockquote>
				]], { i(2), i(1) }),
			fmt([[
					<blockquote cite="{}">
						{}
					</blockquote>
				]], { i(2), i(1) })
		})
	),


	s({
		trig = 'body',
		name = 'body',
		desc = 'HTML - Defines the body element',
	}, fmt([[
				<body>
					{}
				</body>
				]], i(0))
	),

	s({
		trig = 'br',
		name = 'br',
		desc = 'HTML - Inserts a single line break',
	}, t('<br>')
	),

	s({
		trig = 'button',
		name = 'button',
		desc = 'HTML - Defines a push button',
	}, fmt('<button type="{}">{}</button>', { i(1), i(2) })
	),

	s({
		trig = 'canvas',
		name = 'canvas',
		desc = 'HTML - Defines graphics',
	}, fmt('<canvas id="{}">{}</canvas>', { i(1), i(2) })
	),

	s({
		trig = 'caption',
		name = 'caption',
		desc = 'HTML - Defines a table caption',
	}, fmt('<caption>{}</caption>', i(1))
	),

	s({
		trig = 'cite',
		name = 'cite',
		desc = 'HTML - Defines a citation',
	}, fmt('<cite>{}</cite>', i(1))
	),

	s({
		trig = 'code',
		name = 'code',
		desc = 'HTML - Defines computer code text',
	}, fmt('<code>{}</code>', i(1))
	),

	s({
		trig = 'col',
		name = 'col',
		desc = 'HTML - Defines attributes for table columns',
	}, t('<col>')
	),

	s({
		trig = 'colgroup',
		name = 'colgroup',
		desc = 'HTML - Defines group of table columns',
	}, fmt([[
				<colgroup>
					{}
				</colgroup>
				]], i(1))
	),

	s({
		trig = 'command',
		name = 'command',
		desc = 'HTML - Defines a command button [not supported]',
	}, fmt('<command>{}</command>', i(1))
	),

	s({
		trig = 'datalist',
		name = 'datalist',
		desc = 'HTML - Defines a dropdown list',
	}, fmt([[
				<datalist>
					{}
				</datalist>
				]], i(1))
	),

	s({
		trig = 'dd',
		name = 'dd',
		desc = 'HTML - Defines a definition description',
	}, fmt('<dd>{}</dd>', i(1))
	),

	s({
		trig = 'del',
		name = 'del',
		desc = 'HTML - Defines deleted text',
	}, fmt('<del>{}</del>', i(1))
	),

	s({
		trig = 'details',
		name = 'details',
		desc = 'HTML - Defines details of an element',
	}, fmt([[
				<details>
				{}
				</details>
				]], i(1))
	),

	s({
		trig = 'dialog',
		name = 'dialog',
		desc = 'HTML - Defines a dialog (conversation)',
	}, fmt('<dialog>{}</dialog>', i(1))
	),

	s({
		trig = 'dfn',
		name = 'dfn',
		desc = 'HTML - Defines a definition term',
	}, fmt('<dfn>{}</dfn>', i(1))
	),

	s({
			trig = 'div',
			name = 'div',
			desc = 'HTML - Defines a section in a document',
		},
		c(1, {
			sn(nil,
				fmt([[
					<div>
						{}
					</div>
					]], i(1))
			),
			sn(nil,
				fmt([[
					<div class="{}">
						{}
					</div>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<div id="{}">
						{}
					</div>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<div class="{}" id="{}">
						{}
					</div>
					]], { i(2), i(3), i(1) })
			)
		})
	),

	s({
		trig = 'dl',
		name = 'dl',
		desc = 'HTML - Defines a definition list',
	}, fmt([[
				<dl>
					{}
				</dl>
				]], i(1))
	),

	s({
		trig = 'dt',
		name = 'dt',
		desc = 'HTML - Defines a definition term',
	}, fmt('<dt>{}</dt>', i(1))
	),

	s({
		trig = 'em',
		name = 'em',
		desc = 'HTML - Defines emphasized text',
	}, fmt('<em>{}</em>', i(1))
	),

	s({
		trig = 'embed',
		name = 'embed',
		desc = 'HTML - Defines external interactive content ot plugin',
	}, fmt('<embed src="{}">', i(1))
	),

	s({
		trig = 'fieldset',
		name = 'fieldset',
		desc = 'HTML - Defines a fieldset',
	}, fmt([[
			<fieldset>
				{}
			</fieldset>
			]], i(1))
	),

	s({
		trig = 'figcaption',
		name = 'figcaption',
		desc = 'HTML - Defines a caption for a figure',
	}, fmt('<figcaption>{}</figcaption>', i(1))
	),

	s({
		trig = 'figure',
		name = 'figure',
		desc = 'HTML - Defines a group of media content, and their caption',
	}, fmt([[
					<figure>
						{}
					</figure>
					]], i(1))
	),

	s({
		trig = 'footer',
		name = 'footer',
		desc = 'HTML - Defines a footer for a section or page',
	}, fmt([[
				<footer>
					{}
				</footer>
				]], i(1))
	),

	s({
		trig = 'form',
		name = 'form',
		desc = 'HTML - Defines a form',
	}, fmt([[
				<form>
					{}
				</form>
				]], i(1))
	),

	s({
			trig = 'h1',
			name = 'h1',
			desc = 'HTML - Defines header 1',
		},
		c(1, {
			sn(nil, fmt('<h1>{}</h1>', i(1))),
			sn(nil, fmt([[
							<h1>
								{}
							</h1>
						]], i(1)))
		})
	),
	s({
			trig = 'h2',
			name = 'h2',
			desc = 'HTML - Defines header 2',
		},
		c(1, {
			sn(nil, fmt('<h2>{}</h2>', i(1))),
			sn(nil, fmt([[
							<h2>
								{}
							</h2>
						]], i(1)))
		})
	),
	s({
			trig = 'h3',
			name = 'h3',
			desc = 'HTML - Defines header 3',
		},
		c(1, {
			sn(nil, fmt('<h3>{}</h3>', i(1))),
			sn(nil, fmt([[
							<h3>
								{}
							</h3>
						]], i(1)))
		})
	),
	s({
			trig = 'h4',
			name = 'h4',
			desc = 'HTML - Defines header 4',
		},
		c(1, {
			sn(nil, fmt('<h4>{}</h4>', i(1))),
			sn(nil, fmt([[
							<h4>
								{}
							</h4>
						]], i(1)))
		})
	),
	s({
			trig = 'h5',
			name = 'h5',
			desc = 'HTML - Defines header 5',
		},
		c(1, {
			sn(nil, fmt('<h5>{}</h5>', i(1))),
			sn(nil, fmt([[
							<h5>
								{}
							</h5>
						]], i(1)))
		})
	),
	s({
			trig = 'h6',
			name = 'h6',
			desc = 'HTML - Defines header 6',
		},
		c(1, {
			sn(nil, fmt('<h6>{}</h6>', i(1))),
			sn(nil, fmt([[
							<h6>
								{}
							</h6>
						]], i(1)))
		})
	),
	s({
		trig = 'head',
		name = 'head',
		desc = 'HTML - Defines information about the document',
	}, fmt([[
		<head>
			{}
		</head>
		]], i(1))
	),

	s({
		trig = 'header',
		name = 'header',
		desc = 'HTML - Defines a header for a section of page',
	}, fmt([[
		<header>
			{}
		</header>
		]], i(1))
	),
	s({
		trig = 'hgroup',
		name = 'hgroup',
		desc = 'HTML - Defines information about a section in a document',
	}, fmt([[
		<hgroup>
			{}
		</hgroup>
		]], i(1))
	),
	s({
		trig = 'hr',
		name = 'hr',
		desc = 'HTML - Defines a horizontal rule',
	}, t('<hr>')
	),
	s({
			trig = 'html',
			name = 'html',
			desc = 'HTML - Defines an html document',
		},
		c(1, {
			sn(nil, fmt([[
							<html>
								{}
							</html>
						]], i(1))),
			sn(nil, fmt([[
							<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
								{}
							</html>
						]], i(1)))
		})
	),
	s({
		trig = 'sst',
		name = 'Standard starter template',
		desc = 'Template for starting an HTML file'
	}, fmt([[
			<!DOCTYPE html>

			<html lang="{}" xmlns="http://www.w3.org/1999/xhtml">
				<head>
					<meta charset="UTF-8">
					<title>{}</title>
				</head>
				<body>
					{}
				</body>
			</html>
			]], { i(1, 'en'), i(2, 'Title'), i(0) })
	),
	s({
		trig = 'html5',
		name = 'html5',
		desc = 'HTML - Defines a template for a html5 document',
	}, fmt([[
            <!DOCTYPE html>
            <html lang="{}" xmlns="http://www.w3.org/1999/xhtml">
            	<head>
            		<meta charset="UTF-8">
            		<meta name="viewport" content="width=device-width, initial-scale=1">
            		<title>{}</title>
            		<link href="{}" rel="stylesheet">
            	</head>
            	<body>
					{}
            	</body>
            </html>"
		]], { i(1, 'en'), i(2, 'Title'), i(3, 'css/styles.css'), i(0) })
	),
	s({
		trig = 'i',
		name = 'i',
		desc = 'HTML - Defines italic text',
	}, fmt('<i>{}</i>', i(1))
	),
	s({
			trig = 'iframe',
			name = 'iframe',
			desc = 'HTML - Defines an inline sub window',
		},
		c(1, {
			sn(nil, fmt('<iframe>{}</iframe>', i(1))),
			sn(nil, fmt('<iframe src="{}">{}</iframe>', { i(1), i(2) }))
		})
	),
	s({
			trig = 'img',
			name = 'img',
			desc = 'HTML - Defines an image',
		},
		c(1, {
			sn(nil, fmt('<img{}>', i(1))),
			sn(nil, fmt('<img src="{}" alt="{}">', { i(1), i(2) }))
		})
	),

	s({
			trig = 'input',
			name = 'input',
			desc = 'HTML - Defines an input field',
		},
		c(1, {
			sn(nil, fmt('<input{}>', i(1))),
			sn(nil, fmt('<input type="{}" name="{}" value="{}">', { i(1), i(2), i(3) }))
		})
	),

	s({
		trig = 'ins',
		name = 'ins',
		desc = 'HTML - Defines inserted text',
	}, fmt('<ins>{}</ins>', i(1))
	),
	s({
		trig = 'keygen',
		name = 'keygen',
		desc = 'HTML - Defines a generated key in a form',
	}, fmt('<keygen name="{}">', i(1))
	),
	s({
		trig = 'kbd',
		name = 'kbd',
		desc = 'HTML - Defines keyboard text',
	}, fmt('<kbd>{}</kbd>', i(1))
	),

	s({
		trig = 'label',
		name = 'label',
		desc = 'HTML - Defines an inline window'
	}, fmt('<label for="{}">{}</label>', { i(1), i(2) })
	),

	s({
		trig = 'legend',
		name = 'legend',
		desc = 'HTML - Defines a title in a fieldset',
	}, fmt('<legend>{}</legend>', i(1))
	),
	s({
		trig = 'li',
		name = 'li',
		desc = 'HTML - Defines a list item',
	}, fmt('<li>{}</li>', i(1))
	),
	s({
			trig = 'link',
			name = 'link',
			desc = 'HTML - Defines a resource reference',
		},
		c(1, {
			sn(nil, fmt('<link{}>', i(1))),
			sn(nil, fmt('<link rel="{}" type="{}" href="{}">', { i(1), i(2), i(3) }))
		})
	),
	s({
		trig = 'main',
		name = 'main',
		desc = 'HTML - Defines an image map',
	}, fmt([[
		<main>
			{}
		</main>
		]], i(1))
	),
	s({
		trig = 'map',
		name = 'map',
		desc = 'HTML - Defines an image map',
	}, fmt([[
			<map name="{}">
				{}
			</map>
			]], { i(1), i(2) })
	),
	s({
		trig = 'mark',
		name = 'mark',
		desc = 'HTML - Defines marked text',
	}, fmt('<mark>{}</mark>', i(1))
	),
	s({
		trig = 'menu',
		name = 'menu',
		desc = 'HTML - Defines a menu list',
	}, fmt([[
		<menu>
			{}
		</menu>
		]], i(1))
	),
	s({
		trig = 'menuitem',
		name = 'menuitem',
		desc = 'HTML - Defines a menu item [firefox only]',
	}, fmt('<menuitem>{}</menuitem>', i(1))
	),
	s({
			trig = 'meta',
			name = 'meta',
			desc = 'HTML - Defines meta information',
		},
		c(1, {
			sn(nil, fmt('<meta{}>', i(1))),
			sn(nil, fmt('<meta name="{}" content="{}">', { i(1), i(2) }))
		})
	),
	s({
			trig = 'meter',
			name = 'meter',
			desc = 'HTML - Defines measurement within a predefined range',
		},
		c(1, {
			sn(nil, fmt('<meter>{}</meter>', i(1))),
			sn(nil, fmt('<meter value="{}">{}</meter>', { i(1), i(2) }))
		})
	),
	s({
		trig = 'nav',
		name = 'nav',
		desc = 'HTML - Defines navigation links',
	}, fmt([[
		<nav>
			{}
		</nav>
		]], i(1))
	),
	s({
		trig = 'noscript',
		name = 'noscript',
		desc = 'HTML - Defines a noscript section',
	}, fmt([[
		<noscript>
			{}
		</noscript>
		]], i(1))
	),
	s({
		trig = 'object',
		name = 'object',
		desc = 'HTML - Defines an embedded object',
	}, fmt('<object width="{}" height="{}" data="{}">{}</object>', {
		i(1),
		i(2),
		i(3),
		i(4)
	})
	),
	s({
			trig = 'ol',
			name = 'ol',
			desc = 'HTML - Defines an ordered list',
		},
		c(1, {
			sn(nil,
				fmt([[
					<ol>
						{}
					</ol>
					]], i(1))
			),
			sn(nil,
				fmt([[
					<ol class="{}">
						{}
					</ol>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<ol id="{}">
						{}
					</ol>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<ol class="{}" id="{}">
						{}
					</ol>
					]], { i(2), i(3), i(1) })
			)
		})
	),
	s({
		trig = 'optgroup',
		name = 'optgroup',
		desc = 'HTML - Defines an option group',
	}, fmt([[
		<optgroup>
			{}
		</optgroup>
		]], i(1))
	),
	s({
			trig = 'option',
			name = 'option',
			desc = 'HTML - Defines an option in a drop-down list',
		},
		c(1, {
			sn(nil, fmt('<option>{}</option>', i(1))),
			sn(nil, fmt('<option value="{}">{}</option>', { i(1), i(2) }))
		})
	),
	s({
			trig = 'output',
			name = 'output',
			desc = 'HTML - Defines some types of output',
		},
		c(1, {
			sn(nil, fmt('<output>{}</output>', i(1))),
			sn(nil, fmt('<output name="{}" for="{}">{}</output>', { i(1), i(2), i(3) }))
		})
	),
	s({
			trig = 'p',
			name = 'p',
			desc = 'HTML - Defines a paragraph',
		},
		c(1, {
			sn(nil, fmt('<p>{}</p>', i(1))),
			sn(nil, fmt('<p class="{}">{}</p>', { i(2), i(1) })),
			sn(nil, fmt('<p id="{}">{}</p>', { i(2), i(1) })),
			sn(nil, fmt('<p class="{}" id="{}">{}</p>', { i(2), i(3), i(1) }))
		})
	),
	s({
			trig = 'param',
			name = 'param',
			desc = 'HTML - Defines a parameter for an object',
		},
		c(1, {
			sn(nil, fmt('<param{}>', i(1))),
			sn(nil, fmt('<param name="{}" value="{}">', { i(1), i(2) }))
		})
	),
	s({
		trig = 'pre',
		name = 'pre',
		desc = 'HTML - Defines preformatted text',
	}, fmt('<pre>{}</pre>', i(1))
	),
	s({
			trig = 'progress',
			name = 'progress',
			desc = 'HTML - Defines progress of a task of any kind',
		},
		c(1, {
			sn(nil, fmt('<progress>{}</progress>', i(1))),
			sn(nil, fmt('<progress value="{}" max="{}">{}</progress>', { i(1), i(2), i(3) }))
		})
	),
	s({
		trig = 'q',
		name = 'q',
		desc = 'HTML - Defines a short quotation',
	}, fmt('<q>{}</q>', i(1))
	),
	s({
		trig = 'rp',
		name = 'rp',
		desc = 'HTML - Used in ruby annotations to define what to show browsers that do not support the ruby element',
	}, fmt('<rp>{}</rp>', i(1))
	),
	s({
		trig = 'rt',
		name = 'rt',
		desc = 'HTML - Defines explanation to ruby annotations',
	}, fmt('<rt>{}</rt>', i(1))
	),
	s({
		trig = 'ruby',
		name = 'ruby',
		desc = 'HTML - Defines ruby annotations',
	}, fmt([[
		<ruby>
			{}
		</ruby>
	]], i(1))
	),
	s({
		trig = 's',
		name = 's',
		desc = 'HTML - Used to define strikethrough text',
	}, fmt('<s>{}</s>', i(1))
	),
	s({
		trig = 'samp',
		name = 'samp',
		desc = 'HTML - Defines sample computer code',
	}, fmt('<samp>{}</samp>', i(1))
	),
	s({
		trig = 'script',
		name = 'script',
		desc = 'HTML - Defines a script',
	}, fmt([[
		<script>
			{}
		</script>
		]], i(1))
	),
	s({
		trig = 'section',
		name = 'section',
		desc = 'HTML - Defines a section',
	}, fmt([[
		<section>
			{}
		</section>
		]], i(1))
	),
	s({
		trig = 'select',
		name = 'select',
		desc = 'HTML - Defines a selectable list',
	}, fmt([[
		<select>
			{}
		</select>
		]], i(1))
	),
	s({
		trig = 'small',
		name = 'small',
		desc = 'HTML - Defines small text',
	}, fmt('<small>{}</small>', i(1))
	),
	s({
			trig = 'source',
			name = 'source',
			desc = 'HTML - Defines media resource',
		},
		c(1, {
			sn(nil, fmt('<source{}>', i(1))),
			sn(nil, fmt('<source src="{}" type="{}">', { i(1), i(2) }))
		})
	),
	s({
		trig = 'span',
		name = 'span',
		desc = 'HTML - Defines a section in a document',
	}, fmt('<span>{}</span>', i(1))
	),
	s({
		trig = 'strong',
		name = 'strong',
		desc = 'HTML - Defines strong text',
	}, fmt('<strong>{}</strong>', i(1))
	),
	s({
		trig = 'style',
		name = 'style',
		desc = 'HTML - Defines a style definition',
	}, fmt([[
		<style>
			{}
		</style>
		]], i(1))
	),
	s({
		trig = 'sub',
		name = 'sub',
		desc = 'HTML - Defines sub-scripted text',
	}, fmt('<sub>{}</sub>', i(1))
	),
	s({
		trig = 'sup',
		name = 'sup',
		desc = 'HTML - Defines super-scripted text',
	}, fmt('<sup>{}</sup>', i(1))
	),
	s({
		trig = 'summary',
		name = 'summary',
		desc = 'HTML - Defines a visible heading for the detail element [limited support]',
	}, fmt('<summary>{}</summary>', i(1))
	),
	s({
		trig = 'table',
		name = 'table',
		desc = 'HTML - Defines a table',
	}, fmt([[
		<table>
			{}
		</table>
		]], i(1))
	),
	s({
		trig = 'tbody',
		name = 'tbody',
		desc = 'HTML - Defines a table body',
	}, fmt([[
		<tbody>
			{}
		</tbody>
		]], i(1))
	),
	s({
		trig = 'td',
		name = 'td',
		desc = 'HTML - Defines a table cell',
	}, fmt('<td>{}</td>', i(1))
	),
	s({
		trig = 'textarea',
		name = 'textarea',
		desc = 'HTML - Defines a text area',
	}, fmt('<textarea rows="{}" cols="{}">{}</textarea>', { i(1), i(2), i(3) })
	),
	s({
		trig = 'tfoot',
		name = 'tfoot',
		desc = 'HTML - Defines a table footer',
	}, fmt([[
		<tfoot>
			{}
		</tfoot>
		]], i(1))
	),
	s({
		trig = 'thead',
		name = 'thead',
		desc = 'HTML - Defines a table head',
	}, fmt([[
		<thead>
			{}
		</thead>
		]], i(1))
	),
	s({
		trig = 'th',
		name = 'th',
		desc = 'HTML - Defines a table header',
	}, fmt('<th>{}</th>', i(1))
	),
	s({
		trig = 'time',
		name = 'time',
		desc = 'HTML - Defines a date/time',
	}, fmt('<time datetime="{}">{}</time>', { i(1), i(2) })
	),
	s({
		trig = 'title',
		name = 'title',
		desc = 'HTML - Defines the document title',
	}, fmt('<title>{}</title>', i(1))
	),
	s({
			trig = 'tr',
			name = 'tr',
			desc = 'HTML - Defines a table row',
		},
		c(1, {
			sn(nil, fmt('<tr>{}</tr>', i(1))),
			sn(nil, fmt([[
						<tr>
							{}
						</tr>
						]], i(1)))
		})
	),
	s({
		trig = 'track',
		name = 'track',
		desc = 'HTML - Defines a table row',
	}, fmt('<track src="{}" kind="{}" srclang="{}" label="{}">', {
		i(1),
		i(2),
		i(3),
		i(4)
	})
	),
	s({
		trig = 'u',
		name = 'u',
		desc = 'HTML - Used to define underlined text',
	}, fmt('<u>{}</u>', i(1))
	),
	s({
			trig = 'ul',
			name = 'ul',
			desc = 'HTML - Defines an unordered list',
		},
		c(1, {
			sn(nil,
				fmt([[
					<ul>
						{}
					</ul>
					]], i(1))
			),
			sn(nil,
				fmt([[
					<ul class="{}">
						{}
					</ul>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<ul id="{}">
						{}
					</ul>
					]], { i(2), i(1) })
			),
			sn(nil,
				fmt([[
					<ul class="{}" id="{}">
						{}
					</ul>
					]], { i(2), i(3), i(1) })
			)
		})
	),
	s({
		trig = 'var',
		name = 'var',
		desc = 'HTML - Defines a variable',
	}, fmt('<var>{}</var>', i(1))
	),
	s({
		trig = 'video',
		name = 'video',
		desc = 'HTML - Defines a video'
	}, fmt([[
            <video width="{}" height="{}" controls>
				{}
            </video>
			]], {
		i(1),
		i(2),
		i(3)
	})
	),
}
