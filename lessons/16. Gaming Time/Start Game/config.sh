#!/bin/bash

# 🎨 Colors
export BOLD="\033[1m"
export RED="\033[31m"
export GREEN="\033[32m"
export YELLOW="\033[33m"
export BLUE="\033[34m"
export CYAN="\033[36m"
export RESET="\033[0m"

# 🗂️ Directories
export BIN_DIR="$HOME/.mr_linux_game"
export TMP_DIR="/tmp/mr_linux_game_$$"

mkdir -p "$TMP_DIR"