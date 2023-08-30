vim.bo.tabstop = 2      -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 2   -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 2  -- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.o.pumheight = 7
vim.opt.colorcolumn = "80"
vim.cmd('set fileformat=dos')

require('lspconfig').typst_lsp.setup {
	settings = {
		exportPdf = "onType" -- Choose onType, onSave or never.
		-- serverPath = "" -- Normally, there is no need to uncomment it.
	}
}
