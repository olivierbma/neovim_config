local home = "C:/Users/Olivier/"

local dapp = require('dap-python')
dapp.setup(home .. "AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")


vim.keymap.set('n','<F5>', require('dap').continue, {desc = "start debug"})
