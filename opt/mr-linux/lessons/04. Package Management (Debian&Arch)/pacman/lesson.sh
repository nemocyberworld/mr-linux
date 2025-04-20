#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'pacman' Tool — Arch Linux Package Manager${RESET}"
echo
echo "'pacman' is the package manager used in Arch Linux and Arch-based distros (like Manjaro). It installs, updates, and removes packages from the official repositories or local files."
pause

# Step 1: Introduction and basic usage
clear
echo -e "${YELLOW}${BOLD}🔧 Step 1: Installing a Package with pacman${RESET}"
echo -e "${BOLD}➡️ Command: sudo pacman -S package_name${RESET}"
echo "Installs the specified package from the official repositories."
pause

# Step 2: Show pacman commands with examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'pacman' Commands and Their Usage:${RESET}"

declare -A PACMAN_USAGE
PACMAN_USAGE["sudo pacman -S nano"]="Install a package"
PACMAN_USAGE["sudo pacman -R nano"]="Remove a package"
PACMAN_USAGE["sudo pacman -Rs nano"]="Remove a package and its unused dependencies"
PACMAN_USAGE["sudo pacman -Ss nano"]="Search for a package"
PACMAN_USAGE["sudo pacman -Qi nano"]="Get detailed info about a package"
PACMAN_USAGE["sudo pacman -Ql nano"]="List files installed by a package"
PACMAN_USAGE["sudo pacman -Qk nano"]="Check for missing files of a package"
PACMAN_USAGE["sudo pacman -Qdt"]="List orphaned packages"
PACMAN_USAGE["sudo pacman -Rns $(pacman -Qdtq)"]="Remove orphaned packages"
PACMAN_USAGE["sudo pacman -Syu"]="Update system (sync + upgrade)"
PACMAN_USAGE["sudo pacman -Sy"]="Update package database only"

for cmd in "${!PACMAN_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${PACMAN_USAGE[$cmd]}${RESET}"
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
    "Install the 'htop' package" \
    "Try: sudo pacman -S htop" \
    "^sudo[[:space:]]+pacman[[:space:]]+-S[[:space:]]+htop[[:space:]]*$"

ask_and_check \
    "Remove the 'nano' package" \
    "Try: sudo pacman -R nano" \
    "^sudo[[:space:]]+pacman[[:space:]]+-R[[:space:]]+nano[[:space:]]*$"

ask_and_check \
    "Search for the 'vim' package" \
    "Try: sudo pacman -Ss vim" \
    "^sudo[[:space:]]+pacman[[:space:]]+-Ss[[:space:]]+vim[[:space:]]*$"

ask_and_check \
    "List orphaned packages" \
    "Try: sudo pacman -Qdt" \
    "^sudo[[:space:]]+pacman[[:space:]]+-Qdt[[:space:]]*$"

ask_and_check \
    "Update all packages on the system" \
    "Try: sudo pacman -Syu" \
    "^sudo[[:space:]]+pacman[[:space:]]+-Syu[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've completed the 'pacman' lesson.${RESET}"
echo -e "🧠 'pacman' is fast, powerful, and perfect for Arch users!"
pause
