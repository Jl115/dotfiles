#!/usr/bin/env sh

# Font definitions
FONT="JetBrainsMono Nerd Font Mono"
NERD_FONT="JetBrainsMono Nerd Font Mono"

colors=(
    # ---------------------------------------------
    # Catppuccin Mocha Palette (from your kitty.conf)
    # ---------------------------------------------

    # Core Colors
    BACKGROUND=0xff1E1E2E      # background
    FOREGROUND=0xffCDD6F4      # foreground / text
    TRANSPARENT=0x00000000

    # Accents & UI Elements
    LAVENDER=0xffB4BEFE       # active_border_color
    ROSEWATER=0xffF5E0DC      # selection_background / cursor
    MAUVE=0xffCBA6F7          # active_tab_background
    SAPPHIRE=0xff74C7EC       # mark3_background

    # Terminal Colors (ANSI)
    BLACK=0xff45475A          # color0
    GREY=0xffA6ADC8           # color15
    WHITE=0xffCDD6F4          # foreground / color7 in some contexts
    RED=0xffF38BA8            # color1
    GREEN=0xffA6E3A1          # color2
    YELLOW=0xffF9E2AF         # color3
    BLUE=0xff89B4FA           # color4
    MAGENTA=0xffF5C2E7        # color5
    CYAN=0xff94E2D5           # color6
    PEACH=0xffFAB387          # (Orange tone from the full palette)
    ASH=0xff45475A
    LIME=0xffF9E2AF
    PURPLE=0xffCBA6F7
    SKY=0xff74C7EC
    ORANGE=0xffFAB387
    TEXT=0xffCDD6F4
)

get_color() {
    local COLOR="$1"
    local OPACITY="${2:-}"     # optional, if omitted return full color

    # find the color value
    local val=""
    for entry in "${colors[@]}"; do
        IFS='=' read -r name value <<< "$entry"
        if [ "$name" = "$COLOR" ]; then
            val="$value"
            break
        fi
    done

    if [ -z "$val" ]; then
        echo "Color $COLOR not found" >&2
        return 1
    fi

    # If no opacity specified, return the full color
    if [ -z "$OPACITY" ]; then
        echo "$val"
        return 0
    fi

    local hexdec=$(( (OPACITY * 255 + 50) / 100 ))
    # Format to two uppercase hex digits
    local hex="${hexdec#0x}"   # not strictly needed, just to be safe
    printf -v hex "%02X" "$hexdec"

    # val is "0xAARRGGBB", so we extract "RRGGBB"
    local rgb="${val:4}"

    # Construct new color with opacity
    echo "0x${hex}${rgb}"
}
