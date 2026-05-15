vim.cmd [[packadd alpha-nvim]]

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                      ",
  "                  Code. Build. Repeat.                ",
  "                                                      ",
}
dashboard.section.footer.val = {
  "                                                      ",
  "                  ┌─────────────────┐                 ",
  "                  │    ROBOTICS     │                 ",
  "                  └─────────────────┘                 ",
  "                                                      ",
}

-- 메뉴 버튼 설정
dashboard.section.buttons.val = {
  dashboard.button("e", "📄 > 새 파 일 열 기", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "🔎 > 파 일 찾 기", ":Telescope find_files <CR>"),
  dashboard.button("r", "🗂️ > 최 근 파 일", ":Telescope oldfiles <CR>"),
  dashboard.button("g", "🔍 > grep 문자열 찾기", ":Telescope live_grep<CR>"),
  dashboard.button("a", "🚀 > Launch 파일 탐색", ":Telescope find_files search_dirs=src prompt_title=launch<CR>"),
  dashboard.button("u", "⬆️ > 플러그인 업데이트", ":PlugUpdate<CR>"),
  -- dashboard.button("l", "📜 > LSP 로그 열기", ":e $HOME/.cache/nvim/lsp.log<CR>"),
  dashboard.button("c", "⚙️ > Neovim 설정 열기", ":e ~/.config/nvim/init.lua<CR>"),
  dashboard.button("q", "❌>  종 료", ":qa<CR>"),
}

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true 

-- 시작 화면 설정 적용
alpha.setup(dashboard.config)
