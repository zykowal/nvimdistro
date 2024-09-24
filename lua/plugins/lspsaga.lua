return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  cmd = "Lspsaga",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["]d"] = { "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" }
        maps.n["[d"] = { "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" }
      end,
    },
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local maps = opts.mappings

        -- call hierarchy
        maps.n["<Leader>lc"] =
          { "<Cmd>Lspsaga incoming_calls<CR>", desc = "Incoming calls", cond = "callHierarchy/incomingCalls" }
        maps.n["<Leader>lC"] =
          { "<Cmd>Lspsaga outgoing_calls<CR>", desc = "Outgoing calls", cond = "callHierarchy/outgoingCalls" }

        -- definition
        maps.n["<Leader>lp"] =
          { "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek definition", cond = "textDocument/definition" }

        -- goto type definition
        maps.n["<Leader>lt"] =
          { "<Cmd>Lspsaga goto_type_definition<CR>", desc = "Goto type definition", cond = "textDocument/definition" }

        -- outline
        maps.n["<Leader>lS"] =
          { "<Cmd>Lspsaga outline<CR>", desc = "Symbols outline", cond = "textDocument/documentSymbol" }

        -- references
        maps.n["<Leader>lR"] = {
          "<Cmd>Lspsaga finder<CR>",
          desc = "Search references",
          cond = function(client)
            return client.supports_method "textDocument/references"
              or client.supports_method "textDocument/implementation"
          end,
        }

        -- rename
        maps.n["<Leader>lr"] =
          { "<Cmd>Lspsaga rename<CR>", desc = "Rename current symbol", cond = "textDocument/rename" }
      end,
    },
  },
  opts = function()
    local astroui = require "astroui"
    local get_icon = function(icon) return astroui.get_icon(icon, 0, true) end
    return {
      code_action = {
        extend_gitsigns = require("astrocore").is_available "gitsigns.nvim",
      },
      lightbulb = {
        sign = false,
        enable = false,
      },
      ui = {
        code_action = get_icon "DiagnosticHint",
        expand = get_icon "FoldClosed",
        collapse = get_icon "FoldOpened",
      },
    }
  end,
}
