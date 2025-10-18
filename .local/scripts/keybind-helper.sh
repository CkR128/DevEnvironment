#!/bin/zsh

selected=`ls ~/.local/keybind-helper | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

if [[ ! -f "$HOME/.local/keybind-helper/$selected" ]]; then
    exit 1
fi

tmux neww bash -c "nvim $HOME/.local/keybind-helper/$selected"
