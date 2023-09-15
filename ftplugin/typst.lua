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
local knap = require 'plugins.knap'
local gknapsettings = {
	typoutputext = "pdf",
	typtopdf = "echo refreshing",
	typtopdfviewerlaunch = "typst watch main.typ",
	typtopdfviewerrefresh = "Close viewer"
}
vim.g.knap_settings = gknapsettings

-- set shorter name for keymap function
-- local kmap = vim.keymap.set
--
-- -- F5 processes the document once, and refreshes the view
-- kmap({ 'n', 'v', 'i' }, '<F5>', function() require("knap").process_once() end)
--
-- -- F6 closes the viewer application, and allows settings to be reset
-- kmap({ 'n', 'v', 'i' }, '<F6>', function() require("knap").close_viewer() end)
--
-- -- F7 toggles the auto-processing on and off
-- kmap({ 'n', 'v', 'i' }, '<F7>', function() require("knap").toggle_autopreviewing() end)
--
-- -- F8 invokes a SyncTeX forward search, or similar, where appropriate
require('lspconfig').ltex.setup({
	filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc", "typst" },
	flags = { debounce_text_changes = 300 },
	settings = {
		ltex = {
			-- language = "en"
			language = "fr"
		}
	},
})
