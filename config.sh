#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Utility functions
pause() {
    echo
    read -p "Press Enter to continue..." temp
}

success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

fail() {
    echo -e "${RED}❌ $1${RESET}"
}
