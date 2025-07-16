require "nvchad.mappings"

vim.keymap.set("v", ">", ">gv", { desc = "general indent" })

vim.keymap.set(
   "n",
   "<C-h>",
   ":TmuxNavigateLeft<CR><ESC>",
   { desc = "tmux_navigator Window left" }
)
vim.keymap.set(
   "n",
   "<C-l>",
   ":TmuxNavigateRight<CR><ESC>",
   { desc = "tmux_navigator Window right" }
)
vim.keymap.set(
   "n",
   "<C-j>",
   ":TmuxNavigateDown<CR><ESC>",
   { desc = "tmux_navigator Window down" }
)
vim.keymap.set(
   "n",
   "<C-k>",
   ":TmuxNavigateUp<CR><ESC>",
   { desc = "tmux_navigator Window left" }
)
vim.keymap.set(
   "n",
   "<C-b>",
   ":TmuxNavigatePrevious<CR><ESC>",
   { desc = "tmux_navigator Window previous" }
)

vim.keymap.set("n", "<leader>dr", function()
   require("dap").restart()
end, { desc = "dap Restart session" })
vim.keymap.set("n", "<leader>rb", function()
   require("dap").clear_breakboints()
end, { desc = "dap Remove all breakpoints" })
vim.keymap.set("n", "<leader>dt", function()
   require("dap").terminate()
end, { desc = "dap Terminate session" })
vim.keymap.set("n", "<leader>tu", function()
   require("dap").up()
end, { desc = "dap Go up in current stacktrace without stepping" })
vim.keymap.set("n", "<leader>td", function()
   require("dap").down()
end, { desc = "dap Go down in current stacktrace without stepping" })
vim.keymap.set("n", "<leader>rc", function()
   require("dap").reverse_continue()
end, {
   desc = "dap Reverse continue. Debugger & debug adapter have to support it",
})
vim.keymap.set("n", "<F5>", function()
   require("dap").continue()
end, { desc = "dap Continue" })
vim.keymap.set("n", "<F10>", function()
   require("dap").step_over()
end, { desc = "dap Step over" })
vim.keymap.set("n", "<F11>", function()
   require("dap").step_into()
end, { desc = "dap Step into by statement" })
-- seems to not work with codelldb ?
-- vim.keymap.set("n", "<F9>", function()
--   require("dap").step_into({steppingGranularity = 'instruction'})
-- end, { desc = "dap Step into by instruction" })
vim.keymap.set("n", "<F12>", function()
   require("dap").step_out()
end, { desc = "dap Step out" })
vim.keymap.set("n", "<leader>b", function()
   require("dap").toggle_breakpoint()
end, { desc = "dap Toggle breakpoint" })
vim.keymap.set("n", "<leader>sb", function()
   require("dap").set_breakpoint()
end, { desc = "dap Set breakpoint" })
vim.keymap.set("n", "<leader>blp", function()
   require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end, { desc = "dap Set breakpoint with log point" })
vim.keymap.set("n", "<leader>do", function()
   require("dap").repl.open()
end, { desc = "dap Repl open?" })
vim.keymap.set("n", "<leader>dl", function()
   require("dap").run_last()
end, { desc = "dap Run last?" })

vim.keymap.set("n", "<leader>do", function()
   require("dapui").open()
end, { desc = "dapui Open" })
vim.keymap.set("n", "<leader>dc", function()
   require("dapui").close()
end, { desc = "dapui Close" })
vim.keymap.set("n", "<leader>de", function()
   require("dapui").eval()
end, { desc = "dapui Show hover window with evaluating expression" })
vim.keymap.set({ "n", "v" }, "<leader>dh", function()
   require("dap.ui.widgets").hover()
end, { desc = "dapui hover?" })
vim.keymap.set({ "n", "v" }, "<leader>dp", function()
   require("dap.ui.widgets").preview()
end, { desc = "dapui preview?" })
-- vim.keymap.set("n", "<leader>df", function()
--    local widgets = require "dap.ui.widgets"
--    widgets.centered_float(widgets.frames)
-- end, { desc = "dapui widgets frame float ?" })
-- vim.keymap.set("n", "<leader>ds", function()
--    local widgets = require "dap.ui.widgets"
--    widgets.centered_float(widgets.scopes)
-- end, { desc = "dapui widgets scopes float ?" })

