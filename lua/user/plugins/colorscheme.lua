return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                color_overrides = {
                    mocha = {
                        base = "#131111",
                    },
                }
            }

            vim.cmd [[
                try
                    colorscheme catppuccin
                catch
                    colorscheme default
                endtry
            ]]
        end,
    }
}
