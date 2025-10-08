#!/bin/bash
# Colored logger utility functions
# Usage: source this file in your bash scripts to get colored logger functions
#
# Available functions:
#   log_info "message"    - Blue info messages
#   log_success "message" - Green success messages  
#   log_warn "message"    - Yellow warning messages
#   log_error "message"   - Red error messages
#   log_debug "message"   - Cyan debug messages
#   log_step "message"    - Blue step messages (same as info but with different emoji)
#   log_cleanup "message" - Yellow cleanup messages
#   log_progress "message" - Blue progress messages without newline (use for "Loading...")

# Color definitions
readonly LOG_GREEN='\033[0;32m'
readonly LOG_YELLOW='\033[1;33m'
readonly LOG_BLUE='\033[0;34m'
readonly LOG_RED='\033[0;31m'
readonly LOG_CYAN='\033[0;36m'
readonly LOG_NC='\033[0m'  # No Color

# logger functions with consistent emoji usage
log_info() {
    echo -e "${LOG_BLUE}ℹ️  $1${LOG_NC}"
}

log_success() {
    echo -e "${LOG_GREEN}✅ $1${LOG_NC}"
}

log_warn() {
    echo -e "${LOG_YELLOW}⚠️  $1${LOG_NC}"
}

log_error() {
    echo -e "${LOG_RED}❌ $1${LOG_NC}"
}

log_debug() {
    echo -e "${LOG_CYAN}🔍 $1${LOG_NC}"
}

log_step() {
    echo -e "${LOG_BLUE}🚀 $1${LOG_NC}"
}

log_cleanup() {
    echo -e "${LOG_YELLOW}🗑️  $1${LOG_NC}"
}

log_progress() {
    echo -ne "${LOG_BLUE}🔍 $1${LOG_NC}"
}

# Additional utility functions
log_separator() {
    echo -e "${LOG_CYAN}════════════════════════════════════════${LOG_NC}"
}

log_header() {
    echo ""
    log_separator
    echo -e "${LOG_BLUE}🎯 $1${LOG_NC}"
    log_separator
    echo ""
}

# Function to log with custom emoji and color
log_custom() {
    local color="$1"
    local emoji="$2"
    local message="$3"
    echo -e "${color}${emoji} ${message}${LOG_NC}"
}

# Function to log without newline (for progress indicators)
log_progress_custom() {
    local color="$1"
    local emoji="$2"
    local message="$3"
    echo -ne "${color}${emoji} ${message}${LOG_NC}"
}

# Success indicator for progress messages
log_progress_done() {
    echo -e " ${LOG_GREEN}✅${LOG_NC}"
}

# Failure indicator for progress messages
log_progress_failed() {
    echo -e " ${LOG_RED}❌${LOG_NC}"
}