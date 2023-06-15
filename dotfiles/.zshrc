#
# Zinit
#

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### Plugins
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit load zdharma/fast-syntax-highlighting
fast-theme -q clean

#
# General
#

setopt no_beep

#
# Environment variables
#
export EDITOR="nvim"
export PATH="${HOME}/bin:${PATH}"

#
# Completion
#
autoload -Uz compinit && compinit

#
# History
#

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_all_dups
setopt share_history

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
setopt correct

bindkey '^F' autosuggest-accept

#
# Alias
#
alias v="nvim"
alias vim="nvim"
alias ls="ls --color=auto --file-type"
alias la="ls -a"
alias ll="ls -al"
alias -g G="| grep"
alias -g L="| less"

#
# Tool settings
#

# Python
source "${HOME}/.rye/env"

# Rust
export PATH="${CARGO_HOME}/bin:${PATH}"
export RUSTUP_HOME="${HOME}/.rustup"
export CARGO_HOME="${HOME}/.cargo"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:${HOME}/go/bin

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# Local config
#
LOCALCONFIG="${HOME}/.zshrc.local"
if [ -e ${LOCALCONFIG} ]; then
  source ${LOCALCONFIG}
fi
