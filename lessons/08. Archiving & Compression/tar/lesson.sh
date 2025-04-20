#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'tar' Command — Archive and Compress Files${RESET}"
echo
echo "'tar' (tape archive) is used to combine multiple files into a single archive file (.tar), and optionally compress them."
pause

# Step 1: Show help and usage
clear
echo -e "${YELLOW}${BOLD}📘 tar --help (partial):${RESET}"
tar --help | head -20
pause

# Step 2: Common tar usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'tar' Examples:${RESET}"

declare -A TAR_USAGE
TAR_USAGE["tar -cf archive.tar file.txt"]="Create an archive from file.txt"
TAR_USAGE["tar -xf archive.tar"]="Extract contents of archive.tar"
TAR_USAGE["tar -tf archive.tar"]="List contents of archive.tar"
TAR_USAGE["tar -czf archive.tar.gz dir/"]="Create a compressed tar.gz archive from a directory"
TAR_USAGE["tar -xzf archive.tar.gz"]="Extract a tar.gz compressed archive"

for cmd in "${!TAR_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${TAR_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Setup practice directory
PRACTICE_DIR="$SCRIPT_DIR/playground/tar_lesson"
mkdir -p "$PRACTICE_DIR/mydir"
echo "file one" > "$PRACTICE_DIR/mydir/file1.txt"
echo "file two" > "$PRACTICE_DIR/mydir/file2.txt"
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
    "Create a tar archive named 'mydir.tar' from the 'mydir' folder" \
    "Use 'tar -cf'" \
    "^tar[[:space:]]+-cf[[:space:]]+mydir\.tar[[:space:]]+mydir/?[[:space:]]*$"

ask_and_check \
    "List the contents of 'mydir.tar'" \
    "Use 'tar -tf'" \
    "^tar[[:space:]]+-tf[[:space:]]+mydir\.tar[[:space:]]*$"

ask_and_check \
    "Extract the 'mydir.tar' archive" \
    "Use 'tar -xf'" \
    "^tar[[:space:]]+-xf[[:space:]]+mydir\.tar[[:space:]]*$"

ask_and_check \
    "Create a compressed archive named 'mydir.tar.gz' from the 'mydir' directory" \
    "Use 'tar -czf'" \
    "^tar[[:space:]]+-czf[[:space:]]+mydir\.tar\.gz[[:space:]]+mydir/?[[:space:]]*$"

ask_and_check \
    "Extract 'mydir.tar.gz'" \
    "Use 'tar -xzf'" \
    "^tar[[:space:]]+-xzf[[:space:]]+mydir\.tar\.gz[[:space:]]*$"

# Step 6: Wrap up and cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
