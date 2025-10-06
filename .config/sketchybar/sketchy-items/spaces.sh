#!/bin/bash

# --- Configuration ---
# Set the number of static space icons you want to see per display.
# Adjust this number if you typically use more or fewer spaces.
TOTAL_SPACES=7

# --- Script ---
# Destroy all existing space items before creating new ones
sketchybar --remove '/space\..*/'

# Get the index for all connected displays
# This command is built-in to macOS and has no dependencies.
for display in $(system_profiler SPDisplaysDataType | awk '/Resolution/{print i++}' i=1); do

	# For each display, create the configured number of space items
	for i in $(seq 1 $TOTAL_SPACES); do

		# The space ID ($sid) is based on an internal macOS index that starts at 1.
		# We can't know the exact ID without a window manager, but for setups with
		# few spaces, a simple 1-to-1 mapping often works for highlighting.
		sid=$i

		space=(
			associated_space=$sid
			associated_display=$display # <--- This is the crucial line for multi-monitor support
			icon=$sid
			icon.padding_left=6
			icon.padding_right=7
			icon.color=$NOTICE
			label.drawing=off
			background.color=$HIGH_MED
			background.height=$(($BAR_HEIGHT - 12))
			background.corner_radius=7
			background.drawing=off
			script="$RELPATH/plugins/spaces/script.sh" # This script handles highlighting the active space
		)

		# Create a unique name for each space on each display
		sketchybar --add space space.$display.$sid left \
			--set space.$display.$sid "${space[@]}"
	done
done

# --- Bracketing and Styling ---
# This groups all the space items together for a common background.
sketchybar --add bracket spaces '/space\..*/' \
	--set spaces "${zones[@]}"
