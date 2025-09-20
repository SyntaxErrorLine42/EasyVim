return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ASCII art header
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New File", ":ene <CR>"),
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("a", "  Find All Files", "<cmd>Telescope find_files cwd=" .. vim.fn.expand("~") .. " follow=true hidden=true<CR>"),
      dashboard.button("s", "󰦛  Select Sessions", '<cmd>lua require("telescope").load_extension("ui-select"); require("persistence").select()<CR>'),
      dashboard.button("l", "  Continue Last Session", '<cmd>lua require("persistence").load({ last = true })<CR>'),
    }

    -- Set spacing between buttons
    dashboard.section.buttons.opts = {
      spacing = 2,          -- <- increase this number for more space
      position = "center",
    }

    -- Footer
    dashboard.section.footer.val = "Welcome! Customize me however you like 😊"
    dashboard.section.footer.opts = { position = "center" }

    -- Center header
    dashboard.section.header.opts = { position = "center" }

    -- Layout
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    -- List of random messages
    local vim_messages = {
      "I quit Vim once. It took 3 hours.",
      "Escape is futile.",
      "Normal mode is my default personality.",
      "Save & quit? In this economy?",
      "I came for the editor, stayed for the keybind Stockholm syndrome.",
      "Every keystroke counts. Mostly against you.",
      "Vim users don’t close files. They close chapters of life.",
      "Remember: :wq is faster than therapy.",
      "Who needs a mouse when you have RSI?",
      "NeoVim: because your pinky finger didn’t suffer enough.",
      "You can’t exit, but at least you look cool trying.",
      "Insert mode is just a rumor.",
      "hjkl are my arrow keys now. Send help.",
      "When in doubt, :q! out.",
      "Real programmers exit with ZZ.",
      "Vim is easy… once you’ve ascended.",
      "Pressing Esc is my cardio.",
      "This startup message will self-destruct in :q seconds.",
      "Half my mappings are just panic buttons.",
      "Who needs productivity when you have plugins?",
      "Neovim: the text editor that edits *you*.",
      "Mode confusion is part of the fun™.",
      "You thought this was an editor. It’s a lifestyle.",
      "alias vim='nvim' # cope",
      "Proudly wasting your keystrokes since 1991.",
      "Learning curve: yes.",
      "Undo tree > family tree.",
      "The real insert key was the friends we made along the way.",
      "One does not simply exit Vim.",
      "Quit? Nah, just open another buffer.",
      "NeoVim: the only game where the boss fight is your config.",
      "Warning: missing semicolon. Just kidding, this isn’t Java.",
      "Insert mode is for cowards.",
      "Emacs? Never heard of her.",
      "This buffer brought to you by 17 plugins and a prayer.",
      "Your config is now longer than your thesis.",
      "Remember: plugins won’t fix your bad habits.",
      "Neovim is just Vim with DLC.",
      "Ctrl-C, Ctrl-V is cheating.",
      "Vim motions: because words like 'forward-inner-thing' make sense.",
      "Coding? No. Wrestling my config? Yes.",
      "At this point, Esc is muscle memory.",
      "Auto-completion is my love language.",
      "If you think quitting is hard, try tabs vs splits.",
      "Did you mean to type :q or do you just enjoy suffering?",
      "jj is the new Esc, cope.",
      "There’s a plugin for that. And for that. And for that too.",
      "This isn’t just an editor. It’s Stockholm syndrome with syntax highlighting.",
      "My leader key is worth more than my GPA.",
      "Neovim: turning simple tasks into a PhD project since 2015.",
      "Neovim: where your config is bigger than your codebase.",
      "I came here to code, but ended up writing Lua.",
      "Welcome back, gladiator. The keymap arena awaits.",
      "My pinky finger is sponsored by <Esc>.",
      "Split window, split mind.",
      "Is it a bug or just a mapping you forgot?",
      "You don’t open Vim. Vim opens you.",
      "Neovim is like Dark Souls: prepare to cry, but stylishly.",
      "Alt key? Sorry, we don’t use that name here.",
      "Vim users measure time in keystrokes, not seconds.",
      "Some people meditate. I type :noh.",
      "The real IDE is friends you yell 'hjkl' with.",
      "Completion engines: the Pokémon of Neovim.",
      "Who needs mouse clicks when you have tendonitis?",
      "Treesitter is life. Treesitter is love.",
      "Lua wasn’t supposed to be part of this journey, yet here we are.",
      "Every buffer tells a story. Mostly a sad one.",
      "Plugin managers are just loot boxes for coders.",
      "Your colorscheme defines your personality.",
      "Warning: too many splits may cause vertigo.",
      "If Neovim crashes, just pretend it’s a feature.",
      "There’s a plugin for everything—except quitting.",
      "You didn’t choose Vim. Vim chose you.",
      "Caps Lock? No, that’s my <Esc> key.",
      "Start slow, end in leader key worship.",
      "My Vim config is basically fanfiction now.",
      "The *real* insert mode was the mistakes we made along the way.",
      "Buffer closed, soul closed.",
      "Who needs therapy when you can remap keys forever?",
      "At this point, Neovim *is* my operating system.",
      "Help files are just riddles with syntax highlighting.",
      "Every :q! is a cry for help.",
      "Neovim doesn’t load slow, you just lack patience.",
      "There is no spoon. Only splits.",
      "Half of coding is waiting for LSP to attach.",
      "God said, 'Let there be :w'.",
      "Vim vs IDE: fight me in normal mode.",
      "Coffee, plugins, and regret fuel this session.",
      "My leader key is basically a personality trait.",
      "Guess what? You’re still in Normal mode.",
      "Autocmds are dark magic I pretend to understand.",
      "Don’t forget: every quit is just a :w away.",
      "My .vimrc turned into a Lua novel.",
      "Vim motions: like choreography, but angrier.",
      "This session is proudly sponsored by :help user-manual.",
      "Escape reality, press <Esc>.",
      "Who needs StackOverflow when you can :h everything?",
      "Your keystrokes are being judged.",
      "NeoVim doesn’t crash, it rage quits.",
      "Another day, another broken config.",
    }

    -- Function to generate a random cowsay bubble
    local function random_cow()
        math.randomseed(os.time())
        local msg = vim_messages[math.random(#vim_messages)]
        local len = #msg
        local top = " " .. string.rep("_", len + 2)
        local bottom = " " .. string.rep("-", len + 2)
        local cow = {
            top,
            "< " .. msg .. " >",
            bottom,
            "       \\   ^__^",
            "        \\  (oo)\\_______",
            "           (__)\\       )\\/\\",
            "               ||----w |",
            "               ||     ||",
        }
        return cow
    end

    -- Set the footer dynamically
    dashboard.section.footer.val = random_cow()
    dashboard.section.footer.opts = { position = "center" }


    alpha.setup(dashboard.config)
  end,
}

