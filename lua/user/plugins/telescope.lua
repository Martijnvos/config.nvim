require("telescope").load_extension("ui-select")

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fde", function() builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "<leader>fdw", function() builtin.diagnostics({ severity = vim.diagnostic.severity.WARN }) end)
vim.keymap.set("n", "<leader>fdi", function() builtin.diagnostics({ severity = vim.diagnostic.severity.INFO }) end)
vim.keymap.set("n", "<leader>fdh", function() builtin.diagnostics({ severity = vim.diagnostic.severity.HINT }) end)

vim.keymap.set("n", "<leader>gf", builtin.git_files)
vim.keymap.set("n", "<leader>gc", builtin.git_commits)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>gt", builtin.git_stash)
