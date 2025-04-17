#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: ip — Network Interface Management Tool${RESET}"
echo
echo "'ip' is a powerful replacement for the old 'ifconfig' command. It is used to manage network interfaces, IP addresses, routes, and more."
pause

# Step 1: Basic usage
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: Display IP Address Info${RESET}"
echo -e "${BOLD}➡️ Command: ip a${RESET}"
echo "Displays all IP addresses and interfaces on the system."
pause

# Step 2: Common Options
clear
echo -e "${CYAN}${BOLD}📚 Common 'ip' Options:${RESET}"

declare -A IP_USAGE
IP_USAGE["ip a"]="Show all interfaces and IP addresses"
IP_USAGE["ip link"]="Show link-layer (MAC) interface info"
IP_USAGE["ip addr add 192.168.1.100/24 dev eth0"]="Assign IP to interface"
IP_USAGE["ip addr del 192.168.1.100/24 dev eth0"]="Remove IP from interface"
IP_USAGE["ip link set eth0 up"]="Bring interface up"
IP_USAGE["ip link set eth0 down"]="Bring interface down"
IP_USAGE["ip route"]="Show routing table"
IP_USAGE["ip route add default via 192.168.1.1"]="Add a default gateway"

for cmd in "${!IP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${IP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Tasks
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
            echo -e "${CYAN}⚠️  This is a simulation. The actual command is not executed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Show all network interfaces and IP addresses" \
    "Try: ip a" \
    "^ip[[:space:]]+a(ddr)?[[:space:]]*$"

ask_and_check \
    "Display routing table" \
    "Try: ip route" \
    "^ip[[:space:]]+route[[:space:]]*$"

ask_and_check \
    "Bring interface eth0 up" \
    "Try: ip link set eth0 up" \
    "^ip[[:space:]]+link[[:space:]]+set[[:space:]]+eth0[[:space:]]+up[[:space:]]*$"

ask_and_check \
    "Add default gateway 192.168.1.1" \
    "Try: ip route add default via 192.168.1.1" \
    "^ip[[:space:]]+route[[:space:]]+add[[:space:]]+default[[:space:]]+via[[:space:]]+192\.168\.1\.1[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Awesome! You've completed the 'ip' command lesson.${RESET}"
echo -e "🔌 You're now ready to manage interfaces, addresses, and routes like a pro!"
pause
