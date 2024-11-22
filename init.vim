call plug#begin('~/.vim/plugged')

" Plugins
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'windwp/nvim-autopairs'
Plug 'morhetz/gruvbox'
Plug 'folke/neodev.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'rust-lang/rust.vim'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'prichrd/netrw.nvim'
Plug 'lyokha/vim-xkbswitch'

call plug#end()

" General Settings
syntax enable
set background=dark
set number
set cmdheight=0
set guifont=FiraCode\ Nerd\ Font:h24
let g:netrw_banner = 0

" Key Mappings
nnoremap j k
nnoremap k j
nnoremap <C-n> :Explore<CR>

" Airline Settings
let g:airline#extensions#trailing#enabled = 0
let g:airline_section_z = '%{strftime("%H:%M:%S")}'
let g:airline_theme = 'bubblegum'

" XkbSwitch Settings
let g:XkbSwitchLib = '/usr/local/lib/input-source-switcher/build/libInputSourceSwitcher.dylib'
let g:XkbSwitchEnabled = 1
autocmd InsertLeave * :silent !setxkbmap -layout us

" Cursor
set guicursor=n-v-c:ver25
set guicursor+=i:ver25
set guicursor+=r-cr:ver25

" Nvim-Autopairs Setup
lua << EOF
require("nvim-autopairs").setup {}
EOF

" Nvim-Cmp Setup
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
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
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
}
require('lspconfig')['ts_ls'].setup {
  capabilities = capabilities,
}
EOF

" Netrw Setup with Icons
lua << EOF
require("netrw").setup({
  use_devicons = true,
})

local devicons = require('nvim-web-devicons')

devicons.setup({
  default = true,
  override = {
    python = { icon = '', color = '#3572A5', name = 'Python' },
    javascript = { icon = '', color = '#F7DF1E', name = 'JavaScript' },
    javascriptreact = { icon = '', color = '#F7DF1E', name = 'JavaScriptReact' },
    typescript = { icon = '', color = '#3178C6', name = 'TypeScript' },
    typescriptreact = { icon = '', color = '#3178C6', name = 'TypeScriptReact' },
    lua = { icon = '', color = '#000080', name = 'Lua' },
    ruby = { icon = '', color = '#701516', name = 'Ruby' },
    go = { icon = '', color = '#00ADD8', name = 'Go' },
    rust = { icon = '', color = '#FF5733', name = 'Rust' },
  }
})

require'nvim-web-devicons'.set_icon {
  folder = {
    default = '',
    open = '',
  },
}
EOF
