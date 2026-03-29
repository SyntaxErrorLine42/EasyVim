-- This is the plugin needed to set up Roslyn LSP for CSharp
return {
	"seblyng/roslyn.nvim",
	ft = { "cs", "razor", "blazor" },
	opts = {
		-- your configuration here; empty is fine for defaults
	},
    -- This function auto generates summary comments over the classes
    -- Just start typing ///...
	config = function(_, opts)
		require("roslyn").setup(opts)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local bufnr = args.buf

				if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
					vim.api.nvim_create_autocmd("InsertCharPre", {
						desc = "Roslyn: Trigger an auto insert on '/'.",
						buffer = bufnr,
						callback = function()
							local char = vim.v.char
							if char ~= "/" then
								return
							end

							local row, col = unpack(vim.api.nvim_win_get_cursor(0))
							row, col = row - 1, col + 1
							local uri = vim.uri_from_bufnr(bufnr)

							local params = {
								_vs_textDocument = { uri = uri },
								_vs_position = { line = row, character = col },
								_vs_ch = char,
								_vs_options = {
									tabSize = vim.bo[bufnr].tabstop,
									insertSpaces = vim.bo[bufnr].expandtab,
								},
							}

							vim.defer_fn(function()
								client:request("textDocument/_vs_onAutoInsert", params, function(err, result, _)
									if err or not result then
										return
									end
									vim.snippet.expand(result._vs_textEdit.newText)
								end, bufnr)
							end, 1)
						end,
					})
				end
			end,
		})
	end,
}
