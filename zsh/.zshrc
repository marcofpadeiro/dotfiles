if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

HISTSIZE=10000
SAVEHIST=10000

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
autoload -U compinit && compinit -u

# Setting up the theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugin Manager
plugins=(
    zsh-autosuggestions
    git
    z
    zsh-completions
    #command-not-found
    autojump
#    zsh-vi-mode
    zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias ls='ls --color=auto'
alias chrome='google-chrome-stable'
alias pdf='evince'
alias hdmi='. ~/scripts/hdmi.sh'
alias vim='nvim'
alias windows="vboxmanage startvm 'Windows 10' "
alias mysql="mysql --auto-rehash -u marco -p"
alias lamp="systemctl start mysql && systemctl start httpd"
alias lamp-stop="systemctl stop mysql && systemctl stop httpd"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

