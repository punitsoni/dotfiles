-------------------------------------------------------------------------------
-- Actions library
-- Select and execute pre-registered actions. Requires telescope plugin.
-------------------------------------------------------------------------------
local ts_pickers = require 'telescope.pickers'
local ts_finders = require 'telescope.finders'
local ts_themes = require 'telescope.themes'
local ts_actions = require 'telescope.actions'
local ts_actions_state = require 'telescope.actions.state'
local ts_config = require 'telescope.config'.values

-- Table to hold global list of actions. Actions are added to this by calling
-- register_action() function.
local all_actions = {}

local M = {}

-- Registers a single action.
-- Args
--  action: map-like table with 2 keys. 'name' and 'func'
M.register_action = function(action)
  all_actions = vim.tbl_extend('error', all_actions, {
    [action.name] = action,
  })
  -- print('Action registered: ' .. action.name)
end

-- Opens a telescope picker to select an action and executes selected action.
M.pick_action = function(opts)
  opts = opts or {}
  local opts_theme = ts_themes.get_dropdown()
  opts = vim.tbl_deep_extend('force', opts_theme, opts)

  -- Telescope finder for actions.
  local action_finder = ts_finders.new_table {
    -- results = get_actions_table(),
    results = vim.tbl_values(all_actions),
    entry_maker = function(entry)
      return {
        value = entry.func,
        display = entry.name,
        ordinal = entry.name,
      }
    end
  }

  local action_picker = ts_pickers.new(opts, {
    prompt_title = "Actions",
    finder = action_finder,
    sorter = ts_config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      ts_actions.select_default:replace(function()
        ts_actions.close(prompt_bufnr)
        local selection = ts_actions_state.get_selected_entry()
        -- Execute action
        local action_func = selection.value
        action_func()
     end)
      return true
    end,
  })
  -- Run the picker.
  action_picker:find()
end


-- Returns the function associated with action `name`
M.action_func = function(name)
  local action = all_actions[name]
  if action == nil then
    return nil
  end
  return action.func
end


-- Finds the action by `name` and runs it.
M.run_action = function(name)
  local action = all_actions[name]
  if action == nil then
    print('No action with name ' .. name)
    return
  end
  action.func()
end

return M

