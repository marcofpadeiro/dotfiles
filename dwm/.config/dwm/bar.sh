#!/bin/bash
get_wifi() {
    read ssid signal <<<$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | awk -F: '/^yes:/ {print $2, $3}')

    if [[ -z "$ssid" ]]; then
        echo "󰤭 Disconnected" 
    else
        if (( signal >= 75 )); then
            icon="󰤨"
        elif (( signal >= 50 )); then
            icon="󰤥"
        elif (( signal >= 25 )); then
            icon="󰤢"
        elif (( signal >= 10 )); then
            icon="󰤟"
        else
            icon="󰤯"
        fi
        echo "$icon $ssid"
    fi
}

get_date() {
    date +"%d %b %R"
}

get_brightness() {
    bright=$(brightnessctl | grep "Current brightness" | cut -d '(' -f 2 | cut -d ')' -f 1)
    echo " $bright"
}

get_cpu_usage() {
    cpu=$(mpstat 1 1 | awk '/Average/ {printf "%.0f%%", 100 - $NF}')
    echo " $cpu"
}

get_temperature() {
    temperature=$(sensors | grep CPU | cut -d '+' -f 2 | tr -d ' ')
    echo " $temperature"
}

get_battery() {
    percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    power_draw=$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/power_now) / 1000000" | bc)
    status=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$status" = "Charging" ]; then
        icon="" 
        echo "$icon $percentage%"
    else
        if [ "$percentage" -ge 90 ]; then
            icon="" 
        elif [ "$percentage" -ge 70 ]; then
            icon=""
        elif [ "$percentage" -ge 40 ]; then
            icon=""
        elif [ "$percentage" -ge 10 ]; then
            icon=""
        else
            icon=""
        fi
        echo "$icon $percentage% ($power_draw W)"
    fi

}

get_memory() {
    used_ram=$(free -h | grep Mem | tr -s ' ' | cut -d ' ' -f 3)
    echo " $used_ram"
}

xsetroot -name "$(get_wifi) | $(get_temperature) | $(get_brightness) | $(get_cpu_usage) | $(get_memory) | $(get_battery) | $(get_date)"
