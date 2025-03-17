## Create Forder Bash Script

## Overview
This script is designed to create specific folders in a given base directory.
It asks the user if he/she wants to create folders in a particular category, and creates folders based on the user's response.
After creation is complete, it displays a list of all created folders.

## How to use
1. **PREPARE THE SCRIPT**: Save the script in a directory of your choice and give the file execute permission.
   ```bash
   chmod +x create_folders.sh
   ```` 2.
**Execute the script**: Run the script passing the path of the base directory as an argument.
   ```bash
   . /create_folders.sh /path/to/base/directory
   ```

## Requirements.
- **Shell**: This script is designed to run in the Bash shell.
- **System**: A UNIX-based operating system such as Linux or macOS is required.
- **Permissions**: The user executing the script must have write permission to the specified directory.

## Script flow
1. **Directory Existence Check**: Checks if the specified base directory exists. 2.
2. **Question**: Ask the user if he/she wants to create a specific folder. 3.
**Create Folder**: If the user answers 'y', the specified folder is created. 4.
**Display Results**: Displays a list of the folders created.

## Example Usage
The following is a general example of using the script.
```bash
. /create_folders.sh /Users/exampleuser/projects/myproject
```
This command starts the process of creating folders in the `/Users/exampleuser/projects/myproject` directory.

## Notes.
- This script requires input from the user. If used within an automated script, the answers must be incorporated into the script beforehand.
- If the folder creation fails, an error message will be displayed and the script will exit.
