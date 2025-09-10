return {
  {
    "hrsh7th/cmp-nvim-lsp", -- This one communicates with your LSP server
  },
  {
    "hrsh7th/cmp-nvim-lua", -- Useful for completions when doing nvim configs
    dependencies = { "nvim-cmp" }
  },
  {
    "hrsh7th/cmp-path",  -- For path suggestion
    dependencies = { "nvim-cmp" }
  },
  {
    "L3MON4D3/LuaSnip", -- Main snippets manager
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets", -- List of snippets
    },

    config = function()
      require("luasnip").setup({
        enable_treesitter = true, -- This is hella important since snippet and treesetter indentations fuck each other up
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp", -- This is the main engine, the main handler of snippets
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- OMG this is hella important you have to load both of them (you can either trust me or read more about it at the end of the file)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({paths = {vim.fn.stdpath('config') .. '/lua/snippets'}})

      -- local has_words_before = function() -- Uncomment this if you want the TAB and S-TAB mapping functionality explained a few lines below
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- I like cycling through the completions with TAB and S-TAB
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- This checks if a snippet can be jumped to or expanded first, so switching placeholders takes place over switching snippets
            if luasnip.jumpable() then -- It must not be expand_or_jump because it messes up SOME snippets, also it's currently 5:18 AM bruh
              luasnip.jump(1) -- 1 is very important
            -- This then checks if a completion menu is visible
            -- elseif cmp.visible() then
              -- cmp.select_next_item()
            -- This is the final check for autocompletion
            -- elseif has_words_before() then
              -- cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then -- Same thing here, jumping the placeholders is the top priority
              luasnip.jump(-1)
            -- elseif cmp.visible() then
              -- cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- All this commented out code it me trying to make TAB work for both placeholder jumping and for auto cmp scrolling
        -- but that is just terrible it doesn't work, its better if you just learn <C-n> and <C-p> for completion scrolling
        -- This is where you load your autocompletions in order
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "path" },
          { name = "spell" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}

-- So the reason whe loaded the LuaSnip twice is because the first time we load up friendly-snippets, that is the default option with empty ()
-- But also when adding custom ones we create a file in snippets folder and we add the language in the package.json (you can see the example in the file it ain't that hard)
-- The reason why we load both is because if we only load custom ones, the friendly-snippets won't load every time, it was strange to me but and i still don't fully...
-- ... get why but friendly-snippets only load when they are in correct positions (for example "for" or "while" snippets only load under functions)
-- To avoid that you have to load the friendly-snippets first and then you have to load your custom ones
-- Custom snippets are fucking great and i HIGHLY recommend you to read the LuaSnip custom snippet documentation, it's great fr
-- But yeah, creating snippets is very easy and you can just follow the example of my LeetCode snippet to create your own
-- (I'm putting these comments here and not there since those are JSON files and JSONC isn't supported for the snippets)
