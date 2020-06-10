#!/bin/sh
set -e

TMP=/tmp/screenshot.png

# Take a screenshot
flameshot full -r > $TMP

# Pixellate it 10x
mogrify -scale 10% -scale 1000% $TMP

# Turn the screen off after a delay.
( sleep 60; pgrep i3lock && xset dpms force off ) &

# stop notifications while locked
pkill -u "$USER" -USR1 dunst

# Lock screen displaying this image.
# Afterwards, resume dunst
( i3lock -i $TMP -n; pkill -u "$USER" -USR2 dunst; rm $TMP) &
