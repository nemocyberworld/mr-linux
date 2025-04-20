#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📁 Lesson: OpenSSL — Encryption, Decryption, and Hashing Basics${RESET}"
echo
echo "'openssl' is a powerful command-line tool for cryptographic operations such as encryption, decryption, key generation, and hashing."
pause

# Step 1: Create a working directory
echo -e "${BOLD}📦 Setting up environment...${RESET}"
TMPDIR="$HOME/.mr_linux_openssl_practice"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

echo "This is a secret message." > secret.txt
pause

# Step 2: Hashing with OpenSSL
clear
echo -e "${CYAN}${BOLD}🔐 Hashing Files${RESET}"
echo -e "OpenSSL can generate hashes using SHA or MD5 algorithms."

echo -e "\n➡️  Example: openssl dgst -sha256 secret.txt"
openssl dgst -sha256 secret.txt
pause

# Step 3: Symmetric encryption with AES
clear
echo -e "${CYAN}${BOLD}🔒 AES Encryption & Decryption${RESET}"
echo "We can encrypt files with AES using a passphrase."

echo -e "\n➡️  Example: openssl enc -aes-256-cbc -salt -in secret.txt -out secret.enc"
openssl enc -aes-256-cbc -salt -in secret.txt -out secret.enc
pause

echo -e "\n➡️  Now decrypt it:"
echo "Example: openssl enc -d -aes-256-cbc -in secret.enc -out decrypted.txt"
openssl enc -d -aes-256-cbc -in secret.enc -out decrypted.txt
pause

# Step 4: Compare original and decrypted file
echo -e "${YELLOW}📂 Verifying decryption:${RESET}"
echo -e "Original:"
cat secret.txt
echo -e "\nDecrypted:"
cat decrypted.txt
pause

# Step 5: Task checker
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

# Step 6: Interactive tasks
ask_and_check \
    "Generate a SHA-256 hash of 'secret.txt'" \
    "Try: openssl dgst -sha256 secret.txt" \
    '^openssl[[:space:]]+dgst[[:space:]]+-sha256[[:space:]]+secret\.txt[[:space:]]*$'

ask_and_check \
    "Encrypt 'secret.txt' using AES-256-CBC into 'cipher.bin'" \
    "Try: openssl enc -aes-256-cbc -salt -in secret.txt -out cipher.bin" \
    '^openssl[[:space:]]+enc[[:space:]]+-aes-256-cbc[[:space:]]+-salt[[:space:]]+-in[[:space:]]+secret\.txt[[:space:]]+-out[[:space:]]+cipher\.bin[[:space:]]*$'

ask_and_check \
    "Decrypt 'cipher.bin' into 'reveal.txt'" \
    "Try: openssl enc -d -aes-256-cbc -in cipher.bin -out reveal.txt" \
    '^openssl[[:space:]]+enc[[:space:]]+-d[[:space:]]+-aes-256-cbc[[:space:]]+-in[[:space:]]+cipher\.bin[[:space:]]+-out[[:space:]]+reveal\.txt[[:space:]]*$'

ask_and_check \
    "Verify the decrypted file matches original using diff" \
    "Try: diff secret.txt reveal.txt" \
    '^diff[[:space:]]+secret\.txt[[:space:]]+reveal\.txt[[:space:]]*$'

# Step 7: Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 You’ve completed the OpenSSL lesson! Solid work!${RESET}"
echo -e "🧹 Cleaning up practice environment..."
rm -rf "$TMPDIR"
pause
