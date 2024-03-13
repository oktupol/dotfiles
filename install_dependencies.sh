#!/bin/bash

dependencies=(
	sway
	swaybg
	swaylock
	swayidle
	sway-contrib
	waybar
	wofi
	kitty
	brightnessctl
	kanshi
	grim
	slurp
	mako
	polkit-gnome
	ttf-jetbrains-mono-nerd
	ttf-mplus-nerd
)

sudo pacman -S ${dependencies[@]}

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
