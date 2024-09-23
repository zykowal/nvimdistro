return {
  "piersolenski/telescope-import.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  config = function() require("telescope").load_extension "import" end,
  keys = {
    { mode = { "n" }, "<leader>fi", ":Telescope import<CR>", desc = "Find import modules" },
  },
}
