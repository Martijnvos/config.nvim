return {
    {
        "everviolet/nvim",
        name = "evergarden",
        priority = 1000,
        config = function()
            require("evergarden").setup {
                theme = {
                    variant = "winter",
                },
                overrides = {
                    Normal = {
                        bg = "#181A1C",
                    },
                }
            }

            vim.cmd [[
                try
                    colorscheme evergarden
                catch
                    colorscheme default
                endtry
            ]]
        end,
    }
}
