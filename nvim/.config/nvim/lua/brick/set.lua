-- Use block cursor always (disables GUI cursor shape changes)
vim.opt.guicursor = ""

-- Line numbers
vim.opt.nu = true                                       -- show absolute line number on current line
vim.opt.relativenumber = true                           -- show relative line numbers for all other lines

-- Indentation
vim.opt.tabstop = 4                                     -- a tab character counts as 4 spaces
vim.opt.softtabstop = 4                                 -- tab key inserts 4 spaces
vim.opt.shiftwidth = 4                                  -- >> and << shift by 4 spaces
vim.opt.expandtab = true                                -- insert spaces instead of tab characters
vim.opt.smartindent = true                              -- auto-indent new lines based on syntax

-- Display
vim.opt.wrap = false                                    -- don't wrap long lines
vim.opt.colorcolumn = ""                                -- no column ruler/highlight

-- File safety
vim.opt.swapfile = false                                -- don't create swap files
vim.opt.backup = false                                  -- don't create backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- persistent undo directory
vim.opt.undofile = true                                 -- enable persistent undo across sessions

-- Search
vim.opt.hlsearch = false                                -- don't highlight all search matches
vim.opt.incsearch = true                                -- highlight matches as you type

-- UI
vim.opt.termguicolors = true                            -- enable 24-bit RGB colors
vim.opt.scrolloff = 8                                   -- keep 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"                              -- always show the sign column (prevents layout shift)

-- Filename parsing
vim.opt.isfname:append("@-@")                           -- allow @ in filenames (useful for gf / path resolution)

-- Performance
vim.opt.updatetime = 50                                 -- faster CursorHold events (ms); improves LSP responsiveness

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })          -- show inline diagnostic messages