vim.keymap.set(
   "n",
   "<leader>;",
   ":Telescope commands<CR>",
   { desc = "Telescope commands" }
)
vim.keymap.set(
   "n",
   "<leader>tch",
   ":Telescope command_history<CR>",
   { desc = "Telescope command history" }
)

vim.keymap.set(
   "n",
   "<leader>CG",
   ":CMakeGenerate <CR>",
   { desc = "CMake Configure and generate" }
)
vim.keymap.set("n", "<leader>CB", ":CMakeBuild <CR>", { desc = "CMake Build" })
vim.keymap.set("n", "<leader>CR", ":CMakeRun <CR>", { desc = "CMake Run" })
vim.keymap.set(
   "n",
   "<leader>CK",
   ":CMakeSelectKit <CR>",
   { desc = "CMake Select kit" }
)
vim.keymap.set(
   "n",
   "<leader>CS",
   ":CMakeSettings <CR>",
   { desc = "CMake Project settings" }
)
vim.keymap.set(
   "n",
   "<leader>Cd",
   ":CMakeDebug <CR>",
   { desc = "CMake Debug. Wanna add args?`:CMakeTargetSettings`" }
)
vim.keymap.set(
   "n",
   "<leader>Ce",
   ":CMakeCloseExecutor <CR>",
   { desc = "CMake Close executor" }
)
vim.keymap.set(
   "n",
   "<leader>Cr",
   ":CMakeCloseRunner <CR>",
   { desc = "CMake Close runner" }
)
vim.keymap.set(
   "n",
   "<leader>Coe",
   ":CMakeOpenExecutor <CR>",
   { desc = "CMake Open executor" }
)
vim.keymap.set(
   "n",
   "<leader>Cor",
   ":CMakeOpenRunner <CR>",
   { desc = "CMake Open runner" }
)
vim.keymap.set(
   "n",
   "<leader>Cse",
   ":CMakeStopExecutor <CR>",
   { desc = "CMake Stop current cmake executor's process" }
)
vim.keymap.set(
   "n",
   "<leader>Csr",
   ":CMakeStopRunner <CR>",
   { desc = "CMake Stop current cmake runner's process" }
)
vim.keymap.set("n", "<leader>Cc", ":CMakeClean <CR>", { desc = "CMake Clean" })
vim.keymap.set(
   "n",
   "<leader>Cqb",
   ":CMakeQuickBuild <CR>",
   { desc = "CMake Quick build" }
)
vim.keymap.set(
   "n",
   "<leader>Cqr",
   ":CMakeQuickRun <CR>",
   { desc = "CMake Quick run" }
)
vim.keymap.set(
   "n",
   "<leader>Ci",
   ":CMakeInstall <CR>",
   { desc = "CMake Install" }
)
vim.keymap.set(
   "n",
   "<leader>Cl",
   ":CMakeLaunchArgs <CR>",
   { desc = "CMake Launch args" }
)
vim.keymap.set(
   "n",
   "<leader>Csp",
   ":CMakeSelectBuildPreset <CR>",
   { desc = "CMake Select build preset" }
)
vim.keymap.set(
   "n",
   "<leader>Cst",
   ":CMakeSelectBuildTarget <CR>",
   { desc = "CMake Select build target" }
)
vim.keymap.set(
   "n",
   "<leader>CsT",
   ":CMakeSelectBuildType <CR>",
   { desc = "CMake Select build variant" }
)
vim.keymap.set(
   "n",
   "<leader>Csc",
   ":CMakeSelectConfigurePreset <CR>",
   { desc = "CMake Select configure preset" }
)
vim.keymap.set(
   "n",
   "<leader>Csl",
   ":CMakeSelectLaunchTarget <CR>",
   { desc = "CMake Select launch target" }
)
vim.keymap.set(
   "n",
   "<leader>Ctf",
   ":CMakeShowTargetFiles <CR>",
   { desc = "CMake Show target file" }
)
vim.keymap.set(
   "n",
   "<leader>Cts",
   ":CMakeTargetSettings <CR>",
   { desc = "CMake Target settings" }
)
vim.keymap.set(
   "n",
   "<leader>Csb",
   ":CMakeSelectBuildDir <CR>",
   { desc = "CMake Select build dir" }
)
vim.keymap.set(
   "n",
   "<leader>Csw",
   ":CMakeSelectCwd <CR>",
   { desc = "CMake Select cwd" }
)

