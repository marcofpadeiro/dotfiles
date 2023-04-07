#!/bin/bash
# Install script dotfiles

function configureZSH {
    echo "Configuring zsh..."
    cd $HOME/dotfiles-temp

    # Deleting old config files
    echo "  Deleting old config files..."
    rm -rf $HOME/.oh-my-zsh
    rm -rf $HOME/.zshrc
    rm -rf $HOME/.p10k.zsh

    # Installing oh-my-zsh
    echo "  Installing oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &> /dev/null 


    # Installing zsh plugins
    while read plugin; do
        echo "  Installing $plugin..."
        rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin
        git clone https://github.com/$plugin ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin &> /dev/null 
    done < zsh/pluginList.txt

    # Installing zsh themes
    echo "  Installing powerlevel10k..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &> /dev/null 

    echo "  Moving config files to the right place..."
    mv zsh/zshrc $HOME/.zshrc
    mv zsh/p10k.zsh $HOME/.p10k.zsh

}

function configureNeovim {
    echo "Configuring neovim..."
    cd $HOME/dotfiles-temp

    echo "  Installing Packer..."
    rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim &> /dev/null
    
    echo "  Moving files to the right path..."
    rm -rf $HOME/.config/nvim
    mv nvim $HOME/.config/nvim
    
    echo "  Syncing packages..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function configureAlacritty {
    echo "Configuring alacritty..."
    cd $HOME/dotfiles-temp

    rm -rf $HOME/.alacritty.yml
    mv alacritty/config $HOME/.alacritty.yml
}

function configurei3 {
    echo "Configuring i3..."
    cd $HOME/dotfiles-temp

    rm -rf $HOME/.config/i3
    mv i3 $HOME/.config/i3
}

function configurei3bar {
    echo "Configuring i3status..."
    cd $HOME/dotfiles-temp

    rm -rf $HOME/.config/i3status
    mv i3status $HOME/.config/i3status
}


echo "Configuration of dotfiles..."
read -p "Do you want this script to automaticly install the required packages? [Y/n]: " packages
read -p "Do you want this script to automaticly configure the programs? [Y/n]: " configure

if [ "$packages" == "Y" ] || [ "$packages" == "y" ] || [ "$packages" == "" ]; then
    echo "  Installing required packages..."
    curl -sS https://raw.githubusercontent.com/MarcoPadeiroIPL/dotfiles/master/pkglist.txt -o pkglist.txt
    sudo pacman -S --needed - < pkglist.txt
    rm -rf pkglist.txt
fi

if [ "$configure" == "Y" ] || [ "$configure" == "y" ] || [ "$configure" == "" ]; then
    echo "Downloading dotfiles from repository..."
    rm -rf $HOME/dotfiles-temp
    git clone git@github.com:MarcoPadeiroIPL/dotfiles.git $HOME/dotfiles-temp &> /dev/null
    cd $HOME/dotfiles-temp

    configureZSH
    configureNeovim
    configureAlacritty
    configurei3
    configurei3bar

    echo "Cleaning up..."
    rm -rf $HOME/dotfiles-temp

    read -p "Make zsh default shell? [Y/n]" defaultshell

    if [ "$defaultshell" == "Y" ] || [ "$defaultshell" == "y" ] || [ "$defaultshell" == "" ]; then
        chsh -s /bin/zsh
    fi

fi

