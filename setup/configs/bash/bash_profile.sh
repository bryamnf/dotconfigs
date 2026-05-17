#!/bin/bash
###### prompt colors #############
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
set -o vi

if [ -x $HOME/.local/bin/mise ]; then
    export PATH="$HOME/.local/bin:$PATH"
    eval "$(mise activate bash --shims)"
else
    echo "[W] mise-en-place not found!"
fi

function l() {
    if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
    else
        echo "[E] bashrc not found!"
        return
    fi
    echo "[I] bashrc sourced!"
    return
}
