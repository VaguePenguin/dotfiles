#!/usr/bin/env sh

PPATH=/home/e/.config/polybar

cat "$PPATH/shared/config.default" > "$PPATH/config.pre"

for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
	for bar in $(ls "$PPATH/bars"); do
		echo -en "\n" >> "$PPATH/config.pre"
		cat "$PPATH/bars/$bar" | sed "s/#monitor/$m/g" | sed -E "s+(\[bar/.*-)+\1$m+" >> "$PPATH/config.pre"
		echo -en "\n" >> "$PPATH/config.pre"
		cat "$PPATH/shared/bars.shared" >> "$PPATH/config.pre"
	done
done

# for mod in $(ls "$PPATH/modules"); do
#	echo -en "\n" >> "$PPATH/config.pre"
#       	cat "$PPATH/modules/$mod" >> "$PPATH/config.pre"
# done

cat "$PPATH/shared/modules" >> "$PPATH/config.pre"

cat "$PPATH/config.pre" > "$PPATH/config.live"
rm "$PPATH/config.pre"
