#!/bin/sh


# Package Install
PACKAGE='zsh vim-gnome tmux curl cmake git openjdk-8-jdk'

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

# Rust
curl https://sh.rustup.rs -sSf | sh
rustup update
rustup component add rls rust-analysis rust-src

# Clojure
curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o ~/bin/lein --create-dirs
chmod a+x ~/bin/lein
curl -sLO https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo
chmod a+x install-clj-kondo
sudo ./install-clj-kondo
rm install-clj-kondo

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc
