return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  config = true,
  dependencies = {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          ["<leader>ld"] = {
            "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
            desc = "goto preview definition",
          },

          ["<leader>lD"] = {
            "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
            desc = "goto preview declaration",
          },

          ["<leader>lT"] = {
            "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
            desc = "goto preview implementation",
          },

          ["<leader>lt"] = {
            "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
            desc = "goto preview type definition",
          },

          ["<leader>lp"] = {
            "<cmd>lua require('goto-preview').close_all_win()<CR>",
            desc = "close all preview windows",
          },
        },
      },
    },
  },
}
