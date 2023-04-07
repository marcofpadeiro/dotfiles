#!/bin/bash

# Simple script to modify screen brightness
# USAGE:
# brightness.sh +20 (Increase brightness by 20%)

basedir="/sys/class/backlight/amdgpu_bl0"

# current brightness
old_brightness=$(cat $basedir"/brightness")

# max brightness
max_brightness=$(cat $basedir"/max_brightness")

# new brightness 
new_brightness=$(($old_brightness $1 17))

# set the new brightness value
echo $new_brightness > $basedir"/brightness"
