#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'apt' Tool — Debian/Ubuntu Package Manager${RESET}"
echo
echo "'apt' is the command-line package manager used in Debian-based systems (like Ubuntu) for installing, updating, upgrading, and removing packages."
pause

# Step 1: Update Package Index (dry run)
clear
echo -e "${YELLOW}${BOLD}🔧 Step 1: Update the package list from repositories${RESET}"
echo -e "${BOLD}➡️ Command: sudo apt update${RESET}"
echo -e "This command fetches the latest list of available packages and versions from your configured sources."
pause

# Step 2: Show 'apt' commands with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'apt' Commands and Their Usage:${RESET}"

declare -A APT_USAGE
APT_USAGE["sudo apt update"]="Update the list of available packages"
APT_USAGE["sudo apt upgrade"]="Upgrade all upgradable packages"
APT_USAGE["sudo apt install cowsay"]="Install a package (example: cowsay)"
APT_USAGE["sudo apt remove cowsay"]="Remove a package (example: cowsay)"
APT_USAGE["sudo apt purge cowsay"]="Remove a package and its config files"
APT_USAGE["sudo apt autoremove"]="Remove unnecessary dependencies"
APT_USAGE["apt show cowsay"]="Show detailed info about a package"
APT_USAGE["apt list --installed"]="List all installed packages"
APT_USAGE["apt search cowsay"]="Search for packages matching a keyword"

for cmd in "${!APT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${APT_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Tasks
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
                echo -e "${CYAN}⚠️ (Simulated — no real install/remove will happen in this lesson)${RESET}"
            fi
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Update the package list from repositories" \
    "Try: sudo apt update" \
    "^sudo[[:space:]]+apt[[:space:]]+update[[:space:]]*$" true

ask_and_check \
    "Search for a package named 'htop'" \
    "Try: apt search htop" \
    "^apt[[:space:]]+search[[:space:]]+htop[[:space:]]*$" true

ask_and_check \
    "Install the package 'cowsay'" \
    "Try: sudo apt install cowsay" \
    "^sudo[[:space:]]+apt[[:space:]]+install[[:space:]]+cowsay[[:space:]]*$" true

ask_and_check \
    "Remove the package 'cowsay'" \
    "Try: sudo apt remove cowsay" \
    "^sudo[[:space:]]+apt[[:space:]]+remove[[:space:]]+cowsay[[:space:]]*$" true

ask_and_check \
    "List all installed packages" \
    "Try: apt list --installed" \
    "^apt[[:space:]]+list[[:space:]]+--installed[[:space:]]*$" true

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'apt' lesson.${RESET}"
echo -e "🧠 Use 'apt' to manage packages on Debian-based Linux distributions."
pause
