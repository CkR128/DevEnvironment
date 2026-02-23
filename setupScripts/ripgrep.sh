#!/bin/zsh

INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/rg"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install ripgrep
else
    echo "Installing rg from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    curl -L -O "https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-aarch64-apple-darwin.tar.gz"
    tar -xzvf "ripgrep-15.1.0-aarch64-apple-darwin.tar.gz"
    rm "ripgrep-15.1.0-aarch64-apple-darwin.tar.gz"
    xattr -c "ripgrep-15.1.0-aarch64-apple-darwin/rg"
    chmod u+x "ripgrep-15.1.0-aarch64-apple-darwin/rg"
    mkdir -p "$INSTALL_PATH" 
    mv "ripgrep-15.1.0-aarch64-apple-darwin/rg" $INSTALL_DIR
    rm -frd "ripgrep-15.1.0-aarch64-apple-darwin/"
fi
