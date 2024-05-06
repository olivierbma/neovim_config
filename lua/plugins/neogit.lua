return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
    -- "ibhagwan/fzf-lua",              -- optional
  },
  config = function()
    -- require("telescope").load_extension("lazygit")

    require("neogit").setup {}
    vim.keymap.set('n', '<leader>lg', ':Neogit <CR>', { desc = "[G]it [N]eo" })
    return true
  end,


}
