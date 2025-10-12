#!/usr/bin/env bash

SCRIPT_FRONT_APP="export PATH=$PATH; $HOME/.config/sketchybar/plugins/app/script.sh"

SCRIPT_CLICK_FRONT_APP="export PATH=$PATH; yabai -m window --toggle float"

add_app_item() {
	local side="${1:-left}"

	app=(
		background.color=$(get_color BACKGROUND 100)
		background.height=$(($BAR_HEIGHT - 12))
		background.corner_radius=7
		label.color=$(get_color FOREGROUND 100)
		label.font="$FONT:Black:14.0"
		padding_left=5
		icon=􀢌
		icon.font="sketchybar-app-font:Regular:24.0"
		icon.color=$(get_color LAVENDER 100)
		script="$SCRIPT_FRONT_APP"
		click_script="$SCRIPT_CLICK_FRONT_APP"
	)

	sketchybar --add item "app" "$side" \
		--set "app" \
		--set app "${app[@]}" \
		--subscribe app system_woke front_app_switched
}
