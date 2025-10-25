return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 800,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = false,
        integrations = {
          telescope = true,
          treesitter = true,
          gitsigns = true,
          lualine = true,
        },
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        variant = 'moon',
        dark_variant = 'moon',
        disable_background = false,
      }
    end,
  },
  {
    'alligator/accent.vim',
    name = 'accent',
    priority = 1100,
  },
}
