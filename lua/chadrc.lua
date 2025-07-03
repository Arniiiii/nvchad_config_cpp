---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "highlights"

M.base46 = {
  theme = "mito-laser",
  theme_toggle = { "vscode_light", "mito-laser" },
  -- transparency = true,
  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "block",
    order = { "mode", "myfile", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
    modules = {
      -- abc = function()
      --   return "hi"
      -- end,

      -- xyz = "hi",
      myfile = function()
        local x = "%F"
        return "%#St_file# " .. x .. " "
      end,
    },
  },
}

-- M.plugins = "plugins"

-- check core.mappings for table structure
-- M.mappings = require "mappings"

M.lazy_nvim = require "lazy_nvim"

return M
