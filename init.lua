-- ============================================================================
-- init.lua — migrated from ~/.vimrc
-- ============================================================================

-- Leader must be set BEFORE lazy loads plugins
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- ============================================================================
-- Options
-- ============================================================================
local opt = vim.opt

opt.tabstop = 2
opt.softtabstop = 1
opt.expandtab = true
opt.shiftwidth = 2
opt.smarttab = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.hidden = true
opt.autoread = true
opt.swapfile = false
opt.list = true
opt.showmode = false
opt.mouse = 'a'
opt.number = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.clipboard = 'unnamedplus'

opt.suffixesadd = { '.js', '.jsx', '.ts', '.tsx' }
opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
opt.grepformat:append('%f:%l:%c:%m')

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugins
-- ============================================================================
require('lazy').setup({
  -- Colorscheme (same one you had)
  {
    'junegunn/seoul256.vim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.seoul256_background = 234
      vim.cmd.colorscheme('seoul256')
      vim.cmd([[
        hi cursorline ctermbg=none
        hi cursorlinenr ctermfg=red
      ]])
    end,
  },

  -- Fuzzy finder — replaces CtrlP + ack.vim
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup({
        defaults = { path_display = { 'filename_first' } },
      })
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },

  -- File tree — replaces NERDTree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  -- Treesitter — replaces every syntax plugin
  -- (vim-javascript, yats, jsx-pretty, vim-json, vim-less, elm, rust, elixir, solidity)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'javascript', 'typescript', 'tsx', 'json', 'html', 'css',
          'python', 'rust', 'elixir', 'lua', 'vim',
          'bash', 'markdown', 'yaml', 'toml',
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP — replaces ALE's gd/gr/hover
  { 'williamboman/mason.nvim', config = true },
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      local servers = { 'ts_ls', 'rust_analyzer', 'pylsp', 'elixirls' }
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
      require('mason-lspconfig').setup({ ensure_installed = servers })
      vim.lsp.enable(servers)
    end,
  },

  -- Auto-install formatters/linters via mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'black', 'flake8', 'mypy',   -- Python
        },
      })
    end,
  },

  -- Completion — replaces ALE's completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = { expand = function(a) require('luasnip').lsp_expand(a.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
          ['<Tab>']     = cmp.mapping.select_next_item(),
          ['<S-Tab>']   = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'nvim_lsp' }, { name = 'luasnip' },
          { name = 'buffer' },   { name = 'path' },
        },
      })
    end,
  },

  -- Format on save — replaces ALE fix_on_save
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters = {
          oxfmt = {
            command = require('conform.util').find_executable(
              { 'node_modules/.bin/oxfmt' }, 'oxfmt'
            ),
            args = { '--stdin-filepath', '$FILENAME' },
            stdin = true,
          },
        },
        formatters_by_ft = {
          javascript      = { 'oxfmt' },
          javascriptreact = { 'oxfmt' },
          typescript      = { 'oxfmt' },
          typescriptreact = { 'oxfmt' },
          json   = { 'oxfmt' },
          rust   = { 'rustfmt' },
          python = { 'black' },
        },
        format_on_save = { timeout_ms = 2000, lsp_fallback = false },
      })
    end,
  },

  -- Linting — replaces ALE linters
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        javascript      = { 'oxlint' },
        javascriptreact = { 'oxlint' },
        typescript      = { 'oxlint' },
        typescriptreact = { 'oxlint' },
        python          = { 'flake8', 'mypy' },
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        callback = function()
          local names = lint.linters_by_ft[vim.bo.filetype] or {}
          local avail = {}
          for _, n in ipairs(names) do
            if vim.fn.executable(n) == 1 then table.insert(avail, n) end
          end
          if #avail > 0 then lint.try_lint(avail) end
        end,
      })
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim', -- replaces vim-gitgutter
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 300, virt_text_pos = 'eol' },
    },
  },
  'tpope/vim-fugitive',

  -- Statusline — replaces vim-airline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({ options = { theme = 'auto' } })
    end,
  },

  -- Kept as-is (all still work great in Neovim)
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-sleuth',
  'christoomey/vim-tmux-navigator',
  'haya14busa/vim-asterisk',
})

-- ============================================================================
-- Keymaps
-- ============================================================================
local map = vim.keymap.set

-- Disable arrow keys
for _, k in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
  map({ 'n', 'v', 'o' }, k, '<Nop>')
end

vim.cmd([[cnoreabbrev W w]])

-- File tree (was NERDTree)
map('n', '<C-k>b', '<cmd>NvimTreeToggle<cr>',   { silent = true })
map('n', '<C-k>f', '<cmd>NvimTreeFindFile<cr>', { silent = true })

-- Fuzzy finder (was CtrlP)
local tb = require('telescope.builtin')
map('n', '<C-p>',      tb.find_files, { silent = true })
map('n', '<leader>fr', tb.oldfiles,     { silent = true }) -- recent files
map('n', '<leader>fb', tb.buffers,      { silent = true })
map('n', '<leader>fc', tb.git_bcommits, { silent = true }) -- current file's commits

-- Grep (was `K` and `\`)
map('n', 'K',  tb.grep_string, { silent = true }) -- grep word under cursor
map('n', '\\', tb.live_grep,   { silent = true }) -- was :Ack<space>

-- LSP (was ALE gd/gr/hover)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true }
    map('n', 'gd',        vim.lsp.buf.definition, o)
    map('n', 'gr',        vim.lsp.buf.references, o)
    map('n', '<leader>h', vim.lsp.buf.hover,      o)
  end,
})

-- Diagnostics: populate + open loclist for current window
map('n', '<leader>q', vim.diagnostic.setloclist, { silent = true })

-- Scratch files
map('n', '<leader>ed', ':vsp ~/.scratch/todo.md<CR>')
map('n', '<leader>es', ':vsp ~/.scratch/sprint.md<CR>')

-- JSON prettify (uses attached LSP formatter, e.g. prettier via conform)
map('n', '=j', vim.lsp.buf.format)

-- Edit config
map('n', 'gev', ':e $MYVIMRC<CR>')

-- vim-asterisk
for _, lhs in ipairs({ '*', '#', 'g*', 'g#', 'z*', 'gz*', 'z#', 'gz#' }) do
  map('', lhs, '<Plug>(asterisk-' .. lhs .. ')')
end

-- ============================================================================
-- Autocmds
-- ============================================================================

-- Disable auto comment insertion
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})
