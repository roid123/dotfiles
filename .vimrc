"----------------------------------------------------
" 基本的な設定
"----------------------------------------------------
" viとの互換性をとらない(vimの独自拡張機能を使う為)
set nocompatible
" 改行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
"----------------------------------------------------
" バックアップ関係
"----------------------------------------------------
" バックアップをとらない
"set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
set writebackup
" バックアップをとる場合
set backup
" バックアップファイルを作るディレクトリ
set backupdir=~/.vimbackup
" スワップファイルを作るディレクトリ
set directory=~/.vimswap
"----------------------------------------------------
" 検索関係
"----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチを使わない
set noincsearch
"----------------------------------------------------
" 移動関係
"----------------------------------------------------
"表示行単位で移動
nnoremap j gj
nnoremap k gk
"----------------------------------------------------
" 表示関係
"----------------------------------------------------
" タイトルをウインドウ枠に表示する
set title
" 行番号を表示しない
"set nonumber
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-,extends:<,trail:-,eol:<
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
" シンタックスハイライトを有効にする
syntax on
" ハイライトの色を背景色に合わせる
set background=dark
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コメント文の色を変更
"highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu
" 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace / /
" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
" ステータスラインの色
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white
"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを無効にする
"set noautoindent
" タブが対応する空白の数
set tabstop=8
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使わない
" set noexpandtab
set expandtab
"----------------------------------------------------
" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp,utf-8
set fileencodings+=,ucs-2le,ucs-2,utf-8
"----------------------------------------------------
" オートコマンド
"----------------------------------------------------
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on
    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif
"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"----------------------------------------------------
" その他
"----------------------------------------------------
" バッファを切替えてもundoの効力を失わない
set hidden
" 起動時のメッセージを表示しない
set shortmess+=I

noremap <C-j> <ESC>
noremap! <C-j> <ESC>

" NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" ここにインストールしたいプラグインのリストを書く
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'mac' : 'make -f make_mac.mak',
  \ },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'thinca/vim-quickrun'

filetype plugin on
filetype indent on

"-----------------------
" unite.vim
"-----------------------
" 挿入モードで開始する
"let g:unite_enable_start_insert=1
" ファイル一覧
noremap <C-u><C-f> :UniteWithBufferDir -buffer-name=files file<CR>
" バッファ一覧
noremap <C-u><C-b> :Unite buffer<CR>
" 最近使ったファイルの一覧
noremap <C-u><C-r> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" <Tab>rec<Enter>でfile_rec起動
let s:unite_action_rec = {}

function! s:unite_action_rec.func(candidate)
  call unite#start([['file_rec', a:candidate.action__path]])
endfunction

call unite#custom_action('directory', 'rec', s:unite_action_rec)
unlet! s:unite_action_rec

"----------------------
" neocomplcache
"----------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
