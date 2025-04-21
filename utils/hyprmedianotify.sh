#!/bin/sh
notify_id_filepath="/tmp/notify_id"

function require()
{
	command -v $1 >/dev/null 2>&1 || { echo >&2 "I require '$1' but it's not installed.  Aborting."; exit 1; }
}
require wpctl
require brightnessctl
require notify-send
function get_icon()
{
	if [ $1 -eq 1 ]; then
		[ $2 -eq 1 ] && echo "/usr/share/icons/breeze-dark/status/24/audio-volume-muted.svg" || echo "/usr/share/icons/breeze-dark/status/24/audio-volume-high.svg"
	fi
	if [ $1 -eq 2 ]; then
		[ $2 -eq 1 ] && echo "/usr/share/icons/breeze-dark/status/24/mic-off.svg" || echo "/usr/share/icons/breeze-dark/status/24/mic-on.svg"
	fi
	if [ $1 -eq 3 ]; then
		[ $2 -eq 1 ] && echo "/usr/share/icons/breeze-dark/actions/24/brightness-low.svg" || echo "/usr/share/icons/breeze-dark/actions/24/brightness-high.svg"
	fi

}
function notify_static()
{
	#echo $1
	[ -f "$notify_id_filepath" ] && notify_id=$(< "$notify_id_filepath")
	[ -z "$notify_id" ] && notify_id="0"
	#echo $notify_id
	icon=$(get_icon $2 $3)
	#echo $icon
	notify-send -i $icon -u low -r $notify_id -t 1000 --print-id -a hyprmedianotify -h int:value:${1%%} "$1" > $notify_id_filepath
}
function get_device_volume()
{
	wpctl_vol=$(wpctl get-volume $1)
	[[ "$wpctl_vol" =~ ([0-9]).([0-9]+) ]] && echo $(("10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}")) || echo "0"
}
function get_device_mute()
{
	wpctl_vol=$(wpctl get-volume $1)
	[[ "$wpctl_vol" =~ \[MUTED\] ]] && echo "1" || echo "0"
}
function get_brightness()
{
	bri=$(brightnessctl i -m)
	tmp_arr=(${bri//,/ })
	echo ${tmp_arr[3]}
}
function set_volume()
{
	wpctl set-volume $1 -l 1 $2
	vol=$(get_device_volume $1)
	mute=$(get_device_mute $1)
	notify_static "$vol%" $3 $mute
}
function toggle_mute()
{
	wpctl set-mute $1 toggle
	vol=$(get_device_volume $1)
	mute=$(get_device_mute $1)
	notify_static "$vol%" $3 $mute
}
function set_brightness()
{
	bri=$(brightnessctl s $1 -m)
	tmp_arr=(${bri//,/ })
	notify_static ${tmp_arr[3]} 3 0
	#bri=$(get_brightness)
	#
}

val=""
if [[ "$2" =~ ([0-9]+)%([+-])? ]]; then
#	echo ${BASH_REMATCH[@]}
	val="${BASH_REMATCH[1]}%${BASH_REMATCH[2]}"
	#echo $val
elif [ "$2" = "mute" ]; then
	val="mute"
else
	exit 1
fi


if [ "$1" = "sink" ] || [ "$1" = "source" ]; then
	#set_volume $1

	if [ "$1" = "sink" ]; then
		device="@DEFAULT_AUDIO_SINK@"
		devtype=1
	else
		device="@DEFAULT_AUDIO_SOURCE@"
		devtype=2
	fi
	[ "$val" = "mute" ] && toggle_mute $device $val $devtype ||	set_volume $device $val $devtype

elif [ "$1" = "brightness" ]; then
	set_brightness $val
else
	exit 1
fi
