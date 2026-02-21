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

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    vim.cmd("colorscheme evergarden")
                end,
            })
        end,
    }
}
