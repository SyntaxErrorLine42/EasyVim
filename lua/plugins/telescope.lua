return {
  {
    'nvim-telescope/telescope-ui-select.nvim', -- It makes code actions appear in the nice telescope UI
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Requirement for the plugin to work
      "nvim-telescope/telescope-file-browser.nvim", -- Extremely useful, gives you a file system inside of the nvim
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "   ", -- Symbol at the start of the prompt
          selection_caret = " ", -- Symbol for the selected entry
          entry_prefix = " ", -- Prefix for each entry
          sorting_strategy = "ascending", -- Display results top-to-bottom instead of bottom-to-top
          layout_config = { -- How Telescope windows are arranged
            horizontal = {
              prompt_position = "top", -- Prompt at the top of the horizontal layout
              preview_width = 0.55, -- Width of the preview panel relative to window
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = { -- Key mappings inside Telescope
            n = { ["[q]"] = actions.close }, -- Press 'q' in normal mode to close Telescope
          },
        },
        extensions = {
          file_browser = { -- You can put your extension configs here
            -- Now the way i customized this plugin extension is my making it a folder browser since we can use
            -- native telescope file finder for files, that is why we put 'files = hidden'
            -- <C-t> to set the folder as the current nvim path, automatically switches the nvim-tree
            -- <C-f> to swap between file and folder finding
            -- <C-h> to swap between showing hidden files or not
            hidden = true,
            files = false,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select") -- You load extensions this way

      -- Keymaps
      local map = vim.keymap.set
      -- Find files in the current buffer
      map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Telescope find files" })

      -- Find all files in the home directory, very useful when you have to open a file that isn't in the current dir
      map( "n", "<leader>fa", "<cmd>Telescope find_files cwd=" .. vim.fn.expand("~") .. " follow=true hidden=true<CR>", { desc = "Telescope find all files" })
      -- you can set no_ignore=true to hide git hidden files, also you can customize cwd to set your own path, DO NOT USE '/' FOLDER since it has too many files it will break

      -- Grep through the entire current dir
      map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })

      -- Find buffer out of currently opened ones
      map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })

      -- This is for finding telescope find tags, you can uncomment it if you want
      -- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })

      -- Find specific mark you set with 'm', very useful in big projects with many files
      map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })

      -- Select a recently opened file
      map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })

      -- Grep current buffer, you can use it but '/' is honestly better
      map( "n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })

      -- map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
      -- map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })

      -- Change directories, <C-t> to set the path to selected folder
      map("n", "<leader>fd", "<cmd>Telescope file_browser<CR>", { desc = "Find directory and cd into it" }) -- Mapped to leader f d (Find Directories)
    end,
    -- Important tip: when inside of the telescope window, you can use Tab and Shift+Tab to scroll between buffers as well as <C-p> and <C-n>,
    -- but you can also use C-d and C-u for scrolling the current buffer preview, cool as fuck, right?
  },
}
