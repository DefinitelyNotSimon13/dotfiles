#!/bin/bash

# source: https://stackoverflow.com/questions/25903943/looping-dots-until-a-process-is-complete-bash

"$@" &
runningPrinted=false
while kill -0 $!; do
  if [[ "$runningPrinted" == "false" ]]; then
    printf "Running" > /dev/tty
    runningPrinted=true
  fi
  printf '.' > /dev/tty
  printf "$counter" > /dev/tty
  sleep 1
done
printf "Done!" > /dev/tty
printf '\n' > /dev/tty

