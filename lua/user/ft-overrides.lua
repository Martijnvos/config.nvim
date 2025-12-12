vim.filetype.add({
    pattern = {
        -- See https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/#comments-in-appsettingsjson
        ['.*/appsettings.*%.json'] = 'jsonc',
    },
})
