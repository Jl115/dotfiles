#!/usr/bin/env bash
#
# Fast SketchyBar App Menu with Submenu Support
# Dynamically loads menus via AppleScript for speed.

set -euo pipefail

CMD="${1:-toggle}"
MENU_PATH="${2:-}"
PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"

# ----------------------------------------------------------------------
# Utility: Clear all menu items
# ----------------------------------------------------------------------
clear_menu() {
	sketchybar --query menu 2>/dev/null | jq -r '.popup.items[]?' |
		while read -r item; do
			[ -n "$item" ] && sketchybar --remove "$item" 2>/dev/null || true
		done
}

# ----------------------------------------------------------------------
# Command Dispatcher
# ----------------------------------------------------------------------
case "$CMD" in
# ----------------------------------------------------------------------
# TOGGLE MENU VISIBILITY
# ----------------------------------------------------------------------
toggle)
	STATE=$(sketchybar --query menu 2>/dev/null | jq -r '.popup.drawing')

	if [ "$STATE" = "on" ]; then
		sketchybar --set menu popup.drawing=off
		clear_menu
	else
		sketchybar --set menu popup.drawing=on
		"$0" load_top
	fi
	;;

# ----------------------------------------------------------------------
# LOAD TOP-LEVEL MENU BAR ITEMS
# ----------------------------------------------------------------------
load_top)
	clear_menu

	APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true')

	MENUS=$(
		osascript <<EOF
tell application "System Events"
	tell process "$APP"
		set resultList to {}
		set idx to 0
		repeat with mb in menu bar items of menu bar 1
			try
				set nameStr to name of mb
				set hasSub to (exists menu 1 of mb)
				set end of resultList to nameStr & "|" & idx & "|" & (hasSub as string)
			end try
			set idx to idx + 1
		end repeat
		return resultList
	end tell
end tell
EOF
	)

	i=0
	echo "$MENUS" | tr ',' '\n' | while read -r entry; do
		IFS='|' read -r name idx has_sub <<<"$(echo "$entry" | tr -d ' "')"
		[ -z "$name" ] || [ "$name" = "missing" ] && continue

		if [[ "$has_sub" == "true" ]]; then
			label="$name ▸"
			click="$PLUGIN_DIR/sketchymenu/app_menu.sh load_sub '$idx'"
		else
			label="$name"
			click="echo 'Execute: $name'"
		fi

		sketchybar --add item "menu.item.$i" popup.menu \
			--set "menu.item.$i" label="$label" icon.drawing=off click_script="$click"

		((i++))
	done
	;;

# ----------------------------------------------------------------------
# LOAD SUBMENU ITEMS
# ----------------------------------------------------------------------
load_sub)
	[ -z "$MENU_PATH" ] && exit 0
	clear_menu

	sketchybar --add item "menu.item.back" popup.menu \
		--set "menu.item.back" label="‹ Back" icon.drawing=off \
		click_script="$PLUGIN_DIR/sketchymenu/app_menu.sh load_top"

	sketchybar --add item "menu.item.sep" popup.menu \
		--set "menu.item.sep" label="────────" icon.drawing=off

	APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true')
	MENU_INDEX=$((MENU_PATH + 1))

	ITEMS=$(
		osascript <<EOF
tell application "System Events"
	tell process "$APP"
		try
			set itemList to {}
			set menuBarItem to menu bar item $MENU_INDEX of menu bar 1
			repeat with mi in menu items of menu 1 of menuBarItem
				try
					set nm to name of mi
					set en to enabled of mi
					if nm is missing value then
						set end of itemList to "---"
					else if en then
						set end of itemList to nm
					else
						set end of itemList to "[" & nm & "]"
					end if
				end try
			end repeat
			return itemList
		on error
			return {}
		end try
	end tell
end tell
EOF
	)

	i=2
	echo "$ITEMS" | tr ',' '\n' | while read -r item; do
		item=$(echo "$item" | tr -d '"' | xargs)
		[ -z "$item" ] && continue

		case "$item" in
		"---")
			sketchybar --add item "menu.sub.$i" popup.menu \
				--set "menu.sub.$i" label="────────" icon.drawing=off
			;;
		\[*\])
			label="${item:1:-1}"
			sketchybar --add item "menu.sub.$i" popup.menu \
				--set "menu.sub.$i" label="$label" label.color=0xff888888 icon.drawing=off
			;;
		*)
			sketchybar --add item "menu.sub.$i" popup.menu \
				--set "menu.sub.$i" label="$item" icon.drawing=off \
				click_script="$PLUGIN_DIR/sketchymenu/click_menu_item.applescript '$APP' '$MENU_PATH/$((i - 2))' && sketchybar --set menu popup.drawing=off"
			;;
		esac

		((i++))
		[ "$i" -gt 30 ] && break
	done
	;;
esac
