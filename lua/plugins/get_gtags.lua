vim.cmd [[
   if filereadable("/usr/local/share/gtags/gtags.vim")
      let s:Gtags_Auto_Map = 0
      let s:Gtags_Auto_Update = 1
      source /usr/local/share/gtags/gtags.vim 
   elseif filereadable("/usr/share/gtags/gtags.vim")
      let s:Gtags_Auto_Map = 0
      let s:Gtags_Auto_Update = 1
      source /usr/share/gtags/gtags.vim

   endif
]]
