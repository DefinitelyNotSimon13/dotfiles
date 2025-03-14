#!/usr/bin/env bash

## Original Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
##
## Modified By: @DefinitelyNotSimon13
## Applets : Volume

# Import Current Theme
theme="$HOME/.config/rofi/config/applets.rasi"

# Volume Info
mixer="$(amixer info Master | grep 'Mixer name' | cut -d':' -f2 | tr -d \',' ')"
speaker="$(amixer get Master | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]')"
mic="$(amixer get Capture | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]')"

active=""
urgent=""

# Speaker Info
amixer get Master | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
	active="-a 1"
	stext='Unmute'
	sicon=''
else
	urgent="-u 1"
	stext='Mute'
	sicon=''
fi

# Microphone Info
amixer get Capture | grep '\[on\]' &>/dev/null
if [[ "$?" == 0 ]]; then
    [ -n "$active" ] && active+=",3" || active="-a 3"
	mtext='Unmute'
	micon=''
else
    [ -n "$urgent" ] && urgent+=",3" || urgent="-u 3"
	mtext='Mute'
	micon=''
fi

# Theme Elements
player="$(playerctl metadata --format \{\{playerName\}\})"
player="${player^}"
artist="$(playerctl metadata --format \{\{artist\}\})"
title="$(playerctl metadata --format \{\{title\}\})"
if [ "$player" == "Spotify" ];then
  player=""
else
  player="  $player:"
fi
prompt="$player $artist - $title"
prompt="${prompt:0:69}"
mesg="$mixer - Speaker: $speaker, Mic: $mic"

list_col='5'
list_row='1'
win_width='670px'

# Options
option_1=""
option_2="$sicon"
option_3=""
option_4="$micon"
option_5="󰴸"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		"${active}" "${urgent}" \
		-markup-rows \
		-theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		amixer -Mq set Master,0 5%+ unmute
	elif [[ "$1" == '--opt2' ]]; then
		amixer set Master toggle
	elif [[ "$1" == '--opt3' ]]; then
		amixer -Mq set Master,0 5%- unmute
	elif [[ "$1" == '--opt4' ]]; then
		amixer set Capture toggle
	elif [[ "$1" == '--opt5' ]]; then
		pavucontrol
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$option_1")
		run_cmd --opt1
        ;;
    "$option_2")
		run_cmd --opt2
        ;;
    "$option_3")
		run_cmd --opt3
        ;;
    "$option_4")
		run_cmd --opt4
        ;;
    "$option_5")
		run_cmd --opt5
        ;;
esac

