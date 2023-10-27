local opt = vim.opt -- for conciseness

-- Line numbers and relative line numbers for easy line jumping
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

opt.title = true

-- Tab/Spacing settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.rtp:append("C:/Program Files/Neovim/share/nvim-qt/runtime/")

-- Prevents buffers from being closed when they are "abandoned", need for ToggleTerm
opt.hidden = true

-- line wrapping
opt.wrap = true

-- cursor line
opt.cursorline = true

-- command height
opt.cmdheight = 1 -- set to 0 to hide command line unless used

-- enable undo file with undo history
opt.undofile = true

-- Directory Settings
opt.swapfile = false

-- Set highlight on search
opt.ignorecase = true
opt.smartcase = true

-- time in ms to wait for a mapped sequence to complete
opt.timeout = true
opt.timeoutlen = 300
opt.updatetime = 250

-- Enable mouse mode
opt.mouse = 'a'

-- For using powershell as terminal
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end

-- enable terminal gui colors | NOTE: Ensure your terminal supports this.
opt.termguicolors = true
opt.background = 'dark' -- defaults dark to applicable color schemes
opt.signcolumn = 'yes' -- show sign column tso that text doesn't shift

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard:append('unnamedplus')

opt.splitright = true
opt.splitbelow = true

-- Lines to keep on screen when scrolling
opt.scrolloff = 8

-- Draw a column
opt.colorcolumn:append("120")

opt.iskeyword:append("-") -- consider string-string as a whole word
