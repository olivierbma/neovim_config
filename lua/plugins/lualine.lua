return {


	'nvim-lualine/lualine.nvim',
	opts = {
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	

}
