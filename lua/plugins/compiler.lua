return {
  "Zeioth/compiler.nvim",
  dependencies = {
    {
      "stevearc/overseer.nvim",
      opts = {
        task_list = { -- this refers to the window that shows the result
          direction = "bottom",
          min_height = 25,
          max_height = 25,
          default_detail = 1,
          bindings = {
            ["q"] = function() vim.cmd "OverseerClose" end,
          },
        },
      },
      config = function(_, opts) require("overseer").setup(opts) end,
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        maps.n["<leader>Mo"] = { "<cmd>CompilerOpen<CR>", desc = "Compiler Open" }
      end,
    },
  },
  cmd = { "CompilerOpen", "CompilerToggleResults" },
  opts = {},
}
