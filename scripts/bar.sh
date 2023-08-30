#!/bin/bash
## Network
network() {
  local ssid=$(nmcli -t -f active,ssid dev wifi | rg '^yes' | cut -d':' -f2)
  if [ -n "$ssid" ]; then
    echo "$ssid 󰤨"
  else
    echo "Disconnected 󰤭"
  fi
}

# Main loop
while true; do

  # Network
  network=$(network)

  # Time
  time=$(date +%R)

  # Battery status
  battery=$(acpi -b | awk '/Battery 0/ {print $4}' | tr -d '%,')
  if [ -z "$battery" ]; then
      battery_emoji="󰂄"
  else
    if [ $(echo "$battery < 20" | bc) -ne 0 ]; then
      battery_emoji="󰁺"
    elif [ $(echo "$battery < 50" | bc) -ne 0 ]; then
      battery_emoji="󰁾"
    else
      battery_emoji="󰁹"
    fi
    battery="$battery% $battery_emoji"
  fi

  # Set the bar using xsetroot
  xsetroot -name "$network | $battery | $time "

  sleep 60
done
