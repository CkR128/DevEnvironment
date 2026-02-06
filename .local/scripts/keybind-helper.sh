#!/bin/zsh

selected=`ls $HOME/.local/keybind-helper/ | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

if [[ ! -f "$HOME/.local/keybind-helper/$selected" ]]; then
    echo "Could not find file. Not sure how this happened."
    exit 1
fi

TMUX_INSTALLED=0
if command -v tmux >/dev/null 2>&1; then
    TMUX_INSTALLED=1
fi

if [[ TMUX_INSTALLED -eq 0 ]]; then
    man $HOME/.local/keybind-helper/$selected
    exit 0
fi

if [[ -z "$TMUX" ]]; then
    tmux new-session -s keybind-lookup "bash -c 'man $HOME/.local/keybind-helper/$selected'" > /dev/null
else
    tmux neww -n keybind-lookup bash -c "man $HOME/.local/keybind-helper/$selected"
fi
