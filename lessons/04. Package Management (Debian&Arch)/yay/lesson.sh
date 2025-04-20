#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🚀 Lesson: The 'yay' Tool — AUR Helper for Arch Linux${RESET}"
echo
echo "'yay' (Yet Another Yaourt) is an AUR helper that simplifies package management on Arch Linux and Arch-based distros like Manjaro. It supports both official and AUR packages in a unified way."
pause

# Step 1: Intro and basic install usage
clear
echo -e "${YELLOW}${BOLD}🧰 Step 1: Installing a Package with yay${RESET}"
echo -e "${BOLD}➡️ Command: yay -S package_name${RESET}"
echo "Installs the specified package, from either official repo or the AUR."
pause

# Step 2: Common yay commands
clear
echo -e "${CYAN}${BOLD}📚 Common 'yay' Commands:${RESET}"

declare -A YAY_USAGE
YAY_USAGE["yay -S package"]="Install a package (official or AUR)"
YAY_USAGE["yay -R package"]="Remove a package"
YAY_USAGE["yay -Ss keyword"]="Search for a package"
YAY_USAGE["yay -Qs keyword"]="Search installed packages"
YAY_USAGE["yay -Qi package"]="Show package info"
YAY_USAGE["yay -Ql package"]="List package files"
YAY_USAGE["yay -Yc"]="Remove orphaned packages"
YAY_USAGE["yay"]="Update all packages (official and AUR)"
YAY_USAGE["yay -Sc"]="Clean package cache"

for cmd in "${!YAY_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${YAY_USAGE[$cmd]}${RESET}"
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
            echo -e "${CYAN}⚠️  This is a simulation. No real installation/removal will occur.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Install the 'neofetch' package using yay" \
    "Try: yay -S neofetch" \
    "^yay[[:space:]]+-S[[:space:]]+neofetch[[:space:]]*$"

ask_and_check \
    "Search for a package named 'spotify'" \
    "Try: yay -Ss spotify" \
    "^yay[[:space:]]+-Ss[[:space:]]+spotify[[:space:]]*$"

ask_and_check \
    "Remove a package called 'cowsay'" \
    "Try: yay -R cowsay" \
    "^yay[[:space:]]+-R[[:space:]]+cowsay[[:space:]]*$"

ask_and_check \
    "Update all packages" \
    "Try: yay" \
    "^yay[[:space:]]*$"

ask_and_check \
    "Remove orphaned packages" \
    "Try: yay -Yc" \
    "^yay[[:space:]]+-Yc[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'yay' lesson.${RESET}"
echo -e "🧠 You now know how to install and manage AUR packages with ease!"
pause
