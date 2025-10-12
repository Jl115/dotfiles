#!/bin/bash

SCRIPT_USER="$PLUGIN_DIR/currentuser/script.sh"

add_currentuser_item() {
	local side="${1:-right}"
	user=(
		icon=
		icon.color=$(get_color ROSEWATER)
		icon.font="$NERD_FONT:Regular:24.0"
		icon.y_offset=1
		icon.padding_right=0
		icon.padding_left=0
		drawing=on
		script="$SCRIPT_USER"
		label.font="$NERD_FONT:Medium:13.0"
		padding_left=$PADDINGS_SMALL
		padding_right=$(($PADDINGS_SMALL / 2))
		label.color=$(get_color FOREGROUND)
		label.drawing=on
		label.padding_right=0
		label.padding_left=3
		update_freq=0
	)

	sketchybar --add item currentuser "$side" \
		--set currentuser "${user[@]}"
}
