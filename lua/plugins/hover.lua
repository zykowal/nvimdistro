return {
  "lewis6991/hover.nvim",
  lazy = true,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = { opt = { mousemoveevent = false } },
        mappings = {
          n = {
            gh = { function() require("hover").hover() end, desc = "Hover cursor" },
            gk = { function() require("hover").hover_select() end, desc = "Hover selection" },
            ["]h"] = { function() require("hover").hover_switch "next" end, desc = "Next hover source" },
            ["[h"] = { function() require("hover").hover_switch "previous" end, desc = "Previous hover source" },
          },
        },
      },
    },
  },
  opts = {
    init = function()
      require "hover.providers.lsp"
      require "hover.providers.gh"
      require "hover.providers.gh_user"
      require "hover.providers.jira"
      require "hover.providers.dap"
      require "hover.providers.fold_preview"
      require "hover.providers.diagnostic"
      require "hover.providers.man"
      require "hover.providers.dictionary"
    end,
  },
}
