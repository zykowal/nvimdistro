return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local lspkind = require "lspkind"

    local function snippets_last(entry1, entry2)
      local kind1 = entry1:get_kind()
      local kind2 = entry2:get_kind()

      if kind1 == cmp.lsp.CompletionItemKind.Snippet and kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
        return false
      end

      if kind2 == cmp.lsp.CompletionItemKind.Snippet and kind1 ~= cmp.lsp.CompletionItemKind.Snippet then
        return true
      end

      return nil
    end

    opts.sorting = {
      comparators = {
        snippets_last, -- 我们的自定义比较器放在最前面
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    }

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
        border = "rounded",
        scrollbar = false,
      },
    }

    return opts
  end,
}
