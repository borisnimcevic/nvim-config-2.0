let mapleader = " "

" Numbers on the side
set relativenumber
set number

" Tab experience
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Source local vimrc
set exrc
set secure " This is important where it goes, so if something you get errors later come back to this line.

" Cursor fancyness (pretty much just make it blink)
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

" Better search experience
set nohlsearch
set ignorecase
set smartcase

" Keep the buffer you've been editing in the background (not loosing it)? I don't quite understand this one, but I've been
" using it for a while and everything seems fine.
set hidden

set noerrorbells

" Keeping history
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Better scrolling
set scrolloff=5

" The column on the right side
set colorcolumn=80

" How often the swap file is saved?
set updatetime=300

" Hide '---INSERT----' at the bottom
set noshowmode

" Enable mouse in all modes
set mouse+=a

" Show white space characters
set list
set listchars=tab:▸\ ,eol:¬

" Spelling
set spell spelllang=en_us

" Makes copping and pasting from outside the vim easier
set clipboard=unnamed

" Better colors?
set termguicolors

" PLUGS
call plug#begin('~/.vim/plugged')
" Color
Plug 'gruvbox-community/gruvbox'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Inserting comments
Plug 'tpope/vim-commentary'
" Highlight what you've just yanked
Plug 'machakann/vim-highlightedyank'
call plug#end()

" LSP stuff
lua << EOF
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}
EOF

" COLOR STUFF
colorscheme gruvbox

fun! ToggleColor()
    if &background==# 'dark'
        set background=light
    else
        set background=dark
    endif
endfun

nnoremap <leader>tc :call ToggleColor()<CR>

" Telescope stuff

lua << EOF
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")
EOF


nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

" Highlight-Yank settings
let g:highlightedyank_highlight_duration = 300
