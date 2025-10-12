#!/bin/bash
SCRIPT_PKGS="$PLUGIN_DIR/packages/script.sh"

add_pkgs_item() {
	local side="${1:-left}"

	echo "$SCRIPT_PKGS"

	pkgs=(
		drawing=on
		script="$SCRIPT_PKGS"
		#click_script="$SCRIPT_CLICK_PKGS"
		icon=􀐛
		icon.color="$(get_color ORANGE)"
		icon.font="$FONT:Regular:18.0"
		icon.padding_left=0 #$(($OUTER_PADDINGS - 4))
		icon.padding_right=0
		label=""
		label.font="$FONT:Semibold:14.0"
		label.padding_left=$PADDINGS_SMALL
		label.padding_right=6
		padding_left=$PADDINGS_LARGE
		padding_right=$PADDINGS_LARGE
		update_freq=0
	)

	sketchybar --add item pkgs "$side" \
		--set pkgs "${pkgs[@]}"

}
