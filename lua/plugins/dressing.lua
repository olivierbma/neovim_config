local get_cursor = function(opts)
  opts = opts or {}

  local theme_opts = {
    theme = "cursor",

    sorting_strategy = "ascending",
    results_title = false,
    layout_strategy = "cursor",
    layout_config = {
      width = 80,
      height = 19,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  }

  return vim.tbl_deep_extend("force", theme_opts, opts)
end




return {
  'stevearc/dressing.nvim',
  opts = {},
  config = function()
    require('dressing').setup({
      select = {
        enabled = true,

        backend = { "telescope" }, -- "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        telescope = get_cursor(),
      },
    })
  end
}
