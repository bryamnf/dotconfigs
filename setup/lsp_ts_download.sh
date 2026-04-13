#!/bin/bash 
pixi global install lua-language-server
uv tool install basedpyright
cargo install --locked tree-sitter-cli
npm install -g bash-language-server
