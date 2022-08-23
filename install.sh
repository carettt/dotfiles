#!/bin/sh

sudo pacman -Syy alacritty i3-gaps i3lock neofetch nvim polybar feh paru
paru -S themix-full-git picom-ibhagwan-git
cp -r alacritty i3 neofetch nvim oomox picom polybar ~/.config
cp -r .themes .bg1920.jpg .bg2560.jpg ~/
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
