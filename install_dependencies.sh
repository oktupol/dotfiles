#!/bin/bash

dependencies=(
	sway
	swaybg
	swaylock
	swayidle
	waybar
	wofi
	kitty
	brightnessctl
	kanshi
	grim
	slurp
	mako
	polkit-gnome
)

sudo pacman -S ${dependencies[@]}

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
