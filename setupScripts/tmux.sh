#!/bin/zsh
INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/tmux"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install tmux
else
    echo "Installing tmux from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    curl -L -O "https://github.com/tmux/tmux-builds/releases/download/v3.6a/tmux-3.6a-macos-arm64.tar.gz"
    tar -xzvf "tmux-3.6a-macos-arm64.tar.gz"
    rm "tmux-3.6a-macos-arm64.tar.gz"
    xattr -c "tmux"
    chmod u+x "tmux"
    mkdir -p "$INSTALL_PATH" 
    mv "tmux" $BINARY_LINK
fi
