export LANG=ja_JP.UTF-8
export EDITOR=vim
export PAGER=lv
#export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH
#export CLICOLOR=1
#export LSCOLORS=DxGxcxdxCxegedabagacad
export CLICOLOR=1
export LSCOLORS=bxfxcxdxbxegedabagacad

## 履歴の保存先
HISTFILE=$HOME/.zsh-history
## メモリに展開する履歴の数
HISTSIZE=100000
## 保存する履歴の数
SAVEHIST=100000
## 補完機能の強化
autoload -U compinit
compinit
## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## Emacsライクキーバインド設定
bindkey -e
## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## TAB で順に補完候補を切り替える
setopt auto_menu
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ヒストリを共有
setopt share_history
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
#eval `dircolors`
#export ZLS_COLORS=$LS_COLORS
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
export ZLS_COLORS=$LSCOLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LSCOLORS}
## 大文字小文字を区別しないで補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## プロンプトの設定
autoload colors
colors
PROMPT="%{${fg[cyan]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[cyan]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"
## スペースアルクで単語検索
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    w3m "http://www.alc.co.jp/"
  fi
}
## エイリアス設定
alias ll='ls -lh'
alias lt='ls -lhtr'
alias la='ls -lah'
alias lS='ls -lShr'
alias vi='vim'
alias vimu='vim -c ":Unite file_mru"'
alias java='java -Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
## ls command color
setopt complete_aliases # aliased ls needs if file/dir completions work
alias where="command -v"
alias j="jobs -l"
case "${OSTYPE}" in
    freebsd*|darwin*)
          alias ls="ls -G -w"
            ;;
        linux*)
              alias ls="ls --color"
                ;;
        esac
# Attache tmux
#if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
#    if ( tmux has-session ); then
#	session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]*\).*$/\1/'`
#    	if [ -n "$session" ]; then
#	    echo "Attache tmux session $session."
#    	    tmux attach-session -t $session
#	else
#	    echo "Session has been already attached."
#	    tmux list-sessions
#    	fi
#    else
#	echo "Create new tmux session."
#	tmux
#    fi
#fi
# zshでHEAD^
typeset -A abbreviations
abbreviations=(
	"L"    "| $PAGER"
	"G"    "| grep"

	"HEAD^"     "HEAD\\^"
	"HEAD^^"    "HEAD\\^\\^"
	"HEAD^^^"   "HEAD\\^\\^\\^"
	"HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
	"HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"
)

magic-abbrev-expand () {
	local MATCH
	LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
	LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

magic-abbrev-expand-and-insert () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-accept () {
	magic-abbrev-expand
	zle accept-line
}

no-magic-abbrev-expand () {
	LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET はできなくなる
bindkey "^J"  accept-line # no magic
bindkey " "   magic-abbrev-expand-and-insert
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^x " no-magic-abbrev-expand

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# プロセスを見つける関数pfind()
function pfind() {
    PSAUX=$(ps aux)
    echo $PSAUX | head -1
    echo $PSAUX | grep $1 | grep -v grep
}

function cprint() {
    i=0
    out=$1
    shift

    enscript --pretty-print --color --line-numbers --fancy-header=a2ps -o $out.ps $@
    pstopdf $out.ps
}
function cprint2() {
    i=0
    out=$1
    shift

    enscript --pretty-print --color --line-numbers --fancy-header=a2ps --landscape --columns=2 -o $out.ps $@
    pstopdf $out.ps
}
