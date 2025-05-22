#!/bin/bash

# ========== Config ==========
STRING_FILE="strings.txt"   # File containing the list of strings to search for
LOG_DIR="./logs"            # Directory containing the log files
IGNORE_CASE=true           # Set to true to ignore case sensitivity
# ============================

check_files() {
  if [[ ! -f "$STRING_FILE" ]]; then
    echo "String list file '$STRING_FILE' not found."
    exit 1
  fi

  if [[ ! -d "$LOG_DIR" ]]; then
    echo "Log directory '$LOG_DIR' not found."
    exit 1
  fi
}

# ========= Main Script =========

check_files

FOUND=false
MATCHES_LIST=()

echo "String existence check result:"

while IFS= read -r STRING; do
  STRING=$(echo "$STRING" | tr -d '\r' | xargs)  # Trim whitespace and carriage returns

  MATCHED=false

  for FILE in "$LOG_DIR"/*.log; do
    if $IGNORE_CASE; then
      MATCHES=$(grep -iFn "$STRING" "$FILE")
    else
      MATCHES=$(grep -Fn "$STRING" "$FILE")
    fi

    if [[ -n "$MATCHES" ]]; then
      echo "String '$STRING' found in file '$FILE'."
      MATCHES_LIST+=("[$FILE] $MATCHES")
      MATCHED=true
      FOUND=true
    fi
  done

  if ! $MATCHED; then
    echo "String '$STRING' not found in any log file."
  fi

done < "$STRING_FILE"

if $FOUND; then
  echo -e "\nList of matching log lines:"
  for MATCH in "${MATCHES_LIST[@]}"; do
    echo "$MATCH"
  done
else
  echo "None of the strings in the list were found in any log files."
fi

