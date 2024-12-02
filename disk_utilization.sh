#!/bin/bash


THRESHOLD=30
# Use grep to filter the '/' line and awk to extract the usage percentage
USAGE=$(df -h | grep ' /$' | awk '{print $5}' | awk '{print substr($0, 1, length($0)-1)}') # Removes '%'

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage critical: ${USAGE}% (Threshold: ${THRESHOLD}%)"
    exit 1 # Non-zero exit code for critical disk usage
else
    echo "Disk usage is under control: ${USAGE}% (Threshold: ${THRESHOLD}%)"
    exit 0 # Zero exit code for normal usage
fi
