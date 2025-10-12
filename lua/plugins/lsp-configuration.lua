-- This is your main space for LSP configuration. It is split into 3 main plugins. First one is "mason" which is the main server side plugin for LSPs, "nvim-lspconfig" is the one that sends requests to the server ("mason") and "mason-lspconfig" is the one that connects them (that is where you are gonna isntall the LSPs)
-- Mason pretty much puts the packages into your PATH
-- HOW TO DOWNLOAD THE LSP:
-- First of all, choose which one you want for your language, you can google some or check the ":Mason" for available ones
-- Then you can install it from ":Mason" page or you can add it to "ensure_installed" list then reload
-- Check with ":checkhealth vim.lsp" to see what LSPs are currently running
return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- event = { "BufReadPost", "BufNewFile" }, -- THIS SHOULD NOT BE UNCOMMENTED, IT BREAKS THE CONFIG, I LEFT IT HERE SO YOU CAN SEE THAT SOMETIMES FASTER IS NOT BETTER
    -- dependencies = { "mason-org/mason.nvim" },
    opts = {
      auto_install = true,
      automatic_enable = true,
      -- ensure_installed = { "clangd", "lua_ls", "ts_ls", "html", "solargraph", "rust_analyzer", "gopls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- This is perfect, you can see with ':checkhealth vim.lsp' that the LSPs aren't loaded, and when you enter buffer it automatically does the set up
    -- THIS MUST NOT BE SET TO BufReadPost!
    -- This config and enable part is just for reference, LSP automatically picks up your Mason installs, this is just if you wanna configure it
    config = function()
      -- TS/JS
      -- vim.lsp.config('tsserver', {})
      -- vim.lsp.enable('tsserver')

      -- Emmet (HTML tags in all languages), OMG PLEASE DO NOT USE emmet_ls, use this one it is 1000000000 times better, emmet_ls is bloated af and gives completions for random stuff, for example you could be typing hello and the main snippet is gonna be <hello></hello> wtfff, this one is so much better
      -- vim.lsp.config('emmet_language_server', {})
      -- vim.lsp.enable('emmet_language_server')

      -- C/C++
      -- vim.lsp.config('clangd', {})
      -- vim.lsp.enable('clangd')

      -- Ruby
      -- vim.lsp.config('solargraph', {})
      -- vim.lsp.enable('solargraph')

      -- HTML
      -- vim.lsp.config('html', {})
      -- vim.lsp.enable('html')

      -- This is the setup to include neovim syntax into lua config files, but i have switched to lazydev plugin which is basically the same thing only faster since it only runs in config files
      -- Lua (custom settings)
      -- vim.lsp.config('lua_ls', {
      --   settings = {
      --     Lua = {
      --       runtime = { version = "LuaJIT" },
      --       diagnostics = { globals = { "vim" } },
      --       workspace = {
      --         library = {
      --           vim.api.nvim_get_runtime_file("", true),
      --           vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
      --           "${3rd}/luv/library",
      --           vim.fn.expand "$VIMRUNTIME/lua",
      --         },
      --         checkThirdParty = false,
      --       },
      --       telemetry = { enable = false },
      --     },
      --   },
      -- })
      -- vim.lsp.enable('lua_ls')

      -- Rust
      -- vim.lsp.config('rust_analyzer', {})
      -- vim.lsp.enable('rust_analyzer')

      -- Go
      -- vim.lsp.config('gopls', {})
      -- vim.lsp.enable('gopls')

      -- Java
      -- vim.lsp.config("jdtls", {})
      -- vim.lsp.enable("jdtls")

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
      -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action) -- This keymap is set in the telescope-select-ui plugin since we need that to open a nice window
      vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.jump({ count = 1, float = false }) end)
      vim.keymap.set("n", "<leader>gE", function() vim.diagnostic.jump({ count = -1, float = false }) end)
      vim.keymap.set("n", "<Leader>fm", vim.lsp.buf.format, { desc = "Format entire file" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>gw", vim.diagnostic.open_float, { desc = "Open float window with diagnostics" }) -- You can copy the error from this window

      -- Diagnostics config
      vim.diagnostic.config({
        virtual_text = false, -- You can either choose to have linting or underlining (both seem bloaty), I honestly can't make up my mind (btw u can get linting in window with <Leader>gw)
        underline = true,    -- I have also included function at <Leader>lv to toggle the LSP Virtual text at the bottom of this file
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })

      -- Toggle diagnostics, old way, you can uncomment if you want just a simple toggle option, but under this is a better version
      -- vim.keymap.set("n", "<Leader>lt", function()
      --   if vim.g.diagnostics_enabled == nil then
      --     vim.g.diagnostics_enabled = true
      --   end
      --   if vim.g.diagnostics_enabled then
      --     vim.diagnostic.enable(false)
      --     vim.g.diagnostics_enabled = false
      --     print("Diagnostics OFF")
      --   else
      --     vim.diagnostic.enable(true)
      --     vim.g.diagnostics_enabled = true
      --     print("Diagnostics ON")
      --   end
      -- end)

      -- Diagnostic filter presets
      local diag_presets = {
        [0] = { disable = true, label = "No diagnostics" },
        [1] = { severity = { min = vim.diagnostic.severity.ERROR }, label = "Showing: Errors" },
        [2] = { severity = { min = vim.diagnostic.severity.WARN }, label = "Showing: Errors + Warnings" },
        [3] = { severity = { min = vim.diagnostic.severity.INFO }, label = "Showing: Errors + Warnings + Info" },
        [4] = { severity = { min = vim.diagnostic.severity.HINT }, label = "Showing: Errors + Warnings + Info + Hints" },
      }

      -- Function to apply a preset, if we choose 0 it turns off LSP and if we choose any other severity we just reapply the same config but with min severity setting, this shit so good
      local function set_diagnostics_mode(mode)
        local preset = diag_presets[mode]
        if not preset then
          print("Invalid diagnostics mode: " .. tostring(mode))
          return
        end

        if preset.disable then
          vim.diagnostic.enable(false)
        else
          vim.diagnostic.enable(true)
          vim.diagnostic.config({
            virtual_text = {
              severity = preset.severity,
            },
            signs = {
              severity = preset.severity,
              text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN]  = " ",
                [vim.diagnostic.severity.HINT]  = " ",
                [vim.diagnostic.severity.INFO]  = " ",
              },
            },
            underline = false,
            update_in_insert = false,
            severity_sort = true,
          })
        end

        print(preset.label)
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>l0", function() set_diagnostics_mode(0) end, { desc = "Diagnostics OFF" })
      vim.keymap.set("n", "<leader>l1", function() set_diagnostics_mode(1) end, { desc = "Showing: Errors only" })
      vim.keymap.set("n", "<leader>l2", function() set_diagnostics_mode(2) end, { desc = "Showing: Errors + Warnings" })
      vim.keymap.set("n", "<leader>l3", function() set_diagnostics_mode(3) end,
        { desc = "Showing: Errors + Warnings + Info" })
      vim.keymap.set("n", "<leader>l4", function() set_diagnostics_mode(4) end,
        { desc = "Showing: Errors + Warnings + Info + Hints" })

      -- Function to toggle linting:
      local virtual_text_enabled = false
      function ToggleVirtualText()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({ virtual_text = virtual_text_enabled })
        if virtual_text_enabled then
          print("LSP virtual text ON")
        else
          print("LSP virtual text OFF")
        end
      end
      vim.keymap.set("n", "<leader>lv", function() ToggleVirtualText() end, { desc = "Toggle linting" })



      -- GLOBAL DEFAULTS, from official documentation
      -- gra gri grn grr grt i_CTRL-S v_an v_in These GLOBAL keymaps are created unconditionally when Nvim starts:
      -- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
      -- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
      -- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
      -- "grr" is mapped in Normal mode to vim.lsp.buf.references()
      -- "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
      -- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
      -- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
      -- "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()
    end,
  },
}
