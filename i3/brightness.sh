#!/bin/bash

# Simple script to modify screen brightness
# USAGE:
# brightness.sh +20 (Increase brightness by 20%)

basedir="/sys/class/backlight/intel_backlight"

# current brightness
old_brightness=$(cat $basedir"/brightness")

# max brightness
max_brightness=$(cat $basedir"/max_brightness")

# new brightness 
new_brightness=$(($old_brightness $1 (20 * $max_brightness / 100)))

# set the new brightness value
echo $new_brightness > $basedir"/brightness"
