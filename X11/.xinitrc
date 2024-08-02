while true; do
	xprop -root -set WM_NAME "$(date +"%H:%M")"
	sleep 1m
done &

unclutter --timeout 2 --start-hidden &

st &
firefox &

exec dwm
