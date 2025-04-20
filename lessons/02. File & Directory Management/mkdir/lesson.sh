#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: The 'mkdir' Command — Full Guide${RESET}"
echo
echo "'mkdir' is used to create directories in Linux."
echo "It can create single or multiple directories, with support for parent creation and permission settings."
pause

# Step 1: Setup practice directory
echo -e "${BOLD}📦 Setting up a safe practice area...${RESET}"
TMPDIR="$HOME/.mr_linux_mkdir_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1
pause

# Step 2: Show current structure
clear
echo -e "${YELLOW}${BOLD}📘 Starting in empty practice directory:${RESET}"
tree "$TMPDIR"
pause

# Step 3: Show all mkdir options with examples
clear
echo -e "${CYAN}${BOLD}📚 Useful 'mkdir' Command Options and Examples:${RESET}"

declare -A MKDIR_USAGE
MKDIR_USAGE["mkdir dir1"]="Create a single directory"
MKDIR_USAGE["mkdir dir2 dir3"]="Create multiple directories"
MKDIR_USAGE["mkdir -p parent/child/grandchild"]="Create nested directories (parents auto-created)"
MKDIR_USAGE["mkdir -v dir4"]="Verbose mode: show created directories"
MKDIR_USAGE["mkdir -m 755 secure_dir"]="Create dir with specific permissions"

for cmd in "${!MKDIR_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${MKDIR_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    sleep 1
    pause
done

# Step 4: Task checker
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
    "Create a directory named 'projects'" \
    "Try: mkdir projects" \
    '^mkdir[[:space:]]+projects[[:space:]]*$'

ask_and_check \
    "Create three directories: one, two, and three" \
    "Try: mkdir one two three" \
    '^mkdir[[:space:]]+one[[:space:]]+two[[:space:]]+three[[:space:]]*$'

ask_and_check \
    "Create nested directories 'a/b/c' using one command" \
    "Try: mkdir -p a/b/c" \
    '^mkdir[[:space:]]+-p[[:space:]]+a/b/c[[:space:]]*$'

ask_and_check \
    "Create a directory named 'logdir' and display confirmation" \
    "Try: mkdir -v logdir" \
    '^mkdir[[:space:]]+-v[[:space:]]+logdir[[:space:]]*$'

ask_and_check \
    "Create 'secure_dir' with 700 permissions" \
    "Try: mkdir -m 700 secure_dir" \
    '^mkdir[[:space:]]+-m[[:space:]]+700[[:space:]]+secure_dir[[:space:]]*$'

# Step 6: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'mkdir' lesson! Excellent work!${RESET}"
echo -e "🧹 Cleaning up practice area..."
rm -rf "$TMPDIR"
pause
