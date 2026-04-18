local M = {}

local option_text = "Build and run current file"
local option_value = "easyvim_c_current_file"

local function run_current_c_file()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("Save the current buffer before compiling.", vim.log.levels.WARN, {
			title = "Compiler.nvim",
		})
		return
	end

	local utils = require("compiler.utils")
	local cwd = vim.fn.getcwd()
	local output_dir = utils.os_path(cwd .. "/bin-single-c/")
	local output = utils.os_path(cwd .. "/bin-single-c/program")
	local sh_file = vim.fn.shellescape(file)
	local sh_output = vim.fn.shellescape(output)
	local sh_output_dir = vim.fn.shellescape(output_dir)

	require("overseer").new_task({
		name = "- C compiler",
		strategy = {
			"orchestrator",
			tasks = {
				{
					name = "- Build & run current file → \"" .. file .. "\"",
					cmd = "rm -f " .. sh_output .. " || true"
						.. " && mkdir -p " .. sh_output_dir
						.. " && gcc " .. sh_file .. " -o " .. sh_output .. " -Wall -g"
						.. " && " .. sh_output
						.. " && echo " .. vim.fn.shellescape(file)
						.. " && echo \"--task finished--\"",
					cwd = cwd,
					components = { "default_extended" },
				},
			},
		},
	}):start()
end

function M.apply()
	local ok, utils = pcall(require, "compiler.utils")
	if not ok then
		return
	end

	if utils.easyvim_c_single_file_patched then
		return
	end

	utils.easyvim_c_single_file_patched = true

	local original_require_language = utils.require_language
	utils.require_language = function(filetype)
		local language = original_require_language(filetype)
		if filetype ~= "c" or not language then
			return language
		end

		local already_exists = false
		for _, item in ipairs(language.options or {}) do
			if item.value == option_value then
				already_exists = true
				break
			end
		end

		if not already_exists then
			table.insert(language.options, 1, {
				text = option_text,
				value = option_value,
			})
		end

		if not language.easyvim_c_single_file_action_patched then
			language.easyvim_c_single_file_action_patched = true
			local default_action = language.action
			language.action = function(selected_option)
				if selected_option == option_value then
					run_current_c_file()
					return
				end

				default_action(selected_option)
			end
		end

		return language
	end
end

return M
