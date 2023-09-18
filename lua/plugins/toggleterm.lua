return {

	'akinsho/toggleterm.nvim',
	version = "*",

	config = function()
		local toggleterm = require('toggleterm')

		toggleterm.setup {
			direction = 'float'
		}

		vim.keymap.set('n', '<leader>t', ':ToggleTerm <CR>', { desc = "[T]oggle [T]erminal" })
		vim.keymap.set('t', '<C-t>', [[<C-\><C-n>]],
			{ noremap = true, desc = "Go in normal mode when in terminal" })
	end
}
