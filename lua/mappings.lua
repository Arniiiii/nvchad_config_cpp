-- require "nvchad.mappings"

local map = vim.keymap.set

-- Disable mappings
-- local nomap = vim.keymap.del

-- nomap("n", "'")

-- map("n","<C-'>", "<C-i>",{desc="general next in jumplist (tmux workaround)"})
-- tabufline

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
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

map({ "n", "x" }, "<leader>fm", function()
   require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

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

map(
   "n",
   "<leader>tt",
   ":Telescope<CR>",
   { desc = "Telescope telescope" }
)

map(
   "n",
   "<leader>tch",
   ":Telescope command_history<CR>",
   { desc = "Telescope command history" }
)

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

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
   "<leader>th",
   "<cmd>Telescope terms<CR>",
   { desc = "telescope pick hidden term" }
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

map("n", "<leader>f", function()
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

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>CodeCompanionActions<cr>", {
   desc = "CodeCompanion Open an LLM involvement menu",
   noremap = true,
   silent = true,
})
vim.api.nvim_set_keymap("v", "<C-g>", "<cmd>CodeCompanionActions<cr>", {
   desc = "CodeCompanion Open an LLM involvement menu",
   noremap = true,
   silent = true,
})
vim.api.nvim_set_keymap(
   "n",
   "<leader>a",
   "<cmd>CodeCompanionToggle<cr>",
   { desc = "CodeCompanion Open a LLM buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "v",
   "<leader>a",
   "<cmd>CodeCompanionToggle<cr>",
   { desc = "CodeCompanion Open a LLM buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", {
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

vim.api.nvim_set_keymap(
   "n",
   "<M-j>",
   "<cmd>cnext<cr>zz",
   { desc = "Quickfix next", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<M-k>",
   "<cmd>cprev<cr>zz",
   { desc = "Quickfix next", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>j",
   "<cmd>cnext<cr>",
   { desc = "Quickfix next without zz", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>k",
   "<cmd>cprev<cr>",
   { desc = "Quickfix next without zz", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>co",
   "<cmd>copen<cr>",
   { desc = "Quickfix open", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>cc",
   "<cmd>cclose<cr>",
   { desc = "Quickfix close", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>cp",
   "<cmd>colder<cr>",
   { desc = "Quickfix previous list (colder)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>cn",
   "<cmd>cnewer<cr>",
   { desc = "Quickfix next list (cnewer)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>cg",
   "<cmd>cfirst<cr>",
   { desc = "Quickfix first in list (cfirst)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>cG",
   "<cmd>clast<cr>",
   { desc = "Quickfix last in list (clast)", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<M-.>",
   "<cmd>lnext<cr>zz",
   { desc = "Location_list next", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<M-,>",
   "<cmd>lprev<cr>zz",
   { desc = "Location_list previous", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>.",
   "<cmd>lnext<cr>",
   { desc = "Location_list next without zz", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>,",
   "<cmd>lprev<cr>",
   { desc = "Location_list previous without zz", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>lo",
   "<cmd>lopen<cr>",
   { desc = "Location_list open", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>lc",
   "<cmd>lclose<cr>",
   { desc = "Location_list close", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>lolder<cr>", {
   desc = "Location_list previous list (lolder)",
   noremap = true,
   silent = true,
})
vim.api.nvim_set_keymap(
   "n",
   "<leader>ln",
   "<cmd>lnewer<cr>",
   { desc = "Location_list next list (lnewer)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lfirst<cr>", {
   desc = "Location_list first in list (lfirst)",
   noremap = true,
   silent = true,
})
vim.api.nvim_set_keymap(
   "n",
   "<leader>lG",
   "<cmd>llast<cr>",
   { desc = "Location last in list (llast)", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<leader>TN",
   "<cmd>tabnew<cr>",
   { desc = "Tabs new (tabnew)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>Tn",
   "<cmd>tabnext<cr>",
   { desc = "Tabs next (tabnext)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>Tp",
   "<cmd>tabprevious<cr>",
   { desc = "Tabs previous (tabprevious)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>Tc",
   "<cmd>tabclose<cr>",
   { desc = "Tabs close (tabclose)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>Tg",
   "<cmd>tabrewind<cr>",
   { desc = "Tabs first tab (tabrewind)", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
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

vim.api.nvim_set_keymap(
   "n",
   "<M-]>",
   "<cmd>tnext<cr>zz",
   { desc = "Ctags next", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<M-[>",
   "<cmd>tprev<cr>zz",
   { desc = "Ctags previous", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
   "n",
   "<leader>lt",
   "<cmd>execute 'ltag ' . expand('<cword>') | lopen<cr>",
   {
      desc = "Ctags show matching tags in a location list",
      noremap = true,
      silent = true,
   }
)
