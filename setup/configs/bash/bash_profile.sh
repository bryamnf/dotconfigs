[ -d "$HOME/.local/bin" ]  && export PATH="$HOME/.local/bin:$PATH"
[ -x $HOME/.local/bin/mise ] && eval "$(mise activate bash --shims)"
export EDITOR=nvim #yazi
