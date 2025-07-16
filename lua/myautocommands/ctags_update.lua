vim.cmd([[
autocmd BufWritePost * silent! !ctags . --options=$(realpath ~/.config/ctags) &
]])
