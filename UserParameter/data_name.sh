#!/bin/bash
PREFIX="${1:-NOT_SET}"
[[ "$PREFIX" = "NOT_SET" ]] && { echo "Required argument"; }
[[ "$PREFIX" = "1" ]] && { echo "KarelinSF"; }
[[ "$PREFIX" = "2" ]] && { echo "$(date +"%Y-%m-%d")"; }