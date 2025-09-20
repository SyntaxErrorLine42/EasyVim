## What is EasyVim?
First of all, don't let the name fool you. **EasyVim** stands for "**Eas**il**y** The Best Neo**Vim** Distribution Of All Time"! There is absolutely nothing easy about EasyVim! This isn't a distro for beginners and for people that don't have at least some experience with NeoVim. EasyVim is all about productivity and making programming as efficient as possible and that comes with the price of a steep learning curve. I strongly believe that whoever you might be, from a freshmen in college to a senior software engineer at Google, if you took some time out of your life and decided to go and learn NeoVim, you will be a BETTER and more PRODUCTIVE engineer. My goal in making EasyVim is to remove the mental overhead, and by that I mean if you have something in your mind, like "Oh I have to copy this line, move to another folder, enter another file there and paste it, then go back and compile the code again" you shouldn't be stopped by the slowness of the process. When you are building a project, you should spend as much time possible thinking about the code and not about the process of implementing your thought. So instead of clicking around your VS Code or opening up multiple windows to drag lines with your mouse and play with indentations, EasyVim aims to speed all that up as much as possible. BUT SPEED COMES WITH A PRICE. It is gonna take you A LOT of time learning all of this, at the beginning you will feel like you're stupid and the simplest tasks are gonna make you feel like you don't know anything about programming (or even typing). The thing is you gotta be consistent. The goal of Vim in general is developing a muscle memory. Muscle memory is a powerful thing and if it helps you in day to day life, why not try implementing it in programming, we are already programming for hours a day. Another reason to switch to NeoVim is because it's cool as fuck and it's very satisfying. There is no better feeling than hitting a nasty macro, right?

## Why EasyVim and not some other distro?
Absolutely no reason. EasyVim is built for maximizing productivity based on my opinion. Your opinion might differ (feel welcome to open issues or pull requests). Every single thing in EasyVim is configured with the goal of speed and efficiency. Beautiful thing about EasyVim is that it is easily customizable, code is nicely commented and there are many examples on how to insert your own plugins or how to customize the already implemented plugins. If you are already experienced with NeoVim, you might find EasyVim a very good distro and you shouldn't have problems managing it around, you could also check out the config and implement pieces of my code in your own distro.

I try keeping the number of plugins minimal, I don't like adding stuff that is rarely used and that is just gonna bloat up the code and slow down the program, that is the main reason I decided to stop using popular distros and built my own.

## Get Started
1. You need NeoVim installed (who would have thought). I recommend version 0.11, it's the newest one. Some distros keep the older version in their package managers, but you can install the newest version with:
```
wget -O nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
chmod u+x nvim.appimage && \
mv nvim.appimage /usr/local/bin/nvim
```
2. Download EasyVim. If you already have a nvim config, do:
```
mv ~/.config/nvim ~/.config/nvim.backup
```
Then clone the repo:
```
git clone https://github.com/SyntaxErrorLine42/EasyVim.git ~/.config/nvim
```
3. To get the best out of EasyVim, you should download some extra stuff. First of them is LazyGit, a complete Git UI that is connected to a plugin inside of EasyVim. Again, some distros already have it in their package managers but you can also download it like this:
```
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```
Same goes for LazyDocker, it is a complete Docker UI connected to your EasyVim session.
```
git clone https://github.com/jesseduffield/lazydocker.git
cd lazydocker
go install # note that you need go installed and go folder in your path (or copy the ~/go/bin/lazydocker to /usr/local/bin/)
```
4. You should also install RipGrep which is available in all package managers (it is literally a better and faster version of Grep). You need it for Telescope grepping through files. Example:
```
sudo apt install ripgrep
```
5. When installing certain LSPs you are gonna be prompted to install some additional packages, I don't wanna include them here because there would be too many and there is a big change you wouldn't even use any of them.

