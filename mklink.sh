#!/bin/sh

set -u

THIS_DIR=$(cd $(dirname $0); pwd)

cd $THIS_DIR
git submodule init
git submodule update

echo "start setup..."

for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    if [ -d ~/"$f" ] && [ ! -L ~/"$f" ]; then
      mv ~/"$f"/* ~/dotfiles/"$f"/
      rm -rf ~/"$f"
    fi

    ln -snfv ~/dotfiles/"$f" ~/
done

echo "complete!!"
