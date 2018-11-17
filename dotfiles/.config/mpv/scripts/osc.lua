-- Show OSC when paused and hide when playing
mp.observe_property('pause', 'bool', function(name, value)
    mp.commandv(
        'script-message',
        'osc-visibility',
        value and 'always' or 'auto',
        'no-osd'
    )
end)
