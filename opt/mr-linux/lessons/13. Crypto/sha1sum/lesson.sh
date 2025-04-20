#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: 'sha1sum' — File Hashing and Verification${RESET}"
echo
echo "'sha1sum' generates and checks SHA-1 hashes — a 160-bit hash commonly used to verify file integrity."
echo "Note: While SHA-1 is considered weak for cryptographic use, it's still widely used for file verification."
pause

# Step 1: Setup
echo -e "${BOLD}📦 Setting up practice environment...${RESET}"
TMPDIR="$HOME/.mr_linux_sha1sum_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "The original trusted content." > trusted.txt
cp trusted.txt backup.txt
pause

# Step 2: Generate SHA-1 Hash
clear
echo -e "${CYAN}${BOLD}🔐 Generate a SHA-1 Hash${RESET}"
echo -e "➡️  Example: sha1sum trusted.txt"
sha1sum trusted.txt
pause

# Step 3: Save Hash for Later Verification
clear
echo -e "${CYAN}${BOLD}📥 Save the SHA-1 hash to a file${RESET}"
sha1sum trusted.txt > trusted.sha1
echo -e "✅ Saved hash to 'trusted.sha1'"
pause

# Step 4: Verify Using Saved Hash
clear
echo -e "${CYAN}${BOLD}✅ Verify file with saved SHA-1 hash${RESET}"
echo -e "➡️  Example: sha1sum -c trusted.sha1"
sha1sum -c trusted.sha1
pause

# Step 5: Simulate Tampering
echo -e "${YELLOW}⚠️ Simulating file tampering...${RESET}"
echo "Injected malicious content" >> trusted.txt
echo -e "Now verifying again:"
sha1sum -c trusted.sha1
pause

# Step 6: Task Checker
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
    "Generate a SHA-1 hash of 'backup.txt'" \
    "Try: sha1sum backup.txt" \
    '^sha1sum[[:space:]]+backup\.txt[[:space:]]*$'

ask_and_check \
    "Save the hash to 'backup.sha1'" \
    "Try: sha1sum backup.txt > backup.sha1" \
    '^sha1sum[[:space:]]+backup\.txt[[:space:]]+>[[:space:]]+backup\.sha1[[:space:]]*$'

ask_and_check \
    "Check integrity using saved hash" \
    "Try: sha1sum -c backup.sha1" \
    '^sha1sum[[:space:]]+-c[[:space:]]+backup\.sha1[[:space:]]*$'

ask_and_check \
    "Tamper with the file" \
    "Try: echo 'oops' >> backup.txt" \
    '^echo[[:space:]].+>>[[:space:]]+backup\.txt[[:space:]]*$'

ask_and_check \
    "Re-run the check and confirm it fails" \
    "Try: sha1sum -c backup.sha1" \
    '^sha1sum[[:space:]]+-c[[:space:]]+backup\.sha1[[:space:]]*$'

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You've completed the 'sha1sum' lesson! Well done!${RESET}"
echo -e "🧹 Cleaning up practice files..."
rm -rf "$TMPDIR"
pause
