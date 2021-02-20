#!/bin/sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# pyenv + virtualenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
