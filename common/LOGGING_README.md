# Colored logger Utility for Bash Scripts

🎨 Consistent, beautiful console output with emoji indicators and colors.

## Quick Start

```bash
#!/bin/bash
# Source the logger utility (directory independent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common/logger.sh"

# Use the functions
log_info "Starting application..."
log_success "Operation completed!"
log_warn "Warning message"
log_error "Error occurred"
```

## Available Functions

| Function | Color | Emoji | Use Case |
|----------|-------|--------|----------|
| `log_info "msg"` | Blue | ℹ️ | General information |
| `log_success "msg"` | Green | ✅ | Success messages |
| `log_warn "msg"` | Yellow | ⚠️ | Warnings |
| `log_error "msg"` | Red | ❌ | Errors |
| `log_debug "msg"` | Cyan | 🔍 | Debug information |
| `log_step "msg"` | Blue | 🚀 | Process steps |
| `log_cleanup "msg"` | Yellow | 🗑️ | Cleanup operations |

## Progress & Formatting

```bash
# Progress indicators
log_progress "Loading..."
log_progress_done    # ✅
# or log_progress_failed  # ❌

# Headers and separators
log_header "My App Starting"
log_separator

# Custom messages
log_custom "$LOG_GREEN" "🌟" "Custom message"
```

## Directory Independence Pattern

**✅ Do this:**
```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common/logger.sh"
"$SCRIPT_DIR/other-script.sh"
```

**❌ Not this:**
```bash
source "./logger.sh"    # Breaks when run from elsewhere
./other-script.sh        # Won't find script
```

## Examples

```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common/logger.sh"

log_header "My Application"
log_progress "Initializing..."
sleep 1 && log_progress_done
log_success "Ready!"

# Error handling
command -v docker &>/dev/null || { log_error "Docker not found"; exit 1; }
log_success "Docker available"
```

## Color Variables

```bash
LOG_GREEN='\033[0;32m'   LOG_YELLOW='\033[1;33m'
LOG_BLUE='\033[0;34m'    LOG_RED='\033[0;31m'
LOG_CYAN='\033[0;36m'    LOG_NC='\033[0m'
```

## Test Scripts

```bash
./common/test-logger.sh        # Demo all functions
./example-script.sh              # Practical example
```

**Features:** 🚀 No dependencies • 📁 Directory independent • 🎨 Consistent styling