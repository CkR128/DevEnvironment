#!/bin/zsh

INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/skhd"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install koekeishiya/formulae/skhd
else
    echo "Installing skhd from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    curl -L -O "https://github.com/jackielii/skhd.zig/releases/download/v0.0.17/skhd-arm64-macos.tar.gz"
    tar -xzvf "skhd-arm64-macos.tar.gz"
    rm "skhd-arm64-macos.tar.gz"
    xattr -c "skhd-arm64-macos"
    chmod u+x "skhd-arm64-macos"
    mkdir -p "$INSTALL_PATH" 
    mv "skhd-arm64-macos" $BINARY_LINK
fi

echo "------------------------------------"
echo ""
echo "See setup instructions here: https://github.com/koekeishiya/skhd"
echo ""
echo "TL:DR - Start with skhd --start-service"
echo "Allow accessability changes in System Preferences / Privacy & Security / Accessibility"
echo "Unlock and allow changes to privacy list."
echo ""
echo "------------------------------------"
