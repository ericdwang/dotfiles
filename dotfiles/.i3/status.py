# -*- coding: utf-8 -*-

import logging
import os

from i3pystatus import Status
from i3pystatus.updates.aptget import AptGet


# Hex color codes
GRAY = '#909090'
GREEN = '#00FF00'
WHITE = '#FFFFFF'

status = Status(standalone=True)


def register(module, **kwargs):
    """Register a module with no logging."""
    status.register(module, log_level=logging.NOTSET, **kwargs)


# Register modules from right to left

register(
    'clock',
    format='🕑 %a %b %d %I:%M%p',
)

register(
    'battery',
    format='⚡ {percentage:.0f}% ({remaining:%E%h:%M})',
    alert=True,
    alert_percentage=5,
)

register(
    'network',
    format_up='📶 {essid} ({quality:.0f}%)',
    dynamic_color=True,
    interface='wlan0',
)

register(
    'temp',
    format='{temp:.0f}°C',
    color=GREEN,
    file='/sys/class/thermal/thermal_zone1/temp',
    alert_temp=55,
)

register(
    'mem',
    format='M {percent_used_mem}%',
    warn_percentage=40,
)

register(
    'updates',
    format='🔃 {count}',
    format_no_updates='🔃 0',
    format_working='🔃 Updating',
    color_no_updates=GRAY,
    color_working=WHITE,
    backends=AptGet(),
)

register(
    'pulseaudio',
    format='🔉 {volume}%',
    multi_colors=True,
    color_muted=GRAY,
)

register(
    'backlight',
    format='☀ {percentage:.0f}%',
    backlight='intel_backlight',
)

register(
    'weather',
    location_code=os.environ['I3_LOCATION_CODE'],
    units='imperial',
    colorize=True,
    interval=60 * 5,
)

register(
    'cmus',
    format='{status} {song_elapsed}/{song_length} {title} ({album})',
    format_not_running='⏯',
    color=GRAY,
    color_not_running=GRAY,
)

status.run()
