charging_status=$(cat /sys/class/power_supply/BAT0/status)
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
power_draw=$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/power_now) / 1000000" | bc)
date=$(date +'%Y-%m-%d %X')
lang=$(swaymsg -t get_inputs | jq 'map(select(has("xkb_active_layout_name")))[1].xkb_active_layout_name')

charging_icon=""
if [ "$lang" = '"Portuguese"' ]; then
    lang="pt"
else
    lang="en"
fi

if [ "$charging_status" = "Charging" ]; then
    charging_icon=""
fi

echo "$charging_icon $battery_percentage% (${power_draw}W) | $lang | $date"
