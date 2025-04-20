#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: File & Directory Operations${RESET}"
echo
echo "In this lesson, you'll learn how to work with files and directories using Bash."
pause

# === Existence Checks ===
clear
echo -e "${CYAN}${BOLD}🔍 Checking File & Directory Existence${RESET}"
echo
echo "Use -f to check if a file exists:"
echo -e "${BOLD}[ -f file.txt ] && echo 'File exists'${RESET}"
echo
echo "Use -d to check if a directory exists:"
echo -e "${BOLD}[ -d myfolder ] && echo 'Directory exists'${RESET}"
pause

ask_and_check \
    "Check if a file named notes.txt exists" \
    "Try: [ -f notes.txt ] && echo Exists" \
    "^\[ -f notes.txt \] && echo Exists\$"

ask_and_check \
    "Check if a directory named data exists" \
    "Try: [ -d data ] && echo Exists" \
    "^\[ -d data \] && echo Exists\$"

# === Creating, Deleting, Renaming ===
clear
echo -e "${CYAN}${BOLD}🛠 Creating, Deleting, Renaming${RESET}"
echo
echo -e "${BOLD}touch file.txt${RESET} → Creates an empty file"
echo -e "${BOLD}mkdir myfolder${RESET} → Creates a directory"
echo -e "${BOLD}rm file.txt${RESET} → Deletes a file"
echo -e "${BOLD}rmdir myfolder${RESET} → Deletes an empty directory"
echo -e "${BOLD}mv old.txt new.txt${RESET} → Renames/moves a file"
pause

ask_and_check \
    "Create a file named hello.txt" \
    "Try: touch hello.txt" \
    "^touch hello.txt\$"

ask_and_check \
    "Create a directory named stuff" \
    "Try: mkdir stuff" \
    "^mkdir stuff\$"

ask_and_check \
    "Rename hello.txt to greetings.txt" \
    "Try: mv hello.txt greetings.txt" \
    "^mv hello.txt greetings.txt\$"

ask_and_check \
    "Delete greetings.txt" \
    "Try: rm greetings.txt" \
    "^rm greetings.txt\$"

ask_and_check \
    "Delete the directory stuff" \
    "Try: rmdir stuff" \
    "^rmdir stuff\$"

# === Reading Files Line-by-Line ===
clear
echo -e "${CYAN}${BOLD}📖 Reading Files Line-by-Line${RESET}"
echo
echo "To read each line in a file:"
echo -e "${BOLD}while IFS= read -r line; do echo \"Line: \$line\"; done < file.txt${RESET}"
pause

# Prepare a sample file
echo -e "apple\nbanana\ncherry" > fruits.txt

ask_and_check \
    "Read fruits.txt line-by-line and print with prefix" \
    "Try: while IFS= read -r line; do echo \"Fruit: \$line\"; done < fruits.txt" \
    "^while[[:space:]]+IFS=[[:space:]]*read[[:space:]]+-r[[:space:]]+line;[[:space:]]+do[[:space:]]+echo[[:space:]]+\\\"Fruit:[[:space:]]*\\\$line\\\";[[:space:]]+done[[:space:]]+< fruits.txt\$"


# Cleanup
rm -f fruits.txt

# === Wrap-Up ===
echo
echo -e "${GREEN}${BOLD}🎉 Great work!${RESET}"
echo "You've now seen how to check, create, delete, rename, and read files in Bash!"
pause
