#!/bin/zsh

INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/fzf"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install fzf
else
    echo "Installing nvim from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi

    curl -L -O "https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-darwin_arm64.tar.gz"
    tar -xzvf fzf-0.68.0-darwin_arm64.tar.gz
    rm fzf-0.68.0-darwin_arm64.tar.gz
    mkdir -p "$INSTALL_PATH" 
    mv "fzf" "$BINARY_LINK"
    xattr -c "$BINARY_LINK"
    chmod u+x "$BINARY_LINK"
fi
