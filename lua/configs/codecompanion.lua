require("codecompanion").setup {
   adapters = {
      dolphin_mistral = function()
         return require("codecompanion.adapters").extend("ollama", {
            name = "codellama:7b", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
               model = {
                  default = "codellama:7b",
               },
               num_ctx = {
                  default = 4096,
               },
               num_predict = {
                  default = -1,
               },
            },
         })
      end,
      -- my_gemini_2_5_pro = function()
      --    return require("codecompanion.adapters").extend("gemini", {
      --       schema = {
      --          model = {
      --             default = "gemini-2.5-pro",
      --          },
      --       },
      --       reasoning_effort = {
      --          "high",
      --       },
      --    })
      -- end,
   },
   strategies = {
      chat = {
         adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            reasoning_effort = "high",
         },
      },
      inline = {
         adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            reasoning_effort = "high",
         },
      },
      agent = {
         adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            reasoning_effort = "high",
         },
      },
      cmd = {
         adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            reasoning_effort = "high",
         },
      },
   },
   opts = {
      send_code = true,
   },
}
