#!/bin/bash

choice=$( (echo "Vider le presse-papier" ; cliphist list) | wofi --dmenu --prompt "Clipboard" )

if [[ "$choice" == "Vider le presse-papier" ]]; then
    cliphist wipe
else
    echo "$choice" | cliphist decode | wl-copy
fi
