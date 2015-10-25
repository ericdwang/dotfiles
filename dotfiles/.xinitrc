#!/bin/sh

# Map caps lock to escape when tapped and to control when held
setxkbmap -option ctrl:nocaps
xcape

# Better font rendering
xrdb -merge ~/.Xresources

# Prevent the screen from going blank
xset s off
xset -dpms
xset noblank

# Disable tap to click
synclient MaxTapTime=0

# Disable touchpad for one second after typing
syndaemon -i 1 -tkd

# Credential manager
export $(gnome-keyring-daemon -s)

# Automount removable media
devmon &

# Launch i3
exec dbus-launch --exit-with-session i3
