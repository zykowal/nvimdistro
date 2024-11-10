return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    require("nvim-treesitter.configs").setup {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = false,
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
    }
  end,
}
