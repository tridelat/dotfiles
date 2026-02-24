----------------------
-- GLOBAL VARIABLES --
----------------------
--
vim.g.mapleader = ' '       -- global leader key
vim.g.maplocalleader = ' '  -- local leader key
vim.g.have_nerd_font = true -- nerd font switch

--------------------
-- GLOBAL OPTIONS --
--------------------
--
-- Visual options
vim.o.number = true -- line number
vim.o.relativenumber = true -- relative line number
vim.o.cursorline = true -- show line where cursor is placed
vim.o.scrolloff = 10 -- minimum number of lines above and below when scrolling
vim.o.breakindent = true -- break indent when long lines wrap
vim.o.signcolumn = 'yes' -- display signs on left of line (git, breakpoints, lsp diagnostics)
vim.o.list = true -- show whitespace symbols
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- whitespace symbols
vim.o.showmode = false -- show mode (already in status bar)
vim.o.inccommand = 'split' -- show command effects on text before applying it
-- Timing options
vim.o.updatetime = 250 -- update time
vim.o.timeoutlen = 300 -- mapped sequence wait time
-- History options
vim.o.undofile = true -- undo history
vim.o.undolevels = 1000 -- levels of undo history
-- Search options
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- smart case when searching
-- Split options
vim.o.splitright = true -- new horizontal split right
vim.o.splitbelow = true -- new vertical split below
-- Mouse options
vim.o.mouse = 'a' -- enable mouse mode
-- Quit options
vim.o.confirm = true -- confirm save or not
-- Diagnostic options
vim.diagnostic.config { virtual_lines = { current_line = true } }
-- Options to set after `UiEnter` (to increase startup-time).
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus' -- sync clipboard between OS and Neovim
end)

--------------------
-- GLOBAL KEYMAPS --
--------------------
--
-- Buffer
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true }) -- leave insert mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')                   -- clear highlight search
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move left"<CR>')   -- forbid left arrow in normal mode
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move right"<CR>') -- forbid right arrow in normal mode
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move up"<CR>')       -- forbid up arrow in normal mode
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move down"<CR>')   -- forbid down arrow in normal mode
-- Window
vim.keymap.set("n", "<leader>x", "<cmd>confirm q<CR>")                -- close window
-- focus on left window or split
vim.keymap.set("n", "<C-h>", function()
  vim.cmd(vim.fn.winnr("h") ~= vim.fn.winnr() and "wincmd h" or "topleft vsplit | enew")
end, { noremap = true, silent = true })
-- focus on lower window or split
vim.keymap.set("n", "<C-j>", function()
  vim.cmd(vim.fn.winnr("j") ~= vim.fn.winnr() and "wincmd j" or "botright split | enew")
end, { noremap = true, silent = true })
-- focus on upper window or split
vim.keymap.set("n", "<C-k>", function()
  vim.cmd(vim.fn.winnr("k") ~= vim.fn.winnr() and "wincmd k" or "topleft split | enew")
end, { noremap = true, silent = true })
-- focus on left window or split
vim.keymap.set("n", "<C-l>", function()
  vim.cmd(vim.fn.winnr("l") ~= vim.fn.winnr() and "wincmd l" or "botright vsplit | enew")
end, { noremap = true, silent = true })
-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>') -- exit terminal mode
-- Other
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

------------------
-- AUTOCOMMANDS --
------------------
--
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set buffer-local keymaps when an LSP server attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>sl', require('telescope.builtin').lsp_document_symbols, '[S]earch Document Symbo[l]s')
    map('<leader>sW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace Symbols')
  end,
})

-------------
-- PLUGINS --
-------------
--
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  { "github/copilot.vim" },

  -- File explorer: nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    event = "VimEnter", -- or remove this and rely solely on `keys` to lazy-load on first keypress
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = {
      renderer = {
        icons = { show = { file = false, folder = false, folder_arrow = false, git = false } },
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = false,
          icons = {
            corner = "└",
            edge   = "│",
            item   = "├",
            none   = " ",
          },
        },
      },
      filters = { dotfiles = false, git_clean = false, no_buffer = false },
      git = { enable = true, ignore = false },
    },
    keys = {
      {
        "<leader>ee",
        function() require("nvim-tree.api").tree.toggle() end,
        desc = "Toggle file tree",
        noremap = true,
        silent = true,
      },
      {
        "<leader>ef",
        function() require("nvim-tree.api").tree.find_file({ open = true, focus = true }) end,
        desc = "Reveal current file",
        noremap = true,
        silent = true,
      },
    },
  },


  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          file_ignore_patterns = { "%.git/", "%.git\\", "%.cache/", "%.cache\\", "%build/", "%build\\", "%.vs/", "%.vs\\" },
        }
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },


  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { -- Treesitter: syntax-aware highlighting and indentation
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  { -- LSP: language servers managed by Mason
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
    config = function()
      -- Configure individual language servers
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
      vim.lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            analysis = { typeCheckingMode = 'basic' },
          },
        },
      })

      require('mason-lspconfig').setup {
        ensure_installed = { 'basedpyright', 'ruff', 'lua_ls' },
        automatic_enable = true,
      }
    end,
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
    },
  },

  { -- Statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Autoformat on save
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = 'ConformInfo',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_organize_imports', 'ruff_format' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    },
  },

  { -- Auto-close brackets, quotes, etc.
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },

  { -- Surround: add/delete/change surrounding characters
    'echasnovski/mini.surround',
    opts = {},
  },

  { -- Treesitter-based textobjects: select/move by function, class, etc.
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
            [']a'] = '@parameter.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[a'] = '@parameter.outer',
          },
        },
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
