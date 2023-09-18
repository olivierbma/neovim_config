return {
	'kdheepak/lazygit.nvim',
	requires = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
	},

	config = function()
		require("telescope").load_extension("lazygit")
		vim.keymap.set('n', 'gl', ':LazyGit <CR>', { desc = "[G]it [L]Azy" })
	end
}
