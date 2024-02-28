#!/bin/bash

CACHE_PATH="$HOME/.cache/compile_nvim"
mode="$1"
path="$2"

if [ ! -e "$CACHE_PATH" ]; then
    touch "$CACHE_PATH"
fi

if [ -z "$mode" ] || [ -z "$path" ]; then
    echo "Usage: $0 <mode> <path>"
    exit 1
fi

if [ "$mode" != "compile" ] && [ "$mode" != "edit" ]; then
    echo -e "Invalid mode: $mode\n"
    echo "Valid modes:"
    echo -e "\tcompile"
    echo -e "\tedit"
    exit 1
fi


if [ "$mode" == "compile" ]; then
    exists=0

    while IFS= read -r line; do
        file_path=$(echo "$line" | awk -F':' '{print $1}')

        if [ "$file_path" = "$path" ]; then
            exists=1
            command=$(echo "$line" | awk -F':' '{print $2}')
            echo -e "Running: \"$command\"...\n"
            $command
            break
        fi
    done < "$CACHE_PATH"

    if [ $exists -eq 0 ]; then
        echo "No command found for: $path"
    fi
    echo ""

    read -p "Press enter to exit..."
    exit 1
fi

if [ "$mode" == "edit" ]; then 
    if [ -z "$EDITOR" ]; then
        echo "EDITOR environment variable is not set"
        exit 1
    fi

    temp_file=$(mktemp)
    exists=0

    while IFS= read -r line; do
        file_path=$(echo "$line" | awk -F':' '{print $1}')

        if [ "$file_path" = "$path" ]; then
            exists=1
            old=$(echo "$line" | awk -F':' '{print $2}')
            echo "$old" > "$temp_file"
            break
        fi
    done < "$CACHE_PATH"

    $EDITOR "$temp_file"

    new_content=$(cat "$temp_file")

    if [ $exists -eq 0 ]; then
        echo "$path:$new_content" >> "$CACHE_PATH"
    else
        fixed=$(echo "$path:$new_content" | sed 's/[&/]/\\&/g')
        sed -i "s|$line|$fixed|" "$CACHE_PATH"
    fi

    if [ "$new_content" = "" ]; then
        escaped_path=$(echo "$path" | sed 's/[&/]/\\&/g')
        sed -i "/$escaped_path:/d" "$CACHE_PATH"
    fi


    rm "$temp_file"
    exit 0
fi
