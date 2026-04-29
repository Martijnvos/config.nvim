-- Helper functions
local function jump_to_last_cursor_position(opts)
    local ft = vim.bo[opts.buf].filetype
    if (ft:match("commit") or ft:match("rebase")) then
        return
    end
    local markpos = vim.api.nvim_buf_get_mark(0, "\"")
    local line = markpos[1]
    local col = markpos[2]
    if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
        vim.api.nvim_win_set_cursor(0, { line, col })
    end
end

-- Autocommands
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    group = augroup,
    desc =
    "Jump to the last known cursor position. Don't when the position is invalid, when inside an event handler and for a commit message (it's likely a different one than last time)",
    callback = jump_to_last_cursor_position
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    desc = "Enable treesitter highlighting, skip large files",
    callback = function(args)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > max_filesize then
            return
        end
        pcall(vim.treesitter.start)
    end,
})
