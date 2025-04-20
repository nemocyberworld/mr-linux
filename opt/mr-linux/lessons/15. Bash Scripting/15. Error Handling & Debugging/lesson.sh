#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🐞 Lesson: Error Handling & Debugging in Bash${RESET}"
echo
echo "Let’s tame those sneaky bugs and mysterious crashes! 🕵️‍♂️"
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

    local cleaned_user cleaned_expected
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

# === set -e ===
clear
echo -e "${CYAN}${BOLD}💥 set -e: Exit on error${RESET}"
echo
echo "This makes your script stop running when a command fails. No more silent fails!"
pause

ask_and_check \
  "Try a script that exits when a command fails" \
  "Try:
set -e
echo 'Before failure'
false
echo 'After failure'" \
  "set -e
echo 'Before failure'
false
echo 'After failure'"

# === set -u ===
clear
echo -e "${CYAN}${BOLD}🙀 set -u: Unset variable panic${RESET}"
echo
echo "This will make your script crash if you try to use an unset variable. Useful for catching typos!"
pause

ask_and_check \
  "Cause an error with unset variable" \
  "Try:
set -u
echo \$undefined_var" \
  "set -u
echo \$undefined_var"

# === trap ===
clear
echo -e "${CYAN}${BOLD}🪤 trap: Catch signals and errors${RESET}"
echo
echo "trap lets you react to signals like EXIT, ERR, INT (Ctrl+C), etc."
pause

ask_and_check \
  "Trap script exit and say goodbye" \
  "Try:
trap 'echo Goodbye!' EXIT
echo 'Doing stuff...'" \
  "trap 'echo Goodbye!' EXIT
echo 'Doing stuff...'" \
  $'Doing stuff...\nGoodbye!'

# === set -x ===
clear
echo -e "${CYAN}${BOLD}🔬 set -x: Trace the script${RESET}"
echo
echo "This prints each command before it’s executed. Super useful for debugging!"
pause

ask_and_check \
  "Trace commands as they run" \
  "Try:
set -x
echo Hello
echo World" \
  "set -x
echo Hello
echo World"

# === Exit Codes ===
clear
echo -e "${CYAN}${BOLD}🚪 Exit Codes${RESET}"
echo
echo "Every command returns an exit code (0 = success, non-zero = error)."
pause

ask_and_check \
  "Check exit status of a command" \
  "Try:
ls /not-a-real-file
echo \$?" \
  "ls /not-a-real-file
echo \$?"

# === Wrap-up ===
clear
echo -e "${GREEN}${BOLD}🎉 You’ve mastered error handling & debugging!${RESET}"
echo
echo "✅ set -e: Exit on error"
echo "✅ set -u: Catch unset variables"
echo "✅ trap: Run cleanup code on exit"
echo "✅ set -x: Print commands as they run"
echo "✅ Exit codes help you detect success/failure"
pause
