#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

get_public_ip() {
	local ip
	for service in "icanhazip.com" "ifconfig.me" "ipinfo.io/ip"; do
		ip=$(curl -s --max-time 5 "$service")
		# Check if the result is a valid IP address
		if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
			echo "$ip"
			return 0
		fi
	done
	return 1
}

IP=$(get_public_ip)
IS_IP=$IP # If the function succeeded, IP will be the IP address
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')
PADDING_RIGHT=-6

# determine default interface normally
iface=$(route get default 2>/dev/null | awk '/interface:/ {print $2}')
[ -z "$iface" ] && iface=$(netstat -rn | awk '/^default/ {print $NF; exit}')

# If using a VPN, find the underlying physical interface
if printf '%s\n' "$iface" | grep -Eq '^(utun|ppp|tun)'; then
	sc_line=$(scutil --nwi 2>/dev/null | awk -F': ' '/Network interfaces:/ {print $2; exit}')
	if [ -n "$sc_line" ]; then
		for cand in $sc_line; do
			case "$cand" in
			lo0 | utun* | vboxnet* | vmnet* | bridge* | awdl0 | llw0 | vmenet*) continue ;;
			esac
			if scutil --nwi 2>/dev/null | awk -v IF="$cand" '
          BEGIN{found=0}
          $1==IF && $0 ~ /address/ {found=1; exit}
          END{if(found) exit 0; else exit 1}
        '; then
				phys_iface="$cand"
				break
			fi
		done
	fi

	if [ -z "${phys_iface:-}" ]; then
		phys_iface=$(networksetup -listallhardwareports 2>/dev/null | awk '
      $0 ~ "Hardware Port:" { hp=$0 }
      $0 ~ "Device:" { if ($2 !~ /^utun|^lo|^bridge|^ap|^awdl|^llw|^vmenet/) {
          if (!seen[$2]++) { print $2 }
        }
      }' | head -1)
	fi

	if [ -n "${phys_iface:-}" ]; then
		iface="$phys_iface"
	fi
fi

hwport=$(networksetup -listallhardwareports 2>/dev/null | awk -v IF="$iface" '
  $0 ~ "Hardware Port:" { hp=$0 }
  $0 ~ "Device:" && $2 == IF { print hp }
' | sed 's/Hardware Port: //')

media=$(ifconfig "$iface" 2>/dev/null | awk '/media:/{print tolower($0); exit}')

IS_WIRED=0
if printf '%s\n' "$hwport" "$media" | grep -Eiq 'lan|ether|ethernet|base(-| )?t|[[:digit:]]+base'; then
	IS_WIRED=1
fi

if [[ -n "$IS_VPN" && -n "$IS_IP" ]]; then
	if [[ $IS_WIRED -eq 1 ]]; then
		ICON="" # VPN + Wired
	else
		ICON="" # VPN + WiFi
	fi
	BG_COLOR="$(get_color FOREGROUND 100)"
	PADDING_RIGHT=-8
	LABEL="($IP)"
elif [[ -n "$IS_IP" ]]; then
	if [[ $IS_WIRED -eq 1 ]]; then
		ICON="" # Wired
	else
		ICON="" # WiFi
	fi
	BG_COLOR="$(get_color FOREGROUND 100)"
	LABEL="$IP"
else
	BG_COLOR="$(get_color FOREGROUND 100)"
	PADDING_RIGHT=-8
	ICON="" # Error/No Connection
	LABEL="Not Connected"
fi

sketchybar --set "$NAME" \
	label="$LABEL" \
	icon="$ICON" \
	icon.padding_right=$PADDING_RIGHT \
	background.color="$(get_color BACKGROUND 100)" \
	background.drawing=on \
	icon.drawing=on \
	icon.color="$(get_color FOREGROUND 100)"
