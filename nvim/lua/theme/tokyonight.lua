require("tokyonight").setup({
  style = "night", -- night | storm | moon | day 중 선택
  transparent = true, -- true면 배경이 투명
  terminal_colors = true, -- 터미널 색상도 변경

  styles = {
    comments = { italic = true }, -- 주석은 명확하게 평문 스타일
    keywords = { italic = false }, -- 키워드는 강조 대신 또렷하게
    functions = { bold = true }, -- 함수 이름을 돋보이게
    variables = {},
  },

  sidebars = { "qf", "help", "terminal", "packer", "NvimTree" }, -- 밝기 낮추는 사이드바
  dim_inactive = true, -- 비활성 창은 살짝 어둡게
  lualine_bold = true, -- lualine 텍스트를 굵게

  on_highlights = function(hl, c)
    hl.LineNr = { fg = c.blue }
    hl.CursorLineNr = { fg = c.orange, bold = true }
    hl.CursorLine = { bg = c.bg_highlight }
    hl.Visual = { bg = "#334155" } -- 선택 영역 색상
    hl.Search = { fg = c.bg, bg = c.orange, bold = true }
  end,
})

vim.cmd("colorscheme tokyonight")
