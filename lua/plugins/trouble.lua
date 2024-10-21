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
      end,
    },
  },
  opts = function()
    local get_icon = require("astroui").get_icon
    local lspkind_avail, lspkind = pcall(require, "lspkind")
    return {
      auto_preview = false,
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
}
