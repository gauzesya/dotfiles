#!/bin/bash

# install
for file in "$HOME"/dotfiles/installers/*; do
	echo -n "Installing $(basename "$file") ... "
	sh "$file" >/dev/null 2>&1
	echo -e "\u2713"
done
echo "Install completed !!"
echo ""
