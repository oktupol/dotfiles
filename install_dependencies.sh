#!/bin/bash

dependencies=(
	sway
	dmenu
	kitty
	j4-dmenu-desktop
	brightnessctl
	kanshi
)

sudo pacman -S ${dependencies[@]}

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
