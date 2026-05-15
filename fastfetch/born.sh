#!/bin/bash
pacman -Qi filesystem | grep 'Install Date' \
  | sed 's/Install Date[[:space:]]*:[[:space:]]*//' \
  | xargs -I{} bash -c '
      install=$(date -d "{}" +%s)
      now=$(date +%s)
      days=$(( (now - install) / 86400 ))
      years=$((days / 365))
      months=$(( (days % 365) / 30 ))
      rem=$((days % 365 % 30))
      echo "${years}y ${months}m ${rem}d (${days} days old)"
    '
