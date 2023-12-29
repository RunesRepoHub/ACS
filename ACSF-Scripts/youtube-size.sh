#!/bin/bash

# Usage: ./calculate_storage_usage.sh /path/to/directory

# Check if du and cut are installed
if ! command -v du &> /dev/null; then
    echo "du (Disk Usage) is not installed. Please install it to proceed."
    exit 1
fi

if ! command -v cut &> /dev/null; then
    echo "cut is not installed. Please install it to proceed."
    exit 1
fi

# Check if the path is provided
if [ -z "$1" ]; then
    echo "Please provide a path to calculate storage usage."
    exit 1
fi

# Assign the path to a variable
SEARCH_PATH="$1"

# Calculate the total storage usage of the path
total_usage=$(du -sh "$SEARCH_PATH" | cut -f1)

# Output the total storage usage
echo "Total storage usage of $SEARCH_PATH: $total_usage"

