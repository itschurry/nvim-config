local term = require("utils.terminal")

local DEFAULT_CONFIG = ".nvim-rsync.lua"

local function config_path()
  return vim.g.rsync_config_path or (vim.fn.getcwd() .. "/" .. DEFAULT_CONFIG)
end

local function trim_slash(value)
  return value:gsub("/+$", "")
end

local function join(base, subpath)
  base = trim_slash(base)
  if not subpath or subpath == "" then
    return base .. "/"
  end
  return base .. "/" .. subpath:gsub("^/+", ""):gsub("/+$", "") .. "/"
end

local function load_config()
  local path = config_path()
  assert(vim.fn.filereadable(path) == 1, "Rsync config not found: " .. path)

  local config = dofile(path)
  assert(type(config) == "table", "Rsync config must return a table: " .. path)
  assert(type(config.local_base) == "string" and config.local_base ~= "", "Rsync config needs local_base")
  assert(type(config.remote_base) == "string" and config.remote_base ~= "", "Rsync config needs remote_base")
  assert(type(config.exclude) == "table", "Rsync config needs exclude")
  assert(type(config.flags) == "table", "Rsync config needs flags")

  return {
    local_base = vim.fn.expand(config.local_base),
    remote_base = config.remote_base,
    exclude = config.exclude,
    flags = config.flags,
  }
end

local function shell_join(args)
  return table.concat(vim.tbl_map(vim.fn.shellescape, args), " ")
end

local function build_command(direction, subpath)
  local config = load_config()
  local from = direction == "up" and join(config.local_base, subpath) or join(config.remote_base, subpath)
  local to = direction == "up" and join(config.remote_base, subpath) or join(config.local_base, subpath)
  local args = { "rsync" }

  vim.list_extend(args, config.flags)
  for _, item in ipairs(config.exclude) do
    table.insert(args, "--exclude=" .. item)
  end
  table.insert(args, from)
  table.insert(args, to)

  return shell_join(args)
end

local function rsync(direction, subpath)
  term.run_in_popup_terminal(build_command(direction, subpath))
end

vim.api.nvim_create_user_command("RsyncUp", function(opts)
  rsync("up", opts.args)
end, {
  nargs = "?",
  desc = "Rsync local to remote from .nvim-rsync.lua",
  complete = "dir",
})

vim.api.nvim_create_user_command("RsyncDown", function(opts)
  rsync("down", opts.args)
end, {
  nargs = "?",
  desc = "Rsync remote to local from .nvim-rsync.lua",
  complete = "file",
})

local function confirm_rsync(direction)
  local subpath = vim.fn.input("Subpath to sync (empty = all): ")
  local label = subpath ~= "" and subpath or "all"
  local choice = vim.fn.input(("Rsync %s %s ? (Y/n): "):format(direction, label))
  if choice == "" or choice:lower() == "y" then
    rsync(direction, subpath)
  end
end

vim.keymap.set("n", "<leader>ru", function()
  confirm_rsync("up")
end, { silent = true, desc = "Rsync up" })

vim.keymap.set("n", "<leader>rd", function()
  confirm_rsync("down")
end, { silent = true, desc = "Rsync down" })
