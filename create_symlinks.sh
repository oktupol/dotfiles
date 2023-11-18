#!/bin/bash

from_paths=(
	"home"
	"home/.config"
	"home/.config/systemd/user"
)

for path in "${from_paths[@]}"; do
	for f in $(find $path -mindepth 1 -maxdepth 1); do
		basename="$(basename $f)"
		absolute_path="$(realpath $f)"
		link_target="$HOME/${f#*/}"

		if [[ -L "$link_target" ]]; then
			rm $link_target
		fi
		if [[ ! -e "$link_target" ]]; then
			ln -s $absolute_path $link_target
		fi
	done
done
