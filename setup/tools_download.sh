#!/bin/bash 
pixi global install lua-language-server clang clang-tools
uv tool install basedpyright
uv tool install ruff
uv tool install pylatexenc #markdown render pkg
cargo install --locked tree-sitter-cli
cargo install --locked zoxide
cargo install --force --git https://github.com/sxyazi/yazi.git yazi-build
npm install -g bash-language-server
npm install -g libtexprintf #markdown render pkg
npm install -g opencode-ai
npm install -g @vtsls/language-server
