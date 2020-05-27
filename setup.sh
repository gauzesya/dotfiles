#!/bin/bash

function ask_yes_no {
  while true; do
    echo -n "$* [y/n]: "
    read ANS
    case $ANS in
      [Yy]*)
        return 0
        ;;
      [Nn]*)
        return 1
        ;;
      *)
        echo "Answer must be [y/n]"
        ;;
    esac
  done
}


# Package Install
PACKAGE='zsh vim-gtk tmux curl cmake git'

if which apt-get >/dev/null 2>&1; then
  LENGTH=`echo $PACKAGE | tr ' ' '\n' | wc -l`
  for i in `seq $LENGTH`
  do
    ELEMENT=`echo $PACKAGE | cut -d ' ' -f $i`
    sudo apt-get install $ELEMENT -y
  done
fi


# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc

# Python
if ask_yes_no "Install python settings ?"; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

# Rust
if ask_yes_no "Install rust settings ?"; then
  curl https://sh.rustup.rs -sSf | sh
  rustup update
  rustup component add rls rust-analysis rust-src
fi

# Clojure
if ask_yes_no "Install clojure settings ?"; then
  sudo apt-get install openjdk-8-jdk -y
  curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ~/bin/lein --create-dirs
  chmod a+x ~/bin/lein
  curl -sLO https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo
  chmod a+x install-clj-kondo
  sudo ./install-clj-kondo
  rm install-clj-kondo
fi
