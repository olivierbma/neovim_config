local dapp = require('dap-python')
dapp.setup("C:\\Users\\Jopioligui\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")


vim.keymap.set('n','<F5>', require('dap').continue, {desc = "start debug"})
