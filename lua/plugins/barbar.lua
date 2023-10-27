return {
	'romgrk/barbar.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { desc = "pick buffer" })
	end
}
