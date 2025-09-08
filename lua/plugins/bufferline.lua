-- This option is important and has to be loaded before the plugin
vim.opt.termguicolors = true

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slant", -- Can be 'thick', 'padded_slant', 'thin', 'none', 'slant'
				numbers = "ordinal", -- Show buffer numbers
				modified_icon = "●", -- Dot for unsaved changes, pretty useful
				always_show_bufferline = true, -- Show or hide the bufferline when you open a single buffer
				diagnostics = "nvim_lsp", -- Show LSP diagnostics in bufferline

				-- -- Function that displays errors and workings in buffer tabs
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 	local icon = level:match("error") and " " or level:match("warning") and " " or " "
				-- 	return " " .. icon .. count
				-- end,

				show_buffer_close_icons = false, -- We can close buffers with <Leader>x like shown at the end of the file
				show_close_icon = false, -- No 'x' button to close the buffers

				-- Show only file names
				name_formatter = function(buf)
					return vim.fn.fnamemodify(buf.name, ":t") -- ":t" strips the path part of the full file name
				end,

				offsets = {
					{
						filetype = "NvimTree",
						highlight = "NvimTreeNormal", -- You can check the hex with ":highlight NvimTreeNormal"
            padding = 1,
					},
				},
        highlights = {
          -- inactive tabs + fill = underline only
          fill = {
            underline = true,
            sp = "#BBBBBB",
          },
          background = {
            underline = true,
            sp = "#BBBBBB",
          },

          -- active tab = keep your bg (#0e0e0e) and add borders
          buffer_selected = {
            bold = true,
            underline = true,
            sp = "#BBBBBB",
          },
          separator_selected = {
            fg = "#BBBBBB",
          },

          -- inactive separators = underline look
          separator = {
            fg = "#BBBBBB",
          },
          separator_visible = {
            fg = "#BBBBBB",
          },
        },
			},
		})

		-- Keymaps: <leader>1 ... <leader>9 to go to buffer with corresponding numbers, very useful
		-- but you can disable this if you like the telescope <Leader>fb for switching between currently opened buffers
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				require("bufferline").go_to_buffer(i, true)
			end, { desc = "Go to buffer " .. i })
		end

		-- Keymaps: <leader>x to close current buffer, <leader>n for new empty buffer
		-- vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Close current buffer" }) -- This one is depricated, it works like shit
		vim.keymap.set("n", "<leader>n", ":enew<CR>", { desc = "New empty buffer" })

    -- This is the better version of closing buffers
    local function close_buffer()
        local bufnr = vim.api.nvim_get_current_buf()
        local modified = vim.bo[bufnr].modified

        -- Get list of listed buffers
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })

        if #buffers == 1 then
            -- Only one buffer → open new empty
            -- If unsaved, confirm deletion
            if modified then
                vim.cmd("confirm bd " .. bufnr)
                return
            end

            vim.cmd("enew")
            vim.api.nvim_buf_delete(bufnr, { force = false })
            return
        end

        -- Find index of current buffer in the list
        local current_index = nil
        for i, buf in ipairs(buffers) do
            if buf.bufnr == bufnr then
                current_index = i
                break
            end
        end

        -- Determine next buffer: if closing last, go to second-to-last
        local next_bufnr
        if current_index == #buffers then
            next_bufnr = buffers[current_index - 1].bufnr
        else
            next_bufnr = buffers[current_index + 1].bufnr
        end

        -- If unsaved, confirm deletion
        if modified then
            vim.cmd("confirm bd " .. bufnr)
        end

        -- Switch to next buffer and delete current
        vim.api.nvim_set_current_buf(next_bufnr)


        vim.api.nvim_buf_delete(bufnr, { force = false })
    end
    vim.keymap.set("n", "<leader>x", close_buffer, { desc = "Smart close current buffer (wrap to prev if last)" })


		-- Keymaps: Tab to go to next buffer, Shift-Tab for previous
		vim.keymap.set("n", "<Tab>", function()
			require("bufferline").cycle(1)
		end, { desc = "Next buffer" })

		vim.keymap.set("n", "<S-Tab>", function()
			require("bufferline").cycle(-1)
		end, { desc = "Previous buffer" })

    -- Move buffer left/right
    vim.keymap.set("n", "<Leader><", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
    vim.keymap.set("n", "<Leader>>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })

	end,
}

