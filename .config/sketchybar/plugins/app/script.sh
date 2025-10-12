#!/bin/bash
RELPATH=$HOME/.config/sketchybar
source $RELPATH/icons.sh

if [[ -n "$INFO" ]]; then
	sketchybar --set $NAME label="$INFO" icon=$(
		__icon_map "$INFO"
		echo $icon_result
	)
fi
