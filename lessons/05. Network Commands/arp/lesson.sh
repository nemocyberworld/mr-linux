# #!/bin/bash
# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
# source "$SCRIPT_DIR/config.sh"

# clear
# echo -e "${CYAN}${BOLD}🌐 Lesson: arp — Address Resolution Protocol Utility${RESET}"
# echo
# echo "'arp' is used to view and manipulate the system's ARP (Address Resolution Protocol) cache."
# echo "It helps map IP addresses to MAC addresses on a local network."
# pause

# # Step 1: Show ARP Table
# clear
# echo -e "${YELLOW}${BOLD}🔹 Step 1: View ARP Table${RESET}"
# echo -e "${BOLD}➡️ Command: arp -a${RESET}"
# echo "This shows the current ARP cache with IP-MAC address mappings."
# pause

# # Step 2: Common arp Options
# clear
# echo -e "${CYAN}${BOLD}📚 Common 'arp' Options:${RESET}"

# declare -A ARP_USAGE
# ARP_USAGE["arp -a"]="Display the current ARP table"
# ARP_USAGE["arp -d <IP>"]="Delete a specific entry from the ARP table"
# ARP_USAGE["arp -s <IP> <MAC>"]="Manually add a static ARP entry"
# ARP_USAGE["ip neigh"]="Modern replacement for 'arp' (shows neighbor table)"

# for cmd in "${!ARP_USAGE[@]}"; do
#     echo
#     echo -e "${YELLOW}💬 ${ARP_USAGE[$cmd]}${RESET}"
#     echo -e "${BOLD}➡️  Example: $cmd${RESET}"
#     pause
# done

# # Step 3: Tasks
# ask_and_check() {
#     local description="$1"
#     local hint="$2"
#     local check_regex="$3"

#     while true; do
#         echo
#         echo -e "${CYAN}${BOLD}🧠 TASK: $description${RESET}"
#         [[ -n "$hint" ]] && echo -e "${YELLOW}💡 Hint: $hint${RESET}"
#         read -rp "💻 Type the command: " user_cmd

#         if [[ "$user_cmd" =~ $check_regex ]]; then
#             echo -e "${GREEN}✅ Correct!${RESET}"
#             echo -e "${CYAN}⚠️  This is a simulation. The actual command is not executed.${RESET}"
#             break
#         else
#             echo -e "${RED}❌ Incorrect. Try again.${RESET}"
#         fi
#     done
#     pause
#     clear
# }

# ask_and_check \
#     "Display the system's ARP table" \
#     "Try: arp -a" \
#     "^arp[[:space:]]+-a[[:space:]]*$"

# ask_and_check \
#     "Delete an ARP entry for IP 192.168.1.100" \
#     "Try: arp -d 192.168.1.100" \
#     "^arp[[:space:]]+-d[[:space:]]+192\.168\.1\.100[[:space:]]*$"

# ask_and_check \
#     "Add a static ARP entry for IP 192.168.1.200 and MAC aa:bb:cc:dd:ee:ff" \
#     "Try: arp -s 192.168.1.200 aa:bb:cc:dd:ee:ff" \
#     "^arp[[:space:]]+-s[[:space:]]+192\.168\.1\.200[[:space:]]+aa:bb:cc:dd:ee:ff[[:space:]]*$"

# ask_and_check \
#     "Use the modern alternative to view neighbors" \
#     "Try: ip neigh" \
#     "^ip[[:space:]]+neigh[[:space:]]*$"

# # Wrap-up
# echo
# echo -e "${GREEN}${BOLD}🎉 Well done! You've completed the 'arp' command lesson.${RESET}"
# echo -e "🔧 You can now inspect and manipulate the ARP cache like a network ninja!"
# pause
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🌐 Lesson: arp — Address Resolution Protocol Utility${RESET}"
echo
echo "'arp' is used to view and manipulate the system's ARP cache."
echo "It maps IP addresses to MAC addresses on a local network."
pause

# Step 1: View ARP Table
clear
echo -e "${YELLOW}${BOLD}🔹 Step 1: View ARP Table${RESET}"
echo -e "${BOLD}➡️ Command: arp -a${RESET}"
echo
arp -a | head -n 10 || echo "Command failed or not supported on this system."
pause

# Step 2: Common arp Options
clear
echo -e "${CYAN}${BOLD}📚 Common 'arp' Options:${RESET}"

declare -A ARP_USAGE
ARP_USAGE["arp -a"]="Display the current ARP table"
ARP_USAGE["arp -d <IP>"]="Delete a specific entry from the ARP table"
ARP_USAGE["arp -s <IP> <MAC>"]="Manually add a static ARP entry"
ARP_USAGE["ip neigh"]="Modern replacement for 'arp' (shows neighbor table)"

for cmd in "${!ARP_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${ARP_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Interactive Tasks (with actual execution)
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
            echo -e "${GREEN}✅ Correct! Executing...${RESET}"
            echo
            eval "$user_cmd"
            break
        else
            echo -e "${RED}❌ Incorrect. Try again.${RESET}"
        fi
    done
    pause
    clear
}

ask_and_check \
    "Display the system's ARP table" \
    "Try: arp -a" \
    "^arp[[:space:]]+-a[[:space:]]*$"

ask_and_check \
    "Delete an ARP entry for IP 192.168.1.100 (simulate if needed)" \
    "Try: arp -d 192.168.1.100" \
    "^arp[[:space:]]+-d[[:space:]]+192\.168\.1\.100[[:space:]]*$"

ask_and_check \
    "Add a static ARP entry for IP 192.168.1.200 and MAC aa:bb:cc:dd:ee:ff (requires sudo)" \
    "Try: sudo arp -s 192.168.1.200 aa:bb:cc:dd:ee:ff" \
    "^sudo[[:space:]]+arp[[:space:]]+-s[[:space:]]+192\.168\.1\.200[[:space:]]+aa:bb:cc:dd:ee:ff[[:space:]]*$"

ask_and_check \
    "Use the modern tool to view ARP/neighbor entries" \
    "Try: ip neigh" \
    "^ip[[:space:]]+neigh[[:space:]]*$"

# Wrap-up
echo
echo -e "${GREEN}${BOLD}🎉 Lesson Complete: arp${RESET}"
echo -e "⚙️ You've now used 'arp' to explore and modify local network mappings!"
pause
