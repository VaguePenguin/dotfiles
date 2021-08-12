#!/usr/bin/env sh

PPATH=/home/e/.config/polybar

# Terminate already running bar instance
killall -q polybar

# Wait until the processes have been shut down
# while ps -ax | grep polybar >/dev/null; do sleep 1; done

sh "$PPATH/preprocess.sh"

cat "$PPATH/config.live" | sed 's/<<mpd-password>>/castle/g' > "$PPATH/config.live.p"

# Launch on all monitors
mons=$(xrandr --query | grep " connected" | tr -s " " |  cut -d " " -f1)
echo $mons > /home/e/tst/p-log
for mon in $(xrandr --query | grep " connected" | cut -d " " -f1); do
	echo $mon >> /home/e/tst/p-log
	polybar page-$mon        --config="$PPATH/config.live"  &
	polybar music-$mon       --config="$PPATH/config.live.p" &
	polybar songname-$mon    --config="$PPATH/config.live" &
	polybar center-$mon      --config="$PPATH/config.live" &
	polybar currenttool-$mon --config="$PPATH/config.live" &
	polybar system-$mon      --config="$PPATH/config.live"
done

echo "Bar launched..."
