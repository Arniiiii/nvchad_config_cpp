vim.cmd([[
autocmd BufWritePost * silent! !ctags . &
]])
