#!/bin/sh

# Run user profile shell script
profile="$HOME/.profile"
if [ -d "$profile" ]; then
    . "$profile"
fi

# Enable media keys
xbindkeys & 

# Restore the wallpaper
~/.fehbg &

# Start nice graphic effects
picom -F &

