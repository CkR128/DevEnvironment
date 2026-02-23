#!/bin/zsh

INSTALL_PATH="$HOME/.bin"
BINARY_LINK="$INSTALL_PATH/sketchybar"
if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew tap FelixKratz/formulae
    brew install sketchybar
else
    echo "Installing nvim from binary"
    if [ -e $BINARY_LINK ]; then
        rm -f $BINARY_LINK
    fi
    if [ -d $INSTALL_DIR ]; then
        rm -frd $INSTALL_DIR
    fi

    xcode-select --install
    git clone https://github.com/FelixKratz/SketchyBar.git
    pushd SketchyBar
    make
    mv bin/sketchybar $BINARY_LINK
    popd
    rm -frd SketchyBar
fi
