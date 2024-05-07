if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U colors && colors

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export PROMPT_COMMAND='history -a'

autoload -U compinit && compinit -u

export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

export EDITOR='nvim'
export ZVM_CURSOR_STYLE_ENABLED=false


bindkey -s '^e' 'fzf-tmux\n'
bindkey -s '^i' 'cht\n'


# aliases
alias zshrc="nvim ~/.config/zsh/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias tmuxrc="nvim ~/.config/tmux"
alias alacrittyrc="nvim ~/.config/alacritty"
alias dwmrc="nvim ~/.config/dwm/config.h && cd ~/.config/dwm && make PREFIX=$HOME/.local/ clean install && cd -"
alias ls='ls --color=auto'
alias vim='nvim'

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZDOTDIR/plugins/git/git.plugin.zsh
source $ZDOTDIR/plugins/z/z.plugin.zsh

bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | xclip -sel c
	zvm_exit_visual_mode
}
