-- require('ufo').setup({
--   provider_selector = function(bufnr, filetype, buftype)
--     -- treesitter 우선, 없으면 indent fallback
--     return { 'treesitter', 'indent' }
--   end,
--   open_fold_hl_timeout = 150,
--   close_fold_kinds_for_ft = { 'imports', 'comment' },
--   preview = {
--     win_config = {
--       border = { '', '─', '', '', '', '─', '', '' },
--       winhighlight = 'Normal:Folded',
--       winblend = 0
--     },
--     mappings = {
--       scrollU = '<C-u>',
--       scrollD = '<C-d>',
--       jumpTop = '[',
--       jumpBot = ']'
--     }
--   }
-- })
--
-- vim.opt.foldcolumn = '1'        -- 좌측 폴딩 가이드라인
-- vim.opt.foldlevel = 99          -- 전체 열기
-- vim.opt.foldlevelstart = 99     -- 처음 열 때 열린 상태
-- vim.opt.foldenable = true       -- 폴딩 활성화
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'  -- 기존 foldexpr는 여기서 교체됨
--
-- -- 기존 zR/zM 그대로 사용 가능
-- vim.keymap.set('n', 'zK', function()
--   require('ufo').peekFoldedLinesUnderCursor()
-- end, { desc = "폴딩 미리보기 (ufo)" })

-- Fold 설정
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- Fold 키 매핑
-- vim.api.nvim_set_keymap('n', '<leader>zR', 'zR', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>zM', 'zM', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>za', 'za', { noremap = true, silent = true })
