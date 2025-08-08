-- require "nvchad.mappings"

local map = vim.keymap.set

local function get_selection()
   -- does not handle rectangular selection
   local s_start = vim.fn.getpos "."
   local s_end = vim.fn.getpos "v"
   local lines = vim.fn.getregion(s_start, s_end)
   return lines
end

CloseAllButCurrent = function()
   local current_buf = vim.fn.bufnr()
   local current_win = vim.fn.win_getid()
   local bufs = vim.fn.getbufinfo { buflisted = 1 }
   for _, buf in ipairs(bufs) do
      if buf.bufnr ~= current_buf then
         vim.cmd.bdelete { count = buf.bufnr, mods = { emsg_silent = true } }
      end
   end
   vim.fn.win_gotoid(current_win)
end

vim.keymap.set("n", "<leader>X", function()
   CloseAllButCurrent()
end, { silent = true, desc = "Close all other buffers except current one." })

map("n","<leader>gt", "<cmd>GtagsCursor<CR>", {silent = false, desc = "Gtags GtagsCursor"})
map("n","<leader>gT", "<cmd>Gtags<CR>", {silent = false, desc = "Gtags Gtags"})
map("n","<leader>GT", "<cmd>Gtagsa<CR>", {silent = false, desc = "Gtags Gtagsa (append to current quickfix window)"})

-- Copy paste-edit-resorted from here: https://vim.fandom.com/wiki/Moving_through_camel_case_words#Enhanced_version
-- " Use one of the following to define the camel characters.
-- " Stop on capital letters.
vim.g.camelchar = "A-Z"
-- " Also stop on numbers.
-- vim.g.camelchar = "A-Z0-9"
map(
   "n",
   "<leader>w",
   ":<C-u>call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%$','W')<CR>",
   { silent = true, desc = "general next word (capital letter)" }
)
map(
   "n",
   "<leader>W",
   ":<C-u>call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%^','bW')<CR>",
   { silent = true, desc = "general next word (capital letter)" }
)
map(
   "i",
   "<C-Right>",
   "<C-o>:call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%$','W')<CR>",
   { silent = true, desc = "general next word (capital letter)" }
)
map(
   "i",
   "<C-Left>",
   "<C-o>:call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%^','bW')<CR>",
   { silent = true, desc = "general next word (capital letter)" }
)
map(
   "v",
   "<leader>w",
   "<Esc>`>:<C-U>call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%$','W')<CR>v`<o",
   { silent = true, desc = "general next word (capital letter)" }
)
map(
   "v",
   "<leader>W",
   ":<C-U>call search('\\C\\<\\<Bar>\\%(^\\<Bar>[^'.g:camelchar.']\\@<=\\)['.g:camelchar.']\\<Bar>['.g:camelchar.']\\ze\\%([^'.g:camelchar.']\\&\\>\\@!\\)\\<Bar>\\%^','bW')<CR>v`>o",
   { silent = true, desc = "general next word (capital letter)" }
)

map("x", "<leader>gl", function()
   local selection = get_selection()
   local text = vim.fn.escape(selection[1], [[\/]])
   for i = 2, #selection do
      text = text .. "\\n" .. vim.fn.escape(selection[i], [[\/]])
   end
   vim.cmd("silent lgrep " .. text)
   local win = vim.api.nvim_get_current_win()
   vim.cmd.lopen()
   vim.api.nvim_set_current_win(win)
end, {
   desc = "search selected text everywhere in current folder, put in location list",
   silent = false,
})

map("x", "<leader>gc", function()
   local selection = get_selection()
   local text = vim.fn.escape(selection[1], [[\/]])
   for i = 2, #selection do
      text = text .. "\\n" .. vim.fn.escape(selection[i], [[\/]])
   end
   vim.cmd("silent grep " .. text)
   local win = vim.api.nvim_get_current_win()
   vim.cmd.copen()
   vim.api.nvim_set_current_win(win)
end, {
   desc = "search selected text everywhere in current folder, put in quickfix list",
   silent = false,
})