vim.keymap.set("n", "gD", function()
   vim.lsp.buf.declaration()
end, {
   desc = "LSP declaration",
})

vim.keymap.set("n", "gd", function()
   vim.lsp.buf.definition()
end, {
   desc = "LSP definition",
})

vim.keymap.set("n", "K", function()
   vim.lsp.buf.hover()
end, {
   desc = "LSP hover",
})

vim.keymap.set("n", "gi", function()
   vim.lsp.buf.implementation()
end, {
   desc = "LSP implementation",
})

vim.keymap.set("n", "<leader>lh", function()
   vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })

vim.keymap.set("n", "<leader>D", function()
   vim.lsp.buf.type_definition()
end, { desc = "LSP definition type" })

vim.keymap.set("n", "<leader>ra", function()
   require("nvchad.renamer").open()
end, { desc = "LSP rename using renamer" })

vim.keymap.set("n", "<F2>", function()
   vim.lsp.buf.rename()
end, { desc = "LSP rename" })

vim.keymap.set("n", "<leader>ca", function()
   vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

vim.keymap.set({ "n", "v" }, "<leader>4", function()
   vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

vim.keymap.set("n", "gr", function()
   vim.lsp.buf.references()
end, { desc = "LSP references" })

vim.keymap.set("n", "<leader>f", function()
   vim.diagnostic.open_float { border = "rounded" }
end, { desc = "LSP Floating diagnostic" })

vim.keymap.set("n", "[d", function()
   vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "LSP Goto prev" })

vim.keymap.set("n", "]d", function()
   vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "LSP Goto next" })

vim.keymap.set("n", "<leader>q", function()
   vim.diagnostic.setloclist()
end, { desc = "LSP Diagnostic setloclist" })

vim.keymap.set("n", "<leader>wa", function()
   vim.lsp.buf.add_workspace_folder()
end, { desc = "LSP Add workspace folder" })

vim.keymap.set("n", "<leader>wr", function()
   vim.lsp.buf.remove_workspace_folder()
end, { desc = "LSP Remove workspace folder" })

vim.keymap.set("n", "<leader>wl", function()
   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP List workspace folders" })

vim.keymap.set("n", "<leader>nf", function()
   require("neogen").generate()
end, { desc = "Neogen generate smth" })

vim.keymap.set(
   "n",
   "<leader>lr",
   ":LspRestart <CR>",
   { desc = "LSP restart LSP" }
)
vim.keymap.set("n", "<leader>ls", ":LspStart <CR>", { desc = "LSP start LSP" })
vim.keymap.set("n", "<leader>lS", ":LspStop <CR>", { desc = "LSP stop LSP" })
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

vim.keymap.set("n", "<leader>tt", function()
   require("base46").toggle_theme()
end, { desc = "Base46 Toggle theme", noremap = true, silent = true })
vim.keymap.set("n", "<leader>tT", function()
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
   { desc = "Location_list next", noremap = true, silent = true }
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
   { desc = "Location_list next without zz", noremap = true, silent = true }
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
vim.keymap.set(
   "n",
   "<leader>mm",
   ":make ",
   { desc = "Compile current file", noremap = true }
)
