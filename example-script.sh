#!/bin/bash
# Example script showing how to use the logger utility

# Get the absolute path of the script's directory  
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$SCRIPT_DIR/common"

# Source the logger utility using absolute path
# shellcheck disable=SC1091
. "$COMMON_DIR/logger.sh"

# Example usage in a script
log_header "My Script Starting"

log_info "Starting initialization..."
log_progress "Checking system requirements..."
sleep 1
log_progress_done

log_success "System requirements met!"

log_warn "This is just a warning, not an error"

log_debug "Debug information: script version 1.0"

log_step "Performing main task"
log_progress "Processing data..."
sleep 2
log_progress_done

log_success "Script completed successfully!"
log_separator