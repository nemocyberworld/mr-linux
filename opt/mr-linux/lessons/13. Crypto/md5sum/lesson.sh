#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'md5sum' — File Hashing and Verification${RESET}"
echo
echo "'md5sum' computes the MD5 checksum of a file — a 128-bit hash. It's fast and useful for verifying data integrity, but not suitable for secure applications due to collision weaknesses."
pause

# Step 1: Setup environment
echo -e "${BOLD}📦 Creating test files...${RESET}"
TMPDIR="$HOME/.mr_linux_md5sum_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "This is a sample file." > sample.txt
cp sample.txt copy.txt
pause

# Step 2: Generate MD5 Hash
clear
echo -e "${CYAN}${BOLD}🔐 Generate MD5 hash for a file${RESET}"
echo -e "➡️  Example: md5sum sample.txt"
md5sum sample.txt
pause

# Step 3: Save hash for verification
clear
echo -e "${CYAN}${BOLD}📥 Save hash to a file for later verification${RESET}"
md5sum sample.txt > sample.md5
echo -e "✅ Hash saved to 'sample.md5'"
pause

# Step 4: Verify checksum
clear
echo -e "${CYAN}${BOLD}✅ Verify using the saved hash${RESET}"
echo -e "➡️  Example: md5sum -c sample.md5"
md5sum -c sample.md5
pause

# Step 5: Simulate file tampering
echo -e "${YELLOW}⚠️ Tampering with the file...${RESET}"
echo "Malicious change." >> sample.txt
echo -e "Now re-check the file:"
md5sum -c sample.md5
pause

# Step 6: Task checker
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

# Step 7: Interactive Tasks
ask_and_check \
    "Generate the MD5 hash of 'copy.txt'" \
    "Try: md5sum copy.txt" \
    '^md5sum[[:space:]]+copy\.txt[[:space:]]*$'

ask_and_check \
    "Save the hash of 'copy.txt' to 'copy.md5'" \
    "Try: md5sum copy.txt > copy.md5" \
    '^md5sum[[:space:]]+copy\.txt[[:space:]]+>[[:space:]]+copy\.md5[[:space:]]*$'

ask_and_check \
    "Verify 'copy.txt' using its saved hash" \
    "Try: md5sum -c copy.md5" \
    '^md5sum[[:space:]]+-c[[:space:]]+copy\.md5[[:space:]]*$'

ask_and_check \
    "Tamper with the file by adding text" \
    "Try: echo 'hack' >> copy.txt" \
    '^echo[[:space:]].+>>[[:space:]]+copy\.txt[[:space:]]*$'

ask_and_check \
    "Re-run the integrity check on 'copy.md5'" \
    "Try: md5sum -c copy.md5" \
    '^md5sum[[:space:]]+-c[[:space:]]+copy\.md5[[:space:]]*$'

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'md5sum' lesson! Great job!${RESET}"
echo -e "🧹 Cleaning up environment..."
rm -rf "$TMPDIR"
pause
