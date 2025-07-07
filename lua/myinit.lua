-- local autocmd = vim.api.nvim_create_autocmd

-- https://github.com/NvChad/NvChad/issues/1417#issuecomment-1203490842
local enable_providers = {
  "python3_provider",
  "node_provider",
  "perl_provider",
  "ruby_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.filetype.add {
  extension = {
    fbs = "fbs", -- Map the '.fbs' extension directly to the 'fbs' filetype
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fbs", -- The specific filetype you're interested in
  callback = function(args)
    -- 'args' contains information about the triggered autocommand
    -- args.buf is the buffer number
    -- args.file is the file name
    -- args.match is the pattern that matched (which will be 'your_filetype_name' here)
    -- Perform actions specific to this filetype
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true

    -- You could also set makeprg and errorformat here,
    -- though ftplugin is generally preferred for this.
    -- vim.opt_local.makeprg = 'my_compiler_for_' .. args.match .. ' %'
    -- vim.opt_local.errorformat = '%f:%l:%c: %t%*[^:]:%m'

    require "compiler/fbs"

    -- Define buffer-local mappings for this filetype
    vim.keymap.set("n", "<leader>mm", ":make<CR>", { buffer = args.buf, desc = "Compile current file" })
  end,
  desc = "Apply settings for fbs files",
})

vim.api.nvim_create_autocmd("FileType",{
  pattern = "cpp",
  callback = function(args)
    vim.cmd([[
" Vim compiler file
" Compiler:		GNU C Compiler
" Previous Maintainer:	Nikolai Weibull <now@bitwi.se>
" Last Change:		2010 Oct 14
"			changed pattern for entering/leaving directories
"			by Daniel Hahler, 2019 Jul 12
"			added line suggested by Anton Lindqvist 2016 Mar 31
"			2024 Apr 03 by The Vim Project (removed :CompilerSet definition)

if exists("current_compiler")
  finish
endif
let current_compiler = "gcc"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet errorformat=
      \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
      \%*[^\"]\"%f\"%*\\D%l:\ %m,
      \\"%f\"%*\\D%l:%c:\ %m,
      \\"%f\"%*\\D%l:\ %m,
      \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
      \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
      \%f:%l:%c:\ %trror:\ %m,
      \%f:%l:%c:\ %tarning:\ %m,
      \%f:%l:%c:\ %m,
      \%f:%l:\ %trror:\ %m,
      \%f:%l:\ %tarning:\ %m,
      \%f:%l:\ %m,
      \%f:\\(%*[^\\)]\\):\ %m,
      \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
      \%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
      \%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
      \%D%*\\a:\ Entering\ directory\ %*[`']%f',
      \%X%*\\a:\ Leaving\ directory\ %*[`']%f',
      \%DMaking\ %*\\a\ in\ %f

if exists('g:compiler_gcc_ignore_unmatched_lines')
  CompilerSet errorformat+=%-G%.%#
endif

let &cpo = s:cpo_save
unlet s:cpo_save

]])
  end,
  desc = "apply errorformat for cpp"
})
