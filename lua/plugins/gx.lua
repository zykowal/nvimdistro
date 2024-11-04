return {
  "chrishrb/gx.nvim",
  lazy = true,
  cmd = { "Browse" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { -- lazy load when client is attached with `documentLink` support
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        opts = {
          mappings = {
            n = {
              gx = { "<cmd>Browse<cr>", desc = " Browse links", cond = "textDocument/documentLink" },
            },
            x = {
              gx = { "<cmd>Browse<cr>", desc = " Browse links", cond = "textDocument/documentLink" },
            },
          },
        },
      },
    },
    { -- add buffer local mapping to buffers with documnetLink supporting clients
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = {
            gx = { "<cmd>Browse<cr>", desc = " Browse links", cond = "textDocument/documentLink" },
          },
          x = {
            gx = { "<cmd>Browse<cr>", desc = " Browse links", cond = "textDocument/documentLink" },
          },
        },
      },
    },
  },
  config = true,
}
