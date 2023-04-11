#!/bin/bash
# Install script dotfiles

env="desktop"
function configureZSH {
    echo "Configuring zsh..."

    # Deleting old config files
    echo "  Backing up old config files..."
    [ -f $HOME/.zshrc ] && mkdir -p $HOME/.old-dotfiles/zsh && mv $HOME/.zshrc $HOME/.old-dotfiles/zsh/zshrc 
    [ -f $HOME/.oh-my-zsh ] && mkdir -p $HOME/.old-dotfiles/zsh && mv $HOME/.oh-my-zsh $HOME/.old-dotfiles/zsh/oh-my-zsh
    [ -f $HOME/.p10k.zsh ] && mkdir -p $HOME/.old-dotfiles/zsh && mv $HOME/.p10k.zsh $HOME/.old-dotfiles/zsh/p10k.zsh

    # Installing oh-my-zsh
    echo "  Installing oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/oh-my-zsh &> /dev/null 


    # Installing oh-my-zsh plugins
    echo "  Installing Auto-Suggestions..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone git@github.com:zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &> /dev/null
    
    echo "  Installing Syntax-Hightlighting..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &> /dev/null
    
    echo "  Installing Completions..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone git@github.com:zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions &> /dev/null
    
    echo "  Installing powerlevel10k..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth=1 git@github.com:romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &> /dev/null

    echo "  Creating symlinks..."
    ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
    ln -s $HOME/dotfiles/zsh/p10k.zsh $HOME/.p10k.zsh
}

function configureNeovim {
    echo "Configuring neovim..."

    # Deleting old config files
    [ -d $HOME/.config/nvim ] && echo "  Backing up old config files..." && mkdir -p $HOME/.old-dotfiles && mv $HOME/.config/nvim $HOME/.old-dotfiles

    echo "  Installing Packer..."
    rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim &> /dev/null

    echo "  Creating symlinks..."
    ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
    
    echo "  Syncing packages..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function configureAlacritty {
    echo "Configuring alacritty..."

    # Deleting old config files
    [ -f $HOME/.alacritty.yml ] && echo "  Backing up old config files... " && mkdir -p $HOME/.old-dotfiles && mkdir -p $HOME/.old-dotfiles/alacritty && mv $HOME/.alacritty.yml $HOME/.old-dotfiles/alacritty/

    echo "  Creating symlinks..."
    ln -s $HOME/dotfiles/alacritty/config $HOME/.alacritty.yml
}

function configurei3 {
    echo "Configuring i3..."

    # Deleting old config files
    echo "  Creating symlinks..."
    [ -d $HOME/.config/i3 ] && echo "  Backing up old config files..." && mkdir -p $HOME/.old-dotfiles && mv $HOME/.config/i3 $HOME/.old-dotfiles

    ln -s $HOME/dotfiles/i3 $HOME/.config/i3
}

function configurei3bar {
    echo "Configuring i3status..."

    # Deleting old config files
    [ -d $HOME/.config/i3status ] && echo "  Backing up old config files..." && mkdir -p $HOME/.old-dotfiles && mv $HOME/.config/i3status $HOME/.old-dotfiles

    # Creating symlinks
    echo "  Creating symlinks..."
    ln -s $HOME/dotfiles/i3status $HOME/.config/i3status
}


echo "Configuration of dotfiles..."
read -p "Do you want this script to automaticaly install the required packages? (pacman only) [Y/n]: " packages
read -p "Do you want this script to automaticaly configure the programs? [Y/n]: " configure

if [ "$packages" == "Y" ] || [ "$packages" == "y" ] || [ "$packages" == "" ]; then
    echo "  Installing required packages..."
    curl -sS https://raw.githubusercontent.com/MarcoPadeiroIPL/dotfiles/master/pkglist.txt -o pkglist.txt

    while read -r pkg; do
        # Check if the package is already installed
        if pacman -Qs $pkg &> /dev/null; then
            echo "Package $pkg is already installed"
        else
            echo "Installing $pkg ..."
            yes | sudo pacman -S $pkg &> /dev/null
        fi

    done < pkglist.txt
fi

if [ "$configure" == "Y" ] || [ "$configure" == "y" ] || [ "$configure" == "" ]; then
    rm -rf $HOME/.old-dotfiles
    rm -rf $HOME/dotfiles
    echo -e "\nDownloading dotfiles from repository..."
    git clone -b $env git@github.com:MarcoPadeiroIPL/dotfiles.git $HOME/dotfiles &> /dev/null

    configureZSH
    configureNeovim
    configureAlacritty
    configurei3
    configurei3bar

    if [ $(echo $SHELL) != "/bin/zsh" ]; then
        read -p "Make zsh default shell? [Y/n]" defaultshell

        if [ "$defaultshell" == "Y" ] || [ "$defaultshell" == "y" ] || [ "$defaultshell" == "" ]; then
            chsh -s /bin/zsh
        fi
    fi

    echo -e "\nDone!"
    echo "You may need to restart your X session for some changes to take effect."
    echo "All the config files are saved in \"$HOME/dotfiles\""
    echo "Your old config files are backed up in \"$HOME/.old-dotfiles\""

    rm $PWD/install.sh
fi

