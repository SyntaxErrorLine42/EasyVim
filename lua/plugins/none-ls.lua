-- This is the community version of "null_ls" which is actually an unbelieveble plugin. It basically makes the formaters and diagnostics ACT like an LSP while not being actually an LSP
-- Some LSPs like Clangd that i use all the time actually have all of this already installed but there are some languages that don't have everything (completions, linting, diagnostics, formatting) so this is a great way of filling up that hole
-- For example, there is Prettier formatting plugin, you can download it off the Mason menu and you source it here in the none-ls in the null_ls setup and that makes your nvim communicate with the Prettier like it was an LSP, but just for formating (so instead of calling the Prettier command yourself it overrides the vim.lsp.buf.format function)
return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPost", "BufNewFile" }, -- Load when opening a buffer
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.diagnostics.erb_lint,
					-- null_ls.builtins.diagnostics.rubocop,
					-- null_ls.builtins.formatting.rubocop,
				},
			})

			-- Smart formating, uses null ls as primary source (your explicitly downloaded formatters), falls back to any active relevant LSP
			vim.keymap.set("n", "<Leader>fm", function()
				local buf = vim.api.nvim_get_current_buf()
				local ft = vim.bo[buf].filetype
				local sources = require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")
				local have_nls = #sources > 0

				local formatter_name = ""

				vim.lsp.buf.format({
					bufnr = buf,
					filter = function(client)
						if have_nls then
							formatter_name = sources[1].name .. " (null-ls)"
							return client.name == "null-ls"
						end
						formatter_name = client.name .. " (lsp)"
						return client.name ~= "null-ls"
					end,
				})
				vim.cmd('echo "Formatted with: ' .. formatter_name .. '"')
			end, { desc = "Format entire file" })
		end,
	},
	-- Because of this next plugin, you don't have to change any code, you just download the formatter and THAT IS IT, cool as fuck
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Setup Mason
			require("mason").setup()

			-- Setup mason-null-ls
			require("mason-null-ls").setup({
				ensure_installed = {
					-- "black",                         -- Python formatter
					-- "prettier",                      -- JS/TS/HTML/CSS formatter
					-- "stylua",                        -- Lua formatter
					-- "rubocop",                       -- Ruby formatter/linter
				},
				automatic_installation = true, -- auto-install if missing
				handlers = {}, -- You need this to get default options
			})
		end,
	},
}
