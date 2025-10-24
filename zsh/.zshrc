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

# path
export PATH=$HOME/.local/bin:$HOME/dotfiles/scripts:$PATH 

setopt hist_ignore_dups
setopt share_history
setopt correct

# prompt
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_SYNTAXHIGHLIGHTING_PATH="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_POWERLEVEL10K_PATH="/usr/share/zsh-theme-powerlevel10k"

if [[ -f "$ZSH_POWERLEVEL10K_PATH/powerlevel10k.zsh-theme" ]]; then
  source "$ZSH_POWERLEVEL10K_PATH/powerlevel10k.zsh-theme"
else

  autoload -Uz promptinit; promptinit
  prompt adam1
fi

# autocomplete
autoload -Uz compinit && compinit

# java stuff
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# plugins
[[ ! -f "$ZSH_SYNTAXHIGHLIGHTING_PATH" ]] || source "$ZSH_SYNTAXHIGHLIGHTING_PATH"
[[ ! -f "$ZSH_AUTOSUGGESTIONS_PATH" ]] || source "$ZSH_AUTOSUGGESTIONS_PATH"
source "$ZSH_POWERLEVEL10K_PATH/config/p10k-robbyrussell.zsh"
