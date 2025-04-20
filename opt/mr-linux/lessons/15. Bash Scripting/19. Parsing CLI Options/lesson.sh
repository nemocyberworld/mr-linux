#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎛️ Lesson: Parsing CLI Options${RESET}"
echo
echo "Welcome to the world of script customization! Today we’re exploring how to give your scripts superpowers with flags and options."
pause

ask_and_check() {
    local title="$1"
    local expected_hint="$2"
    local expected_code="$3"
    local expected_output="$4"  # Optional

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected_hint"
    echo

    local user_input
    if [[ "$expected_code" == *$'\n'* ]]; then
        echo -e "${CYAN}(Enter your input. Press Ctrl+D when done)${RESET}"
        user_input="$(</dev/stdin)"
    else
        read -rp "> " user_input
    fi

    # Normalize inputs
    local cleaned_user
    local cleaned_expected
    cleaned_user=$(echo "$user_input" | sed 's/[[:space:]]\+$//' | sed '/^$/d')
    cleaned_expected=$(echo "$expected_code" | sed 's/[[:space:]]\+$//' | sed '/^$/d')

    if diff -u <(echo "$cleaned_user") <(echo "$cleaned_expected") >/dev/null; then
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}✅ Correct!${RESET}"
            else
                echo -e "${RED}❌ Output incorrect. Got: '$output', expected: '$expected_output'${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Correct!${RESET}"
        fi
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like:"
        echo "$expected_code"
    fi
    pause
}

# === getopts ===
clear
echo -e "${CYAN}${BOLD}🧩 Using getopts${RESET}"
echo
echo "'getopts' helps you parse short options like -f or -h easily."
pause

ask_and_check \
  "Create a script that handles -f and -h options" \
  "Try:
while getopts \"f:h\" opt; do
  case \$opt in
    f) echo \"File: \$OPTARG\";;
    h) echo \"Help!\";;
  esac
done" \
  'while getopts "f:h" opt; do
  case $opt in
    f) echo "File: $OPTARG";;
    h) echo "Help!";;
  esac
done'

# === Manual parsing ===
clear
echo -e "${CYAN}${BOLD}🔧 Manual Option Parsing${RESET}"
echo
echo "You can also manually parse arguments using a loop. Useful for --long options!"
pause

ask_and_check \
  "Manually handle --help and -f options" \
  "Try:
for arg in \"\$@\"; do
  case \$arg in
    -f|--file) file=1;;
    --help) echo \"Showing help...\"; exit;;
  esac
done" \
  'for arg in "$@"; do
  case $arg in
    -f|--file) file=1;;
    --help) echo "Showing help..."; exit;;
  esac
done'

# === Wrap-up ===
clear
echo -e "${GREEN}${BOLD}🎉 You’re now an argument parsing ninja!${RESET}"
echo
echo "✅ Use getopts for short flags like -f"
echo "✅ Manually parse for fancy --flags"
echo "✅ Write flexible and user-friendly scripts"
pause
