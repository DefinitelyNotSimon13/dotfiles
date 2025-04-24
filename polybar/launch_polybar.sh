if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$m" = "DP-4" ]; then
      MONITOR=$m polybar --reload main &
    else
      MONITOR=$m polybar --reload secondary &
    fi
  done
else
  polybar --reload main &
fi
