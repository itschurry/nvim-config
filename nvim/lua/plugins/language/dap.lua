local dap = require("dap")
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/usr/bin/lldb",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ",
        vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
}

vim.keymap.set("n", "<F5>",  function() dap.continue()   end)
vim.keymap.set("n", "<F10>", function() dap.step_over()  end)
vim.keymap.set("n", "<F11>", function() dap.step_into()  end)
vim.keymap.set("n", "<F12>", function() dap.step_out()   end)
