#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: GnuPG (gpg) — Encrypting, Decrypting, and Managing Keys${RESET}"
echo
echo "'gpg' (Gnu Privacy Guard) allows secure encryption, decryption, and digital signatures using both symmetric and asymmetric cryptography."
pause

# Step 1: Setup
echo -e "${BOLD}📦 Setting up environment...${RESET}"
TMPDIR="$HOME/.mr_linux_gpg_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "Top Secret: The flag is in the castle." > message.txt
pause

# Step 2: Symmetric encryption
clear
echo -e "${CYAN}${BOLD}🔐 Symmetric Encryption with GPG${RESET}"
echo -e "Encrypt a file with a passphrase (no keypair needed)."

echo -e "\n➡️  Example: gpg -c message.txt"
echo "You'll be asked to enter a passphrase."
gpg -c message.txt
pause

echo -e "\n➡️  Decrypt with:"
echo "Example: gpg message.txt.gpg"
gpg message.txt.gpg
pause

# Step 3: Asymmetric encryption
clear
echo -e "${CYAN}${BOLD}🔑 Asymmetric Keypair Generation & Encryption${RESET}"
echo -e "GPG allows you to generate a keypair to encrypt messages for specific recipients."

echo -e "\n➡️  Generate a key (use default options and fake name/email):"
gpg --batch --gen-key <<EOF
%no-protection
Key-Type: RSA
Key-Length: 2048
Name-Real: Mr Linux Student
Name-Email: student@example.com
Expire-Date: 0
%commit
EOF
pause

# Step 4: Encrypt with public key
echo -e "\n➡️  Encrypt the file for yourself:"
gpg --output message_pub.gpg --encrypt --recipient student@example.com message.txt
pause

# Step 5: Decrypt with private key
echo -e "\n➡️  Now decrypt using your private key:"
gpg --output decrypted.txt --decrypt message_pub.gpg
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
    "Encrypt 'message.txt' symmetrically" \
    "Try: gpg -c message.txt" \
    '^gpg[[:space:]]+-c[[:space:]]+message\.txt[[:space:]]*$'

ask_and_check \
    "Decrypt the file 'message.txt.gpg'" \
    "Try: gpg message.txt.gpg" \
    '^gpg[[:space:]]+message\.txt\.gpg[[:space:]]*$'

ask_and_check \
    "List your GPG keys" \
    "Try: gpg --list-keys" \
    '^gpg[[:space:]]+--list-keys[[:space:]]*$' true

ask_and_check \
    "Encrypt 'message.txt' with your public key" \
    "Try: gpg --output out.gpg --encrypt --recipient student@example.com message.txt" \
    '^gpg[[:space:]]+--output[[:space:]]+out\.gpg[[:space:]]+--encrypt[[:space:]]+--recipient[[:space:]]+student@example\.com[[:space:]]+message\.txt[[:space:]]*$'

ask_and_check \
    "Decrypt 'out.gpg' into 'reveal.txt'" \
    "Try: gpg --output reveal.txt --decrypt out.gpg" \
    '^gpg[[:space:]]+--output[[:space:]]+reveal\.txt[[:space:]]+--decrypt[[:space:]]+out\.gpg[[:space:]]*$'

# Step 8: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Great job! You've mastered GPG basics!${RESET}"
echo -e "🧹 Cleaning up practice environment and GPG keys..."

# Clean up
gpg --batch --yes --delete-secret-keys student@example.com >/dev/null 2>&1
gpg --batch --yes --delete-keys student@example.com >/dev/null 2>&1
rm -rf "$TMPDIR"
pause
