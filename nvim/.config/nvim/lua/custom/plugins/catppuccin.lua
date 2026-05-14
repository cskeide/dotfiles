return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = true,
      auto_integrations = true,
      integrations = {
        lualine = true,
      },
    }

    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
