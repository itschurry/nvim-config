local treesitter = require("nvim-treesitter")

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local languages = {
  "c",
  "cpp",
  "cmake",
  "python",
  "dockerfile",
  "bash",
  "regex",
  "json",
  "yaml",
  "lua",
  "vim",
  "markdown",
  "markdown_inline",
}

treesitter.install(languages):wait(300000)

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@struct", { link = "Structure" })
vim.api.nvim_set_hl(0, "@interface", { link = "Structure" })
vim.api.nvim_set_hl(0, "@enum", { link = "Structure" })

require("nvim-autopairs").setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
