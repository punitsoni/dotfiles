local api = vim.api

local test = {}

function test.hello()
  print("Hello World.")
end

-- to save terminals
list_of_terms = {}

function test.Terminal(num, ...)
  -- if the terminal with num exists, set the current buffer to it
  if list_of_terms[num] then
    -- change to the terminal
    vim.api.nvim_set_current_buf(list_of_terms[num])
  -- if the terminal doesn't exist
  else
    -- create a buffer that's is unlisted and not a scratch buffer
    local buf = vim.api.nvim_create_buf(false, false)
    -- change to that buffer
    vim.api.nvim_set_current_buf(buf)
    -- create a terinal in the new buffer using my favorite shell
    vim.api.nvim_call_function("termopen", {"/bin/bash"})
    -- save a reference to that buffer
    list_of_terms[num] = buf
  end
  -- change to insert mode
  vim.api.nvim_command(":startinsert")
end

function test.NavigationFloatingWin()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- if the editor is big enough
  if (width > 150 or height > 35) then
    -- fzf's window height is 3/4 of the max height, but not more than 30
    local win_height = math.min(math.ceil(height * 1 / 2), 20)
    local win_width

    -- if the width is small
    if (width < 150) then
      -- just subtract 8 from the editor's width
      win_width = math.ceil(width - 8)
    else
      -- use 90% of the editor's width
      win_width = math.ceil(width * 0.7)
    end

    -- settings for the fzf window
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2)
    }

    -- create a new floating window, centered in the editor
    local win = vim.api.nvim_open_win(buf, true, opts)
  end
end

return test
