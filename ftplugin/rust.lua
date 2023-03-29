local home = "C:/Users/Jopioligui/"


-- Normal setup

local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { desc = 'Start or continue debug execution' })
-- local capabilities = vim.lsp.protocol.make_client_capabilities()



-- local extension_path = home .. ".vscode/extensions/vadimcn.vscode-lldb-1.9.0/" -- Update this path
local extension_path = home .. "AppData/Local/nvim-data/mason/packages/codelldb/extension/" -- Update this path
local codelldb_path = extension_path .. "adapter/codelldb.exe"
-- local liblldb_path = "C:/Users/Jopioligui/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/bin/liblldb.dll"
-- local liblldb_path = "C:/Users/Jopioligui/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/lib/liblldb.lib"
local liblldb_path = extension_path .. "lldb/lib/liblldb.lib"
-- local liblldb_path =  extension_path .. "adapter/codelldb.dll"


dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_path,
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

local root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml', '.git'}, { upward = true })[1])
local program_name =  vim.fn.fnamemodify(root_dir, ':p:h:t')
local program_path = root_dir .. '/target/debug/' .. program_name .. '.exe'

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = program_path,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
