# NvChad config C++

## What is it?
It's my config for NvChad with orientation to C++ and python.

## How to use it?
Install Neovim  ( google it if you don't know how )

If you are on Linux:
- In a console:  `git clone https://github.com/Arniiiii/nvchad_config_cpp.git --branch master ~/.config/nvim`

If another operational system:
- check where Neovim config is usually located and change the last part of the command for Linux.

Then maybe type `:MasonInstallAll`

Then maybe type `:Lazy` and update all packages using `<shift>u` keybinding.

<!-- To get some plugins working, which are written in some other languages than Lua ( aka remote plugins ), do next stuff: -->
<!-- - `:runtime! plugin/rplugin.vim` -->
<!-- - `:UpdateRemotePlugins` -->
<!-- - restart Neovim -->

Maybe try doing something like this: 

`git config --global core.excludesfile ~/.config/nvim/.gitignore_global`


Try use `<leader>ch` aka `Space Bar + c + h` to get an awesome cheat sheet or use `<leader>wK` for [`which-key`](https://github.com/folke/which-key.nvim) .

## Is it good?
It's have clangd through Mason, CMake plugin, CMake debugger, c++ debugger, python debugger, some keybindings. 
In general, it's great to use.

## TODO
- [ ] Figure out a way of using Large language model.
    - [x] Setup [`olimorris/codecompanion.nvim`](https://github.com/olimorris/codecompanion.nvim) ~~for `ollama` with dolphin-mistral:latest~~ now Gemini because it has free tier.
        - [x] chat
        - [x] inline-prompts
        - [ ] autocomplete?
        - [ ] fucked up logic for mappings. How do they work? How to override them?
        - [x] how to select multiple buffer/files in one telescope selection?
            - [x] added selection stuff in telescope mappings in `configs/telescope.lua`
        - [ ] how to stay in insert mode after selection?
    - [x] check next stuff to specify what model to use, if it's self-deployed: [here](https://github.com/olimorris/codecompanion.nvim/pull/45#issuecomment-2054028057)
- [ ] Find a good solution for `.ipynb` files.
    - [ ] [`goerz/jupytext.vim`](https://github.com/goerz/jupytext.vim) only editing, not executing. Though, amazing, needs `jupytext` installed
    - [ ] [`dccsillag/magma-nvim`](https//github.com/dccsillag/magma-nvim) seems to be about executing `*.py` scripts using `jupyter`. Not about executing `ipynb`.
    - [ ] [`luk400/vim-jukit`](https://github.com/luk400/vim-jukit) investigation...
    - [ ] no solution because of images?
- [x] Migrate to NvChad `v2.5`
    - [x] Apply migrate.sh 
    - [x] Transform mappings syntax to vim mappings
    - [ ] Cheat sheet [doesn't have hints for categories with one mapping](https://github.com/NvChad/NvChad/issues/2688#issuecomment-2046201103) 
- [x] Debugger stuff. Console `gdb`/`lldb` is cool, but some want it inside editor...
    - [x] CMake debugger in Neovim !!! CMake Generate (`<leader>G`), toggle a breakpoint (`<leader>b`), press Continue(`<F5>`), it works! Prerequisite: CMake is 3.27+ and is compiled with DAP feature. (for Gentoo users `flaggie dev-build/cmake +dap`).
        - [x] build folder is taken from CMake plugin
            - [x] (Resolved) ~~is taken at the initialization of Neovim. Changed build directory? Right now only restart Neovim.~~
        - [x] ([Resolved](https://github.com/Civitasv/cmake-tools.nvim/issues/203)) it doesn't take `generate_options` from `:CMakeSettings`.
    - [x] c++/c/rust debugger : press CMake debug (`<leader>cd`), enjoy
        - [x] `codelldb` by default is taken from meson. So, generally, no manual typing paths
        - [ ] how to go through `asm` instructions? Seems that `codelldb` doesn't support it, or my experimental mapping doesn't work.
        - [ ] how to place breakpoint at main, if executable is compiled with `-g0` ? In raw `gdb` or `lldb` it's possible.
    - [x] [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui) is connected
        - [x] added bindings for opening(`<leader>do`) and closing (`<leader>dc`) `nvim-dap-ui` .
    - [ ] `nvim-dap-ui` and [`cmake-tools`](https://github.com/Civitasv/cmake-tools.nvim) are added at startup, not lazy.
        - [ ] for CMake stuff find out how in `lazy` package manager load it if project folder has `CMakeLists.txt` . Investigation.
        - [ ] for DAP stuff should be loading by certain key mappings, though IDK how exactly now. Investigation.
    - [x] Where's python debugger?
        - [x] Added `debugpy` through mason and copy pasted config for it with slight changes
        - [x] Toggle breakpoint, `<F5>`, voilà 
    - [ ] Some floating window key map I have but there's no way to close them?
    - [ ] How to make the mappings for DAP-mode only?
- [x] Find out how to make some command like `:make nextest r` asynchronously
    - [x] Via overseer plugin: run asynchronously via `:Make ...`
    - [ ] can be extrapolated to `:Grep`, `AnyBashCommand`, but now I don't need it now
- [x] More key bindings for some plugins
    - [x] DAP related
    - [x] [`Telescope`](https://github.com/nvim-telescope/telescope.nvim) related
    - [x] [`gitsigns`](https://github.com/lewis6991/gitsigns.nvim) related
- [x] Make better git usage workflow
    - [ ] Somehow get used to [`vim-fugitive`](https://github.com/tpope/vim-fugitive)
        - [x] try as a diff tool or merge tool...
            - [x] when trying to fix conflict, try to use it
        - [x] [`Neogit`](https://github.com/NeogitOrg/neogit) is better. 
            - [ ] Removed `vim-fugitive`.
    - [x] investigate how to use it with [`lazygit`](https://github.com/jesseduffield/lazygit) better.
    - [x] automatic blame via `gitsigns`
        - [ ] What else `gitsigns` can?
            - [x] add some mappings for it
    - [x] it appears vim had built-in diff mode. Added some mappings for it
- [x] `tmux` navigator. Added keybindings for it. `Ctrl+hjkl` for navigating + `tmux` integration!!!
- [ ] Find out if there's a way to turn on less plugin not lazily. Investigation
    - [ ] `ft` for some plugins works, for some not, IDK why
    - [ ] `cmd` works more often than not
- [x] Added [`rcarriga/nvim-notify`](https://github.com/rcarriga/nvim-notify). Good looking plugin.
- [x] Find a plugin for cool command palette
    - [x] [`cmp-cmdline`](https://github.com/hrsh7th/cmp-cmdline) works just fine
        - [x] fixed auto selecting just by adding in `compeleopt` [`noselect`](https://neovim.io/doc/user/options.html#'completeopt')
    - [ ] [`hachy/cmdpalette.nvim`](https://github.com/hachy/cmdpalette.nvim) doesn't support ranges and feels not so good  
    - [ ] (previously used in the config, replaced by `cmp-cmdline`.) [`gelguy/wilder.nvim`](https://github.com/gelguy/wilder.nvim) seems to be a little bit unmaintained  ([my pain at installing it](https://github.com/gelguy/wilder.nvim/issues/196)). UPD: it's still is too buggy, and most important: it's slow. It's using python behind in sync way and on my PC it feels so badly sometimes... Maybe this plugin should be rewritten to Lua or C/C++/Rust/Go/whatever_language ?
        - [ ] has some problems with config portability?
    - [ ] [`VonHeikemen/fine-cmdline.nvim`](https://github.com/VonHeikemen/fine-cmdline.nvim) doesn't support ranges
    - [ ] [`mrjones2014/legendary.nvim`](https://github.com/mrjones2014/legendary.nvim) seems to *not* have ability to somehow get commands from everywhere like `:Telescope commands` , though looks cool. Doesn't support ranges. 
- [ ] Find out how to put more snippets and put them from somewhere. Investigation.
- [ ] Find a good alternative to `:s`. 
    - [ ] should I?
- [x] Allow more diversity of folder structures for include-guard plugin. Now only works if there's `src` in a path to a file. 
    - [ ] Rewrite plugin to Lua and use Neovim API?
    - [x] Actually there's a snippet `#guard`.
- [ ] Use [`ug`](https://github.com/Genivia/ugrep) everywhere:
    - [ ] in telescope
        - [ ] I've tried putting something to `setup { defaults { vimgrep_args: {"ug",...}}}`, but it doesn't work...
    - [x] in `:grep`
- [ ] LaTeX... I need to practice...
    - [x] Installed [`vimtex`](https://github.com/lervag/vimtex)...
    - [ ] Now I should learn some latex for real...
- [ ] Add `errorformat` for `rs` file type for results of tracing that I have
- [ ] GNU Global
- [ ] Get used to use plugin for surrounding stuff
- [ ] Refactor `mappings.lua` to different files, maybe
- [ ] Try either fix usage `nvim-cmp` or move to `blink-cmp`
    - [ ] if fix: make it keep showing function signature while I'm passing `arguments`
- [x] spell checker: add a mapping to toggle it.
    - [x] `<leader>ss`
- [ ] add a mapping to make between capital letters
