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
   },
   strategies = {
      chat = {
         adapter = "gemini",
         model = "gemini-2.5-pro"
      },
      inline = {
         adapter = "gemini",
         model = "gemini-2.5-pro"
      },
      agent = {
         adapter = "gemini",
         model = "gemini-2.5-pro"
      },
   },
   opts = {
      send_code = true,
   },
}
