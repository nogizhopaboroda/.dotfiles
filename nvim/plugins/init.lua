local this_dir = vim.api.nvim_get_var('this_dir')

-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- color scheme
  use { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" }, config = function()
    -- vim.cmd('colorscheme gruvbox')
    -- vim.cmd('set background=dark')
  end }

  -- use { 'ishan9299/nvim-solarized-lua', config = function()
  --   vim.g.solarized_termtrans = 1
  --   vim.g.solarized_italics = 1
  --   vim.cmd('colorscheme solarized')
  -- end }
  use { 'sainnhe/gruvbox-material', config = function()
    vim.cmd('colorscheme gruvbox-material')
    vim.cmd('set background=dark')
  end }

  use { 'p00f/nvim-ts-rainbow', config = function()
  end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "vim", "javascript", "typescript", "tsx", "graphql", "css", "html", "json", "yaml" },
      highlight = {
        enable = true,
      },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      }
    }
  end }

  -- use {'neovim/nvim-lspconfig', run = 'cd ' .. this_dir .. '/nvim && yarn install', config = function()
  --   require('plugins.lsp')
  -- end}
  use { 'neovim/nvim-lspconfig', config = function()
  end }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
    end
  }
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils', config = function()
  end }
  use { 'williamboman/nvim-lsp-installer', config = function()
    require("nvim-lsp-installer").setup {}
    require('plugins.lsp')
  end }

  -- Autocompletion plugin
  use { 'hrsh7th/nvim-compe', config = function()
    -- use .ts snippets in .tsx files
    vim.g.vsnip_filetypes = {
      typescriptreact = { "typescript" }
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
        border = { '', '', '', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
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
  end }

  use { 'windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup()
  end }

  -- use 'kyazdani42/nvim-web-devicons'
  -- files tree
  use { 'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require 'nvim-tree'.setup {}
      vim.cmd([[nmap <silent> <leader>f :NvimTreeToggle<CR>]])
    end }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    after = 'gruvbox.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { hl = 'DiffAdd', text = '▍' },
          change       = { hl = 'DiffChange', text = '▍' },
          delete       = { hl = 'DiffDelete', text = '▁' },
          topdelete    = { hl = 'DiffDelete', text = '▔' },
          changedelete = { hl = 'DiffChangeDelete', text = '▞' },
        },
      }

      vim.cmd("highlight DiffAdd ctermbg=NONE guibg=NONE ctermfg=" ..
        vim.api.nvim_eval("RGB('#05aff7')") .. " guifg=#05aff7 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffDelete ctermbg=NONE guibg=NONE ctermfg=" ..
        vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffTopDelete ctermbg=NONE guibg=NONE ctermfg=" ..
        vim.api.nvim_eval("RGB('#cb4b16')") .. " guifg=#cb4b16 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffChange ctermbg=NONE guibg=NONE ctermfg=" ..
        vim.api.nvim_eval("RGB('#fcba03')") .. " guifg=#fcba03 cterm=NONE gui=NONE")
      vim.cmd("highlight DiffChangeDelete ctermbg=NONE guibg=NONE ctermfg=" ..
        vim.api.nvim_eval("RGB('#ff9800')") .. " guifg=#ff9800 cterm=NONE gui=NONE")
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      vim.api.nvim_set_keymap('n', '<C-p>', ':lua require"telescope.builtin".find_files{}<cr>',
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<space>/', ':lua require"telescope.builtin".live_grep{}<cr>',
        { noremap = true, silent = true })
      -- Global remapping
      ------------------------------
      require('telescope').setup {
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

  -- commenter plugin
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()

      local function getCurrentPath()
        return vim.api.nvim_exec([[echo GetPath("%:p:h", "true", "false") . '/']], true)
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          -- lualine_c = {'filename'},
          lualine_c = {
            { getCurrentPath, color = { fg = '#675f54' } },
            { '%t', color = { fg = '#f2eedf' } },
          },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  -- css colors highlight plugin
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- -- go to github
  -- use 'ruanyl/vim-gh-line'

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
