-- [[Configuration to add the current time to the statusline]]

-- Function to get current time
local function current_time()
  return os.date '%H:%M'
end

-- Define a highlight group for the time
vim.cmd [[
  hi TimeHighlight guifg=#ffffff guibg=#283457 ctermfg=white ctermbg=magenta
]]

-- Initial setup with a unique placeholder for the time
local initial_statusline = vim.o.statusline .. '%#TimeHighlight# TIME_PLACEHOLDER %#'

-- Function to update the status line
local function update_statusline()
  vim.o.statusline = initial_statusline:gsub('TIME_PLACEHOLDER', current_time())
end

-- Set up the initial status line configuration
update_statusline()

-- Timer to update the status line every minute
local timer = vim.loop.new_timer()
timer:start(0, 60000, vim.schedule_wrap(update_statusline))

-- Autocommand to update the status line for various relevant events
vim.api.nvim_create_autocmd({
  'BufEnter',
  'BufWinEnter',
  'WinEnter',
  'VimEnter',
  'BufWritePost',
  'BufReadPost',
  'CursorHold',
  'CursorHoldI',
  'InsertEnter',
  'InsertLeave',
  'TabEnter',
  'TabLeave',
  'BufLeave',
  'WinLeave',
}, {
  pattern = '*',
  callback = update_statusline,
})
