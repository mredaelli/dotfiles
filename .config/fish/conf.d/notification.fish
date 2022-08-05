function fish_right_prompt
    if test $CMD_DURATION
        # if test (xdotool getactivewindow) -ne $WINDOWID
            if test $CMD_DURATION -gt 30000
                set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
                notify-send (echo (history | head -1) returned $status after $duration)
            end
        # end
    end
end
