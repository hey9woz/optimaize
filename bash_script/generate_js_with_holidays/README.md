# Generate JS for Auto-Filling Workdays

## Overview
This script generates a JavaScript file that automatically fills in working hours into input fields on a web page for a specified month.
It fetches public holiday data from an external API and excludes weekends and national holidays.
The generated script can be copied and pasted into the browser's Developer Tools console to automatically populate daily input fields.
While currently tailored for the freelance agent platform Levtech Freelance, it can be customized for other use cases by modifying the relevant functions.

## How to Use

1. **Prepare the Script**  
   Save the script and make it executable:
   ```bash
   chmod +x generate_js_with_holidays.sh
   ```

2. **Run the Script**
   Execute the script, passing the year and month (YYYYMM) as an argument:

   ```bash
   ./generate_js_with_holidays.sh 202505
   ```

3. **Copy and Paste the Output**
   After running, the script will generate a `shell_generated.js` file and print its contents to the terminal.
   Copy the contents and paste them into your browser's Developer Tools console.

## Requirements

* **Shell**: Bash
* **System**: Unix-based OS (Linux or macOS recommended)
* **Tools**:

  * `curl` (for fetching holiday data)
  * `jq` (for processing JSON data)
* **Permissions**: Internet access and permission to write to the current directory

## Script Flow

1. **Argument Check**
   Ensures a `YYYYMM` argument is provided. If not, the script exits with a usage message.

2. **Fetch Holiday Data**
   Retrieves Japanese holiday data for the given year from:
   `https://holidays-jp.github.io/api/v1/<year>/date.json`

3. **Filter Holidays by Month**
   Extracts holidays that fall within the specified month and converts them to `YYYYMMDD` format.

4. **Generate JavaScript Code**

   * Calculates the number of days in the month.
   * Skips weekends and holidays.
   * For each workday, it sets:

     * `start_time` → `'09:00'`
     * `end_time` → `'18:00'`
     * `relax_time` → `'01:00'`

5. **Output the Script**
   Saves the generated JavaScript into `shell_generated.js` and echoes the content to the terminal.

## Example

```bash
./generate_js_with_holidays.sh 202505
```

This will generate JavaScript to fill out work hours for May 2025, excluding weekends and public holidays.

## Notes

* If `shell_generated.js` already exists, it will be overwritten without confirmation.
* Ensure `jq` is installed (`brew install jq` or `apt install jq`) before running.
* If pasting into the browser console fails due to restrictions, try enabling paste via browser-specific commands.

