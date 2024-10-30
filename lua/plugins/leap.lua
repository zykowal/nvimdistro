return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          leap_cursor = {
            {
              event = "User",
              pattern = "LeapEnter",
              callback = function()
                vim.cmd.hi("Cursor", "blend=100")
                vim.opt.guicursor:append { "a:Cursor/lCursor" }
              end,
            },
            {
              event = "User",
              pattern = "LeapLeave",
              callback = function()
                vim.cmd.hi("Cursor", "blend=0")
                vim.opt.guicursor:remove { "a:Cursor/lCursor" }
              end,
            },
          },
        },
        mappings = {
          n = {
            ["f"] = { "<Plug>(leap)", desc = "Leap forward" },
            ["F"] = { "<Plug>(leap-from-window)", desc = "Leap from window" },
            ["R"] = {
              function() require("leap.remote").action() end,
              desc = "Leap remote",
            },
          },
          x = {
            ["f"] = { "<Plug>(leap-forward)", desc = "Leap forward" },
            ["F"] = { "<Plug>(leap-backward)", desc = "Leap backward" },
          },
          o = {
            ["f"] = { "<Plug>(leap-forward)", desc = "Leap forward" },
            ["F"] = { "<Plug>(leap-backward)", desc = "Leap backward" },
            ["R"] = {
              function() require("leap.remote").action() end,
              desc = "Leap remote",
            },
          },
        },
      },
    },
  },
  opts = {
    safe_labels = {},
  },
}
