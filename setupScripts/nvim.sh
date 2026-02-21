#!/bin/zsh
#
INSTALL_PATH="$HOME/.bin"
if [[ $(command -v brew) == "" || $0 == 1 ]]; then
    brew install tree-sitter-cli
    brew install neovim
else
    echo "Installing nvim from binary"
    curl -L -O "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz"
    tar -xzvf nvim-macos-arm64.tar.gz
    xattr -c nvim-macos-arm64/bin/nvim
    chmod u+x nvim-macos-arm64/bin/nvim
    mkdir -p "$INSTALL_PATH" 
    mv nvim-macos-arm64/ "$INSTALL_PATH/nvim-config/"
    ln "$INSTALL_PATH/nvim-config/bin/nvim" "$INSTALL_PATH/nvim"
    rm nvim-macos-arm64.tar.gz
    echo "Add the following to your .zprofile to change the nvim runtime directory:"
    echo "export VIMRUNTIME=\"\$HOME/.bin/nvim-config/share/nvim/runtime\""
    echo "export PATH=\"\$PATH:$HOME/.bin/\""
fi
