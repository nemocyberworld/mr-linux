#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'gzip' Command — Compress Files${RESET}"
echo
echo "'gzip' is used to compress files using the GNU zip algorithm."
echo "It reduces file size and appends a .gz extension."
pause

# Step 1: Show help and usage
clear
echo -e "${YELLOW}${BOLD}📘 gzip --help:${RESET}"
gzip --help | head -20
pause

# Step 2: Common gzip usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'gzip' Examples:${RESET}"

declare -A GZIP_USAGE
GZIP_USAGE["gzip file.txt"]="Compress file.txt → file.txt.gz"
GZIP_USAGE["gzip -k file.txt"]="Compress file.txt but keep the original"
GZIP_USAGE["gzip -d file.txt.gz"]="Decompress a gzip file"
GZIP_USAGE["gzip -l file.txt.gz"]="List compressed file info"
GZIP_USAGE["gzip -r folder/"]="Recursively compress all files in a folder"

for cmd in "${!GZIP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${GZIP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Setup practice directory
PRACTICE_DIR="$SCRIPT_DIR/playground/gzip_lesson"
mkdir -p "$PRACTICE_DIR"
echo "This is a test file for gzip." > "$PRACTICE_DIR/file.txt"
cd "$PRACTICE_DIR" || exit

# Step 4: Interactive task system
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
            eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Tasks
ask_and_check \
    "Compress file.txt using gzip" \
    "Use gzip with the filename." \
    "^gzip[[:space:]]+file\.txt[[:space:]]*$"

ask_and_check \
    "Decompress file.txt.gz using gzip" \
    "Use gzip -d with the .gz file." \
    "^gzip[[:space:]]+-d[[:space:]]+file\.txt\.gz[[:space:]]*$"

ask_and_check \
    "Compress file.txt again but keep the original" \
    "Use gzip -k to keep the original file." \
    "^gzip[[:space:]]+-k[[:space:]]+file\.txt[[:space:]]*$"

# Step 6: Wrap up and cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
