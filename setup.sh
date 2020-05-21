#!/bin/sh


# Package Install
PACKAGE='zsh vim-gnome tmux curl cmake git'

if which apt-get >/dev/null 2>&1; then
  LENGTH=`echo $PACKAGE | tr ' ' '\n' | wc -l`
  for i in `seq $LENGTH`
  do
    ELEMENT=`echo $PACKAGE | cut -d ' ' -f $i`
    sudo apt-get install $ELEMENT -y
  done
fi

# Python
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
export PATH="~/.pyenv/bin:$PATH"

# Rust
curl https://sh.rustup.rs -sSf | sh
rustup update
rustup component add rls rust-analysis rust-src

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc
