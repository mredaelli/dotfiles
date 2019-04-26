#!/bin/sh -e

TMP=/tmp/screenshot.png

# Take a screenshot
flameshot full -r > $TMP

# Pixellate it 10x
mogrify -scale 10% -scale 1000% $TMP

# Turn the screen off after a delay.
( sleep 60; pgrep i3lock && xset dpms force off ) &

# stop notifications while locked
pkill -u "$USER" -USR1 dunst

#xset s off dpms 0 10 0

# Lock screen displaying this image.
i3lock -n -i $TMP 

#xset s off -dpms

pkill -u "$USER" -USR2 dunst

rm $TMP
