return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      mode = { "n" },
      "<leader>sd",
      function() require("wtf").search() end,
      desc = "Search diagnostic with Google",
    },
  },
}
