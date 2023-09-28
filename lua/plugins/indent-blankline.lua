return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  config = function()
    local highlight = 'green'
    local hooks = require('ibl.hooks')
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "green", { fg = "#98971a" })
    end)

    require('ibl').setup({
      scope = {
        enable = true,
        highlight = highlight,

      }


    })
  end
}
