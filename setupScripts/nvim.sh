#!/bin/zsh
#
if [[ $(command -v brew) == "" || $0 == 1 ]]; then
    brew install tree-sitter-cli
    brew install neovim
else
    # echo "Installing nvim from binary"
    # curl -L -O "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz"
    # tar -xzvf nvim-macos-arm64.tar.gz
    # xattr -c nvim-macos-arm64/bin/nvim
    # chmod u+x nvim-macos-arm64/bin/nvim
    # mkdir -p $HOME/.bin/
    # mv nvim-macos-arm64/bin/nvim $HOME/.bin/nvim
    # rm -frd ./nvim-macos-arm64/
    # rm nvim-macos-arm64.tar.gz
fi
