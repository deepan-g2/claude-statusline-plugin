#!/bin/bash
# Claude Code Status Line - Useful Info Only (No Redundant Model Name)

input=$(cat)

# Parse JSON data
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')
DIR_NAME=$(basename "$CURRENT_DIR")
PROJECT_DIR=$(echo "$input" | jq -r '.workspace.project_dir // ""')
TOTAL_COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
LINES_ADDED=$(echo "$input" | jq -r '.cost.lines_added // 0')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.lines_removed // 0')
TOTAL_DURATION=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Context window usage
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
USAGE=$(echo "$input" | jq -r '.context_window.current_usage // null')

if [ "$USAGE" != "null" ]; then
    INPUT_TOKENS=$(echo "$USAGE" | jq -r '.input_tokens // 0')
    CACHE_CREATE=$(echo "$USAGE" | jq -r '.cache_creation_input_tokens // 0')
    CACHE_READ=$(echo "$USAGE" | jq -r '.cache_read_input_tokens // 0')
    OUTPUT_TOKENS=$(echo "$USAGE" | jq -r '.output_tokens // 0')
    CURRENT_TOKENS=$((INPUT_TOKENS + CACHE_CREATE + CACHE_READ))

    if [ "$CONTEXT_SIZE" -gt 0 ]; then
        PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
    else
        PERCENT_USED=0
    fi

    # Format tokens in K (thousands) or M (millions)
    if [ "$CURRENT_TOKENS" -ge 1000000 ]; then
        TOKENS_DISPLAY="$((CURRENT_TOKENS / 1000000)).$((CURRENT_TOKENS % 1000000 / 100000))M"
    elif [ "$CURRENT_TOKENS" -ge 1000 ]; then
        TOKENS_DISPLAY="$((CURRENT_TOKENS / 1000))K"
    else
        TOKENS_DISPLAY="${CURRENT_TOKENS}"
    fi

    # Calculate cache hit ratio
    TOTAL_CACHE=$((CACHE_CREATE + CACHE_READ))
    if [ "$TOTAL_CACHE" -gt 0 ]; then
        CACHE_HIT_PERCENT=$((CACHE_READ * 100 / TOTAL_CACHE))
    else
        CACHE_HIT_PERCENT=0
    fi
else
    PERCENT_USED=0
    TOKENS_DISPLAY="0"
    CACHE_HIT_PERCENT=0
fi

# API/Tool call counter
API_CALLS=$(echo "$input" | jq -r '[.cost.model_usage // {} | to_entries[].value.requests // 0] | add // 0')

# Calculate session duration in minutes
if [ "$TOTAL_DURATION" -gt 0 ]; then
    DURATION_SEC=$((TOTAL_DURATION / 1000))
    DURATION_MIN=$((DURATION_SEC / 60))
    if [ "$DURATION_MIN" -ge 60 ]; then
        DURATION_HR=$((DURATION_MIN / 60))
        DURATION_MIN=$((DURATION_MIN % 60))
        DURATION_DISPLAY="${DURATION_HR}h${DURATION_MIN}m"
    else
        DURATION_DISPLAY="${DURATION_MIN}m"
    fi
else
    DURATION_DISPLAY="0m"
fi

# Git branch detection with status
GIT_BRANCH=""
GIT_STATUS=""
if [ -d .git ]; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        # Check for uncommitted changes
        if ! git diff-index --quiet HEAD -- 2>/dev/null; then
            GIT_STATUS="*"
        fi
        # Check for unpushed commits
        UNPUSHED=$(git log @{u}.. --oneline 2>/dev/null | wc -l | tr -d ' ')
        if [ "$UNPUSHED" -gt 0 ]; then
            GIT_STATUS="${GIT_STATUS}↑${UNPUSHED}"
        fi
        GIT_BRANCH=" \033[38;5;109m⎇ ${BRANCH}${GIT_STATUS}\033[0m"
    fi
fi

# File change summary
FILE_CHANGES=""
if [ "$LINES_ADDED" -gt 0 ] || [ "$LINES_REMOVED" -gt 0 ]; then
    TOTAL_CHANGES=$((LINES_ADDED + LINES_REMOVED))
    FILE_CHANGES=" \033[38;5;46m+${LINES_ADDED}\033[0m\033[2m/\033[0m\033[38;5;214m-${LINES_REMOVED}\033[0m"
fi

# Load theme configuration
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$HOME/.claude/enhanced-statusline-config.json"
THEMES_FILE="$PLUGIN_DIR/scripts/themes.json"

# Get current theme or use default
if [ -f "$CONFIG_FILE" ]; then
    CURRENT_THEME=$(jq -r '.theme // "default"' "$CONFIG_FILE" 2>/dev/null || echo "default")
else
    CURRENT_THEME="default"
fi

