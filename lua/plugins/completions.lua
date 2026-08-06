return {
	{
		"saghen/blink.cmp", -- Much faster alternative to nvim-cmp, written in Rust with a native fuzzy matcher
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Blink auto-loads this for the snippets source
		},
		opts = {
			-- 'enter' preset = CR to accept, Tab/S-Tab jump placeholders, C-Space show, C-e hide,
			-- C-n/C-p select, C-b/C-f scroll docs.
			-- With preselect = false, CR only confirms an item you've actually selected, otherwise
			-- it's just a normal Enter (newline)
			keymap = {
				preset = "enter",
				-- C-n opens the menu when closed, otherwise scrolls down through it.
				-- Can't use the insert_next command because it force-selects the first item on open
				["<C-n>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_next()
						end
						return cmp.show() -- opens menu, nothing preselected
					end,
					"fallback_to_mappings",
				},
			},

			sources = {
				-- 'lsp', 'path', 'snippets' and 'buffer' are built-in; 'lazydev' replaces cmp-nvim-lua
				default = { "lsp", "path", "snippets", "buffer", "lazydev" },
				providers = {
					-- By default buffer only shows when LSP returns nothing, this makes it always show
					-- like the grouped sources
					lsp = { fallbacks = {} },
					snippets = {
						opts = {
							-- My custom snippets folder stays where it is, just point blink at it
							search_paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
						},
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},

			completion = {
				accept = {
					-- Blink auto-inserts brackets for functions by default, I don't want that since
					-- I use nvim-autopairs for brackets
					auto_brackets = { enabled = false },
				},
				-- Show the docs panel beside the menu once an item is selected (C-n/C-p).
				documentation = { auto_show = true, auto_show_delay_ms = 50 },
				list = {
					selection = {
						-- Don't auto-highlight the first item when the menu opens
						preselect = false,
					},
				},
			},
		},
	},
}
