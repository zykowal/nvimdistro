return {
  "rachartier/tiny-code-action.nvim",
  event = "LspAttach",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>la"] = {
              function() require("tiny-code-action").code_action() end,
              desc = "LSP code action",
              cond = "textDocument/codeAction",
            },
          },
          v = {
            ["<Leader>la"] = {
              function() require("tiny-code-action").code_action() end,
              desc = "LSP code action",
              cond = "textDocument/codeAction",
            },
          },
        },
      },
    },
  },
  config = function()
    require("tiny-code-action").setup {
      backend = "vim",
    }
  end,
}
