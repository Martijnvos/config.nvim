local cached_branch = ""

local function fetch_git_branch()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    local branchname = handle:read("*a")
    handle:close()

    if string.len(branchname) > 0 then
        cached_branch = " " .. branchname .. " "
    else
        cached_branch = ""
    end
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("StatuslineBranch", { clear = true }),
    callback = fetch_git_branch,
})

fetch_git_branch()

function construct_status_line()
    return table.concat {
        "%#PmenuSel#", -- Popup menu selected highlight color
        cached_branch,
        "%#LineNr#",   -- Line number highlight color
        " %F",         -- Full file path
        " %m",         -- Modified flag
        "%r",          -- Readonly flag
        "%=",          -- Separation point between left and right aligned items
        "%#CursorColumn#",
        " %y", -- Type of file
        " " .. (string.len(vim.bo.fileencoding) > 0 and vim.bo.fileencoding or vim.o.encoding),
        " [" .. vim.bo.fileformat .. "]",
        " %p%%", -- Percentage through file in lines
        " %c",   -- Current column count
        " "      -- Closing space for breathing room
    }
end

vim.opt.statusline = "%!luaeval(\"construct_status_line()\")"
