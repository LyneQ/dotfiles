#!/bin/bash
pacman -Qi filesystem | grep 'Install Date' | sed 's/Install Date[[:space:]]*:[[:space:]]*//'
