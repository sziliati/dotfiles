#!/bin/bash

# Check if VS Code is running
if pgrep -x "code" > /dev/null; then
    # Get the VS Code window's address
    WIN_ADDRESS=$(hyprctl clients -j | jq -r '.[] | select(.class == "code") | .address')

    # Focus the window if found
    if [ -n "$WIN_ADDRESS" ]; then
        hyprctl dispatch focuswindow address:$WIN_ADDRESS
    fi
else
    # Launch VS Code if not running
    code &
fi
