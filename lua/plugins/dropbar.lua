return {
  "Bekaboo/dropbar.nvim",
  event = "UIEnter",
  opts = {
    menu = {
      scrollbar = {
        enable = false,
        background = true,
      },
      keymaps = {
        ["o"] = function()
          local menu = require("dropbar.utils").menu.get_current()
          if not menu then return end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
          if component then menu:click_on(component, nil, 1, "l") end
        end,
        ["f"] = function()
          local menu = require("dropbar.utils").menu.get_current()
          if not menu then return end
          menu:fuzzy_find_open()
        end,
      },
    },
  },
  specs = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      opts = function(_, opts) opts.winbar = nil end,
    },
  },
  keys = {
    { mode = { "n" }, "gj", function() require("dropbar.api").pick() end, desc = "Pick dropbar" },
  },
}
