-- This plugin is used for inline git signs, all the actual git stuff is being done by lazygit
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",  -- lazy-load after a file is opened, makes NeoVim startup one millionth of a second faster, hell yeah that's what this is all about
    opts = {
      -- Signs for inline git actions
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "‾" },
        changedelete = { text = "󱕖" },
      },

      signcolumn = false,  -- This and current line blame are off by default but can be toggled with <Leader>gt as you can see at the bottom of this file
      current_line_blame = false, -- Shows inline current blame, toggle with `:Gitsigns toggle_current_line_blame`

      -- Settings for inline blame
      current_line_blame_opts = {
        virt_text = true, -- Don't affect the inline text
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,  -- I mean do i really need to explain this line
        ignore_whitespace = false,  -- Don't show git blame for empty lines
        virt_text_priority = 100,
        use_focus = true, -- Only show if the current window is focused, very cool, damn they thought of everything
      },
      current_line_blame_formatter = '              <author>, <author_time:%R> - <summary>', -- Format
      sign_priority = 6, -- Makes so for example LSP diagnostics take the priority over the git signs
      update_debounce = 100, -- Prevents glitchy visual effects
      max_file_length = 40000, -- Don't enable gitsigns on giant files like logs or some shit
      watch_gitdir = { follow_files = true }, -- Makes sure renames/moves keep updating signs

      preview_config = { -- Honestly for hunk you can just use lazygit I think its much better
        -- Options passed to nvim_open_win, toggled with ':Gitsigns preview_hunk'
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
    -- Extremely useful function for when you need to lock in and remove distraction
    vim.keymap.set("n", "<leader>gt", function()
      vim.cmd("Gitsigns toggle_signs")
      vim.cmd("Gitsigns toggle_current_line_blame")
    end, { desc = "Toggle Git signs + inline blame" })
  },
}

