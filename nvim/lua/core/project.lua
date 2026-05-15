local configs = vim.fs.find(".nvim.lua", {
  upward = true,
  path = vim.fn.getcwd(),
  stop = vim.env.HOME,
})

if configs[1] then
  dofile(configs[1])
end
