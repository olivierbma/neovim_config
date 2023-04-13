local home = 'C:\\Users\\Olivier\\'
local jdtls = require('jdtls')



vim.keymap.set('n', '<C-i>', vim.lsp.buf.format, { desc = 'format the current buffer' })


vim.bo.tabstop = 2      -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 2   -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 2  -- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.o.pumheight = 7



-- 💀
-- This is the default if not provided, you can remove it. Or adjust as needed.
-- One dedicated LSP server & client will be started per unique root_dir
local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })


-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
-- local workspace_folder = root_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_folder = vim.fn.fnamemodify(root_dir, ':h') ..
    '/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
print(workspace_folder)
-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Regular Neovim LSP client keymappings
  -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  -- nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
  -- nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  -- nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
  -- nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
  -- nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  -- nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  -- nnoremap('<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts, "List workspace folders")
  -- nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  -- nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
  -- nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  -- vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
  --   { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
  -- nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
  --
  -- -- Java extensions provided by jdtls
  -- nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  -- nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  -- nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  -- vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
  --   { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })
  --
  -- local nmap = function(keys, func, desc)
  --   if desc then
  --     desc = 'LSP: ' .. desc
  --   end
  --
  --   vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  -- end


  --
  -- nnoremap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')
end

-- nnoremap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- nnoremap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
-- nnoremap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
-- nnoremap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
-- nnoremap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
-- nnoremap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
-- nnoremap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
-- nnoremap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
-- -- See `:help K` for why this keymap
-- nnoremap('K', vim.lsp.buf.hover, 'Hover Documentation')
-- nnoremap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
-- -- Lesser used LSP functionality
-- nnoremap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
-- nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')






local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'C:\\Program Files\\OpenJDK\\jdk-20\\bin\\java.exe', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '--add-opens', 'java.base/java.awt=ALL-UNNAMED',

    -- 💀
    '-jar',
    home ..
    'AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', home .. 'AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_folder
  },
  root_dir = root_dir,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },
  on_attach = require('jdtls').setup_dap({ hotcodereplace = 'auto' }),
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this


  init_options = {
    bundles = {
      home ..
      'AppData\\Local\\nvim-data\\mason\\packages\\java-debug-adapter\\extension\\server\\com.microsoft.java.debug.plugin-0.44.0.jar' }
  }
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)




-- debug
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
    vim.cmd('write')
    require('jdtls.dap').setup_dap_main_class_configs()
  end
  require('dap').continue()
end



-- require('jdtls.dap').setup_dap_main_class_configs()
--
vim.keymap.set("n", "<F5>", setup_debug, { desc = 'Start or continue debug execution' })
