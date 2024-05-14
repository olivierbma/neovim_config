local jdtls = require('jdtls')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


vim.keymap.set('n', '<C-i>', vim.lsp.buf.format, { desc = 'format the current buffer' })


vim.bo.tabstop = 2      -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 2   -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 2  -- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.o.pumheight = 7

vim.opt.colorcolumn = "80"
vim.cmd('set fileformat=unix')


-- 💀
-- This is the default if not provided, you can remove it. Or adjust as needed.
-- One dedicated LSP server & client will be started per unique root_dir
local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })



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
local on_attach = function(client, bufnr)
end


local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- 'C:\\Program Files\\Java\\jre-1.8\\bin\\java.exe', -- or '/path/to/java17_or_newer/bin/java'
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
    '--add-opens', 'java.desktop/java.awt=ALL-UNNAMED',
    '--add-opens', 'java.desktop/java.org=ALL-UNNAMED',
    '-classpath', '~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar ',

    -- 💀
    '-jar',
    vim.fn.stdpath("data") ..
    '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', vim.fn.stdpath("data") .. '/mason/packages/jdtls/config_linux',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_folder
  },
  root_dir = root_dir,
  capabilities = capabilities,
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      project = {
        referencedLibraries = {
          vim.fn.stdpath("data") .. '/mason/packages/java-test/extension/server/*.jar ',
        },
      },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {

            name = "JavaSE-1.8",
            path = "/home/olivier/.asdf/installs/java/adoptopenjdk-8.0.392+8", -- or '/path/to/java17_or_newer/bin/java'
          },
          {
            name = "JavaSE-19",
            path = "/home/olivier/.asdf/installs/java/openjdk-19.0.2"
          },
          {
            name = "JavaSE-11",
            path = "/home/olivier/.asdf/installs/java/openjdk-11.0.2"
          },
          {
            name = "JavaSE-21",
            path = "/home/olivier/.asdf/installs/java/openjdk-21.0.1"
          },
          {
            name = "JavaSE-22",
            path = "/home/olivier/.asdf/installs/java/openjdk-22"
          }
        }

      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    extendedClientCapabilities = capabilities,
  },
  -- { hotcodereplace = 'auto' }
  on_attach = on_attach,
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this


  init_options = {
    bundles = {
      vim.fn.stdpath("data") ..
      '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.50.0.jar',
      vim.fn.stdpath("data") ..
      '/mason/packages/java-test/extension/server/com.microsoft.java.test.plugin-0.40.1.jar',

      vim.fn.stdpath('data') .. '/neotest-java/junit-platform-console-standalone-1.10.1.jar',
    },
    extendedClientCapabilities = capabilities,
  },

}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)



-- debug

local function setup_debug()
  vim.cmd('wall')
  require('jdtls.dap').setup_dap_main_class_configs()
  require('dap').continue()
end




-- require('jdtls.dap').setup_dap_main_class_configs()
--
vim.keymap.set("n", "<F5>", setup_debug, { desc = 'Start or continue debug execution' })
