require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,  -- ✨ 꼭 필요!
    debounce = 75,
    keymap = {
      accept = "<C-j>",    -- 인라인 제안 수락 키맵
      next = "<C-l>",      -- 다음 제안으로 이동 키맵
      prev = "<C-h>",      -- 이전 제안으로 이동 키맵
      dismiss = "<C-e>",   -- 제안 거부 키맵
    },
  },
  panel      = { enabled = true },
})
-- Copilot: TAB 키 기본 매핑 제거
vim.g.copilot_no_tab_map = true
