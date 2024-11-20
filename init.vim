call plug#begin('~/.vim/plugged')
    Plug 'junegunn/seoul256.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    Plug 'windwp/nvim-autopairs'
    Plug 'morhetz/gruvbox'
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'folke/neodev.nvim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " nvim-cmp and related plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'rust-lang/rust.vim'

    " Snippet engine for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
call plug#end()

syntax enable
set background=dark
colorscheme gruvbox
set number
set cmdheight=0

let g:airline#extensions#trailing#enabled = 0
let g:airline_section_z = '%{strftime("%H:%M:%S")}'
let g:airline_theme = 'bubblegum'

lua << EOF
-- Setup for nvim-autopairs
require("nvim-autopairs").setup {}

-- Setup for nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Using `vsnip` as the snippet engine
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- Using vsnip for snippets
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP configuration with nvim-cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Example: Replace `<YOUR_LSP_SERVER>` with actual LSP servers
require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
}
require('lspconfig')['ts_ls'].setup {
  capabilities = capabilities,
}
EOF

