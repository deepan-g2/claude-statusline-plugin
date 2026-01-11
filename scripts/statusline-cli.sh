#!/bin/bash
# Enhanced Status Line CLI - Direct access without plugin commands

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
    echo "Enhanced Status Line CLI"
    echo ""
    echo "Usage: statusline-cli <command> [options]"
    echo ""
    echo "Commands:"
    echo "  themes list              - List all available themes"
    echo "  themes current           - Show current theme"
    echo "  themes apply <name>      - Apply a theme"
    echo ""
    echo "  toggle git               - Toggle git display"
    echo "  toggle cost              - Toggle cost display"
    echo "  toggle duration          - Toggle duration display"
    echo "  toggle context           - Toggle context display"
    echo "  toggle changes           - Toggle changes display"
    echo ""
    echo "  config show              - Show current configuration"
    echo "  config reset             - Reset to defaults"
    echo ""
    echo "Examples:"
    echo "  statusline-cli themes list"
    echo "  statusline-cli themes apply dracula"
    echo "  statusline-cli toggle git"
    echo "  statusline-cli config show"
}

case "$1" in
    themes)
        case "$2" in
            list)
                "$SCRIPT_DIR/apply-theme.sh" list
                ;;
            current)
                "$SCRIPT_DIR/apply-theme.sh" current
                ;;
            apply)
                if [ -z "$3" ]; then
                    echo "❌ Please specify a theme name"
                    echo ""
                    "$SCRIPT_DIR/apply-theme.sh" list
                    exit 1
                fi
                "$SCRIPT_DIR/apply-theme.sh" apply "$3"
                ;;
            *)
                echo "❌ Invalid themes command"
                echo ""
                echo "Usage: statusline-cli themes <list|current|apply>"
                ;;
        esac
        ;;
    toggle)
        if [ -z "$2" ]; then
            echo "❌ Please specify a feature to toggle"
            echo ""
            echo "Features: git, cost, duration, context, changes"
            exit 1
        fi
        "$SCRIPT_DIR/toggle-feature.sh" toggle "$2"
        ;;
    config)
        case "$2" in
            show)
                "$SCRIPT_DIR/toggle-feature.sh" show
                ;;
            reset)
                "$SCRIPT_DIR/toggle-feature.sh" reset
                ;;
            *)
                echo "❌ Invalid config command"
                echo ""
                echo "Usage: statusline-cli config <show|reset>"
                ;;
        esac
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
