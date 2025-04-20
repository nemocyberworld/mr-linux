#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: The 'bg' Command — Resume Jobs in the Background${RESET}"
echo
echo "'bg' is used to resume a suspended job in the background. It allows the process to continue running without blocking your terminal."
pause

# Step 1: Display help using `help bg`
clear
echo -e "${YELLOW}${BOLD}📘 bg Command Help:${RESET}"
help bg | head -20
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'bg' Examples:${RESET}"

declare -A BG_USAGE
BG_USAGE["Ctrl+Z"]="Suspend a running foreground process"
BG_USAGE["bg"]="Resume the most recently suspended job in the background"
BG_USAGE["bg %1"]="Resume job number 1 in the background"
BG_USAGE["jobs"]="List current jobs to see job numbers"

for cmd in "${!BG_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${BG_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Practice Environment
PRACTICE_DIR="$SCRIPT_DIR/playground/bg_lesson"
mkdir -p "$PRACTICE_DIR"
cd "$PRACTICE_DIR" || exit

# Step 4: Instructions for interactive job control
clear
echo -e "${CYAN}${BOLD}🎯 TASK: Practice Using 'bg'${RESET}"
echo
echo -e "${YELLOW}1. Run a command that takes time (e.g., 'sleep 100').${RESET}"
echo -e "${YELLOW}2. Press ${BOLD}Ctrl+Z${RESET}${YELLOW} to suspend it.${RESET}"
echo -e "${YELLOW}3. Use the ${BOLD}jobs${RESET}${YELLOW} command to list background/suspended jobs.${RESET}"
echo -e "${YELLOW}4. Use ${BOLD}bg${RESET}${YELLOW} to resume the suspended job in the background.${RESET}"
echo -e "${YELLOW}5. Use ${BOLD}fg${RESET}${YELLOW} to bring it back to the foreground (optional).${RESET}"
echo
echo -e "${CYAN}⬇️ Press Enter when you're ready to try it...${RESET}"
read -r

# Step 5: Confirmation
clear
echo -e "${CYAN}${BOLD}✅ Let's confirm your understanding with a quick test.${RESET}"

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
    "Show running jobs" \
    "Use: jobs" \
    "^jobs[[:space:]]*$"

ask_and_check \
    "Resume the most recent suspended job in the background" \
    "Use: bg" \
    "^bg[[:space:]]*$"

ask_and_check \
    "Resume job number 1 in the background" \
    "Use: bg %1" \
    "^bg[[:space:]]+%1[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've mastered using 'bg' to manage background jobs!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
