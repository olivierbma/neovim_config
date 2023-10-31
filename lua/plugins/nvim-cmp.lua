return {

	'hrsh7th/nvim-cmp',
	dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },

	config = function()
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers


		-- nvim-cmp setup
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
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

		local function jdocsnip(args)
			local nodes = {
				t({ "/**", " * " }),
				r(1, "desc", i(1, "A short Description")),
				t({ "", "" }),
			}

			-- At least one param.
			if string.find(args[2][1], ", ") then
				vim.list_extend(nodes, { t({ " * ", "" }) })
			end

			local insert = 2
			for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
				-- Get actual name parameter.
				arg = vim.split(arg, " ", true)[2]
				if arg then
					local inode = r(insert, "arg" .. arg, i(1))

					vim.list_extend(nodes,
						{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) })

					insert = insert + 1
				end
			end

			if args[1][1] ~= "void" then
				local inode = r(insert, "ret", i(1))

				vim.list_extend(nodes, { t({ " * ", " * @return " }), inode, t({ "", "" }) })
				insert = insert + 1
			end

			if vim.tbl_count(args[3]) ~= 1 then
				local exc = string.gsub(args[3][2], " throws ", "")
				local ins = r(insert, "ex", i(1))
				vim.list_extend(nodes, { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) })
				insert = insert + 1
			end

			vim.list_extend(nodes, { t({ " */" }) })

			local snip = sn(nil, nodes)
			return snip
		end

		ls.add_snippets('java', {
			s("func", {
				d(6, jdocsnip, { 2, 4, 5 }),
				t({ "", "" }),
				i(1, 'private'),
				t(' '),
				i(2, 'int'),
				t(" "),
				i(3, "myFunc"),
				t("("),
				i(4),
				t(")"),
				c(5, {
					t(""),
					sn(nil, {
						t({ "", " throws " }),
						i(1),
					}),
				}),
				t({ " {", "\t" }),
				i(0),
				t({ "", "}" }),
			}),
		})

		ls.add_snippets("java", {
			s("println", {
				t("System.out.println("), i(1, "texte"), t(");")
			}),
			s("main", {
				t({ "public static void main(String[] args) {", "\t" }), i(1), t({ "", "}" })
			}),
			s("for", {
				t("for(int i = 0; i < "), i(1, "variable"), t({ "; i++) {", "\t" }), i(2), t({ "", "}" })
			}),

		})

		ls.add_snippets("typst", {
			s("template", {
				t("#import \"@local/template:"), i(1, "1.0.0"), t("\": *"),
				t({ "", "#show: basic_styling" })
			})
		})
		local function jdocsnip(args)
			local nodes = {
				t({ "/**", " * " }),
				r(1, "desc", i(1, "A short Description")),
				t({ "", "" }),
			}

			-- At least one param.
			if string.find(args[2][1], ", ") then
				vim.list_extend(nodes, { t({ " * ", "" }) })
			end

			local insert = 2
			for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
				-- Get actual name parameter.
				arg = vim.split(arg, " ", true)[2]
				if arg then
					local inode = r(insert, "arg" .. arg, i(1))

					vim.list_extend(nodes,
						{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) })

					insert = insert + 1
				end
			end

			if args[1][1] ~= "void" then
				local inode = r(insert, "ret", i(1))

				vim.list_extend(nodes, { t({ " * ", " * @return " }), inode, t({ "", "" }) })
				insert = insert + 1
			end

			if vim.tbl_count(args[3]) ~= 1 then
				local exc = string.gsub(args[3][2], " throws ", "")
				local ins = r(insert, "ex", i(1))
				vim.list_extend(nodes, { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) })
				insert = insert + 1
			end

			vim.list_extend(nodes, { t({ " */" }) })

			local snip = sn(nil, nodes)
			return snip
		end

		ls.snippets = {
			all = {
				s("test_stored_with_dyn_lambda", {
					i(1, "Pretext"),
					t(" "),
					c(2, {
						sn(nil, r(1, 1)),
						sn(nil, {
							i(1, "extra_arg"),
							t(" "),
							r(2, 1),
						}),
					}),
				}, {
					stored = {
						[1] = sn(nil, {
							i(1, "reversed text"),
							t(" "),
							dl(2, l._1:reverse(), 1), --< dynamic lambdas resets its content
						}),
					},
				}),
				s("test_dynamic", {
					d(6, jdocsnip, { 2, 4, 5 }),
					t({ "", "" }),
					c(1, {
						t("public "),
						t("private "),
					}),
					c(2, {
						t("void"),
						t("String"),
						t("char"),
						t("int"),
						t("double"),
						t("boolean"),
						i(nil, ""),
					}),
					t(" "),
					i(3, "myFunc"),
					t("("),
					i(4),
					t(")"),
					c(5, {
						t(""),
						sn(nil, {
							t({ "", " throws " }),
							i(1),
						}),
					}),
					t({ " {", "\t" }),
					i(0),
					t({ "", "}" }),
				}),
			},
		}
		luasnip.config.setup {}

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
		}

		local lspkind = require('lspkind')
		cmp.setup({
			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"

					return kind
				end,
			},
		})
	end
}
