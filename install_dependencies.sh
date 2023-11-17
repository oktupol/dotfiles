#!/bin/bash

dependencies=(
	sway
	dmenu
	foot
	j4-dmenu-desktop
	brightnessctl
)

sudo pacman -S ${dependencies[@]}

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
