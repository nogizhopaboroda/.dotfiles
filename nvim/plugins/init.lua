print('loading plugins')
local this_dir = vim.api.nvim_get_var('this_dir')

-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "maintained",
      highlight = {
        enable = true,
      }
    }
  end}

  use {'neovim/nvim-lspconfig', run = 'cd ' .. this_dir .. '/nvim && yarn install', config = function()
    require('plugins.lsp')
  end}

  -- Autocompletion plugin
  use {'hrsh7th/nvim-compe', config = function()
    -- use .ts snippets in .tsx files
    vim.g.vsnip_filetypes = {
        typescriptreact = {"typescript"}
    }
    require('compe').setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
          border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        },

        source = {
          path = true;
          buffer = true;
          calc = true;
          nvim_lsp = true;
          nvim_lua = true;
          vsnip = true;
          ultisnips = true;
          luasnip = true;
        },
    }
    vim.cmd([[inoremap <silent><expr> <CR> pumvisible() ? compe#confirm("<CR>") : "\<CR>"]])
  end}

  use {'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup()
  end}

  -- color scheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}, config = function()
    vim.cmd('colorscheme gruvbox')
  end}
  use {'ishan9299/nvim-solarized-lua', config = function()
    -- vim.g.solarized_termtrans = 1
    -- vim.g.solarized_italics = 1
    -- vim.cmd('colorscheme solarized')
  end}

  use 'kyazdani42/nvim-web-devicons'
  -- files tree
  use {'kyazdani42/nvim-tree.lua', config = function()
    vim.api.nvim_set_var('nvim_tree_auto_open', 1)
    vim.api.nvim_set_var('nvim_tree_auto_close', 1)
    vim.api.nvim_set_var('nvim_tree_ignore', { '.git', 'node_modules', '.cache', 'dist' })

    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    -- default mappings
    vim.g.nvim_tree_bindings = {
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      { key = "-",                            cb = tree_cb("dir_up") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }
  end}

  -- Post-install/update hook with neovim command

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'DiffAdd'   , text = '▍'},
          change       = {hl = 'DiffChange', text = '▍'},
          delete       = {hl = 'DiffDelete', text = '▁'},
          topdelete    = {hl = 'DiffDelete', text = '▔'},
          changedelete = {hl = 'DiffChangeDelete', text = '▞'},
        },
      }

      vim.cmd("highlight DiffAdd ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#05aff7')") .. " guifg=#05aff7 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffTopDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffChange ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#fcba03')") .. " guifg=#fcba03 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffChangeDelete ctermbg=NONE guibg=NONE ctermfg=" .. vim.api.nvim_eval("RGB('#ff9800')") .. " guifg=#ff9800 cterm=NONE gui=NONE")
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function()
      vim.api.nvim_set_keymap('n', '<C-p>', ':lua require"telescope.builtin".find_files{}<cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<space>/', ':lua require"telescope.builtin".live_grep{}<cr>', { noremap = true, silent = true })
      -- Global remapping
      ------------------------------
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            },
          },
        }
      }
    end
  }

  -- use 'tpope/vim-fugitive'           -- Git commands in nvim
  -- use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github
  -- use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- -- UI to select things (files, grep results, open buffers...)
  -- use 'joshdick/onedark.vim'         -- Theme inspired by Atom
  -- use 'itchyny/lightline.vim'        -- Fancier statusline
  -- -- Add indentation guides even on blank lines
  -- use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
end)

-- automatically run :PackerCompile whenever this file is updated
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])



