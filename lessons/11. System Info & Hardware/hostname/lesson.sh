#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🧠 Lesson: 'hostname' — View or Set the System's Hostname${RESET}"
echo
echo -e "The ${YELLOW}hostname${RESET} command is used to display or change the system's hostname."
echo -e "The hostname is the name assigned to your machine on a network."
echo
echo -e "${BOLD}📌 Syntax:${RESET}"
echo -e "  ${GREEN}hostname [options] [new_hostname]${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📋 Common Usage:${RESET}"
echo -e "${YELLOW}hostname${RESET}         → Shows the current hostname"
echo -e "${YELLOW}hostname NEWNAME${RESET} → Temporarily sets a new hostname"
echo -e "${YELLOW}hostname -f${RESET}      → Shows the fully qualified domain name (FQDN)"
echo -e "${YELLOW}hostname -I${RESET}      → Shows the IP addresses of the host"
echo -e "${YELLOW}hostnamectl${RESET}      → Manage hostname (on systemd systems)"
pause

# ─────────────────────────────────────────────────────────────
TMPDIR="$HOME/.mr_linux_hostname_lesson"
mkdir -p "$TMPDIR"
cd "$TMPDIR" || exit 1

ask_and_check() {
    local description="$1"
    local hint="$2"
    local regex="$3"
    local success_msg="$4"

    while true; do
        echo
        echo -e "${CYAN}${BOLD}🧪 TASK: $description${RESET}"
        [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
        read -rp "💻 Type your command: " user_cmd

        if [[ "$user_cmd" =~ $regex ]]; then
            echo -e "${GREEN}✅ $success_msg${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again!${RESET}"
        fi
    done
    pause
    clear
}

# ─────────────────────────────────────────────────────────────
ask_and_check \
    "Show the current system hostname" \
    "It's just one word." \
    '^hostname\s*$' \
    "Good! That's how you check the current hostname."

ask_and_check \
    "Display the system's IP addresses" \
    "Use the -I option" \
    '^hostname\s+-I$' \
    "Nice! You can see assigned IPs."

ask_and_check \
    "Show the fully qualified domain name (FQDN)" \
    "Use -f" \
    '^hostname\s+-f$' \
    "Excellent! That's the full domain name."

ask_and_check \
    "Temporarily change the hostname to 'mrlinux-test'" \
    "Just append the new name" \
    '^hostname\s+mrlinux-test$' \
    "Awesome! But remember, this is temporary until reboot."

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}📦 Bonus: Set hostname permanently (Systemd only)${RESET}"
echo -e "Use ${YELLOW}hostnamectl set-hostname NEWNAME${RESET} to make the change persistent."
echo -e "Try this: ${GREEN}sudo hostnamectl set-hostname mrlinux-perm${RESET}"
pause

# ─────────────────────────────────────────────────────────────
echo -e "${CYAN}${BOLD}🧼 Cleaning up...${RESET}"
rm -rf "$TMPDIR"

echo -e "${GREEN}${BOLD}🎉 Lesson Complete!${RESET}"
echo "You've learned how to use ${YELLOW}hostname${RESET} to manage system names!"
pause