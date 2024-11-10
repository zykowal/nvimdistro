return {
  "jlanzarotta/bufexplorer",
  config = function() vim.keymap.set("n", "<leader>o", "<cmd>BufExplorer<CR>", { desc = "BufExplorer" }) end,
}
