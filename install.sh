#!/bin/bash
# Install script dotfiles

function configureZSH {
    echo "Configuring ZSH..."
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

function configuretmux {
    echo "Configuring tmux..."

    # Deleting old config files
    echo "  Deleting old config..."
    rm -rf $HOME/.tmux.conf

    echo "  Creating symlinks..."
    ln -s $PWD/tmux/config $HOME/.tmux.conf
}

    declare -A members=(
        [1]="zsh"
        [2]="nvim"
        [3]="i3"
        [4]="i3status"
        [5]="tmux"
        [6]="kitty"
    )
    
declare -A selected

# Display the menu
echo "Select the items to configure:"

for key in "${!members[@]}"; do
    printf "%4d) %s\n" "$key" "${members[$key]}"
done

echo "Press 'q' to exit."

# Process user input
    read -p "Enter a selection: " input

    # Exit if 'q' is pressed
    if [[ $input == "q" ]]; then
        break
    fi

    if [[ -z $input ]]; then
        selected=($(seq 1 6))
    fi

    IFS=' ' read -ra selections <<< "$input"

    # Validate and process each selection
    for selection in "${selections[@]}"; do
        # Check if the selection is a valid number
        if [[ $selection =~ ^[0-9]+$ ]]; then
            # Check if the selection is within the valid range
            if [[ $selection -ge 1 && $selection -le ${#members[@]} ]]; then
                # Toggle the selection
                if [[ ${selected[$selection]} ]]; then
                    unset "selected[$selection]"
                else
                    selected[$selection]=1
                fi
            else
                echo "Invalid selection: $selection"
            fi
        else
                echo "Invalid selection: $selection"
        fi
    done

    for key in "${!selected[@]}"; do
        case ${members[$key]} in
            "zsh") configureZSH ;;
            "nvim") configureNeovim ;;
            "i3")configurei3 ;;
            "i3status")configurei3status ;;
            "tmux")configuretmux ;;
            "kitty")configureKitty ;;
        esac
    done
    
    echo -e "\nDone!"
    echo "You may need to restart your X session for some changes to take effect."
