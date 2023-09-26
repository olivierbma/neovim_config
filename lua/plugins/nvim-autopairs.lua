return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  opts = {
    check_ts = true,
  }, -- this is equalent to setup({}) function
  config = function()
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    local ts_conds = require('nvim-autopairs.ts-conds')
    local cond = require('nvim-autopairs.conds')

    npairs.setup({
      disable_filetype = { "TelescopePrompt", "vim", "typst", "typ" },
      check_ts = true,

    })


    npairs.add_rules({
      Rule("$", "$", { "java" })
      -- don't add a pair if  the previous character is xxx
          :with_pair(cond.is_inside_quote())
    }, {
      Rule("%", "%", { "java" }):with_pair(ts_conds.is_ts_node({ 'string', 'comment', 'string_content' }))
    }

    )
  end
}
