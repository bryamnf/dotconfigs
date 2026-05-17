#!/bin/bash

#############DYNAMIC-LINKS##################
ln -sf ~/dotconfigs/setup/configs/bash/profile.sh ~/.profile
ln -sf ~/dotconfigs/setup/configs/bash/bash_profile.sh ~/.bash_profile
ln -sf ~/dotconfigs/setup/configs/bash/bashrc.sh ~/.bashrc
ln -sf ~/dotconfigs/setup/configs/git/gitconfig ~/.gitconfig

if [ ! -d $HOME/.config/nvim ] && [ ! -d $HOME/.config/mise ]; then
    echo "Seting up nvim and mise directories"
    mkdir -p $HOME/.config/{mise,nvim}
fi
ln -sfn ~/dotconfigs/nvim ~/.config/nvim
ln -sfn ~/dotconfigs/setup/configs/mise ~/.config/mise

#############MISE-EN-PLACE##################
if [ -x $HOME/.local/bin/mise ]; then 
	echo "Mise already installed"
else
	echo "Installing mise"
	curl https://mise.run | sh
fi

#if [ ! -f $HOME/.config/mise/config.toml ] && [ ! -f $HOME/.config/mise/mise.lock ]; then
#    echo "Seting up mise"
#    mkdir -p $HOME/.config/mise/
#    ln -sfn ~/dotconfigs/mise ~/.config/mise
#    mise trust ~/dotconfigs/setup/configs/mise/config.toml
#fi

#############FONTS##################
if [ -d $HOME/.local/share/fonts ]; then
    echo "local fonts available"
else
    mkdir -p $HOME/.local/share/fonts
    cd $HOME/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
    unzip JetBrainsMono.zip
    fc-cache -fv
    echo "Please select JetBrainsMono nerd-fonts in terminal emulator"
fi 

#############CLI TOOLS#############
if [ ! -f $HOME/.config/opencode/opencode.json ]; then
    mkdir -p $HOME/.config/opencode/
    ln -sf ~/dotconfigs/setup/configs/opencode/opencode.json ~/.config/opencode/opencode.json
fi

if [ ! -f $HOME/.config/yazi/keymap.toml ]; then
    mkdir -p $HOME/.config/yazi/
    ln -sf ~/dotconfigs/setup/configs/yazi/yazi_keymap.toml ~/.config/yazi/keymap.toml
fi

if [ ! -f $HOME/.config/ghostty/config.ghostty ]; then
    mkdir -p $HOME/.config/ghostty/
    ln -sf ~/dotconfigs/setup/configs/ghostty/config.ghostty ~/.config/ghostty/config.ghostty
fi
