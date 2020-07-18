#!/bin/sh

# Better font rendering
xrdb ~/.Xresources

# Import DISPLAY variable for dunst and Redshift
systemctl --user import-environment DISPLAY

# Set wallpaper
sh ~/.fehbg

# Launch i3
exec i3
