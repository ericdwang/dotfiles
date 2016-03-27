# -*- coding: utf-8 -*-

from i3pystatus import Status
from i3pystatus.updates.cower import Cower
from i3pystatus.updates.pacman import Pacman


# Hex color codes
GRAY = '#909090'
GREEN = '#00FF00'
WHITE = '#FFFFFF'

status = Status(click_events=False)


# Register modules from right to left

status.register(
    'clock',
    format='🕑 %a %b %d %I:%M%p',
)

status.register(
    'battery',
    format='⚡ {percentage:.0f}% ({remaining:%E%h:%M})',
    alert=True,
    alert_percentage=5,
)

status.register(
    'network',
    format_up='📶 {essid} ({quality:.0f}%)',
    dynamic_color=True,
    interface='wlp4s0',
)

status.register(
    'temp',
    format='{temp:.0f}°C',
    color=GREEN,
    file='/sys/class/thermal/thermal_zone1/temp',
    alert_temp=55,
)

status.register(
    'mem',
    format='M {percent_used_mem}%',
    warn_percentage=40,
)

status.register(
    'pulseaudio',
    format='🔉 {volume}%',
    multi_colors=True,
    color_muted=GRAY,
)

status.register(
    'backlight',
    format='☀ {percentage:.0f}%',
    backlight='intel_backlight',
)

status.register(
    'updates',
    format='🔃 {Pacman},{Cower}',
    format_no_updates='🔃 0,0',
    format_working='🔃 Updating',
    color_no_updates=GRAY,
    color_working=WHITE,
    backends=[Pacman(), Cower()],
)

status.register(
    'cmus',
    format='{status} {song_elapsed}/{song_length} {title} ({album})',
    format_not_running='⏯',
    color=GRAY,
    color_not_running=GRAY,
)

status.run()
