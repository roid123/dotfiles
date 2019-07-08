"=============================================================================
" init.vim --- Entry file for neovim
" Copyright (c) 2016-2019 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

lua require('spacevim').bootstrap()

inoremap jj <ESC>

set nonumber
set norelativenumber
set ignorecase
set incsearch
set smartcase
set hlsearch

" paste
nnoremap ,i :<C-u>set paste<Return>i
nnoremap ,o :<C-u>set paste<Return>o
autocmd InsertLeave * set nopaste

" unite.vim basic setting
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uo :<C-u>Unite outline<CR>
"nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" 新しいタブで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('tabopen')

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" 選択した範囲を * で検索できるようにする
vnoremap * "zy:let @/ = @z<CR>n

" autocmd FileType go nmap ,gc <Plug>(go-coverage)
autocmd FileType go nnoremap <silent> ,gc :<C-u>GoCoverageToggle<CR>
autocmd FileType go nnoremap <silent> ,gi :<C-u>GoImports<CR>
autocmd FileType go inoremap <silent><expr><buffer> <C-]> empty(v:completed_item) ? "" : split(v:completed_item.info, v:completed_item.word)[1]

let g:indentLine_setConceal = 0
