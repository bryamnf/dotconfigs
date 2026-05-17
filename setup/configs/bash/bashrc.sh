#!/bin/bash

###### prompt colors #############
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

###### Env Vars ##################
[ -d "$HOME/.local/bin" ]  && export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim 
export OPENCODE_EXPERIMENTAL=true 

###### mise-en-place #############
[ -x "$HOME/.local/bin/mise" ] && eval "$(mise activate bash)"

###### enable vim mode ###########
set -o vi

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

####### sbashrc set up ###########
if [ -f "$HOME/.sbashrc" ]; then
    source "$HOME/.sbashrc"
else
    echo "[!] ~/.sbashrc not found"
fi

####### yazi #####################
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
