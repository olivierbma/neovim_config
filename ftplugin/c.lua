local home = 'C:/Users/Olivier/'
local root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
local program_name = vim.fn.fnamemodify(root_dir, ':p:h:t')


function CMakeSetup()
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
  os.execute('cd ' ..
    root_dir ..
    '& mkdir build & cd build && cmake.exe -G \"Ninja\" -D CMAKE_C_COMPILER=clang -D CMAKE_CXX_COMPILER=clang++ ..')
  print("something")
end

function CMakeBuild()
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
  os.execute('cd ' .. root_dir .. ' && cmake --build build')
end

vim.api.nvim_create_user_command('CMakeSetup', CMakeSetup, {})








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
    vim.cmd('wa')
    CMakeBuild()
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
    -- detached = false,
  }
}

local program_path = root_dir .. '/build/src/' .. program_name .. '.exe'

dap.configurations.c = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = program_path,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
