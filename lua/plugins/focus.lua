return {
  "nvim-focus/focus.nvim",
  version = "*",
  opts = function()
    local ignore_filetypes = { "neo-tree", "toggleterm", "noice", "OverseerList", "DiffviewFiles", "qf" }
    local ignore_buftypes = { "nofile", "prompt", "popup" }
    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
    return {
      ui = {
        number = false,
        relativenumber = false,
        hybridnumber = false,
        absolutenumber_unfocussed = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = {
          enable = false,
        },
        signcolumn = false,
        winhighlight = false,
      },
      vim.api.nvim_create_autocmd("WinEnter", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for BufType",
      }),

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for FileType",
      }),
    }
  end,
  keys = {
    { mode = { "n" }, "<C-w>m", ":FocusToggle<CR>", desc = "Toggle focus" },
    { mode = { "n" }, "<C-w>z", ":FocusMaxOrEqual<CR>", desc = "Toggle focus max" },
  },
}
