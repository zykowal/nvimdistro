local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function get_icon_provider()
  local _, mini_icons = pcall(require, "mini.icons")
  if _G.MiniIcons then
    return function(kind) return mini_icons.get("lsp", kind or "") end
  end
  local lspkind_avail, lspkind = pcall(require, "lspkind")
  if lspkind_avail then
    return function(kind) return lspkind.symbolic(kind, { mode = "symbol" }) end
  end
end
---@type function|false|nil
local icon_provider = false

local function get_icon(ctx)
  ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
  if ctx.item.source_name == "LSP" then
    -- TODO: uncomment after nvim-highlight-colors PR merged: https://github.com/brenoprata10/nvim-highlight-colors/pull/135
    -- local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
    -- local color_item = highlight_colors_avail and highlight_colors.format(ctx.item.documentation, { kind = ctx.kind })
    if icon_provider == false then icon_provider = get_icon_provider() end
    if icon_provider then
      local icon = icon_provider(ctx.kind)
      if icon then ctx.kind_icon = icon end
    end
    -- if color_item and color_item.abbr and color_item.abbr_hl_group then
    --   ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
    -- end
  end
  return ctx
end

return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "olimorris/codecompanion.nvim",
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  opts_extend = { "sources.default", "sources.cmdline" },
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
      default = { "lsp", "path", "luasnip", "buffer", "dadbod", "codecompanion" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          score_offset = 1000,
        },
        dadbod = {
          name = "Dadbod",
          enabled = true,
          module = "vim_dadbod_completion.blink",
          score_offset = 950,
        },
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
          score_offset = 1000,
        },
      },
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
          if cmp.is_visible() then
            return cmp.select_next()
          elseif cmp.snippet_active { direction = 1 } then
            return cmp.snippet_forward()
          elseif has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active { direction = -1 } then
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },
    },
    completion = {
      menu = {
        border = "none",
        scrollbar = false,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                get_icon(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx) return get_icon(ctx).kind_hl_group end,
            },
          },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      list = { selection = "auto_insert" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
        window = {
          border = "rounded",
          scrollbar = false,
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
    },
    signature = {
      window = {
        border = "none",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
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
                  default = { "lazydev" },
                  providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                  },
                  min_keyword_length = function(ctx)
                    if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 2 end
                    return 0
                  end,
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
    { "petertriho/cmp-git", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = true },
    { "onsails/lspkind.nvim", enabled = false },
  },
}
