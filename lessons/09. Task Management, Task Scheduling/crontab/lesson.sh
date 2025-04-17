#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: The 'crontab' Tool — Schedule Repetitive Tasks in Linux${RESET}"
echo
echo "'crontab' is used to schedule commands or scripts to run automatically at specified times and intervals."
pause

# Step 1: Display help
clear
echo -e "${YELLOW}${BOLD}📘 crontab Help:${RESET}"
crontab --help | head -20
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'crontab' Examples:${RESET}"

declare -A CRON_USAGE
CRON_USAGE["crontab -e"]="Edit the current user's crontab"
CRON_USAGE["crontab -l"]="List the current user's crontab"
CRON_USAGE["crontab -r"]="Remove the current user's crontab"
CRON_USAGE["* * * * * command"]="Run 'command' every minute"
CRON_USAGE["0 0 * * * backup.sh"]="Run 'backup.sh' at midnight daily"

for cmd in "${!CRON_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${CRON_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Crontab format explanation
clear
echo -e "${CYAN}${BOLD}🧩 Crontab Syntax:${RESET}"
echo -e "${YELLOW}"
echo " ┌───────────── minute (0 - 59)"
echo " │ ┌───────────── hour (0 - 23)"
echo " │ │ ┌───────────── day of month (1 - 31)"
echo " │ │ │ ┌───────────── month (1 - 12)"
echo " │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday=0)"
echo " │ │ │ │ │"
echo " * * * * * command_to_execute"
echo -e "${RESET}"
pause

# Step 4: Practice Environment
PRACTICE_DIR="$SCRIPT_DIR/playground/crontab_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

echo -e "${CYAN}${BOLD}📁 Setting up a test script to run via cron...${RESET}"
echo -e '#!/bin/bash\necho "Cron Test at $(date)" >> "$HOME/cron_test.log"' > test_cron.sh
chmod +x test_cron.sh
echo -e "${GREEN}✅ Created test_cron.sh${RESET}"
pause

# Step 5: Task Instructions
clear
echo -e "${CYAN}${BOLD}🎯 TASK: Schedule 'test_cron.sh' to run every minute using crontab${RESET}"
echo
echo -e "${YELLOW}1. Open your crontab with: ${BOLD}crontab -e${RESET}"
echo -e "${YELLOW}2. Add this line: ${BOLD}* * * * * $PRACTICE_DIR/test_cron.sh${RESET}"
echo -e "${YELLOW}3. Save and exit (e.g., Ctrl+X then Y then Enter for nano)${RESET}"
echo
echo -e "${YELLOW}4. After 1-2 minutes, run: ${BOLD}cat \$HOME/cron_test.log${RESET} to verify it ran.${RESET}"
echo
pause

# Step 6: Confirmation Task
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Open your crontab for editing" \
    "Use: crontab -e" \
    "^crontab[[:space:]]+-e[[:space:]]*$"

ask_and_check \
    "List the crontab entries" \
    "Use: crontab -l" \
    "^crontab[[:space:]]+-l[[:space:]]*$"

# Step 7: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've mastered scheduling tasks using crontab!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up (removing scheduled job and files)...${RESET}"
crontab -r
rm -rf "$PRACTICE_DIR"
pause
