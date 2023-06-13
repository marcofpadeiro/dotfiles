
autoload -U colors && colors

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit && compinit -u

ZSH_THEME="powerlevel10k/powerlevel10k"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias hyprrc="nvim ~/.config/nvim"
alias ls='ls --color=auto'
alias vim='nvim'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /home/marco/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/marco/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(/home/marco/.zsh/plugins/zsh-completions/src $fpath)
source /home/marco/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source /home/marco/.zsh/plugins/git/git.plugin.zsh
source /home/marco/.zsh/plugins/z/z.plugin.zsh