map("n", "<leader>Dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview Close" })
map("n", "<leader>Do", "<cmd>DiffviewOpen<CR>", { desc = "Diffview Open" })
map(
   "n",
   "<leader>Dr",
   "<cmd>DiffviewRefresh<CR>",
   { desc = "Diffview Refresh" }
)
map("n", "<leader>Dl", "<cmd>DiffviewLog<CR>", { desc = "Diffview Log" })
map(
   "n",
   "<leader>Df",
   "<cmd>DiffviewFocusFiles<CR>",
   { desc = "Diffview FocusFiles" }
)
map(
   "n",
   "<leader>Dh",
   "<cmd>DiffviewFileHistory<CR>",
   { desc = "Diffview FileHistory" }
)
map(
   "n",
   "<leader>Dt",
   "<cmd>DiffviewToggleFiles<CR>",
   { desc = "Diffview ToggleFiles" }
)

map("n", "<leader>ng", "<cmd>Neogit<CR>", { desc = "Neogit start" })

local gitsigns = require "gitsigns"

-- Navigation
map("n", "]h", function()
   if vim.wo.diff then
      vim.cmd.normal { "]h", bang = true }
   else
      gitsigns.nav_hunk "next"
   end
end)

map("n", "[h", function()
   if vim.wo.diff then
      vim.cmd.normal { "[h", bang = true }
   else
      gitsigns.nav_hunk "prev"
   end
end)

-- Actions
map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "gitsigns stage_hunk" })
map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "gitsigns reset_hunk" })

map("v", "<leader>hs", function()
   gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = 'gitsigns stage_hunk { vim.fn.line ".", vim.fn.line "v" }' })

map("v", "<leader>hr", function()
   gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = 'gitsigns reset_hunk { vim.fn.line ".", vim.fn.line "v" }' })

map(
   "n",
   "<leader>hS",
   gitsigns.stage_buffer,
   { desc = "gitsigns stage_buffer" }
)
map(
   "n",
   "<leader>hR",
   gitsigns.reset_buffer,
   { desc = "gitsigns reset_buffer" }
)
map(
   "n",
   "<leader>hp",
   gitsigns.preview_hunk,
   { desc = "gitsigns preview_hunk" }
)
map(
   "n",
   "<leader>hi",
   gitsigns.preview_hunk_inline,
   { desc = "gitsigns preview_hunk_inline" }
)

map("n", "<leader>hb", function()
   gitsigns.blame_line { full = true }
end, { desc = "gitsigns blame_line { full = true }" })

map("n", "<leader>hd", gitsigns.diffthis, { desc = "gitsigns diffthis" })

map("n", "<leader>hD", function()
   gitsigns.diffthis "~"
end, { desc = "gitsigns diffthis('~')" })

map("n", "<leader>hQ", function()
   gitsigns.setqflist "all"
end, { desc = "gitsigns setqflist('all')" })
map("n", "<leader>hq", gitsigns.setqflist, { desc = "gitsigns setqflist" })

-- Toggles
map(
   "n",
   "<leader>tb",
   gitsigns.toggle_current_line_blame,
   { desc = "gitsigns toggle_current_line_blame" }
)
map(
   "n",
   "<leader>tw",
   gitsigns.toggle_word_diff,
   { desc = "gitsigns toggle_word_diff" }
)

-- Text object
map(
   { "o", "x" },
   "ih",
   gitsigns.select_hunk,
   { desc = "'ih', gitsigns select_hunk" }
)

map("n", "<leader>Dc", "<cmd>diffoff<CR>", { desc = "diff close" })
map("n", "<leader>Du", "<cmd>diffupdate<CR>", { desc = "diff update" })
map("n", "<leader>Dt", "<cmd>diffthis<CR>", { desc = "diff this" })
map("n", "<leader>Dp", "<cmd>diffpatch<CR>", { desc = "diff patch" })
map("n", "<leader>Ds", "<cmd>diffsplit<CR>", { desc = "diff split" })
map("n", "<leader>Dg", "<cmd>diffget<CR>", { desc = "diff get" })
map("n", "<leader>Dp", "<cmd>diffput<CR>", { desc = "diff put" })

map("n", "<leader>fc", ":Cfilter ")
map("n", "<leader>fl", ":Lfilter ")

