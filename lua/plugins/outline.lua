return {
  "hedyhli/outline.nvim",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<leader>lS"] = { "<cmd>Outline<CR>", desc = "Symbols Outline" }
    end,
  },
  config = function()
    require("outline").setup {
      -- Your setup opts here (leave empty to use defaults)
    }
  end,
}
