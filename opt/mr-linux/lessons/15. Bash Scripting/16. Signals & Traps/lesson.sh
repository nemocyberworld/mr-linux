#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🚨 Lesson: Signals & Traps${RESET}"
echo
echo "This lesson is all about catching signals like SIGINT (Ctrl+C) and SIGTERM."
echo "We'll also learn how to clean up after ourselves using trap."
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

# === What is a signal? ===
clear
echo -e "${CYAN}${BOLD}🧠 What are signals?${RESET}"
echo
echo "Signals are like system messages sent to your scripts."
echo "Example: SIGINT is sent when you press Ctrl+C."
pause

# === Handling Ctrl+C ===
ask_and_check \
  "Trap SIGINT (Ctrl+C)" \
  "Try:
trap 'echo \"Caught SIGINT!\"; exit' SIGINT
echo \"Try pressing Ctrl+C now\"
sleep 10" \
  "trap 'echo \"Caught SIGINT!\"; exit' SIGINT
echo \"Try pressing Ctrl+C now\"
sleep 10"

# === Cleanup on Exit ===
ask_and_check \
  "Clean up temporary files on exit" \
  "Try:
tmpfile=/tmp/lesson_trap_temp
touch \$tmpfile
trap 'echo \"Cleaning up\"; rm -f \$tmpfile' EXIT
echo \"Temp file created: \$tmpfile\"" \
  "tmpfile=/tmp/lesson_trap_temp
touch \$tmpfile
trap 'echo \"Cleaning up\"; rm -f \$tmpfile' EXIT
echo \"Temp file created: \$tmpfile\""

# === Handling SIGTERM ===
ask_and_check \
  "Trap SIGTERM signal" \
  "Try:
trap 'echo \"Terminated!\"; exit' SIGTERM
echo \"Waiting for SIGTERM...\"
sleep 10" \
  "trap 'echo \"Terminated!\"; exit' SIGTERM
echo \"Waiting for SIGTERM...\"
sleep 10"

# === Multiple Traps ===
ask_and_check \
  "Handle both SIGINT and SIGTERM" \
  "Try:
trap 'echo \"Caught SIGINT or SIGTERM!\"; exit' SIGINT SIGTERM
echo \"Try killing me softly (or not)...\"
sleep 10" \
  "trap 'echo \"Caught SIGINT or SIGTERM!\"; exit' SIGINT SIGTERM
echo \"Try killing me softly (or not)...\"
sleep 10"

# === Wrap-up ===
clear
echo -e "${GREEN}${BOLD}🎉 Great job catching those signals!${RESET}"
echo
echo "✅ You now know how to trap Ctrl+C (SIGINT)"
echo "✅ You can clean up with EXIT traps"
echo "✅ You're even handling graceful shutdowns with SIGTERM"
echo
echo -e "💡 Pro tip: Use traps for temporary file cleanup, status logging, or saving work before exit."
pause
