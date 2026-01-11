# Changelog

All notable changes to the Enhanced Status Line Plugin will be documented in this file.

## [1.2.0] - 2026-01-11

### Added
- **10 Pre-built Themes** - Switch themes instantly with `/enhanced-statusline:theme`
  - Default (Cyberpunk) - Original vibrant theme
  - Dracula - Dark purple and pink tones
  - Nord - Cool arctic blue theme
  - Cyberpunk - Ultra-bright neon colors
  - Solarized Dark - Popular Solarized palette
  - Gruvbox - Retro warm colors
  - Ocean - Cool ocean-inspired blues
  - Sunset - Warm sunset oranges
  - Monochrome - Professional grayscale
  - Matrix - Classic green terminal
- **Feature Toggle System** - Enable/disable individual components
  - `/enhanced-statusline:toggle-git` - Show/hide git info
  - `/enhanced-statusline:toggle-cost` - Show/hide cost
  - `/enhanced-statusline:toggle-duration` - Show/hide duration
- **New Metrics**
  - ⚡ API/Tool call counter - Track number of API requests
  - 📦 Cache hit ratio - Monitor prompt caching efficiency (optional)
- **Configuration Management**
  - `/enhanced-statusline:show-config` - View current settings
  - Persistent configuration in `~/.claude/enhanced-statusline-config.json`
  - Per-user theme and feature preferences

### Changed
- Status line now loads colors dynamically from theme configuration
- Improved performance with better jq usage
- Enhanced error handling with fallback values

### Technical
- Added `scripts/themes.json` - Theme definition file
- Added `scripts/apply-theme.sh` - Theme manager script
- Added `scripts/toggle-feature.sh` - Feature toggle manager
- Updated `scripts/statusline.sh` to support dynamic theming

## [1.0.0] - 2025-12-29

### Added
- Initial release of Enhanced Status Line Plugin
- Directory display with folder emoji
- Git branch integration with status indicators
- Smart context tracking with percentage and token count
- Color-coded context warnings (green/yellow/orange)
- Session duration tracking
- Code change monitoring (+/- lines)
- Real-time cost tracking
- Setup command for easy configuration
- Color scheme command for customization
- Comprehensive documentation

### Features
- Support for 256 terminal colors
- Automatic git status detection
- Unpushed commit counter
- Uncommitted changes indicator
- Session time formatting (minutes/hours)
- Token count formatting (K/M suffixes)
- Configurable via plugin commands
- Zero configuration after installation

### Documentation
- Complete README with installation guide
- Color customization examples
- Troubleshooting section
- Contributing guidelines
- MIT License
