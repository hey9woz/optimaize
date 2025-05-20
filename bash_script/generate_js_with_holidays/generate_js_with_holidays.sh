#!/bin/bash

set -e

# ========== Config ==========
GENERATED_FILE_NAME="generated.js"
DEFAULT_START="09:00"
DEFAULT_END="18:00"
DEFAULT_BREAK="01:00"
# ============================

check_args() {
  if [ -z "$1" ]; then
    echo "Usage: $0 YYYYMM"
    exit 1
  fi
}

fetch_holidays() {
  local year="$1"
  local month="$2"
  local api_url="https://holidays-jp.github.io/api/v1/${year}/date.json"
  local json=$(curl -s "$api_url")

  if [ -z "$json" ]; then
    echo "Failed to retrieve holiday data from API."
    exit 1
  fi

  local filtered=()
  while read -r date; do
    if [[ $date =~ ^${year}-${month}- ]]; then
      filtered+=("$(echo "$date" | sed 's/-//g')")
    fi
  done < <(echo "$json" | jq -r 'keys[]')

  echo "${filtered[@]}"
}

generate_js_code() {
  local year="$1"
  local month="$2"
  local yyyymm="$3"
  shift 3
  local holidays=("$@")

cat <<EOF > "$GENERATED_FILE_NAME"
const count_days = new Date($year, $month, 0).getDate();
const holidays = $(jq -nc --argjson arr "$(printf '%s\n' "${holidays[@]}" | jq -R . | jq -s .)" '$arr');

for (let i = 1; i <= count_days; i++) {
  let day = i < 10 ? '0' + i : i;
  let date = "$yyyymm" + day;

  let d = new Date($year, $month - 1, i);
  if (d.getDay() === 0 || d.getDay() === 6 || holidays.includes(date)) {
    console.log("Skipping " + date + " (Holiday or Weekend)");
    continue;
  }

  let start_time_id = date + 'start_time';
  let end_time_id = date + 'end_time';
  let relax_time_id = date + 'relax_time';

  let start_time = document.getElementById(start_time_id);
  let end_time = document.getElementById(end_time_id);
  let relax_time = document.getElementById(relax_time_id);

  if (start_time && end_time && relax_time) {
    start_time.value = '$DEFAULT_START';
    end_time.value = '$DEFAULT_END';
    relax_time.value = '$DEFAULT_BREAK';

    console.log("Set " + start_time_id + " = $DEFAULT_START");
    console.log("Set " + end_time_id + " = $DEFAULT_END");
    console.log("Set " + relax_time_id + " = $DEFAULT_BREAK");
  } else {
    console.log("Elements not found for " + date);
  }
}
EOF
}

print_summary() {
  echo "JavaScript file ${GENERATED_FILE_NAME} generated."
  echo "Copy and paste into the Developer Tools console ↓"
  echo "***************************"
  cat "$GENERATED_FILE_NAME"
  echo "***************************"
  echo "Tips: If copy/paste is disabled in the console, you may need to enable paste manually."
}

# ========= Main Script =========
check_args "$1"
TARGET_YEAR_MONTH="$1"
TARGET_YEAR=${TARGET_YEAR_MONTH:0:4}
TARGET_MONTH=${TARGET_YEAR_MONTH:4:2}

if [ -e "$GENERATED_FILE_NAME" ]; then
  echo "Warning: $GENERATED_FILE_NAME already exists and will be overwritten."
fi

HOLIDAYS=($(fetch_holidays "$TARGET_YEAR" "$TARGET_MONTH"))
generate_js_code "$TARGET_YEAR" "$TARGET_MONTH" "$TARGET_YEAR_MONTH" "${HOLIDAYS[@]}"
print_summary

