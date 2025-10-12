#!/usr/bin/env bash

# ==============================================================================
# CPU WIDGET SETUP FUNCTION
# ==============================================================================
add_cpu_item() {
	# This path assumes your sketchybarrc is in ~/.config/sketchybar/
	local parent_dir="$(cd "$(dirname "$0")" && pwd)"
	local plugin_script="$parent_dir/plugins/graph/script.sh"
	local side="${1:-right}"

	# Set update frequency, allowing for an override from your config.
	: "${CPU_UPDATE_FREQ:=2}"

	sketchybar --add graph cpu.graph "$side" 100 \
		--set cpu.graph background.color=$(get_color BACKGROUND) \
		background.height=34 \
		graph.color=$(get_color FOREGROUND) \
		\
		--add item cpu.percent "$side" \
		--set cpu.percent script="$plugin_script" \
		update_freq=$CPU_UPDATE_FREQ \
		icon=􀧓 \
		icon.padding_right=10 \
		icon.background.height=34 \
		icon.background.corner_radius=12 \
		icon.background.color=$(get_color BACKGROUND) \
		label.font="$FONT:Bold:14.0" \
		label.width=55 \
		label.align=left \
		label.background.color=$(get_color BACKGROUND) \
		label.background.height=34 \
		label.background.corner_radius=12
}
