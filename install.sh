#!/bin/bash
# Install script dotfiles

function configureZSH {
    echo "  Deleting old config..."
    rm -rf ~/.zsh ~/.zshrc ~/.p10k.zsh

    echo "  Preparing directories and symmlinks..."
    ln -s $PWD/zsh/zshrc ~/.zshrc
    ln -s $PWD/zsh/p10k.zsh ~/.p10k.zsh
    
    mkdir ~/.zsh
    mkdir ~/.zsh/themes/
    mkdir ~/.zsh/plugins/
    mkdir ~/.zsh/plugins/git
    mkdir ~/.zsh/plugins/z
    
    echo "  Downloading extensions..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting/ &> /dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/plugins/zsh-autosuggestions &> /dev/null
    git clone https://github.com/zsh-users/zsh-completions ~/.zsh/plugins/zsh-completions &> /dev/null
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/themes/powerlevel10k &> /dev/null
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh -o ~/.zsh/plugins/git/git.plugin.zsh &> /dev/null
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/z/z.plugin.zsh -o ~/.zsh/plugins/z/z.plugin.zsh &> /dev/null
    
    chsh -s /bin/zsh
}

function configureNeovim {
    echo "Configuring neovim..."

    # Deleting old config files
    echo "  Deleting old config..."
    rm -rf $HOME/.config/nvim

    echo "  Installing Packer..."
    rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim &> /dev/null

    echo "  Creating symlinks..."
    ln -s $PWD/nvim $HOME/.config/nvim
    
    echo "  Syncing packages..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function configureKitty {
    echo "Configuring kitty..."

    # Deleting old config files
    echo "  Deleting old config..."
    rm -rf $HOME/.config/kitty

    echo "  Creating symlinks..."
    ln -s $PWD/kitty $HOME/.config/kitty
}

function configurei3 {
    echo "Configuring i3..."

    # Deleting old config files
    echo "  Deleting old config..."
    rm -rf $HOME/.config/i3

    echo "  Creating symlinks..."
    ln -s $PWD/i3 $HOME/.config/i3
}

function configurei3status {
    echo "Configuring i3status..."

    # Deleting old config files
    echo "  Deleting old config..."
    rm -rf $HOME/.config/i3status

    # Creating symlinks
    echo "  Creating symlinks..."
    ln -s $PWD/i3status $HOME/.config/i3status
}

configureZSH
configureNeovim
configureKitty
configurei3
configurei3status

echo -e "\nDone!"
echo "You may need to restart your X session for some changes to take effect."

