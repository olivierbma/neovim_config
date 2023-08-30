local home = "C:/Users/Olivier/"

local dapp = require('dap-python')
dapp.setup(home .. "AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")




local debug_session_active = false;

local dap = require('dap')

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
    vim.cmd('wall')
  end
  require('dap').continue()
end

vim.keymap.set('n','<F5>', setup_debug, {desc = "start debug"})
