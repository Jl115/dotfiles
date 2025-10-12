#!/usr/bin/env bash

add_menu_item() {
	local side="${1:-left}"

	# Main menu icon
	sketchybar --add item "menu" "$side" \
		--set "menu" \
		"${item_style[@]}" \
		label.font="$NERD_FONT:Bold:30.0" \
		label="" \
		label.color="$(get_color LAVENDER 100)" \
		icon.drawing=off \
		label.padding_left=8 \
		label.padding_right=$PADDINGS_LARGE \
		label.y_offset=4 \
		click_script="$PLUGIN_DIR/sketchymenu/app_menu.sh"
}
