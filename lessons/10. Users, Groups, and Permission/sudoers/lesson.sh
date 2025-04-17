#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🔐 Sudoers Configuration – Full Lesson${RESET}"
echo
echo "This lesson covers:"
echo "- Editing /etc/sudoers safely"
echo "- Granting sudo access"
echo "- Modular sudoers.d configs"
echo "- Advanced command restrictions"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}✍️ Edit sudoers safely with visudo${RESET}"
echo
echo "The sudoers file defines who can run what commands as root (or other users)."
echo "⚠️ Never edit it directly with nano/vim!"
echo -es "Use the safe editor: ${YELLOW}visudo${RESET}"
echo -e "\n${BOLD}➡️ sudo visudo${RESET}"
pause

# echo -e "${CYAN}${BOLD}🧩 Format of sudoers entries${RESET}"
# echo
# echo -e "Format: ${YELLOW}<user> <host>=<target_user> <commands>${RESET}"
# echo -e "Example: ${GREEN}alice ALL=(ALL) ALL${RESET}  → Full access to everything"
# pause

echo -e "${CYAN}${BOLD}🧩 Format of sudoers entries${RESET}"
echo
echo -e "The general format of a sudoers rule is:"
echo -e "${YELLOW}<user> <host> = (<target_user>) <commands>${RESET}"
echo
echo -e "Let’s break it down with an example:"
echo -e "${GREEN}alice ALL=(ALL) ALL${RESET}"
echo
echo -e "${BOLD}🔍 What each part means:${RESET}"
echo -e "${YELLOW}alice${RESET} — the username you're giving sudo access to."
echo -e "${YELLOW}ALL${RESET} (host) — means this rule applies no matter which host Alice logs into. Useful in multi-host setups."
echo -e "${YELLOW}(ALL)${RESET} (target user) — means Alice can act as *any* user, including root."
echo -e "${YELLOW}ALL${RESET} (commands) — means she can run *any* command with sudo."
pause

# ─────────────────────────────────────────────────────────────
# TMPDIR="$HOME/.mr_linux_sudoers"
# mkdir -p "$TMPDIR/sudoers.d"
# cd "$TMPDIR" || exit 1

# echo "bob ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart apache2" > "$TMPDIR/sudoers.d/bob"
# echo "charlie ALL=(ALL) NOPASSWD: /usr/bin/systemctl start nginx, !/usr/bin/systemctl stop nginx" > "$TMPDIR/sudoers.d/charlie"
# chmod 440 "$TMPDIR/sudoers.d/"*

TMPDIR="$HOME/.mr_linux_sudoers_simulated"
SUDOERS_D="$TMPDIR/sudoers.d"

mkdir -p "$SUDOERS_D"
cd "$TMPDIR" || exit 1

# Fake sudoers files
echo "bob ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart apache2" > "$SUDOERS_D/bob"
echo "charlie ALL=(ALL) NOPASSWD: /usr/bin/systemctl start nginx, !/usr/bin/systemctl stop nginx" > "$SUDOERS_D/charlie"
chmod 440 "$SUDOERS_D"/*

echo -e "${CYAN}${BOLD}🔧 Simulated sudoers environment created${RESET}"
echo "To avoid requiring root, we're using a fake /etc/sudoers.d/ in:"
echo -e "${YELLOW}$SUDOERS_D${RESET}"


echo -e "${CYAN}${BOLD}📂 Modular sudo rules with /etc/sudoers.d/${RESET}"
echo
echo "Instead of editing the main sudoers file, we can put small config files into:"
echo -e "${YELLOW}/etc/sudoers.d/<filename>${RESET}"
echo
echo -e "Each file must have ${BOLD}chmod 440${RESET} permissions."
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}⚙️ Advanced Examples${RESET}"
echo
echo -e "${YELLOW}1. Full sudo access:${RESET}"
echo -e "${GREEN}alice ALL=(ALL) ALL${RESET}"

echo -e "\n${YELLOW}2. Passwordless sudo:${RESET}"
echo -e "${GREEN}bob ALL=(ALL) NOPASSWD: ALL${RESET}"

echo -e "\n${YELLOW}3. Specific command without password:${RESET}"
echo -e "${GREEN}carol ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart apache2${RESET}"

echo -e "\n${YELLOW}4. Allow start but deny stop:${RESET}"
echo -e "${GREEN}charlie ALL=(ALL) NOPASSWD: /usr/bin/systemctl start nginx, !/usr/bin/systemctl stop nginx${RESET}"
pause

# ─────────────────────────────────────────────────────────────
ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your answer: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Try again!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Write a sudoers line that gives 'alice' full access (with password)" \
    "Format: <user> ALL=(ALL) ALL" \
    '^alice\s+ALL=\(ALL\)\s+ALL$' \
    "Correct! Full access with password."

ask_and_check \
    "Give 'bob' passwordless full sudo access" \
    "Try: bob ALL=(ALL) NOPASSWD: ALL" \
    '^bob\s+ALL=\(ALL\)\s+NOPASSWD:\s+ALL$' \
    "Nice! NOPASSWD skips password prompt."

ask_and_check \
    "Let 'carol' restart apache2 without password" \
    "Use full path: /usr/bin/systemctl restart apache2" \
    '^carol\s+ALL=\(ALL\)\s+NOPASSWD:\s+/usr/bin/systemctl restart apache2$' \
    "Exactly! Restrict to one command."

ask_and_check \
    "Where do modular sudoers rules go?" \
    "It's a directory under /etc for sudo rules" \
    '^/etc/sudoers\.d/?$' \
    "Yep! That's the right directory."

ask_and_check \
    "Write a sudoers.d entry for 'bob' to restart apache2 without password" \
    "Same as carol's line, but for bob" \
    '^bob\s+ALL=\(ALL\)\s+NOPASSWD:\s+/usr/bin/systemctl restart apache2$' \
    "Great job. You can put that into /etc/sudoers.d/bob"

ask_and_check \
    "Allow 'charlie' to start nginx but not stop it" \
    "Use ! before the command you want to deny" \
    '^charlie\s+ALL=\(ALL\)\s+NOPASSWD:\s+/usr/bin/systemctl start nginx,\s*!/usr/bin/systemctl stop nginx$' \
    "Perfect! Combined allow and deny rules in one line."

# ─────────────────────────────────────────────────────────────
echo -e "${GREEN}${BOLD}🎉 All tasks completed!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up your sandbox...${RESET}"
rm -rf "$TMPDIR"
pause
