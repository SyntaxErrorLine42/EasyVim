return {
	"yetone/avante.nvim",
	cmd = "Avante",
	keys = {
		{ "<leader>aa", desc = "Avante: show sidebar" },
	},
	version = false,
	build = "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua", -- reuses existing auth, no extra setup needed
		"HakonHarnes/img-clip.nvim", -- allows image pasting
		"MeanderingProgrammer/render-markdown.nvim",
	},
	opts = {
		-- copilot as main provider, reuses zbirenbaum auth
		provider = "copilot",
		mode = "legacy", -- "agentic" is agent, "legacy" is similar to ask mode, use <leader>am to switch around

		-- WARNING: do NOT set auto_suggestions_provider = "copilot"
		-- it will hammer the API constantly and can get your token rate limited
		-- leave it false and use zbirenbaum/copilot suggestions
		auto_suggestions_provider = false,

		-- providers = {
		-- 	-- define multiple copilot model aliases you can switch between
		-- 	copilot = {
		-- 		model = "gpt-4o", -- default model
		-- 		timeout = 30000,
		-- 		extra_request_body = {
		-- 			temperature = 0.75,
		-- 			max_tokens = 20480,
		-- 		},
		-- 	},
		-- 	-- extra model aliases via __inherited_from so you can :AvanteSwitchProvider
		-- 	["copilot/claude"] = {
		-- 		__inherited_from = "copilot",
		-- 		model = "claude-sonnet-4",
		-- 		display_name = "Copilot/Claude Sonnet 4",
		-- 		extra_request_body = { max_tokens = 65536 },
		-- 	},
		-- 	["copilot/gemini"] = {
		-- 		__inherited_from = "copilot",
		-- 		model = "gemini-2.5-pro",
		-- 		display_name = "Copilot/Gemini 2.5 Pro",
		-- 		extra_request_body = { max_tokens = 65536 },
		-- 	},
		-- 	["copilot/gpt4o"] = {
		-- 		__inherited_from = "copilot",
		-- 		model = "gpt-4o",
		-- 		display_name = "Copilot/GPT-4o",
		-- 		extra_request_body = { max_tokens = 65536 },
		-- 	},
		-- },
		-- disable inline ghost text suggestions (avante's own, separate from copilot.lua)
		suggestion = {
			enabled = false,
		},

		-- disable only the visual mode popup hint
		selection = {
			hint_display = "none",
		},

		behaviour = {
			auto_suggestions = false, -- extra safety to ensure no auto suggestions
		},

		windows = {
			width = 40, -- percentage of screen width
			ask = {
				start_insert = false,
			},
		},
		mappings = {
			submit = {
				-- submit with enter instead of default <C-s>
				normal = "<CR>",
				insert = "<CR>",
			},
		},
	},
	config = function(_, opts)
		require("avante").setup(opts)

		-- toggle between agentic and legacy mode
		vim.keymap.set("n", "<leader>am", function()
			local current = require("avante.config").mode
			local new_mode = current == "agentic" and "legacy" or "agentic"
			require("avante").setup({ mode = new_mode })
			vim.notify("Avante mode: " .. new_mode, vim.log.levels.INFO)
		end, { desc = "Avante: toggle agentic/legacy mode" })
	end,
}

-- List of default mappings:
-- The following key bindings are available for use with avante.nvim:
-- Key Binding 	Description

-- Sidebar

-- ]p 	next prompt
-- [p 	previous prompt
-- A 	apply all
-- a 	apply cursor
-- r 	retry user request
-- e 	edit user request
-- <Tab> 	switch windows
-- <S-Tab> 	reverse switch windows
-- d 	remove file
-- @ 	add file
-- q 	close sidebar
-- Leaderaa 	show sidebar
-- Leaderat 	toggle sidebar visibility
-- Leaderar 	refresh sidebar
-- Leaderaf 	switch sidebar focus

-- Suggestion

-- Leadera? 	select model
-- Leaderan 	new ask
-- Leaderae 	edit selected blocks
-- LeaderaS 	stop current AI request
-- Leaderah 	select between chat histories
-- <M-l> 	accept suggestion
-- <M-]> 	next suggestion
-- <M-[> 	previous suggestion
-- <C-]> 	dismiss suggestion
-- Leaderad 	toggle debug mode
-- Leaderas 	toggle suggestion display
-- LeaderaR 	toggle repomap
-- Files
-- Leaderac 	add current buffer to selected files
-- LeaderaB 	add all buffer files to selected files

-- Diff

-- co 	choose ours
-- ct 	choose theirs
-- ca 	choose all theirs
-- cb 	choose both
-- cc 	choose cursor
-- ]x 	move to next conflict
-- [x 	move to previous conflict

-- Confirm

-- Ctrlwf 	focus confirm window
-- c 	confirm code
-- r 	confirm response
-- i 	confirm input
