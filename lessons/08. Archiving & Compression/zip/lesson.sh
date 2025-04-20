#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'zip' Command — Compress Files into .zip Archives${RESET}"
echo
echo "'zip' is used to compress one or more files into a ZIP archive. It's commonly used for sharing and storage."
pause

# Step 1: Show help
clear
echo -e "${YELLOW}${BOLD}📘 zip --help (partial):${RESET}"
zip -h | head -20
pause

# Step 2: Common examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'zip' Examples:${RESET}"

declare -A ZIP_USAGE
ZIP_USAGE["zip archive.zip file.txt"]="Compress file.txt into archive.zip"
ZIP_USAGE["zip archive.zip file1.txt file2.txt"]="Compress multiple files"
ZIP_USAGE["zip -r archive.zip folder/"]="Recursively compress a folder"
ZIP_USAGE["unzip archive.zip"]="Extract files from archive.zip"
ZIP_USAGE["unzip -l archive.zip"]="List contents of the zip archive"

for cmd in "${!ZIP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${ZIP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Setup practice environment
PRACTICE_DIR="$SCRIPT_DIR/playground/zip_lesson"
mkdir -p "$PRACTICE_DIR/folder"
echo "hello world" > "$PRACTICE_DIR/file1.txt"
echo "linux zip tool" > "$PRACTICE_DIR/file2.txt"
echo "inside folder" > "$PRACTICE_DIR/folder/file3.txt"
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
    "Create a zip archive named 'files.zip' containing 'file1.txt'" \
    "Use: zip archive.zip file.txt" \
    "^zip[[:space:]]+files\.zip[[:space:]]+file1\.txt[[:space:]]*$"

ask_and_check \
    "Create a zip archive named 'multi.zip' with file1.txt and file2.txt" \
    "Use: zip archive.zip file1 file2" \
    "^zip[[:space:]]+multi\.zip[[:space:]]+file1\.txt[[:space:]]+file2\.txt[[:space:]]*$"

ask_and_check \
    "Create a zip archive named 'folder.zip' that includes the 'folder/' directory and its contents recursively" \
    "Use: zip -r folder.zip folder/" \
    "^zip[[:space:]]+-r[[:space:]]+folder\.zip[[:space:]]+folder/?[[:space:]]*$"

ask_and_check \
    "List the contents of 'folder.zip'" \
    "Use: unzip -l folder.zip" \
    "^unzip[[:space:]]+-l[[:space:]]+folder\.zip[[:space:]]*$"

ask_and_check \
    "Extract 'folder.zip'" \
    "Use: unzip folder.zip" \
    "^unzip[[:space:]]+folder\.zip[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've learned how to use zip!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
