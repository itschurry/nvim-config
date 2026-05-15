require("render-markdown").setup({})

vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", {
  silent = true,
  desc = "Toggle markdown render",
})

vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<CR>", {
  silent = true,
  desc = "Preview markdown render",
})
