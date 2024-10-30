return {
  "jlanzarotta/bufexplorer",
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<leader>o"] = { "<cmd>BufExplorer<CR>", desc = "BufExplorer" }
    end,
  },
}
