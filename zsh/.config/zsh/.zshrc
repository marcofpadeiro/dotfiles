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

export EDITOR='nvim'

bindkey -s '^e' 'fzf-tmux\n'
bindkey -s '^i' 'cht\n'


# aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias hyprrc="nvim ~/.config/nvim"
alias ls='ls --color=auto'
alias vim='nvim'
alias rm='rm -i'

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/git/git.plugin.zsh
source $ZDOTDIR/plugins/z/z.plugin.zsh

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
