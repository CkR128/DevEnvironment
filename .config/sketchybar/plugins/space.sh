#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [[ $SELECTED == "false" ]]; then
  if [[ "$NAME" =~ ^space\.([0-9]+)$ ]]; then
    NUMBER="${BASH_REMATCH[1]}"
    sketchybar --set "$NAME" \
    icon="$NUMBER"
  else
    sketchybar --set "$NAME" \
    icon="$NAME"
  fi
else 
sketchybar --set "$NAME" \
    icon=􀂓 \
    # icon.padding_left=5 \
    # icon.padding_right=5 \
    # icon.color=0xffffffff
fi
