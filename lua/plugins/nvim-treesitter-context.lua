return {
	'nvim-treesitter/nvim-treesitter-context',

	config = function()
		vim.keymap.set("n", "<leader>cc", function()
			require("treesitter-context").go_to_context()
		end, { silent = true, desc = "[C]context" })
	end
}
