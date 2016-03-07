#!/bin/sh

source ~/.xprofile

# Better font rendering
xrdb ~/.Xresources

# Launch i3
exec dbus-launch --exit-with-session i3
