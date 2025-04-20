#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'sha256sum' — File Hashing and Verification${RESET}"
echo
echo "'sha256sum' is a command-line utility to calculate and verify SHA-256 checksums for files. It's useful for verifying file integrity and detecting tampering."
pause

# Step 1: Create environment
echo -e "${BOLD}📦 Setting up practice files...${RESET}"
TMPDIR="$HOME/.mr_linux_sha256sum_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "This is the original content." > file.txt
cp file.txt file_copy.txt
pause

# Step 2: Calculate SHA-256 hash
clear
echo -e "${CYAN}${BOLD}🔐 Calculate a SHA-256 Hash${RESET}"
echo "Run 'sha256sum' to generate the hash of a file."

echo -e "\n➡️  Example: sha256sum file.txt"
sha256sum file.txt
pause

# Step 3: Save hash for verification
clear
echo -e "${CYAN}${BOLD}📝 Saving hash to a file for integrity checks${RESET}"
sha256sum file.txt > file.sha256
echo -e "✅ Hash saved to 'file.sha256'"
pause

# Step 4: Verify the checksum
clear
echo -e "${CYAN}${BOLD}✅ Verify a file using a saved checksum${RESET}"

echo -e "\n➡️  Example: sha256sum -c file.sha256"
sha256sum -c file.sha256
pause

# Step 5: Modify file and re-verify
echo -e "${YELLOW}⚠️ Let's simulate tampering...${RESET}"
echo "Extra content" >> file.txt
echo -e "Now try verifying again:"
sha256sum -c file.sha256
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
    "Generate a SHA-256 hash of 'file_copy.txt'" \
    "Try: sha256sum file_copy.txt" \
    '^sha256sum[[:space:]]+file_copy\.txt[[:space:]]*$'

ask_and_check \
    "Save the hash of 'file_copy.txt' to 'copy.sha256'" \
    "Try: sha256sum file_copy.txt > copy.sha256" \
    '^sha256sum[[:space:]]+file_copy\.txt[[:space:]]+>[[:space:]]+copy\.sha256[[:space:]]*$'

ask_and_check \
    "Verify 'file_copy.txt' with 'copy.sha256'" \
    "Try: sha256sum -c copy.sha256" \
    '^sha256sum[[:space:]]+-c[[:space:]]+copy\.sha256[[:space:]]*$'

ask_and_check \
    "Corrupt 'file_copy.txt' by adding a line to it" \
    "Try: echo 'bad stuff' >> file_copy.txt" \
    '^echo[[:space:]]+.\+>>[[:space:]]+file_copy\.txt[[:space:]]*$'

ask_and_check \
    "Re-check 'copy.sha256' and see it fails" \
    "Try: sha256sum -c copy.sha256" \
    '^sha256sum[[:space:]]+-c[[:space:]]+copy\.sha256[[:space:]]*$'

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the 'sha256sum' lesson! Nice work!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
