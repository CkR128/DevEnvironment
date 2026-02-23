#!/bin/zsh
INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/yabai"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install koekeishiya/formulae/yabai 
else
    echo "Installing yabai from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    curl -L -O "https://github.com/asmvik/yabai/releases/download/v7.1.17/yabai-v7.1.17.tar.gz"
    tar -xzvf "yabai-v7.1.17.tar.gz"
    rm "yabai-v7.1.17.tar.gz"
    xattr -c "archive/bin/yabai"
    chmod u+x "archive/bin/yabai"
    mkdir -p "$INSTALL_PATH" 
    mv "archive/bin/yabai" $BINARY_LINK
    rm -frd "archive"
fi

echo "------------------------------------"
echo "See setup instructions here: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)"
echo ""
echo "TL:DR - Start with yabai --start-service"
echo "Allow accessability changes in System Preferences / Privacy & Security / Accessibility"
echo "Unlock and allow changes to privacy list."
echo ""
echo "------------------------------------"
