" ========================================================
" DARKWOLF LOCAL WORKSPACE VIM ARCHITECTURE
" ========================================================
syntax on
set number
set relativenumber
set mouse=a
set clipboard=unnamedplus

" Strict Cloud Engineering Indentation
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" UI Search Enhancements
set hlsearch
set incsearch
set ignorecase
set smartcase

" AI Focus-Bridge Mapping
let mapleader = ","
nnoremap <Leader>c :exe ':!~/repo_ripper.sh . --focus ' . expand('%') . ' --copy'<CR><CR>
