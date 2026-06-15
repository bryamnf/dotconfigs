#!/bin/bash

# Guard for interactive sessions
[[ $- != *i* ]] && return

###### prompt colors #############
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

###### Env Vars ##################
[ -d "$HOME/.local/bin" ]  && export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim 
export OPENCODE_EXPERIMENTAL=true 

###### mise-en-place #############
[ -x "$HOME/.local/bin/mise" ] && eval "$(mise activate bash)"
eval "$(mise completions bash --include-bash-completion-lib )"

###### enable vim mode ###########
set -o vi

###### enable history append #####
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth

###### Completions ###############
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###### aliases ###################
alias nv='nvim .'
alias g='lazygit'
alias cat='bat --paging=never'
alias ll='eza --icons=always -1agl'
alias ls='eza --icons=always'
alias lt='eza --icons=always -1aglT'

####### fzf ######################
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd --type f | sort -k2 -rn'
export FZF_DEFAULT_OPTS="
--style default --layout=reverse --inline-info --border --padding 1,2
--border-label 'Fuzzy Finder' --input-label ' Input ' --header-label ' File Type ' 
--bind 'result:transform-list-label:
    if [[ -z \$FZF_QUERY ]]; then
      echo \" \$FZF_MATCH_COUNT items \"
    else
      echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
    fi
    ' 
--color 'border:#aaaaaa,label:#cccccc' 
--color 'preview-border:#9999cc,preview-label:#ccccff' 
--color 'list-border:#669966,list-label:#99cc99' 
--color 'input-border:#996666,input-label:#ffcccc' 
--color 'header-border:#6699cc,header-label:#99ccff'
"
export FZF_CTRL_T_OPTS="
--preview '$HOME/dotconfigs/setup/configs/fzf/fzf-preview.sh {}'
--bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; fd --type f)' 
--bind 'focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}' 
--bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"'
"
####### zoxide ###################
eval "$(zoxide init bash)"
function ct() {
  local dir
  dir=$(zoxide query -l |  fzf --preview 'eza --icons=always -1gT {}') 
  [ -n "$dir" ] && z "$dir" 
 }
export -f ct
function co() {
    ct && nvim $(fzf) 
}
####### ripgrep ##################
rg() { command rg --json -C 1 "$@" | delta; }

####### yazi #####################
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

####### pixi #####################
export PATH="/home/bryam-n-ez/.pixi/bin:$PATH"

