" Plugin manager
call pathogen#infect()
call pathogen#helptags()

" Editor
syntax on
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set listchars=tab:»·,eol:¶,trail:·
set list
set number

" Loading .apu as PHP files
filetype on
au BufNewFile,BufRead *.apu set filetype=php

" Filename autocompletion
set wildmode=list:longest
set wildmenu

" Grep
set grepprg=grep\ -r\ --exclude-dir="*/.svn/*"

" Search
set hlsearch
set incsearch
nnoremap <silent> <C-N> :noh<CR>

" Remap Plugins
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

nnoremap <silent> <C-L> :Loremipsum!<CR>
nnoremap <silent> <C-J> :Loremipsum! 5<CR>
