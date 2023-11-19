vim.bo.tabstop = 2      -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 2   -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 2  -- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.o.pumheight = 7

vim.opt.colorcolumn = "80"

local root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
local program_name = vim.fn.fnamemodify(root_dir, ':p:h:t')


function CMakeSetup()
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
  os.execute('cd ' ..
    root_dir ..
    ' && mkdir build && cd build && cmake -G \"Ninja\" -D CMAKE_C_COMPILER=clang -D CMAKE_CXX_COMPILER=clang++ ..')
  print("something")
end

function CMakeBuild()
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
  os.execute('cd ' .. root_dir .. ' && cmake --build build')
end

function CMakebuild_project(project_name)
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
  os.execute('cd ' .. root_dir .. ' && cmake --build build --target ' .. project_name)
end

vim.api.nvim_create_user_command('CMakeSetup', CMakeSetup, {})



local function projects()
  local modules = {}
  local run_file = io.open(root_dir .. "/.run", "r")
  if run_file then
    local content = run_file:read("*a")
    for s in content:gmatch("[^\r\n]+") do
      table.insert(modules, s)
    end
    -- projects = table.concat(content, '\n')
    run_file:close()
  end
  local log = io.open(vim.fn.stdpath('data') .. "/log/last_cpp_launched.txt", "r")
  if log then
    local last = log:read("*l");
    if table_contains(modules, last) then
      table.sort(modules, function(a, b) return a == last end)
    end
  end

  return modules
end





local dap = require("dap")


local function setup_debug()
  vim.cmd('wa')
  CMakeBuild()
  require('dap').continue()
end

vim.keymap.set("n", "<F5>", setup_debug, { desc = 'Start or continue debug execution' })
-- local capabilities = vim.lsp.protocol.make_client_capabilities()



-- local extension_path = home .. ".vscode/extensions/vadimcn.vscode-lldb-1.9.0/" -- Update this path
local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/" -- Update this path
local codelldb_path = extension_path .. "adapter/codelldb"
local codelldb = "~/Documents/archive/codelldb-x86_64-linux/extension/adapter/codelldb"
-- local liblldb_path = "C:/Users/Jopioligui/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/bin/liblldb.dll"
-- local liblldb_path = "C:/Users/Jopioligui/AppData/Local/nvim-data/mason/packages/codelldb/extension/lldb/lib/liblldb.lib"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
-- local liblldb_path =  extension_path .. "adapter/codelldb.dll"


dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb,
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}


local program_path = root_dir .. '/build/src/' .. program_name -- .. '.exe'

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      local name = pick_one(projects(), "Choose a project")

      local log = io.open(vim.fn.stdpath('data') .. "/log/last_cpp_launched.txt", "w")
      if log then
        log:write(name)
        log:close()
      end


      print("Running: " .. root_dir .. '/build/' .. name .. "/" .. name)
      return root_dir .. '/build/' .. name .. "/" .. name
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

function pick_one(items, prompt, label_fn, cb)
  local co
  if not cb then
    co = coroutine.running()
    if co then
      cb = function(item)
        coroutine.resume(co, item)
      end
    end
  end
  cb = vim.schedule_wrap(cb)
  if vim.ui then
    vim.ui.select(items, {
      prompt = prompt,
      format_item = label_fn,
    }, cb)
  else
    local result = M.pick_one_sync(items, prompt, label_fn)
    cb(result)
  end
  if co then
    return coroutine.yield()
  end
end

function pick_one_sync(items, prompt, label_fn)
  local choices = { prompt }
  for i, item in ipairs(items) do
    table.insert(choices, string.format('%d: %s', i, label_fn(item)))
  end
  local choice = vim.fn.inputlist(choices)
  if choice < 1 or choice > #items then
    return nil
  end
  return items[choice]
end

function table_contains(tbl, x)
  local found = false
  for _, v in pairs(tbl) do
    if v == x then
      found = true
    end
  end
  return found
end
