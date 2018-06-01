#!/bin/sh

source ~/.xprofile

# Better font rendering
xrdb ~/.Xresources

# Import DISPLAY variable for dunst and Redshift
systemctl --user import-environment DISPLAY

# Launch i3
exec i3
