#!/bin/bash

# variables
IS_REPLACE_FILE=

# parse options
while getopts "y" opt; do
	case $opt in
	y)
		IS_REPLACE_FILE=true
		;;
	\?)
		exit 1
		;;
	esac
done

# install
for file in "$HOME"/dotfiles/installers/*; do
	echo -n "Installing $(basename "$file") ... "
	sh "$file" >/dev/null 2>&1
	echo -e "\u2713"
done
echo "Install completed !!"
echo ""

# link
shopt -s dotglob
function mklink() {
	for file in "$1"/*; do
		base=$(basename "$file")
		[ "$base" = "." ] && continue
		[ "$base" = ".." ] && continue
		[ "$base" = ".DS_Store" ] && continue

		target="$2/$base"
		# if $file is file, make symbolic link
		if [ -f "$file" ]; then

			# ask if target file exists
			if [ -f "$target" ]; then
				if [ $IS_REPLACE_FILE ]; then
					rm -f "$target"
				else
					echo -n "Are you sure to replace $file? [Y/n] "
					read -r ANSWER
					case $ANSWER in
					"" | [Yy]*)
						rm -f "$target"
						;;
					esac
				fi
			fi

			if [ ! -f "$target" ]; then
				ln -snfv "$file" "$2"
			fi

		fi
		# if $file is directory, implement mklink function recursively
		if [ -d "$file" ]; then
			mkdir -p "$target"
			mklink "$file" "$target"
		fi
	done
}
mklink "$HOME"/dotfiles/dotfiles "$HOME"

echo "Setup completed !!"
