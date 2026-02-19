#!/bin/zsh
#
if [[ $(command -v brew) == "" || $0 == 1 ]]; then
    brew install tree-sitter-cli
    brew install neovim
else
    # echo "Installing nvim from binary"
    # curl -L -O "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz"
    # tar -xzvf nvim-macos-arm64.tar.gz
    # xattr -c nvim-macos-arm64/bin/nvim
    # chmod u+x nvim-macos-arm64/bin/nvim
    # mkdir -p $HOME/.bin/
    # mv nvim-macos-arm64/bin/nvim $HOME/.bin/nvim
    # rm -frd ./nvim-macos-arm64/
    # rm nvim-macos-arm64.tar.gz
    echo "Add the following to your .zprofile to change the nvim runtime directory if needed:"
    echo "export VIMRUNTIME=\"\$HOME/.bin/nvim-config/share/nvim/runtime\""
    echo "You may need to copy over the directory from the tar to that file path, or another file path of your choice. Should be bin/ lib/ and share/ in the path, nvim/ under lib/ and icons/ man/ and nvim/ under share/"
    echo "OR this may be create on first launch?"
fi
