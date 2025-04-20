#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: The 'jobs' Command — View Background and Suspended Jobs${RESET}"
echo
echo "'jobs' displays a list of current jobs running in the background or suspended in the current shell."
pause

# Step 1: Display help
clear
echo -e "${YELLOW}${BOLD}📘 jobs Help:${RESET}"
echo -e "${BOLD}Syntax:${RESET} jobs [options]"
echo -e "Shows job status for the current shell session (background/suspended)."
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'jobs' Examples:${RESET}"

declare -A JOBS_USAGE
JOBS_USAGE["jobs"]="Lists all background/suspended jobs"
JOBS_USAGE["jobs -l"]="Shows job IDs and process IDs"
JOBS_USAGE["jobs -p"]="Lists only the process IDs of the jobs"
JOBS_USAGE["jobs -n"]="Shows only jobs whose status has changed since last notification"

for cmd in "${!JOBS_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${JOBS_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Practice Environment
PRACTICE_DIR="$SCRIPT_DIR/playground/jobs_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

echo -e "${CYAN}${BOLD}📁 Creating a test script to simulate background jobs...${RESET}"
echo -e '#!/bin/bash\nfor i in {1..5}; do echo "Processing \$i"; sleep 1; done' > loop.sh
chmod +x loop.sh

echo -e "${GREEN}✅ Script 'loop.sh' created.${RESET}"
pause

# Step 4: Demo and Task
clear
echo -e "${CYAN}${BOLD}🎯 TASK: Run 'loop.sh' in the background and check it using 'jobs'${RESET}"
echo
echo -e "${YELLOW}Steps:${RESET}"
echo "1. Run: ./loop.sh &"
echo "2. Type: jobs"
echo "3. Observe the background job details"
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
    "Run a script in the background" \
    "Use '&' at the end" \
    "^\.\/loop\.sh[[:space:]]*&[[:space:]]*$"

ask_and_check \
    "View background jobs" \
    "Use: jobs" \
    "^jobs([[:space:]]+-[lnp])?[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've learned how to use 'jobs' to view background tasks.${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
