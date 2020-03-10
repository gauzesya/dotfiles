#!/bin/sh

PACKAGE='zsh vim-gnome tmux curl cmake git'

if which apt-get >/dev/null 2>&1; then
  LENGTH=`echo $PACKAGE | tr ' ' '\n' | wc -l`
  for i in `seq $LENGTH`
  do
    ELEMENT=`echo $PACKAGE | cut -d ' ' -f $i`
    sudo apt-get install $ELEMENT -y
  done
fi

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PATH="~/.pyenv/bin:$PATH"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc
