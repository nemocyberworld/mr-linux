#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧩 Lesson: Writing Modular & Reusable Scripts${RESET}"
echo
echo "Let's make our Bash scripts smarter, cleaner, and more reusable. We'll explore sourcing scripts, using config files, and logging like a pro."
pause

ask_and_check() {
    local title="$1"
    local expected_hint="$2"
    local expected_code="$3"
    local expected_output="$4"

    echo -e "${YELLOW}${BOLD}$title${RESET}"
    echo "$expected_hint"
    echo

    local user_input
    if [[ "$expected_code" == *$'\n'* ]]; then
        echo -e "${CYAN}(Enter your input. Press Ctrl+D when done)${RESET}"
        user_input="$(</dev/stdin)"
    else
        read -rp "> " user_input
    fi

    local cleaned_user
    local cleaned_expected
    cleaned_user=$(echo "$user_input" | sed 's/[[:space:]]\+$//' | sed '/^$/d')
    cleaned_expected=$(echo "$expected_code" | sed 's/[[:space:]]\+$//' | sed '/^$/d')

    if diff -u <(echo "$cleaned_user") <(echo "$cleaned_expected") >/dev/null; then
        if [[ -n "$expected_output" ]]; then
            output=$(eval "$user_input" 2>/dev/null)
            if [[ "$output" == "$expected_output" ]]; then
                echo -e "${GREEN}✅ Correct!${RESET}"
            else
                echo -e "${RED}❌ Output incorrect. Got: '$output', expected: '$expected_output'${RESET}"
            fi
        else
            echo -e "${GREEN}✅ Correct!${RESET}"
        fi
    else
        echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        echo "Expected something like:"
        echo "$expected_code"
    fi
    pause
}

# === Sourcing Scripts ===
clear
echo -e "${CYAN}${BOLD}📦 Reuse code with source${RESET}"
echo
echo "Instead of rewriting functions, put them in reusable files and source them!"
pause

echo "Creating helper.sh..."
echo -e '#!/bin/bash\nlog_info() { echo "[INFO] $1"; }' > helper.sh

ask_and_check \
  "Source a script and call a function from it" \
  "Try: source helper.sh; log_info 'Script loaded'" \
  "source helper.sh; log_info 'Script loaded'" \
  "[INFO] Script loaded"

# === Using Config Files ===
clear
echo -e "${CYAN}${BOLD}⚙️  Config Files${RESET}"
echo
echo "Separate configuration from logic."
pause

echo "Creating config.env..."
echo -e 'LOG_LEVEL=debug\nOUTPUT_DIR=results' > config.env

ask_and_check \
  "Load configuration from a file" \
  "Try: source config.env; echo \"Log: \$LOG_LEVEL, Dir: \$OUTPUT_DIR\"" \
  "source config.env; echo \"Log: \$LOG_LEVEL, Dir: \$OUTPUT_DIR\"" \
  "Log: debug, Dir: results"

# === Logging & Structured Output ===
clear
echo -e "${CYAN}${BOLD}📝 Logging and Structured Output${RESET}"
echo
echo "Consistent logging makes scripts easier to debug and monitor."
pause

ask_and_check \
  "Add logging functions" \
  "Try:
log() { echo \"[\$(date +%T)] \$1\"; }
log 'Starting script...'" \
  "log() { echo \"[\$(date +%T)] \$1\"; }
log 'Starting script...'"

# === Wrap-up ===
clear
echo -e "${GREEN}${BOLD}🎉 You now write cleaner, modular scripts!${RESET}"
echo
echo "✅ Source files to reuse functions"
echo "✅ Config files for customization"
echo "✅ Logging for observability"
pause
