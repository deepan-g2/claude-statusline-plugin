#!/bin/bash
# Feature Toggle Manager for Enhanced Status Line Plugin

CONFIG_FILE="$HOME/.claude/enhanced-statusline-config.json"

# Initialize config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" << 'EOF'
{
  "theme": "default",
  "enabled_features": {
    "git": true,
    "context": true,
    "duration": true,
    "changes": true,
    "cost": true,
    "api_calls": true,
    "cache_ratio": false
  }
}
EOF
fi

# Function to toggle a feature
toggle_feature() {
    local feature="$1"

    # Validate feature name
    if ! echo "$feature" | grep -qE '^(git|context|duration|changes|cost|api_calls|cache_ratio)$'; then
        echo "❌ Invalid feature: $feature"
        echo ""
        echo "Valid features: git, context, duration, changes, cost, api_calls, cache_ratio"
        exit 1
    fi

    # Get current state
    local current_state=$(jq -r ".enabled_features.\"$feature\" // true" "$CONFIG_FILE")

    # Toggle the state
    local new_state
    if [ "$current_state" = "true" ]; then
        new_state="false"
    else
        new_state="true"
    fi

    # Update config
    jq ".enabled_features.\"$feature\" = $new_state" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

    # Display result
    if [ "$new_state" = "true" ]; then
        echo "✅ Feature '$feature' enabled"
    else
        echo "⏸️  Feature '$feature' disabled"
    fi

    echo ""
    echo "🔄 Please restart your Claude session to see the changes."
}

# Function to show current configuration
show_config() {
    echo "🎨 Enhanced Status Line Configuration"
    echo ""
    echo "Current Theme:"
    local theme=$(jq -r '.theme // "default"' "$CONFIG_FILE")
    echo "  $theme"
    echo ""
    echo "Enabled Features:"
    jq -r '.enabled_features | to_entries[] | "  \(.key): \(if .value then "✅ enabled" else "⏸️  disabled" end)"' "$CONFIG_FILE"
}

# Function to reset to defaults
reset_config() {
    cat > "$CONFIG_FILE" << 'EOF'
{
  "theme": "default",
  "enabled_features": {
    "git": true,
    "context": true,
    "duration": true,
    "changes": true,
    "cost": true,
    "api_calls": true,
    "cache_ratio": false
  }
}
EOF
    echo "✅ Configuration reset to defaults"
    echo ""
    echo "🔄 Please restart your Claude session to see the changes."
}

# Main logic
case "$1" in
    toggle)
        if [ -z "$2" ]; then
            echo "Usage: $0 toggle <feature>"
            echo ""
            echo "Features: git, context, duration, changes, cost"
            exit 1
        fi
        toggle_feature "$2"
        ;;
    show)
        show_config
        ;;
    reset)
        reset_config
        ;;
    *)
        echo "Enhanced Status Line - Feature Toggle Manager"
        echo ""
        echo "Usage: $0 <command> [args]"
        echo ""
        echo "Commands:"
        echo "  toggle <feature> - Toggle a feature on/off"
        echo "  show             - Show current configuration"
        echo "  reset            - Reset to defaults"
        echo ""
        echo "Features:"
        echo "  git         - Git branch and status indicators"
        echo "  context     - Context usage and token count"
        echo "  duration    - Session duration tracking"
        echo "  changes     - Code changes (+/- lines)"
        echo "  cost        - Cost monitoring"
        echo "  api_calls   - API/Tool call counter"
        echo "  cache_ratio - Cache hit ratio percentage"
        echo ""
        echo "Examples:"
        echo "  $0 toggle git"
        echo "  $0 toggle cache_ratio"
        echo "  $0 show"
        echo "  $0 reset"
        ;;
esac
