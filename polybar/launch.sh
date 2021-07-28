#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

cat "/home/e/.config/polybar/config" | sed 's/<<mpd-password>>/castle/g' > /home/e/.config/polybar/configp

# Launch
polybar page --config="/home/e/.config/polybar/config" &
polybar music --config="/home/e/.config/polybar/configp" &
polybar songname --config="/home/e/.config/polybar/config" &
polybar center --config="/home/e/.config/polybar/config" &
polybar currenttool --config="/home/e/.config/polybar/config" &
polybar system --config="/home/e/.config/polybar/config" &

echo "Bar launched..."