map("x", "<leader>s", function()
   local selection = get_selection()
   local text = vim.fn.escape(selection[1], [[\/"]])
   for i = 2, #selection do
      text = text .. "\\n" .. vim.fn.escape(selection[i], [[\/"]])
   end
   local clear_selection =
      vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
   local double_left =
      vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true)
   local keys_to_feed = ":"
      .. clear_selection
      .. "%s/"
      .. text
      .. "//g"
      .. double_left
   vim.fn.feedkeys(keys_to_feed)
end, {
   desc = "substitute all occurance of selected text with ...",
})

map("x", "<leader>S", function()
   local selection = get_selection()
   local text = vim.fn.escape(selection[1], [[\/"]])
   for i = 2, #selection do
      text = text .. "\\n" .. vim.fn.escape(selection[i], [[\/"]])
   end

   vim.cmd("silent lgrep " .. text)

   local win = vim.api.nvim_get_current_win()
   vim.cmd.lopen()
   vim.api.nvim_set_current_win(win)

   local clear_selection =
      vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
   local double_left =
      vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true)
   local keys_to_feed = ":"
      .. clear_selection
      .. "ldo s/"
      .. text
      .. "//g"
      .. double_left
   vim.fn.feedkeys(keys_to_feed)
end, { desc = "substitute all occurance in current folder" })

map("n", "<leader>ul", function()
   local keys_to_feed = ":lgrep "
   vim.fn.feedkeys(keys_to_feed)
end, { desc = "search and put to location_list" })

map("n", "<leader>uq", function()
   local keys_to_feed = ":grep "
   vim.fn.feedkeys(keys_to_feed)
end, { desc = "search and put to location_list" })

map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<A-q>", function()
   require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<A-Q>", function()
   require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
   require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- whichkey
map("n", "<leader>HK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>Hk", function()
   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

map({ "n", "x" }, "<leader>fm", function()
   require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

map("n", "<leader>ss", "<cmd>set spell!<CR>", { desc = "toggle spell" })
map("n", "<leader>ra", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map(
   "n",
   "<leader>ch",
   "<cmd>NvCheatsheet<CR>",
   { desc = "toggle nvcheatsheet" }
)

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("v", ">", ">gv", { desc = "general indent" })
map("v", "<", "<gv", { desc = "general backdent" })

map(
   "n",
   "<C-h>",
   ":TmuxNavigateLeft<CR><ESC>",
   { desc = "tmux_navigator Window left", noremap = true, silent = true }
)
map(
   "n",
   "<C-l>",
   ":TmuxNavigateRight<CR><ESC>",
   { desc = "tmux_navigator Window right", noremap = true, silent = true }
)
map(
   "n",
   "<C-j>",
   ":TmuxNavigateDown<CR><ESC>",
   { desc = "tmux_navigator Window down", noremap = true, silent = true }
)
map(
   "n",
   "<C-k>",
   ":TmuxNavigateUp<CR><ESC>",
   { desc = "tmux_navigator Window left", noremap = true, silent = true }
)
map(
   "n",
   "<C-b>",
   ":TmuxNavigatePrevious<CR><ESC>",
   { desc = "tmux_navigator Window previous", noremap = true, silent = true }
)

map("n", "<leader>dr", function()
   require("dap").restart()
end, { desc = "dap Restart session" })
map("n", "<leader>rb", function()
   require("dap").clear_breakboints()
end, { desc = "dap Remove all breakpoints" })
map("n", "<leader>dt", function()
   require("dap").terminate()
end, { desc = "dap Terminate session" })
map("n", "<leader>tu", function()
   require("dap").up()
end, { desc = "dap Go up in current stacktrace without stepping" })
map("n", "<leader>td", function()
   require("dap").down()
end, { desc = "dap Go down in current stacktrace without stepping" })
map("n", "<leader>rc", function()
   require("dap").reverse_continue()
end, {
   desc = "dap Reverse continue. Debugger & debug adapter have to support it",
})
map("n", "<F5>", function()
   require("dap").continue()
end, { desc = "dap Continue" })
map("n", "<F10>", function()
   require("dap").step_over()
end, { desc = "dap Step over" })
map("n", "<F11>", function()
   require("dap").step_into()
end, { desc = "dap Step into by statement" })
-- seems to not work with codelldb ?
map("n", "<F9>", function()
   require("dap").step_into { steppingGranularity = "instruction" }
end, { desc = "dap Step into by instruction" })
map("n", "<F12>", function()
   require("dap").step_out()
end, { desc = "dap Step out" })
map("n", "<leader>b", function()
   require("dap").toggle_breakpoint()
end, { desc = "dap Toggle breakpoint" })
map("n", "<leader>sb", function()
   require("dap").set_breakpoint()
end, { desc = "dap Set breakpoint" })
map("n", "<leader>blp", function()
   require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end, { desc = "dap Set breakpoint with log point" })
map("n", "<leader>do", function()
   require("dap").repl.open()
end, { desc = "dap Repl open?" })
map("n", "<leader>dl", function()
   require("dap").run_last()
end, { desc = "dap Run last?" })

map("n", "<leader>do", function()
   require("dapui").open()
end, { desc = "dapui Open" })
map("n", "<leader>dc", function()
   require("dapui").close()
end, { desc = "dapui Close" })
map("n", "<leader>de", function()
   require("dapui").eval()
end, { desc = "dapui Show hover window with evaluating expression" })
map({ "n", "v" }, "<leader>dh", function()
   require("dap.ui.widgets").hover()
end, { desc = "dapui hover?" })
map({ "n", "v" }, "<leader>dp", function()
   require("dap.ui.widgets").preview()
end, { desc = "dapui preview?" })
-- map("n", "<leader>df", function()
--    local widgets = require "dap.ui.widgets"
--    widgets.centered_float(widgets.frames)
-- end, { desc = "dapui widgets frame float ?" })
-- map("n", "<leader>ds", function()
--    local widgets = require "dap.ui.widgets"
--    widgets.centered_float(widgets.scopes)
-- end, { desc = "dapui widgets scopes float ?" })

map(
   "n",
   "<leader>t;",
   ":Telescope commands<CR>",
   { desc = "Telescope commands" }
)

map("n", "<leader>tt", ":Telescope<CR>", { desc = "Telescope telescope" })

map(
   "n",
   "<leader>tch",
   ":Telescope command_history<CR>",
   { desc = "Telescope command history" }
)

-- nvimtree
map(
   "n",
   "<C-n>",
   "<cmd>NvimTreeToggle<CR>",
   { desc = "nvimtree toggle window" }
)
map(
   "n",
   "<leader>e",
   "<cmd>NvimTreeFocus<CR>",
   { desc = "nvimtree focus window" }
)

map(
   "n",
   "<leader>ts",
   "<cmd>Telescope live_grep<CR>",
   { desc = "telescope live grep" }
)
map(
   "n",
   "<leader>tb",
   "<cmd>Telescope buffers<CR>",
   { desc = "telescope find buffers" }
)
map(
   "n",
   "<leader>tht",
   "<cmd>Telescope help_tags<CR>",
   { desc = "telescope help page" }
)
map(
   "n",
   "<leader>tm",
   "<cmd>Telescope marks<CR>",
   { desc = "telescope find marks" }
)
map(
   "n",
   "<leader>to",
   "<cmd>Telescope oldfiles<CR>",
   { desc = "telescope find oldfiles" }
)
map(
   "n",
   "<leader>tz",
   "<cmd>Telescope current_buffer_fuzzy_find<CR>",
   { desc = "telescope find in current buffer" }
)
map(
   "n",
   "<leader>tcm",
   "<cmd>Telescope git_commits<CR>",
   { desc = "telescope git commits" }
)
map(
   "n",
   "<leader>tg",
   "<cmd>Telescope git_status<CR>",
   { desc = "telescope git status" }
)

map(
   "n",
   "<leader>tf",
   "<cmd>Telescope find_files<cr>",
   { desc = "telescope find files" }
)

map(
   "n",
   "<leader>tF",
   "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
   { desc = "telescope find all files" }
)

map(
   "n",
   "<leader>tG",
   "<cmd>Telescope git_files<CR>",
   { desc = "telescope find all files" }
)

map(
   "n",
   "<leader>tSt",
   "<cmd>Telescope filetypes<cr>",
   { desc = "telescope find files" }
)

map("n", "<leader>TH", function()
   require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.6 }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-t>", function()
   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0 }
end, { desc = "terminal toggleable vertical term full-size" })

map({ "n", "t" }, "<A-h>", function()
   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.6 }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
   require("nvchad.term").toggle { pos = "float", id = "floatTerm", size = 0.6 }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

map(
   "n",
   "<leader>CG",
   ":CMakeGenerate <CR>",
   { desc = "CMake Configure and generate" }
)
map("n", "<leader>CB", ":CMakeBuild <CR>", { desc = "CMake Build" })
map("n", "<leader>CR", ":CMakeRun <CR>", { desc = "CMake Run" })
map("n", "<leader>CK", ":CMakeSelectKit <CR>", { desc = "CMake Select kit" })
map(
   "n",
   "<leader>CS",
   ":CMakeSettings <CR>",
   { desc = "CMake Project settings" }
)
map(
   "n",
   "<leader>Cd",
   ":CMakeDebug <CR>",
   { desc = "CMake Debug. Wanna add args?`:CMakeTargetSettings`" }
)
map(
   "n",
   "<leader>Ce",
   ":CMakeCloseExecutor <CR>",
   { desc = "CMake Close executor" }
)
map(
   "n",
   "<leader>Cr",
   ":CMakeCloseRunner <CR>",
   { desc = "CMake Close runner" }
)
map(
   "n",
   "<leader>Coe",
   ":CMakeOpenExecutor <CR>",
   { desc = "CMake Open executor" }
)
map("n", "<leader>Cor", ":CMakeOpenRunner <CR>", { desc = "CMake Open runner" })
map(
   "n",
   "<leader>Cse",
   ":CMakeStopExecutor <CR>",
   { desc = "CMake Stop current cmake executor's process" }
)
map(
   "n",
   "<leader>Csr",
   ":CMakeStopRunner <CR>",
   { desc = "CMake Stop current cmake runner's process" }
)
map("n", "<leader>Cc", ":CMakeClean <CR>", { desc = "CMake Clean" })
map("n", "<leader>Cqb", ":CMakeQuickBuild <CR>", { desc = "CMake Quick build" })
map("n", "<leader>Cqr", ":CMakeQuickRun <CR>", { desc = "CMake Quick run" })
map("n", "<leader>Ci", ":CMakeInstall <CR>", { desc = "CMake Install" })
map("n", "<leader>Cl", ":CMakeLaunchArgs <CR>", { desc = "CMake Launch args" })
map(
   "n",
   "<leader>Csp",
   ":CMakeSelectBuildPreset <CR>",
   { desc = "CMake Select build preset" }
)
map(
   "n",
   "<leader>Cst",
   ":CMakeSelectBuildTarget <CR>",
   { desc = "CMake Select build target" }
)
map(
   "n",
   "<leader>CsT",
   ":CMakeSelectBuildType <CR>",
   { desc = "CMake Select build variant" }
)
map(
   "n",
   "<leader>Csc",
   ":CMakeSelectConfigurePreset <CR>",
   { desc = "CMake Select configure preset" }
)
map(
   "n",
   "<leader>Csl",
   ":CMakeSelectLaunchTarget <CR>",
   { desc = "CMake Select launch target" }
)
map(
   "n",
   "<leader>Ctf",
   ":CMakeShowTargetFiles <CR>",
   { desc = "CMake Show target file" }
)
map(
   "n",
   "<leader>Cts",
   ":CMakeTargetSettings <CR>",
   { desc = "CMake Target settings" }
)
map(
   "n",
   "<leader>Csb",
   ":CMakeSelectBuildDir <CR>",
   { desc = "CMake Select build dir" }
)
map("n", "<leader>Csw", ":CMakeSelectCwd <CR>", { desc = "CMake Select cwd" })

map("n", "gD", function()
   vim.lsp.buf.declaration()
end, {
   desc = "LSP declaration",
})

map("n", "gd", function()
   vim.lsp.buf.definition()
end, {
   desc = "LSP definition",
})

map("n", "K", function()
   vim.lsp.buf.hover()
end, {
   desc = "LSP hover",
})

map("n", "gi", function()
   vim.lsp.buf.implementation()
end, {
   desc = "LSP implementation",
})

map("n", "<leader>lh", function()
   vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })

map("n", "<leader>D", function()
   vim.lsp.buf.type_definition()
end, { desc = "LSP definition type" })

map("n", "<F2>", function()
   vim.lsp.buf.rename()
end, { desc = "LSP rename" })

map("n", "<leader>lr", function()
   vim.lsp.buf.rename()
end, { desc = "LSP rename" })

map({ "n", "v" }, "<leader>4", function()
   vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

map("n", "grr", function()
   vim.lsp.buf.references()
end, { desc = "LSP references" })

map("n", "<leader>lf", function()
   vim.diagnostic.open_float { border = "rounded" }
end, { desc = "LSP Floating diagnostic" })

map("n", "[d", function()
   vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "LSP Goto prev" })

map("n", "]d", function()
   vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "LSP Goto next" })

map("n", "<leader>ld", function()
   vim.diagnostic.setloclist()
end, { desc = "LSP Diagnostic setloclist" })

map("n", "<leader>lwa", function()
   vim.lsp.buf.add_workspace_folder()
end, { desc = "LSP Add workspace folder" })

map("n", "<leader>lwr", function()
   vim.lsp.buf.remove_workspace_folder()
end, { desc = "LSP Remove workspace folder" })

map("n", "<leader>lwl", function()
   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP List workspace folders" })

map("n", "<leader>gd", function()
   require("neogen").generate()
end, { desc = "Neogen generate smth" })

map("n", "<leader>LR", ":LspRestart <CR>", { desc = "LSP restart LSP" })
map("n", "<leader>Ls", ":LspStart <CR>", { desc = "LSP start LSP" })
map("n", "<leader>LS", ":LspStop <CR>", { desc = "LSP stop LSP" })
-- more keybinds!

map("n", "<C-g>", "<cmd>CodeCompanionActions<cr>", {
   desc = "CodeCompanion Open an LLM involvement menu",
   noremap = true,
   silent = true,
})
map("v", "<C-g>", "<cmd>CodeCompanionActions<cr>", {
   desc = "CodeCompanion Open an LLM involvement menu",
   noremap = true,
   silent = true,
})
map(
   "n",
   "<leader>a",
   "<cmd>CodeCompanionToggle<cr>",
   { desc = "CodeCompanion Open a LLM buffer", noremap = true, silent = true }
)
map(
   "v",
   "<leader>a",
   "<cmd>CodeCompanionToggle<cr>",
   { desc = "CodeCompanion Open a LLM buffer", noremap = true, silent = true }
)
map("v", "ga", "<cmd>CodeCompanionAdd<cr>", {
   desc = "CodeCompanion maybe save a chat with a LLM",
   noremap = true,
   silent = true,
})

map("n", "<leader>TT", function()
   require("base46").toggle_theme()
end, { desc = "Base46 Toggle theme", noremap = true, silent = true })
map("n", "<leader>Tt", function()
   require("base46").toggle_transparency()
end, { desc = "Base46 Toggle transparency", noremap = true, silent = true })

map(
   "n",
   "<M-j>",
   "<cmd>cnext<cr>zz",
   { desc = "Quickfix next", noremap = true, silent = true }
)
map(
   "n",
   "<M-k>",
   "<cmd>cprev<cr>zz",
   { desc = "Quickfix next", noremap = true, silent = true }
)
map(
   "n",
   "<leader>j",
   "<cmd>cnext<cr>",
   { desc = "Quickfix next without zz", noremap = true, silent = true }
)
map(
   "n",
   "<leader>k",
   "<cmd>cprev<cr>",
   { desc = "Quickfix next without zz", noremap = true, silent = true }
)
map(
   "n",
   "<leader>cO",
   "<cmd>copen<cr>",
   { desc = "Quickfix open", noremap = true, silent = true }
)
map("n", "<leader>co", function()
   local win = vim.api.nvim_get_current_win()
   vim.cmd.copen()
   vim.api.nvim_set_current_win(win)
end, { desc = "Quickfix open", noremap = true, silent = true })
map(
   "n",
   "<leader>cc",
   "<cmd>cclose<cr>",
   { desc = "Quickfix close", noremap = true, silent = true }
)
map(
   "n",
   "<leader>cp",
   "<cmd>colder<cr>",
   { desc = "Quickfix previous list (colder)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>cn",
   "<cmd>cnewer<cr>",
   { desc = "Quickfix next list (cnewer)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>cg",
   "<cmd>cfirst<cr>",
   { desc = "Quickfix first in list (cfirst)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>cG",
   "<cmd>clast<cr>",
   { desc = "Quickfix last in list (clast)", noremap = true, silent = true }
)

map(
   "n",
   "<M-.>",
   "<cmd>lnext<cr>zz",
   { desc = "Location_list next", noremap = true, silent = true }
)
map(
   "n",
   "<M-,>",
   "<cmd>lprev<cr>zz",
   { desc = "Location_list previous", noremap = true, silent = true }
)
map(
   "n",
   "<leader>.",
   "<cmd>lnext<cr>",
   { desc = "Location_list next without zz", noremap = true, silent = true }
)
map(
   "n",
   "<leader>,",
   "<cmd>lprev<cr>",
   { desc = "Location_list previous without zz", noremap = true, silent = true }
)
map(
   "n",
   "<leader>lO",
   "<cmd>lopen<cr>",
   { desc = "Location_list open", noremap = true, silent = true }
)

map("n", "<leader>lo", function()
   local win = vim.api.nvim_get_current_win()
   vim.cmd.lopen()
   vim.api.nvim_set_current_win(win)
end, { desc = "Location_list open", noremap = true, silent = true })

map(
   "n",
   "<leader>lc",
   "<cmd>lclose<cr>",
   { desc = "Location_list close", noremap = true, silent = true }
)
map("n", "<leader>lp", "<cmd>lolder<cr>", {
   desc = "Location_list previous list (lolder)",
   noremap = true,
   silent = true,
})
map(
   "n",
   "<leader>ln",
   "<cmd>lnewer<cr>",
   { desc = "Location_list next list (lnewer)", noremap = true, silent = true }
)
map("n", "<leader>lg", "<cmd>lfirst<cr>", {
   desc = "Location_list first in list (lfirst)",
   noremap = true,
   silent = true,
})
map(
   "n",
   "<leader>lG",
   "<cmd>llast<cr>",
   { desc = "Location last in list (llast)", noremap = true, silent = true }
)

map(
   "n",
   "<leader>TN",
   "<cmd>tabnew<cr>",
   { desc = "Tabs new (tabnew)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>Tn",
   "<cmd>tabnext<cr>",
   { desc = "Tabs next (tabnext)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>Tp",
   "<cmd>tabprevious<cr>",
   { desc = "Tabs previous (tabprevious)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>Tc",
   "<cmd>tabclose<cr>",
   { desc = "Tabs close (tabclose)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>Tg",
   "<cmd>tabrewind<cr>",
   { desc = "Tabs first tab (tabrewind)", noremap = true, silent = true }
)
map(
   "n",
   "<leader>TG",
   "<cmd>tablast<cr>",
   { desc = "Tabs last tab (tablast)", noremap = true, silent = true }
)

-- Define buffer-local mappings for this filetype
map(
   "n",
   "<leader>mm",
   ":make ",
   { desc = "Compile current file", noremap = true }
)

map(
   "n",
   "<M-]>",
   "<cmd>tnext<cr>zz",
   { desc = "Ctags next", noremap = true, silent = true }
)
map(
   "n",
   "<M-[>",
   "<cmd>tprev<cr>zz",
   { desc = "Ctags previous", noremap = true, silent = true }
)
map("n", "<leader>lt", "<cmd>execute 'ltag ' . expand('<cword>') | lopen<cr>", {
   desc = "Ctags show matching tags in a location list",
   noremap = true,
   silent = true,
})
