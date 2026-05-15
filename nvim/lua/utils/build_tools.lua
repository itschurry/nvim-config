-- ~/.config/nvim/lua/utils/build_tools.lua
-- local term = require("utils.terminal")

vim.g.build_tool = vim.g.build_tool or "catkin"            -- 필요할 때 "colcon" 으로 토글
assert(vim.g.build_tool == "catkin" or vim.g.build_tool == "colcon", "build_tool must be catkin or colcon")

----------------------------------------------------------------------
-- 명령 문자열 빌더 (패키지 선택 지원)
----------------------------------------------------------------------
local function build_cmd(pkg)
  if vim.g.build_tool == "catkin" then
    local base = "source /opt/ros/noetic/setup.bash && catkin config --install"
    local build = "catkin build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release -j4"
    if pkg then build = build .. " " .. pkg end
    local post = "python3 /home/rdv/catkin_ws/merge_compile_commands.py"
    return ("bash -c '%s && %s && %s'"):format(base, build, post)
  else
    local base = "source /opt/ros/humble/setup.bash"
    local build = "colcon build --parallel-workers 4 --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release"
    if pkg then build = build .. " --packages-select " .. pkg end
    return ("bash -c '%s && %s'"):format(base, build)
  end
end

local function clean_cmd(pkg)
  if vim.g.build_tool == "catkin" then
    return pkg and ("catkin clean --yes " .. pkg) or "catkin clean --yes"
  else -- colcon
    if pkg then
      -- colcon clean은 직접 지원하지 않으므로 수동 삭제 방식
      return ("rm -rf build/%s install/%s log"):format(pkg, pkg)
    else
      return "rm -rf build install log"
    end
  end
end

local function run_quickfix_job(cmd, label)
  local lines = {}

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      vim.list_extend(lines, vim.tbl_filter(function(line) return line ~= "" end, data))
    end,
    on_stderr = function(_, data)
      vim.list_extend(lines, vim.tbl_filter(function(line) return line ~= "" end, data))
    end,
    on_exit = function(_, code)
      vim.fn.setqflist({}, "r", {
        title = label,
        lines = lines,
      })
      if code == 0 then
        vim.cmd("cclose")
        vim.notify(label .. " succeeded", vim.log.levels.INFO)
      else
        vim.cmd("copen")
        vim.notify(label .. " failed", vim.log.levels.ERROR)
      end
    end,
  })
end
----------------------------------------------------------------------
-- 공통 프롬프트 → 확인 → 실행 함수
----------------------------------------------------------------------
local function confirm_and_run(kind)   -- kind = "build" | "clean"
  local label = (kind == "build") and "Build" or "Clean"
  local pkg = vim.fn.input(label .. " package (empty=all): ")
  local cmd = (kind == "build") and build_cmd(pkg ~= "" and pkg or nil)
                             or  clean_cmd(pkg ~= "" and pkg or nil)

  local ok = vim.fn.input(label .. " " .. (pkg ~= "" and pkg or "all") .. " ? (Y/n): ")
  if ok == "" or ok:lower() == "y" then
    vim.notify(label .. " started: " .. cmd, vim.log.levels.INFO)
    run_quickfix_job(cmd, label)
  else
    vim.notify(label .. " canceled", vim.log.levels.INFO)
  end
end

----------------------------------------------------------------------
-- 키매핑: <leader>cb / <leader>cc
----------------------------------------------------------------------
vim.keymap.set("n", "<leader>cb", function() confirm_and_run("build") end,
  { desc = "[catkin/colcon] Build (prompt)", silent = true })

vim.keymap.set("n", "<leader>cl", function() confirm_and_run("clean") end,
  { desc = "[catkin/colcon] Clean (prompt)", silent = true })
