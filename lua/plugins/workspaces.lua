return {
  'natecraddock/workspaces.nvim',
  dependencies = { 'natecraddock/sessions.nvim' },
  config = function()
    require("sessions").setup({
      events = { "VimLeavePre" },
      session_filepath = vim.fn.stdpath("data") .. "/sessions",
      absolute = true,
    })
    require('workspaces').setup({
      -- path to a file to store workspaces data in
      -- on a unix system this would be ~/.local/share/nvim/workspaces
      path = vim.fn.stdpath("data") .. "/workspaces",

      -- to change directory for nvim (:cd), or only for window (:lcd)
      -- deprecated, use cd_type instead
      -- global_cd = true,

      -- controls how the directory is changed. valid options are "global", "local", and "tab"
      --   "global" changes directory for the neovim process. same as the :cd command
      --   "local" changes directory for the current window. same as the :lcd command
      --   "tab" changes directory for the current tab. same as the :tcd command
      --
      -- if set, overrides the value of global_cd
      cd_type = "global",

      -- sort the list of workspaces by name after loading from the workspaces path.
      sort = true,

      -- sort by recent use rather than by name. requires sort to be true
      mru_sort = true,

      -- option to automatically activate workspace when opening neovim in a workspace directory
      auto_open = false,

      -- enable info-level notifications after adding or removing a workspace
      notify_info = true,

      -- lists of hooks to run after specific actions
      -- hooks can be a lua function or a vim command (string)
      -- lua hooks take a name, a path, and an optional state table
      -- if only one hook is needed, the list may be omitted
      hooks = {
        add = {},
        remove = {},
        rename = {},
        open_pre = {
          -- If recording, save current session state and stop recording
          "SessionsStop",

          -- delete all buffers (does not save changes)
          "silent %bdelete!",
          "Explore",
        },
        open = function()
          require("sessions").load(nil, { silent = true })
        end,
      },
    })
    require('telescope').load_extension("workspaces")

    vim.keymap.set('n', '<leader>sp', ':Telescope workspaces <CR>', { desc = '[S]earch [P]roject' })
  end
}
