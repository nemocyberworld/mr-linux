#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$SCRIPT_DIR/config.sh"

clear
echo -e "${CYAN}${BOLD}🗂️ Lesson: The 'mount' Command — Mount Filesystems${RESET}"
echo
echo "'mount' is used to attach a filesystem to a directory on the system."
echo "It’s often used to mount USB drives, external devices, or partitions."
pause

# Step 1: Show help and usage
clear
echo -e "${YELLOW}${BOLD}📘 mount --help:${RESET}"
mount --help | head -20
pause

# Step 2: Common mount usage examples
clear
echo -e "${CYAN}${BOLD}📚 Common 'mount' Examples:${RESET}"

declare -A MOUNT_USAGE
MOUNT_USAGE["mount"]="Show currently mounted filesystems"
MOUNT_USAGE["mount /dev/sdX1 /mnt"]="Mount /dev/sdX1 to /mnt"
MOUNT_USAGE["mount -t ext4 /dev/sdX1 /mnt"]="Specify filesystem type when mounting"
MOUNT_USAGE["mount -o ro /dev/sdX1 /mnt"]="Mount a device as read-only"

for cmd in "${!MOUNT_USAGE[@]}"; do
    echo
    echo -e "${YELLOW}💬 ${MOUNT_USAGE[$cmd]}${RESET}"
    echo -e "${BOLD}➡️  Example: $cmd${RESET}"
    pause
done

# Step 3: Create a practice directory
PRACTICE_DIR="$SCRIPT_DIR/playground/mount_lesson"
mkdir -p "$PRACTICE_DIR/fake_device" "$PRACTICE_DIR/mount_point"
dd if=/dev/zero of="$PRACTICE_DIR/fake_device/fake.img" bs=1M count=10 &>/dev/null
mkfs.ext4 "$PRACTICE_DIR/fake_device/fake.img" &>/dev/null
mkdir -p "$PRACTICE_DIR/mount_point"

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
    "View currently mounted filesystems" \
    "Just use: mount" \
    "^mount[[:space:]]*$"

ask_and_check \
    "Mount the fake.img to the mount_point directory" \
    "Use: mount -o loop fake.img mount_point" \
    "^mount[[:space:]]+-o[[:space:]]+loop[[:space:]]+.*fake.img[[:space:]]+.*mount_point[[:space:]]*$"

# Step 6: Wrap up and cleanup
echo -e "${GREEN}${BOLD}🎉 Lesson complete!${RESET}"
echo -e "${YELLOW}🧹 Cleaning up...${RESET}"
umount "$PRACTICE_DIR/mount_point" &>/dev/null
rm -rf "$PRACTICE_DIR"
pause
