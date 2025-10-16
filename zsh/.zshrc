# p10k stuff
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

# aliases
alias ls='lsd'
alias cat='bat'
alias grep='grep --color=auto'
alias gst='git status'

# env variables
export EDITOR=nvim
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export PATH=$HOME/.local/bin:$PATH # path

setopt hist_ignore_dups
setopt share_history
setopt correct

# prompt
ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
else
  autoload -Uz promptinit; promptinit
  prompt adam1
fi

# autocomplete
autoload -Uz compinit && compinit

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
