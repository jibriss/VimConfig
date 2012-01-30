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
set hlsearch

" Loading .apu as PHP files
filetype on
au BufNewFile,BufRead *.apu set filetype=php

" Filename autocompletion
set wildmode=longest:full
set wildmenu

"remap
nnoremap <C-T> :<C-u>FufFile<CR>
nnoremap <C-B> :<C-u>FufBuffer<CR>
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
nnoremap <C-K> :!/usr/bin/env php -l %<CR>
vnoremap <C-A> :call PhpAlign()<CR>
vnoremap <C-O> !sort<CR>
nnoremap <C-N> :noh<CR>


func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
        " Skip comment lines
        if getline (l:line) =~ '^\s*\/\/.*$'
            let l:line = l:line + 1
            continue
        endif
        " \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
    let l:line = a:firstline
    let l:format = "%s%-" . l:maxlength . "s %s %s"
    
    while l:line <= l:endline
        if getline (l:line) =~ '^\s*\/\/.*$'
            let l:line = l:line + 1
            continue
        endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc
