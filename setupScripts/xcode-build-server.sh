#!/bin/zsh
INSTALL_LOCATION="$HOME/.local/"
LINK_LOCATION="$HOME/.local/bin"
git clone "https://github.com/SolaWing/xcode-build-server.git" "$INSTALL_LOCATION" && ln -s "$INSTALL_LOCATION"/xcode-build-server/xcode-build-server "$LINK_LOCATION"
