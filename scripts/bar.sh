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
  battery_level=$(acpi -b | awk '/Battery 0/ {print $4}' | tr -d '%,')
  battery_status=$(acpi -b | awk '/Battery 0/ {print $3}' | tr -d ',')

  if [ "$battery_status" = "Charging" ]; then
      battery_emoji="󰂄"
  else
    case $battery_level in
        [0-9]|10)
            battery_emoji="󰁺"
            ;;
        [11-19]|20)
            battery_emoji="󰁻"
            ;;
        [21-29]|30)
            battery_emoji="󰁼"
            ;;
        [31-39]|40)
            battery_emoji="󰁽"
            ;;
        [41-49]|50)
            battery_emoji="󰁾"
            ;;
        [51-59]|60)
            battery_emoji="󰁿"
            ;;
        [61-69]|70)
            battery_emoji="󰂀"
            ;;
        [71-79]|80)
            battery_emoji="󰂁"
            ;;
        [81-89]|90)
            battery_emoji="󰂂"
            ;;
        [91-99]|100)
            battery_emoji="󰁹"
            ;;
    esac
  fi

  battery="$battery_level% $battery_emoji"


  # Set the bar using xsetroot
  xsetroot -name "$network | $battery | $time "

  sleep 10
done
