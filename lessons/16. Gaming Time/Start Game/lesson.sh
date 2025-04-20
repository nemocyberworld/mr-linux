# #!/bin/bash
# set -euo pipefail

# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# source "$SCRIPT_DIR/config.sh"
# source "$SCRIPT_DIR/utils/input.sh"
# source "$SCRIPT_DIR/utils/pause.sh"
# source "$SCRIPT_DIR/utils/cleanup.sh"

# SAVE_FILE="$HOME/.mr_linux_save"

# trap cleanup EXIT
# mkdir -p "$BIN_DIR"

# # Initialize or load save file
# if [[ -f "$SAVE_FILE" ]]; then
#   source "$SAVE_FILE"
# else
#   COMPLETED_LEVELS=0
#   POINTS=0
# fi

# function save_progress {
#   echo "COMPLETED_LEVELS=$COMPLETED_LEVELS" > "$SAVE_FILE"
#   echo "POINTS=$POINTS" >> "$SAVE_FILE"
# }

# function reset_progress {
#   echo -e "${RED}⚠️  Are you sure you want to reset all progress? This cannot be undone!${RESET}"
#   read -rp "Type [yes/y] to confirm or [no/n] to cancel: " confirm
#   confirm="${confirm,,}"  # Lowercase the input for consistency

#   case "$confirm" in
#     yes|y)
#       COMPLETED_LEVELS=0
#       POINTS=0
#       save_progress
#       echo -e "${YELLOW}🔁 Progress reset successfully!${RESET}"
#       ;;
#     no|n)
#       echo -e "${CYAN}🙃 Reset canceled.${RESET}"
#       ;;
#     *)
#       echo -e "${RED}❓ Invalid input. Reset canceled.${RESET}"
#       ;;
#   esac
#   pause
# }


# # Level names and script files
# LEVEL_NAMES=(
#   "Permissions"
#   "Find Hidden"
#   "Grep Mastery"
#   "Sed & Awk"
#   "Redirection"
#   "Find & Locate"
#   "Tar & Compression"
#   "Zip Zone Showdown"
#   "Networking I(curl,wget)"
#   "Networking II(nc)"
# )
# LEVEL_SCRIPTS=(
#   "level1_permissions.sh"
#   "level2_find_hidden.sh"
#   "level3_grep_mastery.sh"
#   "level4_sed_&_awk.sh"
#   "level5_redirection.sh"
#   "level6_find_&_locate.sh"
#   "level7_tar_&_compression.sh"
#   "level8_zip_zone.sh"
#   "level9_networking1_curl_wget.sh"
#   "level10_networking2_nc.sh"

# )

# TOTAL_LEVELS=${#LEVEL_NAMES[@]}

# clear
# echo -e "${BOLD}${CYAN}Welcome to Mr. Linux Game!${RESET}"
# echo -e "Your Linux-fu will be tested. Good luck!"
# pause

# while true; do
#   clear
#   echo -e "${BOLD}Available Levels:${RESET}"
#   for i in "${!LEVEL_NAMES[@]}"; do
#     echo "$((i + 1)). ${LEVEL_NAMES[$i]}"
#   done
#   echo "S. Skip to next level"
#   echo "R. Reset progress"  # 👇 New menu option
#   echo "Q. Quit"
#   echo
#   # echo "Progress: $COMPLETED_LEVELS/$TOTAL_LEVELS levels complete ✅"
#   # echo "Points: $POINTS 🏆"
#   echo -e "Progress: $COMPLETED_LEVELS/$TOTAL_LEVELS levels complete ✅"
# echo -e "Points: $POINTS 🏆"
# echo -e "${BOLD}Completed Levels:${RESET}"
# for i in "${!LEVEL_NAMES[@]}"; do
#   if [[ $i -lt $COMPLETED_LEVELS ]]; then
#     echo -e "  $((i + 1)). ${LEVEL_NAMES[$i]} ✅"
#   else
#     echo -e "  $((i + 1)). ${LEVEL_NAMES[$i]} ❌"
#   fi
# done

#   echo

#   read -rp "Choose a level number, [S]kip, [R]eset, or [Q]uit: " choice

