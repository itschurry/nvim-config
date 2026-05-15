require("flutter-tools").setup {
  -- flutter path, flutter sdk 경로가 PATH에 있으면 생략 가능
  flutter_path = "flutter",
  fvm = false, -- fvm 사용 시 true로 변경
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "Error",
    prefix = ">> ",
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
  }
}
