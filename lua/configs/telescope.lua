dofile(vim.g.base46_cache .. "telescope")


local actions = require('telescope.actions')
-- local action_state = require('telescope.actions.state')

-- local telescope_custom_actions = {}
-- function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
--     telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
-- end
-- function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
--     telescope_custom_actions._multiopen(prompt_bufnr, "split")
-- end
-- function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
--     telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
-- end
-- function telescope_custom_actions.multi_selection_open(prompt_bufnr)
--     telescope_custom_actions._multiopen(prompt_bufnr, "edit")
-- end
--
-- function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
--     local picker = action_state.get_current_picker(prompt_bufnr)
--     local selected_entry = action_state.get_selected_entry()
--     local num_selections = #picker:get_multi_selection()
--     if not num_selections or num_selections <= 1 then
--         actions.add_selection(prompt_bufnr)
--     end
--     actions.send_selected_to_qflist(prompt_bufnr)
--     vim.cmd("cfdo " .. open_cmd)
-- end
return {
   defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = " ",
      sorting_strategy = "ascending",
      layout_config = {
         horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
         },
         width = 0.87,
         height = 0.80,
      },
      mappings = {
         i = {
            ["<ESC>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-s>"] = actions.toggle_selection,
            ["<C-TAB>"] = actions.toggle_selection
               + actions.move_selection_next,
            ["<S-TAB>"] = actions.toggle_selection
               + actions.move_selection_previous,
            -- ["<CR>"] = telescope_custom_actions.multi_selection_open,
            -- ["<C-V>"] = telescope_custom_actions.multi_selection_open_vsplit,
            -- ["<C-S>"] = telescope_custom_actions.multi_selection_open_split,
            -- ["<C-T>"] = telescope_custom_actions.multi_selection_open_tab,
            ["<C-Down>"] = require("telescope.actions").cycle_history_next,
            ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
         },
         n = i,
      },
   },

   extensions_list = { "themes", "terms" },
   extensions = {},
}
