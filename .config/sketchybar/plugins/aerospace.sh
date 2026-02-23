#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh


#if [[ $SELECTED == "false" ]]; then
echo $SELECTED
echo $NAME
echo $1
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    #sketchybar --set $NAME background.drawing=on
    sketchybar --set "space.$NAME" \
      icon=􀂓 \
else
    sketchybar --set "space.$NAME" \
      icon=􀂓 \
    #background.drawing=off
fi
