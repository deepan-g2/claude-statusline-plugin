#!/bin/bash
# Theme Manager for Enhanced Status Line Plugin

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEMES_FILE="$PLUGIN_DIR/scripts/themes.json"
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
    "cost": true
  }
}
EOF
fi

# Function to list all available themes
list_themes() {
    echo "📋 Available Themes:"
    echo ""
    jq -r 'to_entries[] | "  \(.key) - \(.value.name): \(.value.description)"' "$THEMES_FILE"
}

# Function to apply a theme
apply_theme() {
    local theme_name="$1"

    # Check if theme exists
    if ! jq -e ".\"$theme_name\"" "$THEMES_FILE" > /dev/null 2>&1; then
        echo "❌ Theme '$theme_name' not found!"
        echo ""
        list_themes
        exit 1
    fi

    # Update config file
    jq ".theme = \"$theme_name\"" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

    # Get theme details
    local theme_display_name=$(jq -r ".\"$theme_name\".name" "$THEMES_FILE")
    local theme_description=$(jq -r ".\"$theme_name\".description" "$THEMES_FILE")

    echo "✅ Theme applied successfully!"
    echo ""
    echo "🎨 Theme: $theme_display_name"
    echo "📝 Description: $theme_description"
    echo ""
    echo "🔄 Please restart your Claude session to see the changes."
}

# Function to show current theme
show_current() {
    local current_theme=$(jq -r '.theme' "$CONFIG_FILE")
    local theme_display_name=$(jq -r ".\"$current_theme\".name" "$THEMES_FILE")
    local theme_description=$(jq -r ".\"$current_theme\".description" "$THEMES_FILE")

    echo "🎨 Current Theme: $theme_display_name ($current_theme)"
    echo "📝 Description: $theme_description"
}

# Main logic
case "$1" in
    list)
        list_themes
        ;;
    current)
        show_current
        ;;
    apply)
        if [ -z "$2" ]; then
            echo "Usage: $0 apply <theme-name>"
            echo ""
            list_themes
            exit 1
        fi
        apply_theme "$2"
        ;;
    *)
        echo "Enhanced Status Line - Theme Manager"
        echo ""
        echo "Usage: $0 <command> [args]"
        echo ""
        echo "Commands:"
        echo "  list          - Show all available themes"
        echo "  current       - Show current theme"
        echo "  apply <theme> - Apply a theme"
        echo ""
        echo "Examples:"
        echo "  $0 list"
        echo "  $0 current"
        echo "  $0 apply dracula"
        ;;
esac
