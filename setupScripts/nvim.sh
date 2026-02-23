#!/bin/zsh

INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/nvim"
INSTALL_DIR="$INSTALL_PATH/nvim-config/"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install tree-sitter-cli
    brew install neovim
else
    echo "Installing nvim from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    curl -L -O "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz"
    tar -xzvf "nvim-macos-arm64.tar.gz"
    rm "nvim-macos-arm64.tar.gz"
    xattr -c "nvim-macos-arm64/bin/nvim"
    chmod u+x "nvim-macos-arm64/bin/nvim"
    mkdir -p "$INSTALL_PATH" 
    mv "nvim-macos-arm64/" $INSTALL_DIR
    ln "$INSTALL_DIR/bin/nvim" $BINARY_LINK
    echo "Add the following to your .zprofile to change the nvim runtime directory:"
    echo "export VIMRUNTIME=\"\$HOME/.bin/nvim-config/share/nvim/runtime\""
    echo "export PATH=\"\$PATH:$HOME/.bin/\""
fi
