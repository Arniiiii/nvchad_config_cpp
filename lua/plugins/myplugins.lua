local overrides = require "configs.overrides"

---@type NvPluginSpec[]
local plugins = {

   -- Override plugin definition options

   "nvim-lua/plenary.nvim",

   {
      "nvchad/base46",
      build = function()
         require("base46").load_all_highlights()
      end,
   },

   {
      "nvchad/ui",
      lazy = false,
      config = function()
         require "nvchad"
      end,
   },

   "nvzone/volt",
   "nvzone/menu",
   { "nvzone/minty", cmd = { "Huefy", "Shades" } },

   {
      "nvim-tree/nvim-web-devicons",
      opts = function()
         dofile(vim.g.base46_cache .. "devicons")
         return { override = require "nvchad.icons.devicons" }
      end,
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      event = "User FilePost",
      -- opts = {
      --    indent = { char = "│", highlight = "IblChar" },
      --    scope = { char = "│", highlight = "IblScopeChar" },
      -- },
      config = function(_, opts)
         local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
         }

         local hooks = require "ibl.hooks"
         -- create the highlight groups in the highlight setup hook, so they are reset
         -- every time the colorscheme changes
         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
         end)

         require("ibl").setup { indent = { highlight = highlight } }
         -- dofile(vim.g.base46_cache .. "blankline")

         -- local hooks = require "ibl.hooks"
         -- hooks.register(
         --    hooks.type.WHITESPACE,
         --    hooks.builtin.hide_first_space_indent_level
         -- )
         -- require("ibl").setup(opts)

         -- dofile(vim.g.base46_cache .. "blankline")
      end,
   },

   -- file managing , picker etc
   {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      opts = function()
         return require "nvchad.configs.nvimtree"
      end,
   },

   {
      "folke/which-key.nvim",
      keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
      cmd = "WhichKey",
      opts = function()
         dofile(vim.g.base46_cache .. "whichkey")
         return {}
      end,
   },

   -- formatting!
   {
      "stevearc/conform.nvim",
      opts = {
         formatters_by_ft = { lua = { "stylua" } },
      },
   },

   -- git stuff
   {
      "lewis6991/gitsigns.nvim",
      event = "User FilePost",
      opts = function()
         return require "configs.gitsigns"
      end,
   },

   -- lsp stuff
   {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = function()
         return require "nvchad.configs.mason"
      end,
   },

   {
      "neovim/nvim-lspconfig",
      event = "User FilePost",
      config = function()
         require("nvchad.configs.lspconfig").defaults()
      end,
   },

   -- load luasnips + cmp related in insert mode only
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         {
            -- snippet plugin
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
               require("luasnip").config.set_config(opts)
               require "nvchad.configs.luasnip"
            end,
         },

         -- autopairing of (){}[] etc
         {
            "windwp/nvim-autopairs",
            opts = {
               fast_wrap = {},
               disable_filetype = { "TelescopePrompt", "vim" },
            },
            config = function(_, opts)
               require("nvim-autopairs").setup(opts)

               -- setup cmp for autopairs
               local cmp_autopairs = require "nvim-autopairs.completion.cmp"
               require("cmp").event:on(
                  "confirm_done",
                  cmp_autopairs.on_confirm_done()
               )
            end,
         },

         -- cmp sources plugins
         {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "https://codeberg.org/FelipeLema/cmp-async-path.git",
         },
      },
      opts = function()
         return require "configs.cmp"
      end,
   },
   -- {
   --    "hrsh7th/nvim-cmp",
   --    dependencies = { "saadparwaiz1/cmp_luasnip" },
   --    config = require "configs.cmp",
   --    lazy = false,
   -- },
   -- { "hrsh7th/cmp-buffer", lazy = false },
   -- { "hrsh7th/cmp-path", lazy = false },
   -- { "hrsh7th/cmp-cmdline", lazy = false },
   -- { "hrsh7th/cmp-nvim-lua", lazy = false },

   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      cmd = "Telescope",
      opts = function()
         return require "configs.telescope"
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      opts = function()
         return require "nvchad.configs.treesitter"
      end,
      config = function(_, opts)
         require("nvim-treesitter.configs").setup(opts)
      end,
   },
   {
      lazy = false,
      "neovim/nvim-lspconfig",
      dependencies = {
         -- format & linting
         {
            "nvimtools/none-ls.nvim",
            config = function()
               require "configs.null-ls"
            end,
         },
      },
      config = function()
         require "nvchad.configs.lspconfig"
         require "configs.lspconfig"
      end, -- Override to setup mason-lspconfig
   },

   -- override plugin configs
   {
      "williamboman/mason.nvim",
      opts = overrides.mason,
   },
   {
      "nvim-treesitter/nvim-treesitter",
      opts = overrides.treesitter,
   },

   {
      "nvim-tree/nvim-tree.lua",
      opts = overrides.nvimtree,
   },

   {
      "Civitasv/cmake-tools.nvim",
      config = function()
         require "configs.cmake"
      end,
      lazy = false,
   },

   {
      "NeogitOrg/neogit",
      dependencies = {
         "nvim-lua/plenary.nvim", -- required
         "sindrets/diffview.nvim", -- optional - Diff integration

         -- Only one of these is needed.
         "nvim-telescope/telescope.nvim", -- optional
         -- "ibhagwan/fzf-lua", -- optional
         -- "echasnovski/mini.pick", -- optional
         -- "folke/snacks.nvim", -- optional
      },
      cmd = { "Neogit" },
   },
   {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = function()
         require "configs.neogen"
      end,
      lazy = false,
   },
   {
      "mfussenegger/nvim-dap",
      config = function()
         require "configs.nvim-dap"
      end,
      lazy = false,
   },
   {
      "rcarriga/nvim-dap-ui",
      dependencies = {
         "mfussenegger/nvim-dap",
         "nvim-neotest/nvim-nio",
      },
      config = function()
         require "configs.nvim-dap-ui"
      end,
      lazy = false,
   },

   {
      "christoomey/vim-tmux-navigator",
      lazy = false,
   },
   {
      "olimorris/codecompanion.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-treesitter/nvim-treesitter",
         "hrsh7th/nvim-cmp", -- Optional: For activating slash commands and variables in the chat buffer
         "nvim-telescope/telescope.nvim", -- Optional: For working with files with slash commands
         {
            "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
            opts = {},
         },
      },
      config = function()
         require "configs.codecompanion"
      end,
      lazy = false,
      -- keys = { "<leader>a", "<C-a>", "ga" },
   },

   {
      "rcarriga/nvim-notify",
      config = function()
         require "configs.nvim-notify"
      end,
   },

   -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
   {
      "numToStr/Comment.nvim",
      opts = {
         -- add any options here
      },
      config = function()
         require "configs.commentnvim"
      end,
      lazy = false,
   },

   {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      -- version = "v2.3", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
   },
   {
      "huggingface/llm.nvim",
      dependencies = {
         "huggingface/llm-ls",
      },
      --   -- config = function()
      --   --     -- local isOllamaRunning = require("plenary.curl").get("http://localhost:11434", {
      --   --     --     timeout = 50,
      --   --     --     on_error = function(e) return { status = e.exit } end,
      --   --     -- }).status == 200
      --   --
      --   --     -- require("llm").setup({
      --   --     --     enable_suggestions_on_startup = true,
      --   --     --     -- enable_suggestions_on_files = {
      --   --     --     --     -- disable suggestions in all Telescope windows by enabling only in:
      --   --     --     --     "*.*", -- either has file extension
      --   --     --     --     "*/zshrc.d/*", -- or in zshrc.d folder
      --   --     --     -- },
      --   --     --     -- lsp = {
      --   --     --     --     -- cargo install --rev 16606e5371a1b0582543f03fd8a2666f7bf2580a --git https://github.com/huggingface/llm-ls llm-ls
      --   --     --     --     bin_path = vim.fn.expand("~/.cargo/bin/llm-ls"),
      --   --     --     -- },
      --   --     --     -- tokens_to_clear = { "<EOT>" },
      --   --     --     -- fim = {
      --   --     --     --     enabled = true,
      --   --     --     --     prefix = "<PRE> ",
      --   --     --     --     middle = " <MID>",
      --   --     --     --     suffix = " <SUF>",
      --   --     --     -- },
      --   --     --     model = 'deepseek-coder:6.7b',
      --   --     --     url = "http://localhost:11434/api/generate",
      --   --     --     context_window = 4096,
      --   --     --     -- tokenizer = {
      --   --     --     --     repository = "codellama/CodeLlama-7b-hf",
      --   --     --     -- },
      --   --     --     backend = "ollama",
      --   --     --     request_body = {
      --   --     --         model = "deepseek-coder:7b-code",
      --   --     --     },
      --   --     --     query_params = {
      --   --     --         -- maxNewTokens = 60,
      --   --     --         temperature = 0.2,
      --   --     --         -- doSample = true,
      --   --     --         -- topP = 0.95,
      --   --     --     },
      --   --     --     accept_keymap = "<S-Down>",
      --   --     --     dismiss_keymap = "<S-Up>",
      --   --     --     lsp = {
      --   --     --       bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      --   --     --     },
      --   --     -- })
      --   -- end,
      opts = {
         enable_suggestions_on_startup = false,
         backend = "ollama",
         model = "codellama:7b",
         url = "http://localhost:11434", -- llm-ls uses "/api/generate"
         -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
         request_body = {
            -- Modelfile options for the model you use
            options = {
               temperature = 0.2,
               top_p = 0.95,
            },
         },

         accept_keymap = "<S-Up>",
         dismiss_keymap = "<S-Down>",
      },
      lazy = false,
   },
   -- { lua - utils.nvim },
   -- { nvim - nio },
   -- { nui.nvim },
   -- { plenary.nvim },
   -- { pathlib.nvim },

   -- To make a plugin not be loaded
   -- {
   --   "NvChad/nvim-colorizer.lua",
   --   enabled = false
   -- },

   -- All NvChad plugins are lazy-loaded by default
   -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
   -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
   -- {
   --   "mg979/vim-visual-multi",
   --   lazy = false,
   -- }

   {
      "lervag/vimtex",
      lazy = false, -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function(sds)
         -- VimTeX configuration goes here, e.g.
         vim.g.vimtex_view_method = "zathura"
         vim.g.vimtex_view_general_viewer = "okular"
         vim.g.vimtex_vien_general_options = "--unique file:@pdf#src:@line@tex"
      end,
   },

   {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      lazy = false,
      config = function()
         require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
         }
      end,
   },
   {
      "stevearc/overseer.nvim",
      opts = {},
      config = function()
         require "configs.overseer"
      end,
   },
}

return plugins
