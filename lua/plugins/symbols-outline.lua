return {

  'simrat39/symbols-outline.nvim',
  config = function()
    require("symbols-outline").setup()

    vim.keymap.set('n', '<LEADER>so', require('symbols-outline').toggle_outline, { desc = "[S]earch [O]utline" })
  end



}
