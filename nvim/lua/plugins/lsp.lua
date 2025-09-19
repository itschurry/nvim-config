-- mason은 "설치"만 맡기고, 설정/활성화는 core API로
local mason = require("mason")
local mlsp  = require("mason-lspconfig")
mason.setup()
mlsp.setup { ensure_installed = { "clangd", "pyright", "dockerls", "jsonls", "yamlls", "bashls" } }

-- 진단 표시 취향 유지
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  severity_sort = true,
})

-- on_attach: 키맵은 최신 방식으로
local function on_attach(client, bufnr)
  local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true }) end
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'K',  vim.lsp.buf.hover)
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
end

-- cmp-nvim-lsp capabilities 그대로
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = { "utf-16" }

-- ⬇️ 핵심: 새 API로 clangd 구성
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--pch-storage=memory",
    "--j=6",
    "--log=error",
    "--limit-results=30",
    "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build"
  },
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = { "compile_commands.json", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- 활성화
vim.lsp.enable('clangd')
