require("overseer").setup()

vim.api.nvim_create_user_command("Make", function(params)
   -- Insert args at the '$*' in the makeprg
   local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
   if num_subs == 0 then
      cmd = cmd .. " " .. params.args
   end
   local winnr = vim.fn.win_getid()
   local bufnr = vim.api.nvim_win_get_buf(winnr)
   local efm = vim.api.nvim_get_option_value(
      "errorformat",
      { scope = "local", buf = bufnr }
   )
   local task = require("overseer").new_task {
      cmd = vim.fn.expandcmd(cmd),
      components = {
         {
            "on_output_quickfix",
            open = not params.bang,
            open_height = 8,
            errorformat = efm,
         },
         "default",
      },
   }
   task:start()
end, {
   desc = "Run your makeprg as an Overseer task",
   nargs = "*",
   bang = true,
})
