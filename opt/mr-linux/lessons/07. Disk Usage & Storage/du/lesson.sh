#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📦 Lesson: The 'du' Command — Disk Usage of Files and Directories${RESET}"
echo
echo "'du' (disk usage) estimates file space usage."
echo "It's used to check the size of files and directories on your system."
pause

# Practice directory
TMPDIR="$HOME/.mr_linux_du_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

# Create sample data
mkdir -p dir1/subdir
echo "Sample text" > file1.txt
dd if=/dev/zero of=dir1/bigfile bs=1K count=500 &> /dev/null
echo "Another file" > dir1/subdir/file2.txt

# Step 1: Show example output
clear
echo -e "${YELLOW}${BOLD}🔍 Example Output:${RESET}"
echo -e "Let's look at the disk usage of the current directory:"
echo
du -sh ./*
pause

# Step 2: Show examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'du' Options and Examples:${RESET}"

declare -A DU_USAGE
DU_USAGE["du"]="Default usage – shows disk usage recursively"
DU_USAGE["du -h"]="Human-readable format (KB/MB/GB)"
DU_USAGE["du -s"]="Summary: total size only"
DU_USAGE["du -ah"]="Show all files and directories with human-readable sizes"
DU_USAGE["du -d 1"]="Limit depth to 1 level of subdirectories"

for cmd in "${!DU_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${DU_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Interactive task system
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

# Step 4: Tasks
ask_and_check \
    "Show disk usage of current directory in human-readable format" \
    "Use: du -h" \
    "^du[[:space:]]+-h[[:space:]]*\.*$"

ask_and_check \
    "Show only the total size of 'dir1' in human-readable format" \
    "Use: du -sh dir1" \
    "^du[[:space:]]+-sh[[:space:]]+dir1[[:space:]]*$"

ask_and_check \
    "Show the size of all files and directories in dir1 with depth 1" \
    "Use: du -h -d 1 dir1" \
    "^du[[:space:]]+-h[[:space:]]+-d[[:space:]]+1[[:space:]]+dir1[[:space:]]*$"

# Step 5: Cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
rm -rf "$TMPDIR"
pause
