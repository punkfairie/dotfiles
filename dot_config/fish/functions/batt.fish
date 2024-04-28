#!/usr/bin/env fish

function batt -d "Check battery percentage"
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
        | grep -E "state|time to|percentage"
end
