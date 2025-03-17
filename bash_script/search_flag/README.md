# Flag Search Script

This script searches for `.log` files in the specified directory to see if they contain the specified flag. The search results will be the name of the file in which the flag was found.

## Requirement
- Bash
- The `grep` command

## Usage

The script is run with the required options `-d` (directory) and `-f` (flags).

```bash
. /search_flag.sh -d <directory> -f <flag>
```

- `-d <directory>` : specifies the directory to search.
- `-f <flag>` : specifies a flag string to search for.

### Example.

```bash
. /search_flag.sh -d /var/log -f “search-flag”
```

The above command will search the `.log` files in the `/var/log` directory for files containing the flag `search-flag`.

## Notes.
- Both `-d` (directory) and `-f` (flag) must be specified. If not specified, an error message will be displayed.
- If the specified directory does not exist, an error message is displayed and the program exits.

## License
This script may be freely used, modified, and distributed.
