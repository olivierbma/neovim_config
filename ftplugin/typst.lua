vim.bo.tabstop = 2      -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 2   -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 2  -- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.o.pumheight = 7
vim.opt.colorcolumn = "80"
vim.cmd('set fileformat=unix')


vim.g.typst_pdf_viewer = "evince"
vim.cmd("set lazyredraw nocursorline norelativenumber")
vim.cmd("set synmaxcol=80")


require('lspconfig').typst_lsp.setup {
	settings = {
		exportPdf = "never" -- Choose onType, onSave or never.
		-- serverPath = "" -- Normally, there is no need to uncomment it.
	}
}


require('lspconfig').ltex.setup({
	filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc" }, --"typst"-- },
	flags = { debounce_text_changes = 300 },
	settings = {
		ltex = {
			-- language = "en"
			language = "fr"
		}
	},
})

require 'typst-preview'.setup {
	-- Setting this true will enable printing debug information with print()
	debug = false,

	-- This function will be called to determine the root of the typst project
	get_root = function(bufnr_of_typst_buffer)
		return vim.fn.getcwd()
	end,
}
require('typst-cmp').setup()

-- vim.keymap.set('n', '<C-i>', function()
-- 	-- get current line num
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	print(type(col))
--
-- 	-- format the buffer
-- 	vim.cmd('%! typstfmt --output -')
-- 	if jit.os == 'Windows' then
-- 		local command = "%s/\r//g"
-- 		vim.cmd(command)
--
-- 		-- delete the stdin decorator
-- 		vim.api.nvim_win_set_cursor(0, { 1, 1 })
-- 		vim.api.nvim_del_current_line()
-- 	end
--
--
-- 	-- go back to line nu,ber before formatting
-- 	vim.api.nvim_win_set_cursor(0, { line, col })
-- 	vim.api.nvim_feedkeys("zz", "n", false)
--
-- 	-- success message
-- 	print("Formatting done")
-- end, { desc = 'format the current buffer' })
