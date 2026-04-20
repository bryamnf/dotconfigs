#!/bin/bash 

install_pkgs(){
	pixi global install nvim uv fzf ripgrep fd-find git-delta bat lazygit
}


echo "Creating symbolic links to bashrc, ibashrc, profile, gitconfig and nvim"
ln -sf ~/dotconfigs/setup/bashrc ~/.bashrc
ln -sf ~/dotconfigs/setup/ibashrc ~/.ibashrc
ln -sf ~/dotconfigs/setup/profile ~/.profile
ln -sf ~/dotconfigs/setup/gitconfig ~/.gitconfig
ln -sfn ~/dotconfigs/nvim ~/.config/nvim

if [ -x $HOME/.pixi/bin/pixi ]; then 
	echo "Pixi already installed"
	echo "Installing pkgs"
	install_pkgs
else
	echo "Installing pixi"
	curl -fsSL https://pixi.sh/install.sh | sh
	echo "Installing pkgs"
	install_pkgs
fi

if [ -d $HOME/.nvm ] && [ -d $HOME/.npm ] ; then
       echo "nvm and npm already installed"
else
      echo "Installing nvm"
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash      
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      nvm install node
      nvm install-latest-npm
fi

if [ -d $HOME/.cargo ] && [ -d $HOME/.rustup ]; then 
    echo "rustup and cargo already installed"
else 
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

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
