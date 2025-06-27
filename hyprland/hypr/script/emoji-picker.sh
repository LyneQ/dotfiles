#!/bin/bash

emoji=$(wofi-emoji --no-actions)
if [[ -n "$emoji" ]]; then
    echo -n "$emoji" | wl-copy
fi