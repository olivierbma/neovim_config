local home = "C:/Users/Olivier/"


local dap = require("dap")

local debug_session_active = false;

dap.listeners.after.event_initialized["debug_on_save"] = function()
  debug_session_active = true
end
dap.listeners.before.event_terminated["debug_on_save"] = function()
  debug_session_active = false
end
dap.listeners.before.event_exited["debug_on_save"] = function()
  debug_session_active = false
end

local function setup_debug()
  if debug_session_active == false then
    vim.cmd('write')
    os.execute('zig build')
  end
  require('dap').continue()
end


vim.keymap.set("n", "<F5>", setup_debug, { desc = 'Start or continue debug execution' })
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
    detached = true,
  }
}






local root_dir = vim.fs.dirname(vim.fs.find({ 'build.zig', '.git' }, { upward = true })[1])
local program_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local program_path = root_dir .. '/zig-out/bin/' .. program_name .. '.exe'
local debug_symbols = root_dir .. '/zig-out/bin/' .. program_name .. '.pdb'

dap.configurations.zig = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    args = {},
    program = program_path,
    symbolsSearchPath = root_dir .. '/zig-out/bin',
    additionalSOLibSearchPath = debug_symbols,
    cwd = root_dir,
    stopOnEntry = false,
  }
}
