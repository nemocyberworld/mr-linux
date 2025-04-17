#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🎯 Lesson: The 'systemctl' Command — Manage systemd Services${RESET}"
echo
echo "'systemctl' is the main command used to examine and control the systemd system and service manager."
pause

# Step 1: Display help
clear
echo -e "${YELLOW}${BOLD}📘 systemctl Help:${RESET}"
echo -e "${BOLD}Syntax:${RESET} systemctl [command] [unit]"
echo
echo -e "${BOLD}Examples of units:${RESET} nginx.service, sshd.service"
echo -e "${BOLD}Common systemctl commands:${RESET}"
echo -e "  start, stop, restart, status, enable, disable, is-active, is-enabled"
pause

# Step 2: Common usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'systemctl' Examples:${RESET}"

declare -A SYSTEMCTL_USAGE
SYSTEMCTL_USAGE["systemctl status"]="Shows the overall systemd status"
SYSTEMCTL_USAGE["systemctl status ssh"]="Shows status of the ssh service"
SYSTEMCTL_USAGE["systemctl start ssh"]="Starts the ssh service"
SYSTEMCTL_USAGE["systemctl stop ssh"]="Stops the ssh service"
SYSTEMCTL_USAGE["systemctl restart ssh"]="Restarts the ssh service"
SYSTEMCTL_USAGE["systemctl enable ssh"]="Enables the ssh service at boot"
SYSTEMCTL_USAGE["systemctl disable ssh"]="Disables the ssh service at boot"
SYSTEMCTL_USAGE["systemctl is-active ssh"]="Checks if ssh is active"
SYSTEMCTL_USAGE["systemctl is-enabled ssh"]="Checks if ssh starts at boot"

for cmd in "${!SYSTEMCTL_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${SYSTEMCTL_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Demo + Task Environment
echo -e "${CYAN}${BOLD}⚙️ Simulated Practice using 'ssh' service (or substitute service)...${RESET}"
pause

# Step 4: Task Check Function
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
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Interactive Tasks
ask_and_check \
    "Check status of the ssh service" \
    "Use 'systemctl status'" \
    "^systemctl[[:space:]]+status[[:space:]]+ssh([[:space:]]|$)"

ask_and_check \
    "Start the ssh service" \
    "Use 'systemctl start'" \
    "^systemctl[[:space:]]+start[[:space:]]+ssh[[:space:]]*$"

ask_and_check \
    "Enable ssh service to start on boot" \
    "Use 'systemctl enable'" \
    "^systemctl[[:space:]]+enable[[:space:]]+ssh[[:space:]]*$"

ask_and_check \
    "Check if ssh service is active" \
    "Use 'systemctl is-active'" \
    "^systemctl[[:space:]]+is-active[[:space:]]+ssh[[:space:]]*$"

ask_and_check \
    "Disable ssh service from starting at boot" \
    "Use 'systemctl disable'" \
    "^systemctl[[:space:]]+disable[[:space:]]+ssh[[:space:]]*$"

# Step 6: Wrap up
echo -e "${GREEN}${BOLD}🎉 Lesson complete! You've learned how to manage system services with 'systemctl'.${RESET}"
pause
