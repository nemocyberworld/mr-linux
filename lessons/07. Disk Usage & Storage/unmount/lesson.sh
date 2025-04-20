#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}📤 Lesson: The 'umount' Command — Unmount Filesystems${RESET}"
echo
echo "'umount' is used to detach mounted filesystems or devices from the system."
echo "You typically unmount a USB device before removing it to avoid data corruption."
pause

# Step 1: Show help and usage
clear
echo -e "${YELLOW}${BOLD}📘 umount --help:${RESET}"
umount --help | head -20
pause

# Step 2: Common umount usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'umount' Examples:${RESET}"

declare -A UMOUNT_USAGE
UMOUNT_USAGE["umount /mnt"]="Unmount filesystem mounted at /mnt"
UMOUNT_USAGE["umount /dev/sdX1"]="Unmount the /dev/sdX1 device"
UMOUNT_USAGE["umount -f /mnt"]="Force unmount (use with caution)"
UMOUNT_USAGE["umount -l /mnt"]="Lazy unmount (detaches when not in use)"

for cmd in "${!UMOUNT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${UMOUNT_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Create a fake device and mount it
PRACTICE_DIR="$SCRIPT_DIR/playground/umount_lesson"
mkdir -p "$PRACTICE_DIR/fake_device" "$PRACTICE_DIR/mount_point"
dd if=/dev/zero of="$PRACTICE_DIR/fake_device/fake.img" bs=1M count=10 &>/dev/null
mkfs.ext4 "$PRACTICE_DIR/fake_device/fake.img" &>/dev/null
mkdir -p "$PRACTICE_DIR/mount_point"
mount -o loop "$PRACTICE_DIR/fake_device/fake.img" "$PRACTICE_DIR/mount_point"

# Step 4: Interactive task system
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
            eval "$user_cmd" || echo -e "${RED}⚠️ Command executed but may have failed.${RESET}"
            break
        else
            echo -e "${RED}❌ Incorrect. Please try again.${RESET}"
        fi
    done
    pause
    clear
}

# Step 5: Tasks
ask_and_check \
    "Unmount the filesystem from the mount_point directory" \
    "Use the 'umount' command with the directory path." \
    "^umount[[:space:]]+.*mount_point[[:space:]]*$"

# Step 6: Wrap up and cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
rm -rf "$PRACTICE_DIR"
pause
