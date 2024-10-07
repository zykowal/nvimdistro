return {
  "dnlhc/glance.nvim",
  dependencies = {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["gd"] = { "<Cmd>Glance definitions<CR>", desc = "Show Definitions" }
      maps.n["gr"] = { "<Cmd>Glance references<CR>", desc = "Show References" }
      maps.n["gI"] = { "<Cmd>Glance implementations<CR>", desc = "Implementations" }
      maps.n["gD"] = { "<Cmd>Glance type_definitions<CR>", desc = "Type Definitions" }
    end,
  },
  opts = function()
    local actions = require("glance").actions
    return {
      height = 20,
      mappings = {
        list = {
          ["<C-h>"] = actions.enter_win "preview",
          ["<leader>l"] = false,
        },
        preview = {
          ["<C-l>"] = actions.enter_win "list",
          ["<leader>l"] = false,
        },
      },
      border = {
        enable = true,
      },
      theme = {
        enable = false,
      },
      hooks = {
        before_open = function(results, open, jump, _)
          local uri = vim.uri_from_bufnr(0)
          if #results == 1 then
            local target_uri = results[1].uri or results[1].targetUri

            if target_uri == uri then
              jump(results[1])
            else
              open(results)
            end
          else
            open(results)
          end
        end,
      },
    }
  end,
}
