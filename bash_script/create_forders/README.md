# Create Folders: Bash Script

## Overview
This script creates specific folders in a given base directory.  
It prompts the user to confirm whether folders in each category should be created, then generates them accordingly.  
After creation, it displays a list of all created folders.

## How to Use

1. **Prepare the Script**  
   Save the script to a directory of your choice and make it executable:
   ```bash
   chmod +x create_folders.sh
   ```

2. **Run the Script**
   Execute the script, passing the base directory path as an argument:

   ```bash
   ./create_folders.sh /path/to/base/directory
   ```

## Requirements

* **Shell**: Bash
* **System**: Unix-based OS (e.g., Linux, macOS)
* **Permissions**: Write permission to the specified directory

## Script Flow

1. **Check Directory Existence**
   Verifies if the specified base directory exists:

   ```bash
   if [ ! -d "$base_directory" ]; then
       echo "Error: Base directory does not exist at: $base_directory" >&2
       exit 1
   fi
   ```

2. **Prompt User**
   Asks whether to create specific folders.
   The first argument is the question; subsequent arguments are the folder paths:

   ```bash
   ask_and_create "Do you want to create folder A?" "test/testA1" "test/testA2"
   ask_and_create "Do you want to create folder B?" "test2/testB1"
   ```

3. **Create Folders**
   If the user agrees (`y`), the specified folders are created using `mkdir -p`:

   ```bash
   create_folders() {
       local folder_paths=("$@")
       for path in "${folder_paths[@]}"; do
           full_path="$base_directory/$path"
           mkdir -p "$full_path"
           echo "Created: $full_path"
       done
   }

   ask_and_create() {
       local question="$1"
       local -a paths=("${@:2}")
       echo "$question"
       read -p "Create these folders? (y/n): " answer
       if [[ "$answer" == "y" ]]; then
           create_folders "${paths[@]}"
       else
           echo "Skipped creation."
       fi
   }
   ```

4. **Display Results**
   Lists all created folders:

   ```bash
   echo "Created directories:"
   find "$base_directory" -type d -print
   ```

## Example

```bash
./create_folders.sh /Users/exampleuser/projects/myproject
```

This command will prompt folder creation under `/Users/exampleuser/projects/myproject`.

## Notes

* This script requires interactive user input.
  If used in automation, modify the script to bypass prompts.
* If folder creation fails, an error message will be shown and the script will exit.

