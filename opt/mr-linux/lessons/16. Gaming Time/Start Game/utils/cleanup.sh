#!/bin/bash

cleanup() {
    echo -e "${YELLOW}Cleaning up temporary files at: $TMP_DIR...${RESET}"
    rm -rf "$TMP_DIR"
    echo -e "${GREEN}✅ Cleanup complete.${RESET}"
}
