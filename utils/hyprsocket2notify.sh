#!/bin/sh
# Check if required environment variables are set
if [ -z "$XDG_RUNTIME_DIR" ] || [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    notify-send "Error" "Required environment variables not set for keyboard layout watcher"
    exit 1
fi
function require()
{
	command -v $1 >/dev/null 2>&1 || { echo >&2 "I require '$1' but it's not installed.  Aborting."; exit 1; }
}
require notify-send

notify_id_filepath="/tmp/notify_id"
function notify_static()
{
	[ -f "$notify_id_filepath" ] && notify_id=$(< "$notify_id_filepath")
	[ -z "$notify_id" ] && notify_id="0"
	icon="/usr/share/icons/breeze-dark/status/24/keyboard-layout.svg"
	notify-send -i $icon -u low -r $notify_id -t 1000 --print-id -a hyprsocket2notify -h string:type:keyboardlayoutchange "$1" > $notify_id_filepath
}
function handle()
{
	if [ "${1:0:12}" = "activelayout" ]; then
		notify_static "${1##*,}"
	fi
}
#kb_name=$(hyprctl devices -j | jq '.keyboards[] | select(.main) | .name')

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
