#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'dpkg' Tool — Debian Package Manager (Low-Level)${RESET}"
echo
echo "'dpkg' is a low-level tool used to install, manage, and remove .deb packages manually on Debian-based systems like Ubuntu."
pause

# Step 1: Introduction and basic usage
clear
echo -e "${YELLOW}${BOLD}🔧 Step 1: Installing a .deb Package with dpkg${RESET}"
echo -e "${BOLD}➡️ Command: sudo dpkg -i package.deb${RESET}"
echo "This installs a .deb package. Use it when you manually download .deb files (e.g., from a website)."
pause

# Step 2: Show dpkg commands with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'dpkg' Commands and Their Usage:${RESET}"

declare -A DPKG_USAGE
DPKG_USAGE["sudo dpkg -i sample.deb"]="Install a local .deb file"
DPKG_USAGE["dpkg -l"]="List all installed packages"
DPKG_USAGE["dpkg -l | grep nano"]="Check if 'nano' package is installed"
DPKG_USAGE["dpkg -s nano"]="Show status of a package"
DPKG_USAGE["dpkg -L nano"]="List files installed by a package"
DPKG_USAGE["dpkg -S /bin/nano"]="Find which package owns a file"
DPKG_USAGE["sudo dpkg -r nano"]="Remove a package (keep config)"
DPKG_USAGE["sudo dpkg -P nano"]="Purge a package (remove config too)"

for cmd in "${!DPKG_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${DPKG_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Tasks
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
            echo -e "${CYAN}⚠️  No real installation/removal will happen (simulated)${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "List all installed packages" \
    "Try: dpkg -l" \
    "^dpkg[[:space:]]+-l[[:space:]]*$"

ask_and_check \
    "Check if 'nano' is installed" \
    "Try: dpkg -l | grep nano" \
    "^dpkg[[:space:]]+-l[[:space:]]*\|[[:space:]]*grep[[:space:]]+nano[[:space:]]*$"

ask_and_check \
    "Show info about the 'nano' package" \
    "Try: dpkg -s nano" \
    "^dpkg[[:space:]]+-s[[:space:]]+nano[[:space:]]*$"

ask_and_check \
    "Find which package installed /bin/nano" \
    "Try: dpkg -S /bin/nano" \
    "^dpkg[[:space:]]+-S[[:space:]]+/bin/nano[[:space:]]*$"

ask_and_check \
    "Remove the package 'nano'" \
    "Try: sudo dpkg -r nano" \
    "^sudo[[:space:]]+dpkg[[:space:]]+-r[[:space:]]+nano[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'dpkg' lesson.${RESET}"
echo -e "🧠 'dpkg' is powerful for managing .deb packages when 'apt' is not involved."
pause
