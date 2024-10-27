return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
    "luckasRanarison/tailwind-tools.nvim",
  },
  opts = function(_, opts)
    local lspkind = require "lspkind"

    opts.formatting = {
      format = lspkind.cmp_format {
        mode = "text",
        show_labelDetails = true,
        before = require("tailwind-tools.cmp").lspkind_format,
      },
    }

    opts.window = {
      completion = {
        border = "none",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
        scrollbar = false,
      },
    }

    return opts
  end,
}