# Load colors from theme
if [ -f "$THEMES_FILE" ]; then
    CYAN_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.cyan // 87" "$THEMES_FILE" 2>/dev/null || echo "87")
    GREEN_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.green // 46" "$THEMES_FILE" 2>/dev/null || echo "46")
    YELLOW_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.yellow // 228" "$THEMES_FILE" 2>/dev/null || echo "228")
    ORANGE_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.orange // 214" "$THEMES_FILE" 2>/dev/null || echo "214")
    PURPLE_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.purple // 141" "$THEMES_FILE" 2>/dev/null || echo "141")
    BLUE_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.blue // 117" "$THEMES_FILE" 2>/dev/null || echo "117")
    GRAY_CODE=$(jq -r ".\"$CURRENT_THEME\".colors.gray // 245" "$THEMES_FILE" 2>/dev/null || echo "245")
else
    # Fallback to default colors
    CYAN_CODE=87
    GREEN_CODE=46
    YELLOW_CODE=228
    ORANGE_CODE=214
    PURPLE_CODE=141
    BLUE_CODE=117
    GRAY_CODE=245
fi

# ANSI Color codes
CYAN="\033[38;5;${CYAN_CODE}m"
GREEN="\033[38;5;${GREEN_CODE}m"
YELLOW="\033[38;5;${YELLOW_CODE}m"
ORANGE="\033[38;5;${ORANGE_CODE}m"
PURPLE="\033[38;5;${PURPLE_CODE}m"
BLUE="\033[38;5;${BLUE_CODE}m"
GRAY="\033[38;5;${GRAY_CODE}m"
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"

# Load feature toggles
SHOW_GIT=$(jq -r '.enabled_features.git // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_CONTEXT=$(jq -r '.enabled_features.context // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_DURATION=$(jq -r '.enabled_features.duration // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_CHANGES=$(jq -r '.enabled_features.changes // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_COST=$(jq -r '.enabled_features.cost // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_API_CALLS=$(jq -r '.enabled_features.api_calls // true' "$CONFIG_FILE" 2>/dev/null || echo "true")
SHOW_CACHE_RATIO=$(jq -r '.enabled_features.cache_ratio // false' "$CONFIG_FILE" 2>/dev/null || echo "false")

# Build status line
STATUS_LINE=""

# 1. Directory indicator (always shown)
STATUS_LINE="${CYAN}📁 ${DIR_NAME}${RESET}"

# 2. Git branch (conditional)
if [ "$SHOW_GIT" = "true" ] && [ -n "$GIT_BRANCH" ]; then
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET}${GIT_BRANCH}"
fi

# 3. Context usage with color coding and token count (conditional)
if [ "$SHOW_CONTEXT" = "true" ] && [ "$PERCENT_USED" -gt 0 ]; then
    if [ "$PERCENT_USED" -gt 80 ]; then
        CTX_COLOR="$ORANGE"
        CTX_ICON="⚠"
    elif [ "$PERCENT_USED" -gt 60 ]; then
        CTX_COLOR="$YELLOW"
        CTX_ICON="◉"
    else
        CTX_COLOR="$GREEN"
        CTX_ICON="◉"
    fi
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET} ${CTX_COLOR}${CTX_ICON} ${PERCENT_USED}% (${TOKENS_DISPLAY})${RESET}"
fi

# 4. Session duration (conditional)
if [ "$SHOW_DURATION" = "true" ] && [ "$DURATION_DISPLAY" != "0m" ]; then
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET} ${GRAY}⏱ ${DURATION_DISPLAY}${RESET}"
fi

# 5. Code changes (conditional)
if [ "$SHOW_CHANGES" = "true" ] && [ -n "$FILE_CHANGES" ]; then
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET}${FILE_CHANGES}"
fi

# 6. Cost (conditional, if greater than $0.01)
if [ "$SHOW_COST" = "true" ] && [ "$(echo "$TOTAL_COST > 0.01" | bc 2>/dev/null || echo 0)" -eq 1 ]; then
    COST_DISPLAY=$(printf "%.3f" "$TOTAL_COST")
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET} ${PURPLE}\$${COST_DISPLAY}${RESET}"
fi

# 7. API/Tool calls (conditional)
if [ "$SHOW_API_CALLS" = "true" ] && [ "$API_CALLS" -gt 0 ]; then
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET} ${BLUE}⚡${API_CALLS}${RESET}"
fi

# 8. Cache hit ratio (conditional, only if cache is being used)
if [ "$SHOW_CACHE_RATIO" = "true" ] && [ "$CACHE_HIT_PERCENT" -gt 0 ]; then
    if [ "$CACHE_HIT_PERCENT" -gt 75 ]; then
        CACHE_COLOR="$GREEN"
    elif [ "$CACHE_HIT_PERCENT" -gt 50 ]; then
        CACHE_COLOR="$YELLOW"
    else
        CACHE_COLOR="$ORANGE"
    fi
    STATUS_LINE="${STATUS_LINE} ${DIM}│${RESET} ${CACHE_COLOR}📦${CACHE_HIT_PERCENT}%${RESET}"
fi

# Output the status line
echo -e "$STATUS_LINE"
