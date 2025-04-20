#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧮 Lesson: Arrays & Associative Arrays${RESET}"
echo
echo "This lesson covers how to work with indexed and associative arrays in Bash."
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

    # Normalize inputs (trim trailing spaces, ignore empty lines)
    local cleaned_user
    local cleaned_expected
    cleaned_user=$(echo "$user_input" | sed 's/[[:space:]]\+$//' | sed '/^$/d')
    cleaned_expected=$(echo "$expected_code" | sed 's/[[:space:]]\+$//' | sed '/^$/d')

    if diff -u <(echo "$cleaned_user") <(echo "$cleaned_expected") >/dev/null; then
        if [[ -n "$expected_output" ]]; then
            # Try running the cleaned user code
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

# === INDEXED ARRAYS ===
clear
echo -e "${CYAN}${BOLD}📦 Indexed Arrays${RESET}"
echo
echo "Indexed arrays use numeric indices, starting from 0."
pause

ask_and_check \
  "Create an indexed array of fruits" \
  "Try: fruits=(Apple Banana Cherry)" \
  'fruits=(Apple Banana Cherry)'

fruits=(Apple Banana Cherry)

ask_and_check \
  "Access the first element (index 0)" \
  "Try: echo \${fruits[0]}" \
  'echo ${fruits[0]}' \
  'Apple'

ask_and_check \
  "Loop through all fruits" \
  "Try:
for fruit in \"\${fruits[@]}\"; do
  echo \$fruit
done" \
  'for fruit in "${fruits[@]}"; do
  echo $fruit
done'

# === ASSOCIATIVE ARRAYS ===
clear
echo -e "${CYAN}${BOLD}📘 Associative Arrays${RESET}"
echo
echo "Associative arrays use string keys. Declare them with 'declare -A'."
pause

ask_and_check \
  "Create an associative array of capitals" \
  "Try:
declare -A capitals
capitals[France]=Paris
capitals[Germany]=Berlin" \
  'declare -A capitals
capitals[France]=Paris
capitals[Germany]=Berlin'

declare -A capitals
capitals[France]=Paris
capitals[Germany]=Berlin

ask_and_check \
  "Access the capital of France" \
  "Try: echo \${capitals[France]}" \
  'echo ${capitals[France]}' \
  'Paris'

ask_and_check \
  "Loop through all keys and values" \
  "Try:
for country in \"\${!capitals[@]}\"; do
  echo \"\$country: \${capitals[\$country]}\"
done" \
  'for country in "${!capitals[@]}"; do
  echo "$country: ${capitals[$country]}"
done'

# === WRAP-UP ===
echo
echo -e "${GREEN}${BOLD}🎉 You’ve learned Bash arrays!${RESET}"
echo
echo "Indexed arrays are great for ordered lists. Associative arrays are useful for key-value pairs."
pause
