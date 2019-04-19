#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
autoload -Uz promptinit
promptinit
#prompt kylewest
prompt paradox

# for peco
## history search
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

## cdr
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi
function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr
bindkey '^@' peco-cdr

## functions using peco for docker
function docker-start() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | peco | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'starting container...'
    docker start ${container}
  fi
}

function docker-stop() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | peco | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'stopping container...'
    docker stop ${container}
  fi
} 

function docker-exec-bash() {
  local container
  container="$(docker ps -a -f status=running | sed -e '1d' | peco | awk '{print $1}')"
  if [ -n "${container}" ]; then
    docker exec -it ${container} /bin/bash
  fi
}

function docker-rm() {
  local container
  container="$(docker ps -a -f status=exited | sed -e '1d' | peco | awk '{print $1}')"
  if [ -n "${container}" ]; then
    echo 'removing container...'
    docker rm ${container}
  fi
}

function docker-rmi() {
  local image
  image="$(docker images -a | sed -e '1d' | peco | awk '{print $3}')"
  if [ -n "${image}" ]; then
    echo 'removing container image...'
    docker rmi ${image}
  fi
} 

export EDITOR=vim

# for go
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# for direnv
eval "$(direnv hook zsh)"

# for nodebrew
export PATH=$PATH:~/.nodebrew/current/bin


# for gem
export PATH=$PATH:~/.gem/ruby/2.6.0/bin

# for python
export PATH=$PATH:~/.local/bin

alias svim='vim -u ~/.SpaceVim/vimrc'
alias nvim='nvim -u ~/.SpaceVim/init.vim'
