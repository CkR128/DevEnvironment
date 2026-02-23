#!/bin/zsh
brew install --cask karabiner-elements
echo "------------------------------------"
echo "Run Karabiner from Applications and make sure to set up these permissions:"
echo ""
echo "Login Items & Extensions > Karabiner-Elements Non-Privileged Agents (enable)"
echo "Login Items & Extensions > Karabiner-Elements Privileged Daemons (enable)"
echo "Login Items & Extensions > Driver Extensions > .Karabiner-VirtualHIDDevice-Manager (enable)"
echo "------------------------------------"
brew install kanata
 
"https://github.com/jtroo/kanata/releases/download/v1.11.0/macos-binaries-arm64.zip"
APPLICATION="kanata"
INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/$APPLICATION"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install kanata
else
    echo "Installing $APPLICATION from binary"
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
echo "------------------------------------"
echo "Run kanata with sudo and use --cfg path to kanatarc file."
echo "------------------------------------"
