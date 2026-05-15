local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    cmake = { "cmake_format" },
    json = { "jq" },
    yaml = { "yamlfmt" },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_format = "never",
  },
})

vim.keymap.set("n", "<leader>f", function()
  conform.format({ async = true, lsp_format = "never" })
end, { silent = true, desc = "Format current buffer" })
