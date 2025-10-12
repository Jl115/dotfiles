#!/bin/bash
# Dependencies:
# - jq: for parsing JSON (brew install jq)
# - macmon: for system power metrics (https://github.com/momeni/macmon)

# Source your color variables
source "$HOME/.config/sketchybar/colors.sh"

### Fetch system data
# Get total CPU usage (user + system) from top
TOTAL_CPU_USAGE=$(top -l 1 | grep -E "^CPU" | tail -1 | awk '{print $3 + $5}' | sed 's/%//')

# Get top process info (CPU %, PID, Name)
TOP_PROCESS_PROBE="$(ps -Aceo pcpu,pid,comm -r | sed -n '2p')"
TOP_PROCESS_PERCENT=$(echo "$TOP_PROCESS_PROBE" | awk '{print $1}')
TOP_PROCESS_PID=$(echo "$TOP_PROCESS_PROBE" | awk '{print $2}')
TOP_PROCESS_NAME=$(echo "$TOP_PROCESS_PROBE" | awk '{print $3}')

# Get system power usage from macmon (if available)
SYSTEM_POWER_W=""
if command -v macmon &>/dev/null; then
	SYSTEM_POWER_W=" | $(macmon pipe -s 1 -i 1 | jq -r .sys_power)W"
fi

### Format the labels
PERCENT_LABEL="$(printf "%.0f" "$TOTAL_CPU_USAGE")%"
TOP_PROCESS_LABEL="$TOP_PROCESS_NAME ($TOP_PROCESS_PID)$SYSTEM_POWER_W"

### Calculate graph point (a value between 0.0 and 1.0)
GRAPH_POINT=$(echo "scale=2; $TOTAL_CPU_USAGE / 100" | bc)

### Determine graph color based on total CPU load
case $(printf "%.0f" "$TOTAL_CPU_USAGE") in
[8-9][0-9] | 100)
	GRAPH_COLOR=$(get_color RED 100)
	;;
[6-7][0-9])
	GRAPH_COLOR=$(get_color PEACH 100)
	;;
[3-5][0-9])
	GRAPH_COLOR=$(get_color ROSEWATER 100)
	;;
*) GRAPH_COLOR=$(get_color BLUE 100) ;;
esac

### Update all the sketchybar items in one go
sketchybar --set cpu.percent label="$PERCENT_LABEL" \
	--set cpu.graph graph.color="$GRAPH_COLOR" \
	--push cpu.graph "$GRAPH_POINT"
