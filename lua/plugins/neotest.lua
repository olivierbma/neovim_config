return {
  {
    "rcasia/neotest-java",
    init = function()
      -- override the default keymaps.
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    adapters = {
      ["neotest-java"] = {
        -- config here
      },
    },
  },
}
