local overrides = require "configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
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

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    config = function()
      require "configs.cmake"
    end,
    lazy = false,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
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
    "hrsh7th/nvim-cmp",
    dependencies = { "saadparwaiz1/cmp_luasnip" },
    config = require "configs.cmp",
    lazy = false,
  },
  { "hrsh7th/cmp-buffer", lazy = false },
  { "hrsh7th/cmp-path", lazy = false },
  { "hrsh7th/cmp-cmdline", lazy = false },
  { "hrsh7th/cmp-nvim-lua", lazy = false },
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
}

return plugins
