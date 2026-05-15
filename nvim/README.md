# Neovim Config

Neovim용 Lua 설정이다. 플러그인은 별도 매니저 없이 `site/pack/plugins/start`에 직접 `git clone`해서 쓴다.

## 설치

```sh
git clone <repo-url> ~/.config/nvim
nvim
```

처음 실행하면 `lua/plugins/init.lua`에 정의된 플러그인을 자동 설치한다. 설치가 끝나면 Neovim을 한 번 재시작해.

포맷 기능을 쓰려면 필요한 포맷터를 먼저 설치해.

```vim
:MasonInstall stylua ruff clang-format cmakelang jq yamlfmt
```

## 실행

```sh
nvim
```

플러그인 업데이트:

```vim
:PlugUpdate
```

## 디렉터리 구조

```text
init.lua
lua/core/                 기본 옵션, 키맵, autocommand, 프로젝트 설정
lua/plugins/init.lua      플러그인 설치/업데이트
lua/plugins/ui/           화면, 트리, 상태줄, 대시보드
lua/plugins/editor/       포맷, 폴딩, Treesitter, Markdown 렌더링
lua/plugins/completion/   자동완성, 스니펫
lua/plugins/language/     LSP, DAP
lua/plugins/navigation/   Telescope 탐색
lua/plugins/integrations/ Copilot, Flutter 같은 선택 연동
lua/theme/                colorscheme 설정
lua/utils/                빌드, rsync, 터미널 유틸
```

## 주요 설정

- Leader: `,`
- 테마: `tokyonight`
- LSP: `mason.nvim`, `mason-lspconfig.nvim`, Neovim LSP API
  - 활성 서버: `clangd`, `pyright`, `dockerls`, `jsonls`, `yamlls`
- 자동완성: `nvim-cmp`, `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp_luasnip`
- 저장 시 포맷: `conform.nvim`
  - Lua: `stylua`
  - Python: `ruff format`
  - C/C++: `clang-format`
  - CMake: `cmake-format`
  - JSON: `jq`
  - YAML: `yamlfmt`
- Markdown 보기: `render-markdown.nvim`
  - 토글: `<leader>mt`
  - 분할 미리보기: `<leader>mp`
  - 명령어: `:RenderMarkdown toggle`, `:RenderMarkdown preview`
- 주석: `<leader>/`, `<M-/>`
- 파일 탐색: `<C-n>` (`nvim-tree`, 오른쪽 80컬럼)
- 심볼 탐색: `<C-t>`

## 단축키

Leader 키는 `,`다.

### 기본

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<leader>nh` | 검색 하이라이트 제거 |
| Normal | `<leader>tn` | 줄 번호/상대 줄 번호 끄기 |
| Normal | `<leader>tnr` | 줄 번호/상대 줄 번호 켜기 |
| Normal | `<leader>u` | redo |
| Normal/Visual | `<leader>y` | 시스템 클립보드로 yank |
| Normal | `<leader>P` | 시스템 클립보드에서 paste |
| Normal | `<leader>yr` | 기본 레지스터 출력 |

### 창/버퍼

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<leader>z` | 이전 버퍼로 이동 |
| Normal | `<leader>x` | 다음 버퍼로 이동 |
| Normal | `<leader>d` | 현재 버퍼 닫기 |
| Normal | `<leader>p` | BufferLine 버퍼 선택 |
| Normal | `<leader>pd` | BufferLine 버퍼 선택 후 닫기 |
| Normal | `<leader>h` | 현재 버퍼를 왼쪽 split으로 이동 |
| Normal | `<leader>j` | 현재 버퍼를 아래 split으로 이동 |
| Normal | `<leader>k` | 현재 버퍼를 위 split으로 이동 |
| Normal | `<leader>l` | 현재 버퍼를 오른쪽 split으로 이동 |

