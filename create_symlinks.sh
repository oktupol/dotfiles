#!/bin/bash

# Deploy dotfiles by symlinking the contents of this repo's `home/` tree into
# the real $HOME. Idempotent: it refreshes existing symlinks but never clobbers
# real (non-symlink) files.

# Directories whose immediate children get linked into $HOME. Only these exact
# directories are scanned (not recursively), so a whole subdir like
# `home/.config/sway` becomes a single directory symlink, while
# `home/.config/systemd/user` is listed separately so its files are linked
# individually (other tools also drop unit files into ~/.config/systemd/user).
from_paths=(
	"home"
	"home/.config"
	"home/.config/systemd/user"
)

for path in "${from_paths[@]}"; do
	# Iterate only the direct children of $path (one level deep).
	for f in $(find $path -mindepth 1 -maxdepth 1); do
		# Resolve the repo file's absolute path (the symlink's source).
		absolute_path="$(realpath $f)"
		# Map `home/<rest>` to `$HOME/<rest>` by stripping the leading `home/`.
		link_target="$HOME/${f#*/}"

		# Remove any pre-existing symlink so it can be recreated fresh.
		if [[ -L "$link_target" ]]; then
			rm $link_target
		fi
		# Only create the link if nothing real occupies the target path,
		# so existing non-symlink files are left untouched.
		if [[ ! -e "$link_target" ]]; then
			ln -s $absolute_path $link_target
		fi
	done
done
