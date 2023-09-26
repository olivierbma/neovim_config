return {


  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",

  config = function()
    require('neogen').setup({ snippet_engine = "luasnip" })

    vim.keymap.set({ 'n', 'v' }, '<Space>ng', function() require('neogen').generate() end,
      { desc = '[N]eo[G]en - produce code docs' })

    return true
  end
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
