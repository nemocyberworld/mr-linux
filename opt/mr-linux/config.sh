#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Utility functions
pause() {
    echo
    read -p "Press Enter to continue..." temp
}

success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

fail() {
    echo -e "${RED}❌ $1${RESET}"
}

ask_and_check() {
    local title="$1"
    local expected="$2"
    local regex="$3"
    local expected_output="$4"  # Optional

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected"
    echo

    read -rp "> " user_input

    if [[ "$user_input" =~ $regex ]]; then
        # Check command output if expected_output is given
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}✅ Correct!${RESET}"
            else
                echo -e "${RED}❌ Output was incorrect. Got: '$output' Expected: '$expected_output'${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Correct!${RESET}"
        fi
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like: $expected"
    fi
    pause
}
