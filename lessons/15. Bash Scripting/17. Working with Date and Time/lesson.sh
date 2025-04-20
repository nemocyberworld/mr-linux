#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🕒 Lesson: Working with Date and Time${RESET}"
echo
echo "This lesson will teach you to bend time with the \`date\` command ⏳ and schedule tasks like a time wizard! 🧙‍♂️"
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

# === THE DATE COMMAND ===
clear
echo -e "${CYAN}${BOLD}📅 The Magical date Command${RESET}"
echo
echo "The \`date\` command shows the current date and time. It's your time crystal ball!"
pause

ask_and_check \
  "Show the current date and time" \
  "Try: date" \
  "date"

ask_and_check \
  "Show just the year" \
  "Try: date +%Y" \
  "date +%Y"

ask_and_check \
  "Show day-month-year format" \
  "Try: date +%d-%m-%Y" \
  "date +%d-%m-%Y"

ask_and_check \
  "Show time in 12-hour format with AM/PM" \
  "Try: date +%I:%M%p" \
  "date +%I:%M%p"

# === SCHEDULING BASICS ===
clear
echo -e "${CYAN}${BOLD}⏱️ Scheduling Basics${RESET}"
echo
echo "Want to run a task later? Meet your buddy: the sleep command. 😴"
pause

ask_and_check \
  "Wait 3 seconds before printing 'Done'" \
  "Try:
sleep 3
echo Done" \
  "sleep 3
echo Done" \
  "Done"

echo
echo -e "${CYAN}📝 Real scheduling uses tools like 'cron' or 'at'. Here's a sneak peek!${RESET}"
pause

echo "Example (not interactive): Schedule a job with 'at'"
echo "echo 'echo Hello' | at now + 1 minute"
echo
echo "You can view scheduled jobs with: atq"
echo "Remove one with: atrm <job_id>"
pause

# === WRAP-UP ===
clear
echo -e "${GREEN}${BOLD}🎉 You’ve mastered the basics of time in Bash!${RESET}"
echo
echo "✅ Use \`date\` to peek at time in any format."
echo "✅ Use \`sleep\` to delay commands."
echo "✅ Learn \`cron\` and \`at\` for full scheduling powers."
pause
