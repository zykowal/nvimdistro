return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<leader>sd"] = {
          function() require("wtf").search() end,
          desc = "Search diagnostic with Google",
        }
      end,
    },
  },
}
