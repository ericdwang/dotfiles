#!/bin/sh

sh ~/.xprofile

# Better font rendering
xrdb -merge ~/.Xresources

# Automount removable media
devmon &

# Launch i3
exec dbus-launch --exit-with-session i3
