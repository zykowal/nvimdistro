if true then return {} end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = "<Leader>a"

        maps.n[prefix] = { desc = "CodeCompanion" }
        maps.n[prefix .. "e"] = { "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" }
        maps.v[prefix .. "e"] = { "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" }

        maps.n[prefix .. "o"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions" }
        maps.v[prefix .. "o"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions" }

        maps.n[prefix .. "a"] = { "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanionChat" }
        maps.v[prefix .. "a"] = { "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanionChat" }
      end,
    },
  },
  config = true,
  opts = {
    strategies = {
      chat = {
        adapter = "ollama",
      },
      inline = {
        adapter = "ollama",
      },
    },
    adapters = {
      llama3 = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "deepseek", -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = "deepseek-r1:1.5b",
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
    },
  },
  specs = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.filetypes = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "codecompanion" })
      end,
    },
  },
}
