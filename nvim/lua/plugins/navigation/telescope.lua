local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git", "build", "install" },
    mappings = {
      i = { ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous },
    },
  },
})

-- Telescope 명령어에 키맵 연결
local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true })
map("n", "<leader>fF", "<cmd>Telescope git_files<CR>", { silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",   { silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { silent = true })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { silent = true })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })


-- Fuction for selecting buffers and performing vimdiff
function DiffBuffers()
    require('telescope.builtin').buffers {
        attach_mappings = function(_, map)
            local actions = require('telescope.actions')
            local state = require('telescope.actions.state')

            local buffer_seclection = {}

            map('i', '<CR>', function(prompt_bufnr)
                local selection = state.get_selected_entry()
                table.insert(buffer_seclection, selection.bufnr)

                if #buffer_seclection == 2 then
                    actions.close(prompt_bufnr)
                    vim.cmd('vsplit')
                    vim.cmd('buffer ' .. buffer_seclection[1])
                    vim.cmd('diffthis')
                    vim.cmd('wincmd w')
                    vim.cmd('buffer ' .. buffer_seclection[2])
                    vim.cmd('diffthis')
                else
                    actions.move_selection_next(prompt_bufnr)
                end
            end)
            return true
        end
    }
end
vim.api.nvim_set_keymap('n', '<leader>fd', ':lua DiffBuffers()<CR>', { noremap = true, silent = true })
