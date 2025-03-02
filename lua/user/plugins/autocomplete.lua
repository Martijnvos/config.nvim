return {
    {
        "hrsh7th/nvim-cmp", -- Autocompletion plugin
        dependencies = {
            "L3MON4D3/LuaSnip", -- Snippets plugin
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
        },
        config = function()
            require "user.autocomplete"
        end
    }
}
