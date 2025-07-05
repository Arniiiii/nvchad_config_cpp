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
