#!/bin/bash

ICON_VOL_OFF="/usr/share/icons/Adwaita/256x256/status/audio-volume-muted.png"
ICON_VOL_LOW="/usr/share/icons/Adwaita/256x256/status/audio-volume-low.png"
ICON_VOL_MEDIUM="/usr/share/icons/Adwaita/256x256/status/audio-volume-medium.png"
ICON_VOL_HIGH="/usr/share/icons/Adwaita/256x256/status/audio-volume-high.png"

# Input validation
if [ "$(echo "$1" | sed 's/[0-9][0-9]*[-+]//')" != "" ]; then
    exit
fi

# Extract sign
sign=$(echo "$1" | sed 's/[0-9]*\([-+]\)/\1/')

# Extract volume change (in %)
change=$(echo "$1" | sed 's/\([0-9]*\).*/\1/')

# Obtain the current volume (in %)
vol=$(amixer get Master | tail -1 | cut -d ' ' -f 6 | sed 's/\[\([0-9]*\)%\]/\1/')

# For Pulseaudio
#vol=$(amixer -D pulse get Master | tail -1 | cut -d ' ' -f 7 | sed 's/\[\([0-9]*\)%\]/\1/')

# Calculate the new volume depending on $sign and $change
if [ $sign = '+' ]; then
    # Increase the volume
    new_vol=$[$vol+$change]
else
    # Decrease the volume
    new_vol=$[$vol-$change]
fi

# If the new volume is too low or high
if [ $new_vol -gt 100 ]; then
    new_vol=100
elif [ $new_vol -lt 0 ]; then
    new_vol=0
fi

# Find the right icon for the new volume level
if [ $new_vol -le 0 ]; then
    # Volume off
    icon=$ICON_VOL_OFF
elif [ $new_vol -le 33 ]; then
    # Volume <= 33%
    icon=$ICON_VOL_LOW
elif [ $new_vol -le 66 ]; then
    # Volume <= 66%
    icon=$ICON_VOL_MEDIUM
else
    # Volume >= 67%
    icon=$ICON_VOL_HIGH
fi

# Change the volume
amixer sset Master $new_vol% &> /dev/null

# For Pulseaudio
#amixer -D pulse sset Master $new_vol% &> /dev/null

# Notification (Notify-OSD)
notify-send " " -i $icon -h int:value:$new_vol -h string:synchronous:volume


# TODO:
#   - Add mute/unmute feature
#   - Support other channels (PCM, etc)
