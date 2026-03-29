return {
	-- USAGE: ":Dotnet"
	"GustavEikaas/easy-dotnet.nvim", -- One of the crazies plugins I have ever found, literally complete dotnet IDE experience
	ft = { "cs", "razor", "blazor" }, -- load up only on dotnet relevant files
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		require("easy-dotnet").setup({
			lsp = {
				enabled = false,
				auto_refresh_codelens = false,
			},
			-- debugger = {
			-- 	-- bin_path = nil,    -- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
			-- 	-- bin_path = vim.fn.expand("~") .. "/.vsdbg/vsdbg", -- Use this instead of netcoredbg because it is way faster
			-- 	-- apply_value_converters = true,
			-- 	-- auto_register_dap = true,
			-- },
		})
	end,
}