### 탐색

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<C-n>` | NvimTree 토글 |
| Normal | `<C-t>` | Aerial 심볼 아웃라인 토글 |
| Normal | `<leader>ff` | Telescope 파일 찾기 |
| Normal | `<leader>fF` | Telescope Git 파일 찾기 |
| Normal | `<leader>fg` | Telescope live grep |
| Normal | `<leader>fb` | Telescope 버퍼 목록 |
| Normal | `<leader>fh` | Telescope help tags |
| Normal | `<leader>fo` | Telescope 최근 파일 |
| Normal | `<leader>fs` | Telescope 문서 심볼 |
| Normal | `<leader>fr` | Telescope 참조 찾기 |
| Normal | `<leader>fd` | 버퍼 2개 선택해서 diff |
| Insert | `<C-n>` | Telescope 선택 항목 아래로 이동 |
| Insert | `<C-p>` | Telescope 선택 항목 위로 이동 |

### LSP/진단/포맷

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `gd` | 정의로 이동 |
| Normal | `gr` | 참조 찾기 |
| Normal | `K` | hover 문서 보기 |
| Normal | `gl` | 현재 위치 진단 팝업 |
| Normal | `<leader>gl` | 전체 진단 Telescope로 보기 |
| Normal | `<leader>ca` | code action |
| Normal | `<leader>rn` | symbol rename |
| Normal | `<leader>f` | 현재 버퍼 포맷 |
| Normal | `<F8>` | Python 파일에서 `Autopep8()` 실행 |

### 주석/폴딩

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal/Visual | `<leader>/` | 라인 주석 토글 |
| Normal/Visual | `<M-/>` | 블록 주석 토글 |
| Normal | `<leader>zR` | 모든 fold 열기 |
| Normal | `<leader>zM` | 모든 fold 닫기 |
| Normal | `<leader>za` | 현재 fold 토글 |

### Markdown

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<leader>mt` | Markdown 렌더링 토글 |
| Normal | `<leader>mp` | Markdown 렌더링 분할 미리보기 |

### 자동완성/스니펫

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Insert | `<C-s>` | completion 메뉴 열기 |
| Insert | `<CR>` | completion 선택 확정 |
| Insert | `<Tab>` | 다음 completion 항목 |
| Insert | `<S-Tab>` | 이전 completion 항목 |
| Insert/Select | `<C-K>` | LuaSnip expand 또는 다음 jump |
| Insert/Select | `<C-J>` | LuaSnip 이전 jump |

### 빌드/Rsync/터미널

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<leader>cb` | catkin/colcon 빌드 |
| Normal | `<leader>cl` | catkin/colcon 클린 |
| Normal | `<leader>ru` | rsync 업로드 |
| Normal | `<leader>rd` | rsync 다운로드 |
| Terminal | `<Esc>` | popup terminal 닫기 |

### 디버그

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Normal | `<F5>` | DAP continue |
| Normal | `<F10>` | DAP step over |
| Normal | `<F11>` | DAP step into |
| Normal | `<F12>` | DAP step out |

### Copilot

`plugins.integrations.copilot`을 `init.lua`에서 활성화했을 때만 쓴다.

| 모드 | 키 | 동작 |
| --- | --- | --- |
| Insert | `<C-j>` | 제안 수락 |
| Insert | `<C-l>` | 다음 제안 |
| Insert | `<C-h>` | 이전 제안 |
| Insert | `<C-e>` | 제안 닫기 |

### Alpha 대시보드

시작 화면에서만 동작한다.

| 키 | 동작 |
| --- | --- |
| `e` | 새 파일 열기 |
| `f` | 파일 찾기 |
| `r` | 최근 파일 |
| `g` | grep 문자열 찾기 |
| `a` | `src` 아래 launch 파일 탐색 |
| `u` | 플러그인 업데이트 |
| `c` | Neovim 설정 열기 |
| `q` | 종료 |

## 명령어

| 명령어 | 동작 |
| --- | --- |
| `:PlugUpdate` | 직접 관리하는 플러그인 업데이트 |
| `:RsyncUp [path]` | 로컬에서 원격으로 rsync |
| `:RsyncDown [path]` | 원격에서 로컬로 rsync |

## 프로젝트별 설정

프로젝트 루트나 상위 디렉터리에 `.nvim.lua`를 두면 시작할 때 바로 실행한다.

```lua
vim.g.build_tool = "colcon"
vim.g.rsync_config_path = vim.fn.getcwd() .. "/.nvim-rsync.lua"
```

`vim.g.build_tool` 값:

- `catkin`: ROS Noetic `catkin build`
- `colcon`: ROS Humble `colcon build`

## 빌드 QuickFix

빌드는 quickfix 목록으로 결과를 넣는다.

```vim
<leader>cb
<leader>cl
:cnext
:cprev
```

## Rsync 설정

프로젝트 루트에 `.nvim-rsync.lua`를 만들어야 한다. 없으면 `:RsyncUp`, `:RsyncDown`은 바로 실패한다.

```lua
return {
  local_base = "~/catkin_ws/src",
  remote_base = "user@192.168.0.10:/home/user/workspace/src",
  exclude = {
    ".git",
    "build/",
    "log/",
    "*.log",
  },
  flags = { "-avz", "--progress" },
}
```

실행:

```vim
:RsyncUp
:RsyncDown
:RsyncUp package_name
:RsyncDown package_name
```

기본 설정 파일 경로를 바꾸려면 `init.lua` 쪽에서 직접 지정해.

```lua
vim.g.rsync_config_path = "/absolute/path/to/rsync.lua"
```

## 주의

Alpha 대시보드는 설치된 명령만 연결한다. `Telescope projects`, `SessionManager`처럼 플러그인이 없는 명령은 넣지 않는다.
