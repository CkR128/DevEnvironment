#!/bin/zsh

if [[ $(command -v brew) == "" || $# -eq 0 ]]; then
    brew install --cask font-jetbrains-mono-nerd-font
else
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/jetbrainsmono.zip" -o "$HOME/Downloads/jetbrainsmono.zip"
    echo "Downloaded font zip to downloads directory."
fi
