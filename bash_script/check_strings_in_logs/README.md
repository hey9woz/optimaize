# Check Strings in Log Files

## Overview

This Bash script scans all `.log` files in a specified directory and checks whether each string listed in a separate file exists in any of the logs.

It is especially useful for verifying whether certain error messages, keywords, or events have been recorded in system or application logs.
The script supports optional **case-insensitive matching** and prints out both summary messages and the matched log lines.

## How to Use

1. **Prepare the Script**
   Save the script (e.g., `check_strings_in_logs.sh`) and make it executable:

   ```bash
   chmod +x check_strings_in_logs.sh
   ```

2. **Set Up the Inputs**

   * Create a file named `strings.txt` and list one target string per line.
   * Prepare a directory (default: `./logs/`) containing the log files you want to scan (log files should end with `.log`).

3. **Run the Script**

   Run the script from the terminal:

   ```bash
   ./check_strings_in_logs.sh
   ```

   Optionally, set `IGNORE_CASE=true` in the script to perform **case-insensitive** matching.

## Example

### `strings.txt`

```txt
Error
Timeout
Connection refused
User login failure
```

### Logs directory structure

```
logs/
├── app1.log
├── app2.log
└── system.log
```

### Sample Output

```
String existence check result:
String 'Error' found in file './logs/app1.log'.
String 'Timeout' found in file './logs/app2.log'.
String 'Connection refused' found in file './logs/app1.log'.
String 'User login failure' found in file './logs/system.log'.

List of matching log lines:
[./logs/app1.log] 2:[2025-05-21 10:01:25] ERROR: Connection refused
[./logs/app2.log] 1:[2025-05-21 11:02:10] WARNING: Timeout while accessing external service
[./logs/system.log] 2:[2025-05-21 09:56:00] ERROR: User login failure
```

## Requirements

* **Shell**: Bash
* **OS**: Unix-like (Linux/macOS recommended)
* **Tools**: No external dependencies (uses `grep`, `tr`, `xargs`)

## Script Logic

1. **Validation**

   * Checks if `strings.txt` exists.
   * Checks if the specified log directory exists.

2. **Search**

   * Reads each string from `strings.txt`.
   * Loops through each `.log` file in the directory.
   * Searches using `grep` with optional case-insensitive flag.

3. **Output**

   * Prints summary lines indicating where each string was found.
   * Outputs matching log lines with line numbers and file names.

## Notes

* Log files must have the `.log` extension.
* The script overwrites any previously collected results during each run.
* Make sure the script has execution permission and the input files are placed correctly.

## Customization

You can modify the following variables in the script to fit your use case:

```bash
STRING_FILE="strings.txt"
LOG_DIR="./logs"
IGNORE_CASE=false
```
