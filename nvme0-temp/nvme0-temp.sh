#!/usr/bin/mksh

tempfile="/tmp/nvme0-temp"

trap "rm -f "$tempfile"; exit" 0 1 2 3 13 15  # Exit, HUP, INT, QUIT, PIPE, TERM

while true; do
    temperature="$(nvme smart-log /dev/nvme0 | sed -n '/^[Tt]emperature *: *\([0-9]*\).*/{s//\1/p;q}')"
    builtin echo "$temperature" > "$tempfile"
    builtin sleep 2
done
