local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n",
  "<leader>lE",
  function() vim.cmd.RustLsp "explainError" end,
  { silent = true, buffer = bufnr, desc = "Explain Rust Error" }
)
vim.keymap.set(
  "n",
  "<leader>le",
  function() vim.cmd.RustLsp "renderDiagnostic" end,
  { silent = true, buffer = bufnr, desc = "Render Rust Diagnostic" }
)
vim.keymap.set(
  "n",
  "<leader>lo",
  function() vim.cmd.RustLsp "openDocs" end,
  { silent = true, buffer = bufnr, desc = "Open Rust Docs" }
)