#   case "$choice" in
#     [Qq])
#       echo -e "${YELLOW}👋 Quitting the game. See you soon!${RESET}"
#       break
#       ;;
#     [Rr])  # 👇 Handle reset choice
#       reset_progress
#       ;;
#     [Ss])
#       index=$COMPLETED_LEVELS
#       if [[ $index -lt $TOTAL_LEVELS ]]; then
#         echo -e "${BLUE}⏭️ Skipping to Level $((index + 1)): ${LEVEL_NAMES[$index]}...${RESET}"
#         pause
#         source "$SCRIPT_DIR/levels/${LEVEL_SCRIPTS[$index]}"
#         COMPLETED_LEVELS=$((COMPLETED_LEVELS + 1))
#         POINTS=$((POINTS + 10))
#         echo -e "${GREEN}🎉🎉 Congratulations! You've completed Level $((index + 1)) - ${LEVEL_NAMES[$index]}! 🎉🎉${RESET}"
#         echo -e "${YELLOW}🏅 You've earned 10 points! Total: $POINTS points.${RESET}"
#         echo -e "${CYAN}📈 Progress: $COMPLETED_LEVELS/$TOTAL_LEVELS levels complete.${RESET}"
#         save_progress
#         pause
#       else
#         echo -e "${GREEN}🎉 All levels completed!${RESET}"
#         pause
#       fi
#       ;;
#     ''|*[!0-9]*)
#       echo -e "${RED}❌ Invalid choice. Enter a number, S, R, or Q.${RESET}"
#       pause
#       ;;
#     *)
#       index=$((choice - 1))
#       if [[ $index -ge 0 && $index -lt $TOTAL_LEVELS ]]; then
#         echo -e "${BLUE}Launching ${LEVEL_NAMES[$index]}...${RESET}"
#         pause
#         source "$SCRIPT_DIR/levels/${LEVEL_SCRIPTS[$index]}"
#         if [[ $((index + 1)) -gt $COMPLETED_LEVELS ]]; then
#           COMPLETED_LEVELS=$((index + 1))
#           POINTS=$((POINTS + 10))
#           echo -e "${GREEN}🎉🎉 Congratulations! You've completed Level $((index + 1)) - ${LEVEL_NAMES[$index]}! 🎉🎉${RESET}"
#           echo -e "${YELLOW}🏅 You've earned 10 points! Total: $POINTS points.${RESET}"
#           echo -e "${CYAN}📈 Progress: $COMPLETED_LEVELS/$TOTAL_LEVELS levels complete.${RESET}"
#           save_progress
#           pause
#         fi
#       else
#         echo -e "${RED}❌ Invalid level number.${RESET}"
#         pause
#       fi
#       ;;
#   esac
# done

# echo -e "${GREEN}🎉 Thanks for playing! More levels coming soon!${RESET}"
# rm -rf /tmp/mr_linux* 2>/dev/null
#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/utils/input.sh"
source "$SCRIPT_DIR/utils/pause.sh"
source "$SCRIPT_DIR/utils/cleanup.sh"

SAVE_FILE="$HOME/.mr_linux_save"
trap cleanup EXIT
mkdir -p "$BIN_DIR"

# Initialize or load save file
if [[ -f "$SAVE_FILE" ]]; then
  source "$SAVE_FILE"
else
  COMPLETED_LEVELS=""
  POINTS=0
fi

function save_progress {
  echo "COMPLETED_LEVELS=\"$COMPLETED_LEVELS\"" > "$SAVE_FILE"
  echo "POINTS=$POINTS" >> "$SAVE_FILE"
}

function contains {
  [[ " $COMPLETED_LEVELS " == *" $1 "* ]]
}

function reset_progress {
  echo -e "${RED}⚠️  Are you sure you want to reset all progress? This cannot be undone!${RESET}"
  read -rp "Type [yes/y] to confirm or [no/n] to cancel: " confirm
  confirm="${confirm,,}"
  case "$confirm" in
    yes|y)
      COMPLETED_LEVELS=""
      POINTS=0
      save_progress
      echo -e "${YELLOW}🔁 Progress reset successfully!${RESET}"
      ;;
    no|n)
      echo -e "${CYAN}🙃 Reset canceled.${RESET}"
      ;;
    *)
      echo -e "${RED}❓ Invalid input. Reset canceled.${RESET}"
      ;;
  esac
  pause
}

