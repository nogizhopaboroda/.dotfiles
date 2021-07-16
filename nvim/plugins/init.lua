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

  use {'neovim/nvim-lspconfig', run = 'cd ' .. this_dir .. '/nvim && yarn install', config = function()
    require('plugins.lsp')
  end}

  -- Autocompletion plugin
  use {'hrsh7th/nvim-compe', config = function()
    -- use .ts snippets in .tsx files
    vim.g.vsnip_filetypes = {
        typescriptreact = {"typescript"}
    }
    require"compe".setup {
        preselect = "always",
        source = {
            path = true,
            buffer = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true
        }
    }
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end
    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return vim.fn["compe#confirm"]()
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t("<Plug>(vsnip-expand-or-jump)")
        else
            return t("<Tab>")
        end
    end
    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                            {expr = true, silent = true})
    vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm("<CR>")]],
                            {expr = true, silent = true})
    vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close("<C-e>")]],
                            {expr = true, silent = true})
  end}

  -- color scheme
  use {'ishan9299/nvim-solarized-lua', config = function()
    vim.g.solarized_termtrans = 1
    vim.g.solarized_italics = 1
    vim.cmd('colorscheme solarized')
  end}

  use 'kyazdani42/nvim-web-devicons'
  -- files tree
  use {'kyazdani42/nvim-tree.lua', config = function()
    vim.api.nvim_set_var('nvim_tree_auto_open', 1)
    vim.api.nvim_set_var('nvim_tree_auto_close', 1)
    vim.api.nvim_set_var('nvim_tree_ignore', { '.git', 'node_modules', '.cache', 'dist' })
  end}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

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

  -- use 'tpope/vim-fugitive'           -- Git commands in nvim
  -- use 'tpope/vim-rhubarb'            -- Fugitive-companion to interact with github
  -- use 'tpope/vim-commentary'         -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- -- UI to select things (files, grep results, open buffers...)
  -- use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  -- use 'joshdick/onedark.vim'         -- Theme inspired by Atom
  -- use 'itchyny/lightline.vim'        -- Fancier statusline
  -- -- Add indentation guides even on blank lines
  -- use { 'lukas-reineke/indent-blankline.nvim', branch="lua" }
end)

-- automatically run :PackerCompile whenever this file is updated
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])



