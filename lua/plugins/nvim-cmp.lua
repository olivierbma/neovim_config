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


		ls.add_snippets("java", {
			s("eachfor", {
				t("Tjis is nice")
			}),
			s("println", {
				t("System.out.println("), i(1, "texte"), t(");")
			}),
			s("main", {
				t({ "public static void main(String[] args) {", "\t" }), i(1), t({ "", "}" })
			}),
			s("for", {
				t("for(int i = 0; i < "), i(1, "variable"), t({ "; i++) {", "\t" }), i(2), t({ "", "}" })
			})

		})

		luasnip.config.setup {}

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
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
		cmp.setup {
			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol_text', -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						return vim_item
					end
				})
			}
		}
	end
}
