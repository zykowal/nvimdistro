return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  opts = {
    keymaps = {
      accept_suggestion = "<C-l>",
      accept_word = "<C-[>",
    },
    log_level = "warn",
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
  },
  dependencies = {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      -- Inject codeium into cmp sources, with high priority
      table.insert(opts.sources, 1, {
        name = "supermaven",
        group_index = 1,
        priority = 1000,
      })
    end,
  },
}
