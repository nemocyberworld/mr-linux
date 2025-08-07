#!/bin/bash

# Mr Linux - Created by Hacktolie Academy
# https://hacktolie.com

clear
echo -e "\e[1;32m"  # Green color
echo "███╗░░░███╗██████╗░    ██╗░░░░░██╗███╗░░██╗██╗░░░██╗██╗░░██╗"
echo "████╗░████║██╔══██╗    ██║░░░░░██║████╗░██║██║░░░██║╚██╗██╔╝"
echo "██╔████╔██║██████╔╝    ██║░░░░░██║██╔██╗██║██║░░░██║░╚███╔╝░"
echo "██║╚██╔╝██║██╔══██╗    ██║░░░░░██║██║╚████║██║░░░██║░██╔██╗░"
echo "██║░╚═╝░██║██║░░██║    ███████╗██║██║░╚███║╚██████╔╝██╔╝╚██╗"
echo "╚═╝░░░░░╚═╝╚═╝░░╚═╝    ╚══════╝╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝"
echo -e "\e[0m"
echo -e "           🔧 Created by \e[1;34mHacktolive Academy\e[0m - https://hacktolie.com"
sleep 2

sleep 3s


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

LESSON_DIR="$SCRIPT_DIR/lessons"

# Create lessons folder if missing
mkdir -p "$LESSON_DIR"

# Ctrl+C trap
CTRL_C_COUNT=0
trap_ctrl_c() {
    ((CTRL_C_COUNT++))
    if [ $CTRL_C_COUNT -eq 1 ]; then
        echo -e "\n⚠️  Press Ctrl+C again within 5 seconds to exit Mr Linux."
        (sleep 5 && CTRL_C_COUNT=0) &
    else
        echo -e "\n👋 Exiting Mr Linux. Goodbye!"
        exit 0
    fi
}
trap trap_ctrl_c SIGINT

# Fixed category list (serialized and aligned)
CATEGORY_NAMES=(
  "Intro"
  "File & Directory Management"
  "Searching & Filtering"
  "Package Management (Debian&Arch)"
  "Network Commands"
  "Process Management"
  "Disk Usage & Storage"
  "Archiving & Compression"
  "Task Management, Task Scheduling"
  "Users, Groups, and Permission"
  "System Info & Hardware"
  "System Cleanup & Monitoring"
  "Crypto"
  "Text Editor"
  "Bash Scripting"
  "Gaming Time"
)

CATEGORY_DIRS=(
  "01. Intro"
  "02. File & Directory Management"
  "03. Searching & Filtering"
  "04. Package Management"
  "05. Network Commands"
  "06. Process Management"
  "07. Disk Usage & Storage"
  "08. Archiving & Compression"
  "09. Task Management"
  "10. Users, Groups, and Permission"
  "11. System Info"
  "12. System Cleanup"
  "13. Crypto"
  "14. Text Editor"
  "15. Bash Scripting"
  "16. Gaming Time"
)

