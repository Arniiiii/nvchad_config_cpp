vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
   local repo = "https://github.com/folke/lazy.nvim.git"
   vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      repo,
      "--branch=stable",
      lazypath,
   }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
   {
      "NvChad/NvChad",
      lazy = false,
      branch = "v2.5",
      -- import = "nvchad.plugins",
      config = function()
         require "options"
      end,
   },

   { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
   require "mappings"
end)
require "myinit"

vim.opt.wildignore:append { "target/**", "build*/**", "\\.git/**", "tags" }

vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"

vim.opt.cursorline = true -- Highlight current line

vim.opt.tabstop = 3 -- Tab width
vim.opt.shiftwidth = 3 -- Indent width
vim.opt.softtabstop = 3 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
-- vim.opt.hlsearch = false                           -- Don't highlight search results
vim.opt.incsearch = true -- Show matches as you type

vim.opt.encoding = "UTF-8" -- Set encoding
-- Cursor settings
vim.opt.guicursor =
   "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

if vim.fn.executable "ug" == 1 then
   vim.o.grepprg = 'ug+ --format="\\%f:\\%n:\\%k:\\%O\\%~" --ignore-binary --hidden --ignore-files=.gitignore -R -e "$*"'
end
