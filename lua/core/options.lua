local opt = vim.opt -- for conciseness

-- Line numbers and relative line numbers for easy line jumping
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- Tab/Spacing settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

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

-- Appearance

-- enable terminal gui colors | NOTE: Ensure your terminal supports this.
opt.termguicolors = true
opt.background = 'dark' -- defaults dark to applicable color schemes
opt.signcolumn = 'yes' -- show sign column tso that text doesn't shift

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = ' '}

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, eol, or insert mode start position

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
