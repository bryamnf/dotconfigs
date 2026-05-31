#!/bin/bash


############# DYNAMIC-LINKS ##################
ln -sf ~/dotconfigs/setup/configs/bash/bash_profile.sh ~/.bash_profile
ln -sf ~/dotconfigs/setup/configs/bash/bashrc.sh ~/.bashrc
ln -sf ~/dotconfigs/setup/configs/git/gitconfig ~/.gitconfig

############## Config setup #################
configs=("mise" "tmux" "ghostty" "yazi" "opencode")
path_to_configs="$HOME/dotconfigs/setup/configs"

[ ! -d $HOME/.config ] && mkdir $HOME/.config

for config in ${configs[@]}; do
    if [ -d "$path_to_configs/$config" ]; then
        echo "[I] link available for $config!"
    else
        echo "creating link for $config"
        ln -sfn "$path_to_configs/$config" $HOME/.config
        echo "[I] link created for $config!"
    fi
done

#############MISE-EN-PLACE####################
if [ -x $HOME/.local/bin/mise ]; then 
	echo "[I] Mise already installed!"
else
	echo "[I] Installing mise!"
	curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
    mise up
    mise trust $HOME/dotconfigs/setup/configs/mise/config.toml
fi

#############FONTS##################
if [ -d $HOME/.local/share/fonts ]; then
    echo "[I] Local fonts available!"
else
    mkdir -p $HOME/.local/share/fonts
    cd $HOME/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
    unzip JetBrainsMono.zip
    fc-cache -fv
    echo "Please select JetBrainsMono nerd-fonts in terminal emulator"
fi 
