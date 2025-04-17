#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'watch' — Repeatedly Run Commands and See Updates in Real-Time${RESET}"
echo
echo -e "${YELLOW}watch${RESET} runs a command repeatedly and shows the output on the terminal, refreshing it every 2 seconds by default."
echo
echo -e "${BOLD}📌 Basic Syntax:${RESET}"
echo -e "  ${GREEN}watch [options] command${RESET}"
echo
echo -e "${BOLD}🔍 Example:${RESET}"
echo -e "  ${GRAY}watch ls -l${RESET} — Re-runs 'ls -l' every 2 seconds and updates the output."
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_watch_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create dummy data for live changes
mkdir -p "$TMPDIR/live_dir"
cd "$TMPDIR/live_dir"
touch file1.txt

# ─────────────────────────────────────────────────────────────
ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧪 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Not quite. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Use watch to monitor a directory in real-time." \
    "Try 'watch ls' or 'watch ls -l'" \
    '^watch( +-.*)? +(ls|ls -l)\s*$' \
    "Awesome! You’re watching the directory changes live."

ask_and_check \
    "Change watch refresh interval to 1 second" \
    "Use the -n option" \
    '^watch +-n +1 +(ls|ls -l)\s*$' \
    "Perfect! You just customized the update interval."

ask_and_check \
    "Highlight changes in the output" \
    "Use the -d option" \
    '^watch +-d( +-n +[0-9]+)? +(ls|ls -l)\s*$' \
    "Well done! Now changes will be highlighted as they occur."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🤓 Tip:${RESET}"
echo -e "Use ${YELLOW}watch -d -n 1 command${RESET} to watch and highlight changes every second. Super useful for monitoring log files, disk usage, or network stats in real time!"
pause

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo -e "You’ve mastered using the ${YELLOW}watch${RESET} command to monitor command output live."
pause
