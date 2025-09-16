-- This is coming from a custom mason registry because of https://github.com/mason-org/mason-registry/pull/6330
-- source: https://github.com/Crashdummyy/roslynLanguageServer?tab=readme-ov-file
-- which monitors https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/, as described in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#roslyn_ls
return {
    name = "roslyn",
    settings = {
        ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
        },
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
        }
    }
}
