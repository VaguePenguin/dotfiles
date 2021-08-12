#!/usr/bin/env sh

PPATH=/home/e/.config/polybar

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

sh "$PPATH/preprocess.sh"

cat "$PPATH/config.live" | sed 's/<<mpd-password>>/castle/g' > "$PPATH/config.live.p"

# Launch on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
	polybar page-$m        --config="$PPATH/config.live" &
	polybar music-$m       --config="$PPATH/config.live.p" &
	polybar songname-$m    --config="$PPATH/config.live" &
	polybar center-$m      --config="$PPATH/config.live" &
	polybar currenttool-$m --config="$PPATH/config.live" &
	polybar system-$m      --config="$PPATH/config.live"
done

echo "Bar launched..."