# Level names and scripts
LEVEL_NAMES=(
  "Permissions"
  "Find Hidden"
  "Grep Mastery"
  "Sed & Awk"
  "Redirection"
  "Find & Locate"
  "Tar & Compression"
  "Zip Zone Showdown"
  "Networking I(curl,wget)"
  "Networking II(nc)"
  "Process Kill"
  "Environment Variable"
  "Cron Commando"
  "Argument Arena"
  "File I/O Frenzy"
  "Set & Trap Debug"
  "Regex Rampage"
  "Sysinfo"
  "Functions"
  "Watch"
  "Log Parsing"
  "Fork Bomb"
  "Bash Gauntlet"
)
LEVEL_SCRIPTS=(
  "level1_permissions.sh"
  "level2_find_hidden.sh"
  "level3_grep_mastery.sh"
  "level4_sed_&_awk.sh"
  "level5_redirection.sh"
  "level6_find_&_locate.sh"
  "level7_tar_&_compression.sh"
  "level8_zip_zone.sh"
  "level9_networking1_curl_wget.sh"
  "level10_networking2_nc.sh"
  "level11_process_kill.sh"
  "level12_environment_variable.sh"
  "level13_cron_commando.sh"
  "level14_argument_arena.sh"
  "level15_file_io_frenzy.sh"
  "level16_set_trap_debug.sh"
  "level17_regex_rampage.sh"
  "level18_sysinfo.sh"
  "level19_functions.sh"
  "level20_watch.sh"
  "level21_log_parsing.sh"
  "level22_fork_bomb.sh"
  "level23_bash_gauntlet.sh"
)

TOTAL_LEVELS=${#LEVEL_NAMES[@]}

clear
echo -e "${BOLD}${CYAN}Welcome to Mr. Linux Game!${RESET}"
echo -e "Your Linux-fu will be tested. Good luck!"
pause

while true; do
  clear
  echo -e "${BOLD}Available Levels:${RESET}"
  for i in "${!LEVEL_NAMES[@]}"; do
    echo "$((i + 1)). ${LEVEL_NAMES[$i]}"
  done
  echo "S. Skip to next incomplete level"
  echo "R. Reset progress"
  echo "Q. Quit"
  echo

  completed_count=$(wc -w <<< "$COMPLETED_LEVELS")
  echo -e "Progress: $completed_count/$TOTAL_LEVELS levels complete ✅"
  echo -e "Points: $POINTS 🏆"

  echo -e "${BOLD}Completed Levels:${RESET}"
  for i in "${!LEVEL_NAMES[@]}"; do
    level_number=$((i + 1))
    if contains "$level_number"; then
      echo -e "  $level_number. ${LEVEL_NAMES[$i]} ✅"
    else
      echo -e "  $level_number. ${LEVEL_NAMES[$i]} ❌"
    fi
  done

  echo
  read -rp "Choose a level number, [S]kip, [R]eset, or [Q]uit: " choice

  case "$choice" in
    [Qq])
      echo -e "${YELLOW}👋 Quitting the game. See you soon!${RESET}"
      break
      ;;
    [Rr])
      reset_progress
      ;;
    [Ss])
      for i in "${!LEVEL_NAMES[@]}"; do
        level_number=$((i + 1))
        if ! contains "$level_number"; then
          echo -e "${BLUE}⏭️ Skipping to Level $level_number: ${LEVEL_NAMES[$i]}...${RESET}"
          pause
          source "$SCRIPT_DIR/levels/${LEVEL_SCRIPTS[$i]}"
          COMPLETED_LEVELS="$COMPLETED_LEVELS $level_number"
          POINTS=$((POINTS + 10))
          save_progress
          echo -e "${GREEN}🎉 Completed Level $level_number - ${LEVEL_NAMES[$i]}!${RESET}"
          echo -e "${YELLOW}🏅 Points: $POINTS${RESET}"
          pause
          break
        fi
      done
      ;;
    ''|*[!0-9]*)
      echo -e "${RED}❌ Invalid choice. Enter a number, S, R, or Q.${RESET}"
      pause
      ;;
    *)
      index=$((choice - 1))
      if [[ $index -ge 0 && $index -lt $TOTAL_LEVELS ]]; then
        level_number=$((index + 1))
        echo -e "${BLUE}Launching ${LEVEL_NAMES[$index]}...${RESET}"
        pause
        source "$SCRIPT_DIR/levels/${LEVEL_SCRIPTS[$index]}"
        if ! contains "$level_number"; then
          COMPLETED_LEVELS="$COMPLETED_LEVELS $level_number"
          POINTS=$((POINTS + 10))
          save_progress
          echo -e "${GREEN}🎉 Completed Level $level_number - ${LEVEL_NAMES[$index]}!${RESET}"
          echo -e "${YELLOW}🏅 Points: $POINTS${RESET}"
          pause
        fi
      else
        echo -e "${RED}❌ Invalid level number.${RESET}"
        pause
      fi
      ;;
  esac
done

echo -e "${GREEN}🎉 Thanks for playing! More levels coming soon!${RESET}"
rm -rf /tmp/mr_linux* 2>/dev/null