show_lessons_in_category() {
  CATEGORY_PATH="$LESSON_DIR/$1"
  CATEGORY_NAME="$(basename "$CATEGORY_PATH")"

  if [[ "$CATEGORY_NAME" == "01. Intro" ]]; then
    LESSON_LABELS=("Let's Start With Intro")
    LESSON_DIRS=("Let's Start With Intro")

  elif [[ "$CATEGORY_NAME" == "02. File & Directory Management" ]]; then
    LESSON_LABELS=("cd" "pwd" "ls" "mkdir" "rmdir" "touch" "cp" "mv" "echo" "cat" "more" "less" "head" "tail" "tee" "man" "cut" "sort" "uniq" "wc" "tr" "diff" "cmp" "sed" "awk" "xargs")
    LESSON_DIRS=("cd" "pwd" "ls" "mkdir" "rmdir" "touch" "cp" "mv" "echo" "cat" "more" "less" "head" "tail" "tee" "man" "cut" "sort" "uniq" "wc" "tr" "diff" "cmp" "sed" "awk" "xargs")

  elif [[ "$CATEGORY_NAME" == "03. Searching & Filtering" ]]; then
    LESSON_LABELS=("find" "grep" "which" "locate" "whereis")
    LESSON_DIRS=("find" "grep" "which" "locate" "whereis")

  elif [[ "$CATEGORY_NAME" == "04. Package Management" ]]; then
    LESSON_LABELS=("apt" "dpkg" "pacman" "yay")
    LESSON_DIRS=("apt" "dpkg" "pacman" "yay")

  elif [[ "$CATEGORY_NAME" == "05. Network Commands" ]]; then
    LESSON_LABELS=("ping" "ip" "curl" "wget" "scp" "netstat" "ss" "arp" "traceroute" "whois" "nslookup" "dig" "nmap" "tcpdump" "tshark" "iptables")
    LESSON_DIRS=("ping" "ip" "curl" "wget" "scp" "netstat" "ss" "arp" "traceroute" "whois" "nslookup" "dig" "nmap" "tcpdump" "tshark" "iptables")

  elif [[ "$CATEGORY_NAME" == "06. Process Management" ]]; then
    LESSON_LABELS=("ps" "top" "htop" "kill" "killall" "pkill" "nice" "renice" "trap" "pstree" "alias")
    LESSON_DIRS=("ps" "top" "htop" "kill" "killall" "pkill" "nice" "renice" "trap" "pstree" "alias")

  elif [[ "$CATEGORY_NAME" == "07. Disk Usage & Storage" ]]; then
    LESSON_LABELS=("df" "du" "mount" "unmount" "lsblk")
    LESSON_DIRS=("df" "du" "mount" "unmount" "lsblk")

  elif [[ "$CATEGORY_NAME" == "08. Archiving & Compression" ]]; then
    LESSON_LABELS=("tar" "gzip" "zip")
    LESSON_DIRS=("tar" "gzip" "zip")

  elif [[ "$CATEGORY_NAME" == "09. Task Management" ]]; then
    LESSON_LABELS=("jobs" "fg" "bg" "watch" "crontab" "systemctl")
    LESSON_DIRS=("jobs" "fg" "bg" "watch" "crontab" "systemctl")

  elif [[ "$CATEGORY_NAME" == "10. Users, Groups, and Permission" ]]; then
    LESSON_LABELS=("whoami" "id" "passwd" "users&groups" "su&sudo" "permission" "permission (special-perm)" "sudoers")
    LESSON_DIRS=("whoami" "id" "passwd" "users&groups" "su&sudo" "permission" "permission (special-perm)" "sudoers")

  elif [[ "$CATEGORY_NAME" == "11. System Info" ]]; then
    LESSON_LABELS=("uname" "hostname" "uptime" "free" "lscpu" "lsusb" "lspci" "dmidecode")
    LESSON_DIRS=("uname" "hostname" "uptime" "free" "lscpu" "lsusb" "lspci" "dmidecode")

  elif [[ "$CATEGORY_NAME" == "12. System Cleanup" ]]; then
    LESSON_LABELS=("clear" "history" "env" "export" "watch" "lsof" "dmesg" "journalctl")
    LESSON_DIRS=("clear" "history" "env" "export" "watch" "lsof" "dmesg" "journalctl")

  elif [[ "$CATEGORY_NAME" == "13. Crypto" ]]; then
    LESSON_LABELS=("base64" "md5sum" "sha1sum" "sha256sum" "openssl" "gpg")
    LESSON_DIRS=("base64" "md5sum" "sha1sum" "sha256sum" "openssl" "gpg")

  elif [[ "$CATEGORY_NAME" == "14. Text Editor" ]]; then
    LESSON_LABELS=("nano" "vim")
    LESSON_DIRS=("nano" "vim")

  elif [[ "$CATEGORY_NAME" == "15. Bash Scripting" ]]; then
    LESSON_LABELS=(
      "Introduction to Bash & Shell Scripting"
      "Basic Commands & Syntax"
      "Variables"
      "User Input"
      "Quoting & Escaping"
      "Conditional Statements"
      "Loops"
      "Functions"
      "File & Directory Operations"
      "Command Substitution & Arithmetic"
      "Script Arguments"
      "Standard Input&Output & Redirection"
      "Arrays & Associative Arrays"
      "Regular Expressions & Pattern Matching"
      "Error Handling & Debugging"
      "Signals & Traps"
      "Working with Date and Time"
      "Networking & Remote Execution"
      "Parsing CLI Options"
      "Writing Modular & Reusable Scripts"
    )
    LESSON_DIRS=(
      "01. Introduction to Bash & Shell Scripting"
      "02. Basic Commands & Syntax"
      "03. Variables"
      "04. User Input"
      "05. Quoting & Escaping"
      "06. Conditional Statements"
      "07. Loops"
      "08. Functions"
      "09. File & Directory Operations"
      "10. Command Substitution & Arithmetic"
      "11. Script Arguments"
      "12. Standard Input&Output & Redirection"
      "13. Arrays & Associative Arrays"
      "14. Regular Expressions & Pattern Matching"
      "15. Error Handling & Debugging"
      "16. Signals & Traps"
      "17. Working with Date and Time"
      "18. Networking & Remote Execution"
      "19. Parsing CLI Options"
      "20. Writing Modular & Reusable Scripts"
    )

  elif [[ "$CATEGORY_NAME" == "16. Gaming Time" ]]; then
    LESSON_LABELS=("Mr. Linux Game")
    LESSON_DIRS=("Start Game")

  else
    echo "⚠️ No fixed lesson mapping found for this category."
    read -p "Press Enter to go back..."
    return
  fi

  while true; do
    clear
    echo -e "${BOLD}${CYAN}📚 Mr Linux - Lessons in: $CATEGORY_NAME${RESET}"
    echo "0) Go Back to Categories"

    total=${#LESSON_LABELS[@]}
    for ((i = 0; i < total; i += 3)); do
      line=""
      for j in {0..2}; do
        index=$((i + j))
        if ((index < total)); then
          num=$((index + 1))
          label="${LESSON_LABELS[$index]}"
          line+="$(printf "%2d) %-40s" "$num" "$label")"
        fi
      done
      echo "$line"
    done

    echo -n "#? "
    read -r choice

    if [[ "$choice" == "0" ]]; then
      return
    elif [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= total)); then
      selected_dir="${LESSON_DIRS[$((choice - 1))]}"
      lesson_path="$CATEGORY_PATH/$selected_dir"
      if [[ -f "$lesson_path/lesson.sh" ]]; then
        echo -e "\n🔸 Starting lesson: ${LESSON_LABELS[$((choice - 1))]}"
        (
          trap "echo -e '\n⛔ Lesson interrupted.'; exit 130" SIGINT
          bash "$lesson_path/lesson.sh"
        )
        echo -e "\n✅ Lesson completed. Press Enter to return..."
        read
      else
        echo "❌ Lesson script not found in: $lesson_path"
        read -p "Press Enter to return..."
      fi
    else
      echo "❌ Invalid input. Try again."
      sleep 1
    fi
  done
}


# MAIN MENU
while true; do
  clear
  echo -e "${BOLD}${CYAN}👨‍🏫 Welcome to Mr Linux!${RESET}"
  echo "Learn Linux commands, tools, and scripting step by step."
  echo
  echo "Available Categories:"
  echo " 0) Exit Mr Linux"

  # Show 2-column format
  for i in "${!CATEGORY_NAMES[@]}"; do
    index=$((i + 1))
    label="$(printf "%-35s" "${CATEGORY_NAMES[$i]}")"
    if (( index % 2 == 1 )); then
      printf " %2d) %-35s" "$index" "$label"
    else
      printf "%2d) %-35s\n" "$index" "$label"
    fi
  done
  echo ""

  read -rp "Choose a category number (or 0 to quit): " choice

  if [[ "$choice" == "0" ]]; then
    echo -e "\n👋 Goodbye!"
    exit 0
  elif [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#CATEGORY_DIRS[@]} )); then
    show_lessons_in_category "${CATEGORY_DIRS[$((choice - 1))]}"
  else
    echo -e "${RED}❌ Invalid input. Try again.${RESET}"
    sleep 1
  fi
done
