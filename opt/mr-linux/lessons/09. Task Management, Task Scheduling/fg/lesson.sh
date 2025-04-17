#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: The 'fg' Command — Bring Background Jobs to Foreground${RESET}"
echo
echo "'fg' resumes a suspended or background job in the foreground."
pause

# Step 1: Display help
clear
echo -e "${YELLOW}${BOLD}📘 fg Help:${RESET}"
echo -e "${BOLD}Syntax:${RESET} fg [%job_id]"
echo -e "Use the 'jobs' command to view job IDs."
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'fg' Examples:${RESET}"

declare -A FG_USAGE
FG_USAGE["fg"]="Brings the most recently suspended or background job to the foreground"
FG_USAGE["fg %1"]="Brings job with ID 1 to the foreground (as listed by 'jobs')"

for cmd in "${!FG_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${FG_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Practice Environment
PRACTICE_DIR="$SCRIPT_DIR/playground/fg_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

echo -e "${CYAN}${BOLD}📁 Setting up background job demo...${RESET}"
echo -e '#!/bin/bash\nfor i in {1..5}; do echo "Loop \$i"; sleep 1; done' > loop.sh
chmod +x loop.sh

echo -e "${GREEN}✅ Script 'loop.sh' created. Let's start using it!${RESET}"
pause

# Step 4: Demo and Task
clear
echo -e "${CYAN}${BOLD}🎯 TASK: Run 'loop.sh', suspend it, and bring it to foreground using 'fg'${RESET}"
echo
echo -e "${YELLOW}Steps:${RESET}"
echo "1. Run: ./loop.sh"
echo "2. While it's running, press: Ctrl+Z (this suspends the job)"
echo "3. Type: jobs (to see job ID)"
echo "4. Type: fg (to bring it back to foreground)"
echo
pause

# Step 5: Task Validation
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
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Check running/suspended jobs" \
    "Use: jobs" \
    "^jobs[[:space:]]*$"

ask_and_check \
    "Bring a job to foreground" \
    "Use: fg" \
    "^fg([[:space:]]+%?[0-9]+)?[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've mastered using 'fg' to manage background jobs.${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
