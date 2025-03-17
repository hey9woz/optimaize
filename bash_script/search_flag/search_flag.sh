#!/bin/bash

# Usage function for help message
usage() {
    echo "Usage: $0 -d directory -f flag"
    echo "  -d  Directory to search in (required)"
    echo "  -f  Flag to search for (required)"
    exit 1
}

# Parse options
while getopts "d:f:" opt; do
    case ${opt} in
        d ) directory=$OPTARG ;;
        f ) flag=$OPTARG ;;
        * ) usage ;;
    esac
done

# Check if both directory and flag are provided
if [ -z "$directory" ] || [ -z "$flag" ]; then
    echo "Error: Both -d (directory) and -f (flag) options are required."
    usage
fi

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory $directory does not exist."
    exit 1
fi

echo "Searching for flag \"$flag\" in directory: $directory..."

# Loop through .log files in the specified directory
found=false
for file in "$directory"/*.log; do
    # Check if the file contains the flag
    if grep -q "$flag" "$file"; then
        # Print the filename
        echo "Flag found in: $(basename "$file")"
        found=true
    fi
done

# Notify if no flag was found
if [ "$found" = false ]; then
    echo "No flag \"$flag\" found in directory: $directory"
fi
