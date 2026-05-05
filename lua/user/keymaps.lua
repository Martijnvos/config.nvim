local map_key = vim.keymap.set

-- Leader key config
-- Use space as a leader key to make extra key combinations possible
vim.g.mapleader = " "

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map_key("", "<leader>te", ":tabedit <c-r>=expand(\"%:p:h\")<cr>/")

-- Remaining remaps
--
-- Center on search and line joining
map_key("n", "n", "nzzzv")
map_key("n", "N", "Nzzzv")
map_key("n", "J", "mzJ`z")

-- Undo with breakpoints
map_key("i", ",", ",<c-g>u")
map_key("i", ".", ".<c-g>u")
map_key("i", "!", "!<c-g>u")
map_key("i", "?", "?<c-g>u")

-- Repeat renaming with .
map_key("n", "cn", "*``cgn")
map_key("n", "cN", "*``cgN")
