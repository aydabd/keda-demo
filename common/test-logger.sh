#!/bin/bash
# Test script to demonstrate the logger functions

# Get the absolute path of the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the logger utility using absolute path
# shellcheck disable=SC1091
. "$SCRIPT_DIR/logger.sh"

echo "=== Testing Colored logger Functions ==="
echo ""

log_header "Welcome to the logger Demo"

log_info "This is an info message"
log_success "This is a success message"
log_warn "This is a warning message"
log_error "This is an error message"
log_debug "This is a debug message"
log_step "This is a step message"
log_cleanup "This is a cleanup message"

echo ""
log_separator

echo ""
log_custom "$LOG_CYAN" "🎯" "This is a custom message with cyan color"
log_custom "$LOG_GREEN" "🌟" "This is a custom message with green color"

echo ""
log_progress "This is a progress message (no newline)..."
sleep 1
log_progress_done

log_progress "This is another progress message..."
sleep 1
log_progress_failed

echo ""
log_header "Demo Complete"