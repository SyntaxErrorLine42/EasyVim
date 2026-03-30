return {
	-- USAGE: ":Dotnet"
	"GustavEikaas/easy-dotnet.nvim", -- One of the crazies plugins I have ever found, literally complete dotnet IDE experience
	ft = { "cs", "razor", "blazor" }, -- load up only on dotnet relevant files
    cmd = "Dotnet",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	commit = "ed5aabc5040395f2dd6c59263412ec3bed921b29",
	config = function()
		require("easy-dotnet").setup({
			lsp = {
				enabled = false,
				auto_refresh_codelens = false,
			},
			debugger = {
				bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg"),
				-- bin_path = nil,    -- easy-dotnet-server falls back to its own debugger binary if bin_path is nil
				-- bin_path = vim.fn.expand("~") .. "/.vsdbg/vsdbg", -- This is the closed source debugger used by visual studio
				-- apply_value_converters = true,
				-- auto_register_dap = true,
			},
		})
	end,
}
