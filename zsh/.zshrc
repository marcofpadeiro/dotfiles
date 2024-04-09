# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

bindkey -v
bindkey '^R' history-incremental-search-backward

export PROMPT_COMMAND='history -a'

autoload -U compinit && compinit -u

export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

bindkey -s '^e' 'fzf-tmux\n'
bindkey -s '^i' 'cht\n'


# aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias hyprrc="nvim ~/.config/nvim"
alias ls='ls --color=auto'
alias vim='nvim'
alias cat='bat'
alias rm='rm -i'
alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'



[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=($HOME/.zsh/plugins/zsh-completions/src $fpath)
source $HOME/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh/plugins/git/git.plugin.zsh
source $HOME/.zsh/plugins/z/z.plugin.zsh

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if [ "$(tty)" = "/dev/tty1" ]; then
#     exec dbus-launch --exit-with-session sway
# fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi
