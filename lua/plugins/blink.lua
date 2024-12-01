local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts_extend = { "sources.completion.enabled_providers" },
  opts = {
    snippets = {
      expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then return require("luasnip").jumpable(filter.direction) end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction) require("luasnip").jump(direction) end,
    },
    -- remember to enable your providers here
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer" }, -- add
      },
    },

    -- experimental auto-brackets support
    accept = {
      auto_brackets = { enabled = true },
      expand_snippet = function(snippet) require("luasnip").lsp_expand(snippet) end,
    },
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-N>"] = { "select_next", "show" },
      ["<C-P>"] = { "select_prev", "show" },
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.windows.autocomplete.win:is_open() then
            return cmp.select_next()
          elseif cmp.is_in_snippet() then
            return cmp.snippet_forward()
          elseif has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.windows.autocomplete.win:is_open() then
            return cmp.select_prev()
          elseif cmp.is_in_snippet() then
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },
    },
    windows = {
      autocomplete = {
        selection = "auto_insert",
        border = "none",
        scrollbar = false,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
        border = "none",
        scrollbar = false,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
      signature_help = {
        border = "none",
        enabled = true,
        scrollbar = false,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
      menu = {
        border = "none",
        scrollbar = false,
      },
    },
  },
  specs = {
    {
      "folke/lazydev.nvim",
      optional = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts = function(_, opts)
            if pcall(require, "lazydev.integrations.blink") then
              return require("astrocore").extend_tbl(opts, {
                sources = {
                  -- add lazydev to your completion providers
                  completion = { enabled_providers = { "lazydev" } },
                  providers = {
                    -- dont show LuaLS require statements when lazydev has items
                    lsp = { fallback_for = { "lazydev" } },
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
                  },
                },
              })
            end
          end,
        },
      },
    },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}
