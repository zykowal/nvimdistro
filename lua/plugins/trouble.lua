return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>x"
        maps.n[prefix .. "X"] = { "<Cmd>Trouble diagnostics toggle<CR>", desc = "Trouble Workspace Diagnostics" }
        maps.n[prefix .. "x"] =
          { "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Trouble Document Diagnostics" }
        maps.n[prefix .. "L"] = { "<Cmd>Trouble loclist toggle<CR>", desc = "Trouble Location List" }
        maps.n[prefix .. "Q"] = { "<Cmd>Trouble quickfix toggle<CR>", desc = "Trouble Quickfix List" }
        if require("astrocore").is_available "todo-comments.nvim" then
          maps.n[prefix .. "t"] = { "<cmd>Trouble todo<cr>", desc = "Trouble Todo" }
          maps.n[prefix .. "T"] =
            { "<cmd>Trouble todo filter={tag={TODO,FIX,FIXME}}<cr>", desc = "Trouble Todo/Fix/Fixme" }
        end
        maps.n["<leader>lc"] = { "<Cmd>Trouble lsp_incoming_calls<CR>", desc = "Incoming Calls" }
        maps.n["<leader>lC"] = { "<Cmd>Trouble lsp_outgoing_calls<CR>", desc = "Outgoing Calls" }
        maps.n["gL"] =
          { "<Cmd>Trouble diagnostics toggle filter.buf=0 win.type=float<CR>", desc = "Trouble Diagnostics Float" }
      end,
    },
  },
  opts = function()
    local get_icon = require("astroui").get_icon
    local lspkind_avail, lspkind = pcall(require, "lspkind")
    return {
      auto_preview = false,
      focus = true,
      keys = {
        ["<ESC>"] = "close",
        ["q"] = "close",
      },
      icons = {
        indent = {
          fold_open = get_icon "FoldOpened",
          fold_closed = get_icon "FoldClosed",
        },
        folder_closed = get_icon "FolderClosed",
        folder_open = get_icon "FolderOpen",
        kinds = lspkind_avail and lspkind.symbol_map,
      },
    }
  end,
  specs = {
    { "lewis6991/gitsigns.nvim", optional = true, opts = { trouble = true } },
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { lsp_trouble = true } },
    },
  },
}
