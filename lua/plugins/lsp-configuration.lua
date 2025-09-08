return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      automatic_enable = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- It gives you the definition of the current piece of code you are hovering over
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {}) -- Jumps to the definition of current piece of code (function, variable...)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {}) -- Showcases all the references in the code and pulls up a prompt
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- Shows the code actions on current line
      -- Go to next diagnostic, the float shows the diagnostic when scrolling, honestly it distracts me it's really not needed
      vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.jump({ count = 1, float = false }) end, { desc = "Go to next diagnostic" })
      -- Go to previous diagnostic, btw <Leader>ge and <Leader>gE as in "Get Error"
      vim.keymap.set("n", "<leader>gE", function() vim.diagnostic.jump({ count = -1, float = false }) end, { desc = "Go to previous diagnostic" })


      -- THIS IS DEPRECATED AND WILL BE REMOVED IN THE NVIM 0.12 UPDATE
      -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      -- end

      -- THIS IS THE NEW METHOD
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
          -- optional: also highlight line numbers
          -- numhl = {
          --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          --   [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
          --   [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
          --   [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
          -- },
        },
      })
    end,
  },
}
