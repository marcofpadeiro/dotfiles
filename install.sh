#!/bin/bash
stow_stuff() {
    stow alacritty
    echo -e "\t$HOME/.config/alacritty -> $(pwd)/alacritty/.config/alacritty"

    stow nvim
    echo -e "\t$HOME/.config/nvim -> $(pwd)/nvim/.config/nvim"

    stow tmux
    echo -e "\t$HOME/.config/tmux -> $(pwd)/tmux/.config/tmux"

    echo 'ZDOTDIR=$HOME/.config/zsh' > ~/.zshenv
    stow zsh
    echo -e "\t$HOME/.config/zsh -> $(pwd)/zsh/.config/zsh"

    stow zathura
    echo -e "\t$HOME/.config/zathura -> $(pwd)/zsh/.config/zathura"
}

configure_zsh() {
    ZDOTDIR="$HOME/.config/zsh"

    echo 'ZDOTDIR="$HOME/.config/zsh"' > $HOME/.zshenv
    echo -e "\tCloning zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions $ZDOTDIR/plugins/zsh-completions > /dev/null 2>&1
    echo -e "\tCloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZDOTDIR/plugins/zsh-syntax-highlighting > /dev/null 2>&1
    echo -e "\tCloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions > /dev/null 2>&1
    echo -e "\tCloning powerlevel10k..."
    git clone https://github.com/romkatv/powerlevel10k $ZDOTDIR/themes/powerlevel10k > /dev/null 2>&1
    echo -e "\tCloning zsh-vi-mode..."
    git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZDOTDIR/plugins/zsh-vi-mode > /dev/null 2>&1 

    mkdir -p $ZDOTDIR/plugins/git $ZDOTDIR/plugins/z
    echo -e "\tCloning git plugin..."
    curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh -o $ZDOTDIR/plugins/git/git.plugin.zsh > /dev/null 2>&1
    echo -e "\tCloning z plugin..."
    curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/z/z.plugin.zsh -o $ZDOTDIR/plugins/z/z.plugin.zsh > /dev/null 2>&1
}

configure_tmux() {
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm > /dev/null 2>&1
}

configure_dwm() {
    echo -e "\tCloning..."
    git clone https://git.suckless.org/dwm ~/.config/dwm

    ln -svf $(pwd)/dwm/config.h $HOME/.config/dwm/config.h
    ln -svf $(pwd)/dwm/bar.sh $HOME/.config/dwm/bar.sh

    cd $HOME/.config/dwm
    echo -e "\tAdding patches..."
    curl https://dwm.suckless.org/patches/systray/dwm-systray-20230922-9f88553.diff -o $HOME/.config/dwm/dwm-systray-20230922-9f88553.diff
    git apply dwm-systray-20230922-9f88553.diff 

    echo -e "\tCompiling..."
    make PREFIX=$HOME/.local clean install > /dev/null 2>&1

    cd -
}

install_fonts() {
    mkdir -p $HOME/.local/share/fonts/ttf
    echo -e "\tCloning Hack Nerd Font..."
    wget -O /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip > /dev/null 2>&1
    echo -e "\tCloning Iosevka Nerd Font..."
    wget -O /tmp/Iosevka.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip > /dev/null 2>&1
    echo -e "\tCloning JetBrains Nerd Font..."
    wget -O /tmp/JetbrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip > /dev/null 2>&1

    echo -e "\tExtracting Hack Nerd Font..."
    unzip /tmp/Hack.zip -d $HOME/.local/share/fonts/ttf/Hack > /dev/null 2>&1
    echo -e "\tExtracting Iosevka Nerd Font..."
    unzip /tmp/Iosevka.zip -d $HOME/.local/share/fonts/ttf/Iosevka > /dev/null 2>&1
    echo -e "\tExtracting JetBrains Nerd Font..."
    unzip /tmp/JetBraingsMono.zip -d $HOME/.local/share/fonts/ttf/JetBrainsMono > /dev/null 2>&1
}

link_tlp() { 
    sudo ln -svf $(pwd)/tlp/tlp.conf /etc/tlp.conf
}

link_scripts() {
    find $(pwd)/scripts -type f | while IFS= read -r line; do 
        name=$(basename $line | cut -d '.' -f 1)
        ln -sv $line $HOME/.local/bin/$name
    done
}

ask() {
    read -p "$1 [Y/n] " resp
    [[ "${resp,,}" =~ ^(y|)$ ]]
}

if ask "Stow stuff?"; then
    echo ":: Creating symm links..."
    stow_stuff
fi

if ask "Configure zsh?"; then
    echo ":: Configuring zsh..."
    configure_zsh
fi

if ask "Configure dwm?"; then
    echo ":: Configuring dwm..."
    configure_dwm
fi

if ask "Install fonts?"; then
    echo ":: Installing nerd fonts..."
    install_fonts
fi

if ask "Create tlp.conf sym link?"; then
    echo ":: Linking tlp.conf (needs root)..."
    link_tlp
fi

if ask "Create scripts sym link to .local/bin?"; then
    echo ":: Linking scripts to .local/bin ..."
    link_scripts
fi
