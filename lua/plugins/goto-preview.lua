---@diagnostic disable: missing-parameter
return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  config = true,
  dependencies = {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<leader>ld"] = {
        function() require("goto-preview").goto_preview_definition() end,
        desc = "Definitions Preview",
      }
      maps.n["<leader>lD"] =
        { function() require("goto-preview").goto_preview_type_definition() end, desc = "Declaration Preview" }
      maps.n["<leader>lt"] = {
        function() require("goto-preview").goto_preview_implementation() end,
        desc = "Implementations Preview",
      }
      maps.n["<leader>lp"] = { function() require("goto-preview").close_all_win() end, desc = "Close All Preview" }
    end,
  },
}
