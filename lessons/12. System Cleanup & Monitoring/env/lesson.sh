#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌍 Lesson: The 'env' Command — View and Use Environment Variables${RESET}"
echo
echo "'env' is used to run commands in a modified environment or view current environment variables."
pause

# Step 1: Setup
echo -e "${BOLD}📦 Setting up a practice area...${RESET}"
TMPDIR="$HOME/.mr_linux_env_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Overview
clear
echo -e "${YELLOW}${BOLD}📁 Environment Ready! Let's explore 'env'.${RESET}"
pause

# Step 3: Explain 'env' command with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'env' Command Examples:${RESET}"

declare -A ENV_USAGE
ENV_USAGE["env"]="List all environment variables"
ENV_USAGE["env | grep USER"]="Show your current user variable"
ENV_USAGE["env VAR1=value VAR2=value command"]="Run a command with temporary environment variables"
ENV_USAGE["env -u VAR_NAME command"]="Unset a variable temporarily when running a command"
ENV_USAGE["printenv"]="Another command to show environment variables"

for cmd in "${!ENV_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${ENV_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task function
ask_and_check() {
    local description="$1"
    local hint="$2"
    local check_regex="$3"
    local skip_eval="${4:-false}"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type the command: " user_cmd

        if [[ "$user_cmd" =~ $check_regex ]]; then
            echo -e "${GREEN}✅ Correct!${RESET}"
            if [[ "$skip_eval" != true ]]; then
                eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive tasks
ask_and_check \
    "List all current environment variables" \
    "Try: env" \
    '^env[[:space:]]*$'

ask_and_check \
    "Use 'env' and 'grep' to show your USER variable" \
    "Try: env | grep USER" \
    '^env[[:space:]]*\|[[:space:]]*grep[[:space:]]+USER[[:space:]]*$'

ask_and_check \
    "Run 'env TEST_VAR=123 printenv TEST_VAR' to print a temp variable" \
    "Try: env TEST_VAR=123 printenv TEST_VAR" \
    '^env[[:space:]]+TEST_VAR=123[[:space:]]+printenv[[:space:]]+TEST_VAR[[:space:]]*$'

ask_and_check \
    "Temporarily unset USER when running printenv" \
    "Try: env -u USER printenv USER" \
    '^env[[:space:]]+-u[[:space:]]+USER[[:space:]]+printenv[[:space:]]+USER[[:space:]]*$'

ask_and_check \
    "Print your HOME environment variable using 'printenv'" \
    "Try: printenv HOME" \
    '^printenv[[:space:]]+HOME[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You’ve mastered the 'env' command!${RESET}"
echo -e "🧹 Cleaning up..."
rm -rf "$TMPDIR"
pause
