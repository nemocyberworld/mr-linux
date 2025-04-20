#!/bin/bash

get_input() {
  read -rp \"$1\" input
  echo \"$input\"
}
ask_and_check() {
    local prompt="$1"
    local expected="$2"

    echo -ne "$prompt "
    read -r user_input
    user_input=$(echo "$user_input" | tr -d '[:space:]')

    if [[ "$user_input" == "$expected" ]]; then
        echo -e "${GREEN}✅ Correct!${RESET}"
    else
        echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        exit 1
    fi
}