#!/bin/bash

get_date() {
    date +"%d %b %R"
}

get_cpu_usage() {
    cpu=$(mpstat 1 1 | awk '/Average/ {printf "%.0f%%", 100 - $NF}')
    echo " $cpu"
}



get_memory() {
    used_ram=$(free -h | grep Mem | tr -s ' ' | cut -d ' ' -f 3)
    echo " $used_ram"
}

xsetroot -name "$(get_cpu_usage) | $(get_memory) | $(get_date)"
