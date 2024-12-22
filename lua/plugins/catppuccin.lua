return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  priority = 1000,
  ---@type CatppuccinOptions
  opts = {
    transparent_background = true,
    term_colors = true,
    integrations = {
      aerial = true,
      alpha = true,
      blink_cmp = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      dropbar = {
        enabled = true,
        color_mode = true, -- enable color for kind's texts, not just kind's icons
      },
      dadbod_ui = true,
      gitsigns = true,
      grug_far = true,
      illuminate = true,
      indent_blankline = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      native_lsp = { enabled = true },
      neotree = true,
      neotest = true,
      noice = true,
      notify = true,
      nvim_surround = true,
      overseer = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      ts_rainbow = false,
      render_markdown = true,
      ufo = true,
      which_key = true,
      window_picker = true,
      colorful_winsep = { enabled = true, color = "lavender" },
    },
  },
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      opts = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      },
    },
  },
}
