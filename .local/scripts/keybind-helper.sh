#!/bin/zsh

selected=`ls $HOME/.local/keybind-helper/ | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

if [[ ! -f "$HOME/.local/keybind-helper/$selected" ]]; then
    echo "Could not find file. Not sure how this happened."
    exit 1
fi

if [[ -z "$TMUX" ]]; then
    tmux new-session -s keybind-lookup "bash -c 'man $HOME/.local/keybind-helper/$selected'" > /dev/null
else
    tmux neww -n keybind-lookup bash -c "man $HOME/.local/keybind-helper/$selected"
fi