6. You need [Nerd Font](https://www.nerdfonts.com/) as your terminal font. Make sure the nerd font you set doesn't end with Mono to prevent small icons. Example : JetbrainsMono Nerd Font and not JetbrainsMono Nerd Font Mono.

7. DONE! You can launch EasyVim with ```nvim``` command now

P.S. I have also included the Dockerfile for testing EasyVim, you can build it with
```
docker build -t easyvim .
docker run --rm -it -v </path/to/your/clone>:~/.config/nvim easyvim
```
or you can just run:
```
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs neovim ripgrep build-base wget --update
  git clone https://github.com/SyntaxErrorLine42/EasyVim ~/.config/nvim
  nvim
  '
```

## Usage
As soon as you launch it for the first time, Lazy should install all the plugins for you. After it is installed, you should restart EasyVim and once you are in, you are ready!
To load up the colors after reopening EasyVim call:
```
:lua require("base46").compile(); require("base46").load_all_highlights()
```
You can also call it with shortcut ```<Leader>bc```. This should be called every time you change the nvconfig.lua file (default leader is space).

I would STRONGLY RECOMMEND you to go through the entire code and get to know what you are using. You shouldn't go into this like you are using VS Code. EasyVim does work out-of-the-box, but you should read everything that I have written down in the comments to understand this distro. After you have read all of the code, you should have some basic understanding of how EasyVim works.

If you are too lazy to read the code, this is the summary:
- EasyVim uses Lazy loading for plugins, if you wanna add your own plugin, just create a new file in the lua/plugins folder and make a return table. To check Lazy plugins call the command ```:Lazy```.
- LSPs are configured through Mason. If you wanna install a new LSP, type command ```:Mason```, choose your LSP and install it by clicking ```i```. Everything will be set up automatically (in case completions aren't picked up, go to the completions.nvim file and check out what I have written there, you have to pretty much add 2 lines of code).
- For UI EasyVim uses LuaLine, NvimTree and Bufferline. For themes we are using Base46, a great theme engine made by [siduck](https://github.com/NvChad/base46), the original creator of NvChad.
- Debugging is done by nvim-dap and it's set up as out-of-the-box as possible, you just have to install the debugger you want from ```:Mason``` and it will be automatically set up for you.
- Compiler is done using compiler.nvim and overseer.nvim making it also very out-of-the-box but still highly customizable

These are the basics. I REALLY recommend you to check out GitHub pages of the plugin creators as it will be a lot easier for you to customize stuff.

## Mappings

Modes: n - normal, i - insert, v - visual, s - select, t - terminal, x - any visual, o - operator-pending

Default Leader: ```<Space>```

| Mapping | Mode | Action |
|---------|------|--------|
| `mappings.lua` | | |
| `;` | n | Enter command mode |
| `,` | n, v | Enter command mode |
| `jk` | i | Escape insert mode |
| `jk` | s | Escape select mode |
| `y` | n, v | Yank to clipboard |
| `Y` | n | Yank to clipboard |
| `<C-a>` | n, i, v | Select all |
| `<C-c>` | n | Copy whole file |
| `<C-q>` | n | Replace all |
| `<C-q>` | v | Replace selected |
| `<CS-j>` | n, t | Toggle terminal |
| `<C-S-j>` | n, t | Toggle terminal |
| `<C-x>` | t | Escape terminal mode |
| `<` | v | Indent left |
| `>` | v | Indent right |
| `<` | n | Indent left |
| `>` | n | Indent right |
| `<C-s>` | n, i, v | Save file |
| `<C-h>` | n | Switch window left |
| `<C-l>` | n | Switch window right |
| `<C-j>` | n | Switch window down |
| `<C-k>` | n | Switch window up |
| `<C-h>` | i | Move left |
| `<C-l>` | i | Move right |
| `<C-j>` | i | Move down |
| `<C-k>` | i | Move up |
| `i` | i | Break undo sequence |
| `<Esc>` | n | Clear search highlight |
| `<Leader>bc` | n | Compile Base46 theme |
| `plugins/telescope.lua` | | |
| `<Leader>ff` | n | Find files |
| `<Leader>fa` | n | Find all files in home dir |
| `<Leader>fw` | n | Live grep |
| `<Leader>fb` | n | Find buffers |
| `<Leader>ma` | n | Find marks |
| `<Leader>fo` | n | Find old files |
| `<Leader>fz` | n | Find in current buffer |
| `<Leader>fd` | n | Find directory |
| `plugins/nvim-tree.lua` | | |
| `<C-n>` | n | Toggle file explorer |
| `<Leader>e` | n | Focus file explorer |
| `h` | n | Open in horizontal split |
| `v` | n | Open in vertical split |
| `l` | n | Open file and keep focus |
| `plugins/lsp-configuration.lua` | | |
| `K` | n | Show hover information |
| `<Leader>gd` | n | Go to definition |
| `<Leader>gD` | n | Go to declaration |
| `<Leader>gr` | n | Show references |
| `<Leader>ca` | n | Show code actions |
| `<Leader>ge` | n | Next diagnostic |
| `<Leader>gE` | n | Previous diagnostic |
| `<Leader>fm` | n | Format file |
| `<Leader>rn` | n | Rename variable |
| `<Leader>lt` | n | Toggle diagnostics |
| `plugins/gitsigns.lua` | | |
| `<Leader>gt` | n | Toggle Git signs and inline blame |
| `plugins/debugging.lua` | | |
| `<Leader>db` | n | Toggle breakpoint |
| `<Leader>dr` | n | Run/Continue debugger |
| `<Leader>dx` | n | Terminate debugger |
| `<F6>` | n | Step over |
| `<F7>` | n | Step into |
| `<F8>` | n | Step out |
| `<Leader>dt` | n | Toggle debugger UI |
| `plugins/comment.lua` | | |
| `gcc` | n | Toggle comment |
| `gc` | v | Toggle comment |
| `plugins/bufferline.lua` | | |
| `<Leader>1` to `<Leader>9` | n | Go to buffer 1-9 |
| `<Leader>n` | n | New empty buffer |
| `<Leader>x` | n | Close current buffer |
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<Leader><` | n | Move buffer left |
| `<Leader>>` | n | Move buffer right |
| `plugins/flash.lua` | | |
| `s` | n, x, o | Flash jump |
| `plugins/lazygit.lua` | | |
| `<Leader>lg` | n | Open Lazygit |
| `plugins/lazydocker.lua` | | |
| `<Leader>ld` | n, t | Toggle LazyDocker |
| `plugins/persistence.lua` | | |
| `<Leader>se` | n | Select session |
| `<Leader>sl` | n | Restore last session |
| `<Leader>ss` | n | Save session |
| `plugins/compiler.lua` | | |
| `<F5>` | n | Open Compiler |
| `<Leader>rs` | n | Stop Compiler |
| `<Leader>rt` | n | Toggle Compiler Results |
| `plugins/completions.lua` | | |
| `<C-b>` | i | Scroll docs up |
| `<C-f>` | i | Scroll docs down |
| `<C-Space>` | i | Complete |
| `<C-e>` | i | Abort completion |
| `<CR>` | i | Confirm completion |
| `<Tab>` | i, s | Jump to next snippet placeholder |
| `<S-Tab>` | i, s | Jump to previous snippet placeholder |
| `plugins/surround.lua` | | |
| `cs"'`    | n    | Change " to ' |
| `cs'<q>`  | n    | Change ' to `<q>` |
| `cst"`    | n    | Change `<q>` to " |
| `ds"`     | n    | Remove delimiters |
| `ysiw]`   | n    | Wrap word in [] |
| `cs]{`    | n    | Change [] to {} |
| `yssb`    | n    | Wrap line in () |
| `ds{`     | n    | Remove {} |
| `ysiwt<em>`| n    | Wrap word in `<em>` |
| `St<p class="important">` | v | Wrap visually selected in `<p>` |
| `S'` | v | Wrap visually selected in ' |
| `plugins/leetcode.nvim` | | |
| `:Leet` | n | Open LeetCode UI |
| `:Leet run` | n | Run LeetCode tests |
| `:Leet submit` | n | Submit LeetCode problem |

## Final words
HUGE THANKS to [TypeCraft](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) and his AMAZING series where he shows how to start building your distro from scratch. Also I wanna thank the creator of [NvChad](https://github.com/NvChad/NvChad) as his distro helped me learn a lot about how NeoVim works. Shoutout to creator of the [Lua learning site](https://learnxinyminutes.com/lua/), you can easily learn Lua by reading it a few times. Most importantly, thank you to the entire NeoVim community and all the plugin creators.

I had a lot of fun building EasyVim and I will continue to do so. From now on this will be my primary IDE and I will try to keep it up to date as much as possible. I encourage you to open issues and pull requests if you have ANY ideas on how to make EasyVim better or if you encounter some glitches.
