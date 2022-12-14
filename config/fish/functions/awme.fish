#!/usr/bin/env fish

set SCREEN_OFF_TIMER 10
set BLUR_TYPE 0x6
set SCREENSHOT_TEMP_PATH $XDG_RUNTIME_DIR/awesomeexit.png

function _awme_lock
    maim $SCREENSHOT_TEMP_PATH
    convert $SCREENSHOT_TEMP_PATH -blur $BLUR_TYPE $SCREENSHOT_TEMP_PATH
    xset s $SCREEN_OFF_TIMER
    i3lock -n -u -i $SCREENSHOT_TEMP_PATH
end

function _awme_logout
    awesome-client "awesome.quit()" > /dev/null 2>&1 or true
end

function _awesome_reload
    awesome-client "awesome.restart()" > /dev/null 2>&1 or true
end

function _awme_reboot
    systemctl reboot
end

function _awme_poweroff
    systemctl poweroff
end

function _awme_print_args
    echo "Usage: awme <lock|logout|reload|reboot|poweroff>"
end

function _awme_cleanup
    xset s 600 600
    rm $SCREENSHOT_TEMP_PATH > /dev/null 2>&1 or true
end

function awme --description "Simple session management for awesomewm"
    set -l cmd $argv[1]

    switch $cmd
        case lock logout reload reboot poweroff
            _awme_$cmd $argv[2..-1]
        case '*'
            _awme_print_args
            return 1
    end
    _awme_cleanup
end
