
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ZSH Option

## history setting
setopt HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS INC_APPEND_HISTORY

## pushd and other
setopt PUSHD_IGNORE_DUPS AUTO_PUSHD AUTO_LIST INTERACTIVE_COMMENTS AUTO_CD

## completion settings - pretty print - ignore case
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

# exports

## faster startup, but less safer
export ZSH_DISABLE_COMPFIX="true"

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

## brew install gnupg
export GPG_TTY=$(tty)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## needs Secretive installed - https://github.com/maxgoedjen/secretive
export SSH_AUTH_SOCK=/Users/wetabq/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

## brew install llvm; delete if you are not macos
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

## brew install openssl; delete if you are not macos
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

# zi

## - zsh-aliases-exa: exa required
##
## - macos: only for macOS
##
## - git: git required
## 
## - brew: brew required
##
## - vscode 
##
##  brew install --cask visual-studio code
##  or ln -s /path/to/vscode /user/local/bin/code 
##  for example: ln -s "/Applications/Visual Studio Code.app/Contents/MacOS/Electron" /usr/local/bin/code

zi wait lucid light-mode depth"1" for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start;" \
    zsh-users/zsh-autosuggestions \
  multisrc="{directories,functions}.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh \
  https://raw.githubusercontent.com/xen0n/autojump-rs/develop/integrations/autojump.zsh \
  Colerar/zsh-aliases-exa \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::vscode\
  OMZP::sudo

zi wait'1' lucid light-mode depth"1" for \
  as'completion' \
    zsh-users/zsh-completions \
  z-shell/H-S-MW \
  as'completion' blockf has'cargo' \
    https://raw.githubusercontent.com/rust-lang/cargo/master/src/etc/_cargo \
  as'completion' blockf has'rustc' \
    https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/rust/_rustc \
  as'completion' blockf has'tmux' pick'completion/zsh' \
    greymd/tmux-xpanes \
  as'completion' blockf has'yadm' \
    https://raw.githubusercontent.com/TheLocehiliosan/yadm/master/completion/zsh/_yadm \
  as'completion' pick'_tracks' atload"source $HOME/.zi/completions/_tracks" \
    https://raw.githubusercontent.com/Colerar/Tracks/cli/completions/_tracks \
  svn \
    https://github.com/ohmyzsh/ohmyzsh/trunk/plugins/macos \
  OMZL::key-bindings.zsh \
  OMZP::brew

zi ice lucid depth'1' atload'[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' nocd
zi light romkatv/powerlevel10k


PS1=`print "%F{magenta}❯%f "`

# functions

## jenv
## brew install jenv
export PATH="$HOME/.jenv/shims:${PATH}"
export PATH="$HOME/.pyenv/shims:${PATH}"
export JAVA_HOME="/Users/wetabq/.jenv/versions/17.0" # Fallback
export PYTHON_HOME="/Users/wetabq/.pyenv/shims/python" # Fallback


jenv() {
  unfunction jenv
  export PATH="$HOME/.jenv/bin:$PATH"
  export PATH="/Users/wetabq/.jenv/shims:${PATH}"
  export JENV_SHELL=zsh
  export JENV_LOADED=1
  unset JAVA_HOME
  unset JDK_HOME
  source '/usr/local/Cellar/jenv/0.5.5_2/libexec/libexec/../completions/jenv.zsh'
  jenv rehash 2>/dev/null
  jenv refresh-plugins
  source "/Users/wetabq/.jenv/plugins/export/etc/jenv.d/init/export_jenv_hook.zsh"
  jenv() {
    type typeset &> /dev/null && typeset command
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    enable-plugin|rehash|shell|shell-options)
      eval `jenv "sh-$command" "$@"`;;
    *)
      command jenv "$command" "$@";;
    esac
  }
  jenv "$@"
}

pyenv() {
  unfunction pyenv
  export PATH="$HOME/.pyenv/bin:$PATH"
  PATH="$(bash --norc -ec 'IFS=:; paths=($PATH); for i in ${!paths[@]}; do if [[ ${paths[i]} == "'/Users/wetabq/.pyenv/shims'" ]]; then unset '\''paths[i]'\''; fi; done; echo "${paths[*]}"')"
  export PATH="/Users/wetabq/.pyenv/shims:${PATH}"
  export PYENV_SHELL=zsh
  source '/Users/wetabq/.pyenv/libexec/../completions/pyenv.zsh'
  command pyenv rehash 2>/dev/null
  pyenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    activate|deactivate|rehash|shell)
      eval "$(pyenv "sh-$command" "$@")"
      ;;
    *)
      command pyenv "$command" "$@"
      ;;
    esac
  }
  export PATH="/Users/wetabq/.pyenv/plugins/pyenv-virtualenv/shims:${PATH}";
  export PYENV_VIRTUALENV_INIT=1;
  _pyenv_virtualenv_hook() {
    local ret=$?
    if [ -n "${VIRTUAL_ENV-}" ]; then
      eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
    else
      eval "$(pyenv sh-activate --quiet || true)" || true
    fi
    return $ret
  };
  typeset -g -a precmd_functions
  if [[ -z $precmd_functions[(r)_pyenv_virtualenv_hook] ]]; then
    precmd_functions=(_pyenv_virtualenv_hook $precmd_functions);
  fi
  pyenv "$@"
}

rm(){ 
  /bin/mv -f $@ ~/.trash/; 
  for i in "$@"
  do
    echo "$i"
  done 
}

rmrm() {
  unfunction rm
  unfunction rmrm
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/wetabq/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/wetabq/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/wetabq/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/wetabq/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias proxy='export all_proxy=http://127.0.0.1:6152'
alias unproxy='unset all_proxy'
alias gcc='gcc -Wall -Wextra -Werror -fdiagnostics-color=always'

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s zshrc=vi
alias -s zsh=zsh
alias -s sh=sh
alias gcid="git rev-parse --short HEAD | pbcopy"

alias pwdcp="pwd | pbcopy"

alias towebp="~/Scripts/_toWebp.zsh"
alias tracksub="tracks dig -so -ze -zt China"

alias wiscvpnoff="launchctl unload /Library/LaunchAgents/com.paloal*"
alias wiscvpnon="launchctl load -w /Library/LaunchAgents/com.paloal*"

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

alias lctl="launchctl"

# switch to macbook screen or windows screen on Dell external screen
alias swin="ddcctl -d 2 -i 17 & ddcctl -d 1 -i 17"
alias smac="ddcctl -d 2 -i 15 & ddcctl -d 1 -i 15"

# check cpu performance
alias cpuf="pmset -g thermlog"
