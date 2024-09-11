return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    { "AstroNvim/astroui", opts = { icons = { Wtf = "" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<leader>s"
        maps.n[prefix] = { desc = require("astroui").get_icon("Wtf", 1, true) .. "Diagnostic search" }

        maps.n[prefix .. "f"] = { function() require("wtf").search() end, desc = "Search diagnostic with Google" }
        maps.n[prefix .. "h"] =
          { function() require("wtf").history() end, desc = "Populate the quickfix list with previous chat history" }
        maps.n[prefix .. "g"] =
          { function() require("wtf").grep_history() end, desc = "Grep previous chat history with Telescope" }
      end,
    },
  },
}
