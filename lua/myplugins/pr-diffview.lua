local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Job = require("plenary.job")

local function get_origin_url()
	local handle = io.popen("git remote get-url origin 2>&1")
	if not handle then
		return nil
	end
	local url = handle:read("*a")
	handle:close()
	if not url or url == "" then
		return nil
	end
	return url:gsub("%s+$", "")
end

local function detect_provider()
	local url = get_origin_url()
	if not url then
		return nil
	end
	if url:match("github%.com") then
		return "github"
	end
	if url:match("dev%.azure%.com") or url:match("visualstudio%.com") then
		return "azure"
	end
	return nil
end

local function fetch_pr_github(pr)
	vim.fn.system(string.format("git fetch origin pull/%d/head 2>/dev/null || true", pr.number))
end

local function open_pr_diffview(provider, pr)
	if provider == "github" then
		fetch_pr_github(pr)
		local base = pr.baseRefName or "main"
		vim.cmd(string.format("DiffviewOpen origin/%s...FETCH_HEAD", base))
	elseif provider == "azure" then
		-- For Azure, try to fetch by source ref if possible
		if pr.sourceRefName and pr.targetRefName then
			local source = pr.sourceRefName:gsub("^refs/heads/", "")
			local target = pr.targetRefName:gsub("^refs/heads/", "")
			vim.fn.system(string.format("git fetch origin %s 2>/dev/null || true", source))
			vim.fn.system(string.format("git fetch origin %s 2>/dev/null || true", target))
			vim.cmd(string.format("DiffviewOpen origin/%s...origin/%s", target, source))
		else
			vim.notify("Could not determine base/head for Azure PR", vim.log.levels.WARN)
		end
	end
end

local function list_prs_github(cb)
	if vim.fn.executable("gh") ~= 1 then
		vim.notify("gh not found in PATH (install from https://cli.github.com/)", vim.log.levels.ERROR)
		return
	end
	Job:new({
		command = "gh",
		args = {
			"pr",
			"list",
			"--state",
			"open",
			"--json",
			"number,title,author,baseRefName,headRefName,url",
			"--limit",
			"100",
		},
		on_exit = function(j, return_val)
			if return_val ~= 0 then
				vim.schedule(function()
					vim.notify("gh pr list failed", vim.log.levels.ERROR)
				end)
				return
			end
			local result = table.concat(j:result(), "\n")
			local ok, parsed = pcall(vim.json.decode, result)
			if not ok or type(parsed) ~= "table" then
				vim.schedule(function()
					vim.notify("Failed to parse gh output", vim.log.levels.ERROR)
				end)
				return
			end
			vim.schedule(function()
				cb(parsed)
			end)
		end,
	}):start()
end

local function list_prs_azure(cb)
	if vim.fn.executable("az") ~= 1 then
		vim.notify("az not found in PATH (install Azure CLI)", vim.log.levels.ERROR)
		return
	end
	Job:new({
		command = "az",
		args = { "repos", "pr", "list", "--status", "active", "--output", "json" },
		on_exit = function(j, return_val)
			if return_val ~= 0 then
				vim.schedule(function()
					vim.notify("az repos pr list failed", vim.log.levels.ERROR)
				end)
				return
			end
			local result = table.concat(j:result(), "\n")
			local ok, parsed = pcall(vim.json.decode, result)
			if not ok or type(parsed) ~= "table" then
				vim.schedule(function()
					vim.notify("Failed to parse az output", vim.log.levels.ERROR)
				end)
				return
			end
			vim.schedule(function()
				cb(parsed)
			end)
		end,
	}):start()
end

local function pick_prs()
	local provider = detect_provider()
	if not provider then
		vim.notify("Could not detect GitHub or Azure DevOps from origin remote", vim.log.levels.ERROR)
		return
	end

	local function show_picker(prs)
		if vim.tbl_isempty(prs) then
			vim.notify("No open PRs found", vim.log.levels.INFO)
			return
		end

		pickers
			.new({}, {
				prompt_title = provider == "github" and "Open GitHub PRs" or "Open Azure DevOps PRs",
				finder = finders.new_table({
					results = prs,
					entry_maker = function(pr)
						if provider == "github" then
							local author = pr.author and pr.author.login or "unknown"
							local display = string.format("#%d - %s (%s)", pr.number, pr.title, author)
							return {
								value = pr,
								display = display,
								ordinal = display,
							}
						else
							local author = pr.createdBy and pr.createdBy.displayName or "unknown"
							local display = string.format("#%d - %s (%s)", pr.pullRequestId, pr.title, author)
							return {
								value = pr,
								display = display,
								ordinal = display,
							}
						end
					end,
				}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(prompt_bufnr, map)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						local pr = selection.value
						open_pr_diffview(provider, pr)
					end)
					return true
				end,
			})
			:find()
	end

	if provider == "github" then
		vim.notify("Loading GitHub pull requests...", vim.log.levels.INFO)
		list_prs_github(show_picker)
	else
		vim.notify("Loading Azure DevOps pull requests...", vim.log.levels.INFO)
		list_prs_azure(show_picker)
	end
end

return {
	"nvim-lua/plenary.nvim",
	keys = {
		{
			"<leader>vp",
			function()
				pick_prs()
			end,
			desc = "View PR in Diffview",
		},
	},
}
