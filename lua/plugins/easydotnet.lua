return {
    -- USAGE: ":Dotnet"
	"GustavEikaas/easy-dotnet.nvim", -- One of the crazies plugins I have ever found, literally complete dotnet IDE experience
	ft = { "cs", "razor", "blazor" }, -- load up only on dotnet relevant files
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		require("easy-dotnet").setup({
			lsp = {
				auto_refresh_codelens = false,
			},
		})

	end,
}
