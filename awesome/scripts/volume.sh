#!/bin/bash
[ $1 == "up" ] && pactl set-sink-volume @DEFAULT_SINK@ +5%
[ $1 == "down" ] && pactl set-sink-volume @DEFAULT_SINK@ -5%
[ $1 == "mute" ] && pactl set-sink-mute @DEFAULT_SINK@ toggle
echo $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print$12}')
