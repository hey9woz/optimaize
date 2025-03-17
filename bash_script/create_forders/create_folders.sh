#! /bin/bash

# Path of the base directory
base_directory="$1”

# Check if the directory exists
if [ ! -d “$base_directory” ]; then
    echo “Error: Base directory does not exist at: $base_directory” >&2
    exit 1
fi

# Functions for creating various folders
create_folders() {
    local folder_paths=(“$@”)
    for path in “${folder_paths[@]}”; do
        full_path="$base_directory/$path”
        mkdir -p “$full_path”
        echo “Created: $full_path”
    done
}

# Ask if the folder should be created
ask_and_create() {
    local question=“$1”)
    local -a paths=(“${@:2}”)
    echo “$question”
    read -p “Create these folders? (y/n): ” answer
    if [[ “$answer” == “y”]]; then
        create_folders “${paths[@]}”
    else
        echo “Skipped creation.”
    fi
}

# Each question and folder path
ask_and_create “Do you want to create folder A?” “test/testA1” ”test/testA2”
ask_and_create “Do you want to create folder B?” “test2/testB1”

# List created folders
echo “Created directories:”
find “$base_directory” -type d -print
