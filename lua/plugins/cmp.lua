return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  opts = function(_, opts)
    local lspkind = require "lspkind"

    opts.formatting = {
      format = lspkind.cmp_format {
        mode = "text",
        show_labelDetails = true,
      },
    }

    opts.window = {
      completion = {
        border = "none",
        scrollbar = false,
      },
      documentation = {
        border = "none",
        scrollbar = false,
      },
    }

    return opts
  end,
}
