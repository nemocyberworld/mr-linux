# #!/bin/bash

# # Get script directory
# SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# source "$SCRIPT_DIR/config.sh"

# LESSON_DIR="$SCRIPT_DIR/lessons"

# # Create lessons folder if missing
# if [ ! -d "$LESSON_DIR" ]; then
#     mkdir -p "$LESSON_DIR"
#     echo "📁 Created missing 'lessons/' directory."
# fi

# # Function to show lessons inside a category
# function show_lessons_in_category() {
#     CATEGORY_PATH="$1"

#     while true; do
#         clear
#         echo -e "${BOLD}${CYAN}📚 Mr Linux - Lessons in: $(basename "$CATEGORY_PATH")${RESET}"
#         echo "0) Go Back to Categories"

#         # List all subfolders (lessons)
#         mapfile -t LESSON_NAMES < <(find "$CATEGORY_PATH" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

#         if [ ${#LESSON_NAMES[@]} -eq 0 ]; then
#             echo "⚠️ No lessons found in this category."
#             read -p "Press Enter to go back..."
#             return
#         fi

#         # Show lessons
#         select lesson_name in "${LESSON_NAMES[@]}"; do
#             if [[ "$REPLY" == "0" ]]; then
#                 return  # Go back to category menu
#             fi

#             LESSON_PATH="$CATEGORY_PATH/$lesson_name"
#             if [[ -f "$LESSON_PATH/lesson.sh" ]]; then
#                 echo -e "\n🔸 Starting lesson: $lesson_name"
                
#                 (
#                     trap "echo -e '\n⛔ Lesson interrupted. Returning to lesson list...'; exit 130" SIGINT
#                     bash "$LESSON_PATH/lesson.sh"
#                 )

#                 echo -e "\n✅ Lesson completed. Press Enter to return to lesson list..."
#                 read
#                 break  # After running lesson, re-display lesson list
#             else
#                 echo "❌ Invalid choice. Try again."
#             fi
#         done
#     done
# }

# # MAIN MENU: Select category
# while true; do
#     clear
#     echo -e "${BOLD}${CYAN}👨‍🏫 Welcome to Mr Linux!${RESET}"
#     echo "Learn Linux commands, tools, and scripting step by step."
#     echo

#     echo "Available Categories:"
#     echo "0) Exit Mr Linux"

#     # List all top-level lesson categories
#     mapfile -t CATEGORIES < <(find "$LESSON_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

#     if [ ${#CATEGORIES[@]} -eq 0 ]; then
#         echo "⚠️ No categories found. Add some in the lessons/ directory."
#         exit 1
#     fi

#     # Show categories to choose
#     select category in "${CATEGORIES[@]}"; do
#         if [[ "$REPLY" == "0" ]]; then
#             echo -e "\n👋 Goodbye! See you next time!"
#             exit 0
#         fi

#         CATEGORY_PATH="$LESSON_DIR/$category"
#         if [[ -d "$CATEGORY_PATH" ]]; then
#             show_lessons_in_category "$CATEGORY_PATH"
#             break  # After returning from lessons, go back to main category menu
#         else
#             echo "❌ Invalid choice. Try again."
#         fi
#     done
# done

#!/bin/bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

LESSON_DIR="$SCRIPT_DIR/lessons"

# Create lessons folder if missing
if [ ! -d "$LESSON_DIR" ]; then
    mkdir -p "$LESSON_DIR"
    echo "📁 Created missing 'lessons/' directory."
fi

# Global Ctrl+C handling
CTRL_C_COUNT=0

trap_ctrl_c() {
    ((CTRL_C_COUNT++))
    if [ $CTRL_C_COUNT -eq 1 ]; then
        echo -e "\n⚠️  Press Ctrl+C again within 5 seconds to exit Mr Linux."
        # Reset after 5 seconds
        (sleep 5 && CTRL_C_COUNT=0) &
    else
        echo -e "\n👋 Exiting Mr Linux. Goodbye!"
        exit 0
    fi
}

trap trap_ctrl_c SIGINT

# Function to show lessons inside a category
function show_lessons_in_category() {
    CATEGORY_PATH="$1"

    while true; do
        clear
        echo -e "${BOLD}${CYAN}📚 Mr Linux - Lessons in: $(basename "$CATEGORY_PATH")${RESET}"
        echo "0) Go Back to Categories"

        # List all subfolders (lessons)
        mapfile -t LESSON_NAMES < <(find "$CATEGORY_PATH" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

        if [ ${#LESSON_NAMES[@]} -eq 0 ]; then
            echo "⚠️ No lessons found in this category."
            read -p "Press Enter to go back..."
            return
        fi

        # Show lessons
        select lesson_name in "${LESSON_NAMES[@]}"; do
            if [[ "$REPLY" == "0" ]]; then
                return  # Go back to category menu
            fi

            LESSON_PATH="$CATEGORY_PATH/$lesson_name"
            if [[ -f "$LESSON_PATH/lesson.sh" ]]; then
                echo -e "\n🔸 Starting lesson: $lesson_name"
                
                (
                    trap "echo -e '\n⛔ Lesson interrupted. Returning to lesson list...'; exit 130" SIGINT
                    bash "$LESSON_PATH/lesson.sh"
                )

                echo -e "\n✅ Lesson completed. Press Enter to return to lesson list..."
                read
                break  # After running lesson, re-display lesson list
            else
                echo "❌ Invalid choice. Try again."
            fi
        done
    done
}

# MAIN MENU: Select category
while true; do
    clear
    echo -e "${BOLD}${CYAN}👨‍🏫 Welcome to Mr Linux!${RESET}"
    echo "Learn Linux commands, tools, and scripting step by step."
    echo

    echo "Available Categories:"
    echo "0) Exit Mr Linux"

    # List all top-level lesson categories
    mapfile -t CATEGORIES < <(find "$LESSON_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

    if [ ${#CATEGORIES[@]} -eq 0 ]; then
        echo "⚠️ No categories found. Add some in the lessons/ directory."
        exit 1
    fi

    # Show categories to choose
    select category in "${CATEGORIES[@]}"; do
        if [[ "$REPLY" == "0" ]]; then
            echo -e "\n👋 Goodbye! See you next time!"
            exit 0
        fi

        CATEGORY_PATH="$LESSON_DIR/$category"
        if [[ -d "$CATEGORY_PATH" ]]; then
            show_lessons_in_category "$CATEGORY_PATH"
            break  # After returning from lessons, go back to main category menu
        else
            echo "❌ Invalid choice. Try again."
        fi
    done
done
