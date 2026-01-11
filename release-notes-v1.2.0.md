# 🚀 Major Update: Enhanced Status Line Plugin v1.2.0

This is a **major feature release** with themes, toggles, and advanced metrics!

## ✨ What's New

### 🎨 10 Pre-Built Themes
Switch themes instantly with `/enhanced-statusline:theme`:
- **Default (Cyberpunk)** - Original vibrant pink/cyan theme
- **Dracula** - Dark purple and pink tones
- **Nord** - Cool arctic blue theme
- **Cyberpunk Neon** - Ultra-bright neon colors
- **Solarized Dark** - Popular Solarized palette
- **Gruvbox** - Retro warm color scheme
- **Ocean** - Cool ocean-inspired blues
- **Sunset** - Warm sunset oranges
- **Monochrome** - Professional grayscale
- **Matrix** - Classic green terminal theme

### ⚙️ Feature Toggle System
Customize what you see with toggle commands:
- `/enhanced-statusline:toggle-git` - Show/hide git branch and status
- `/enhanced-statusline:toggle-cost` - Show/hide cost monitoring
- `/enhanced-statusline:toggle-duration` - Show/hide session duration
- All preferences persist across sessions!

### 📊 New Advanced Metrics
- **⚡ API Call Counter** - Track number of API requests in your session
- **📦 Cache Hit Ratio** - Monitor prompt caching efficiency (optional, disabled by default)

### 🔧 Configuration Management
- `/enhanced-statusline:show-config` - View your current theme and settings
- Persistent configuration in `~/.claude/enhanced-statusline-config.json`
- Per-user preferences saved automatically

## 📸 New Status Line Preview

```
📁 myproject │ ⎇ main*↑3 │ ◉ 45% (450K) │ ⏱ 1h30m │ +320/-145 │ $0.450 │ ⚡25 │ 📦85%
```

Legend:
- ⚡25 = 25 API calls made
- 📦85% = 85% cache hit rate (green = excellent caching!)

## 🔄 How to Update

### If You Already Have v1.0.0 Installed:

**Option 1: Uninstall & Reinstall (Recommended)**
```bash
claude plugin uninstall enhanced-statusline
claude plugin install enhanced-statusline@deepan-statusline-plugins
```

**Option 2: Update Command**
```bash
claude plugin update enhanced-statusline@deepan-statusline-plugins
```

If update doesn't work, use Option 1.

### For New Users:
```bash
/plugin marketplace add deepan-g2/claude-statusline-plugin
/plugin install enhanced-statusline@deepan-statusline-plugins
```

## 🎯 Quick Start with New Features

After updating:

**Try different themes:**
```bash
/enhanced-statusline:theme
# Choose from 10 themes!
```

**Customize what you see:**
```bash
/enhanced-statusline:toggle-git      # Hide git if you don't need it
/enhanced-statusline:toggle-cost     # Hide cost tracking
```

**View your configuration:**
```bash
/enhanced-statusline:show-config
```

## 📦 New Files & Scripts

- `scripts/themes.json` - 10 theme definitions
- `scripts/apply-theme.sh` - Theme management utility
- `scripts/toggle-feature.sh` - Feature toggle manager
- `commands/theme.md` - Theme switching command
- `commands/show-config.md` - Configuration viewer
- `commands/toggle-*.md` - Individual toggle commands

## 🔧 Technical Improvements

- Dynamic theme loading from JSON configuration
- Feature toggle support in statusline.sh
- Improved error handling with fallback values
- Better jq usage for performance optimization
- Persistent user preferences system

## 📈 Stats

- **+800 lines of code**
- **15 files changed**
- **3x more commands** (2 → 8 commands)
- **10 themes** available
- **2 new metrics** (API calls & cache ratio)

## 🐛 Known Issues

- Plugin update may require uninstall/reinstall on first upgrade from v1.0.0
- This is a Claude Code plugin system limitation, not a bug in the plugin

## 📚 Documentation

- Updated README with all new features
- Comprehensive troubleshooting section
- Update instructions for existing users
- Full CHANGELOG with migration notes

## 🙏 Thank You

Thanks to everyone who installed v1.0.0 and provided feedback! This release addresses many community requests.

## 🔗 Links

- **Repository:** https://github.com/deepan-g2/claude-statusline-plugin
- **Issues:** https://github.com/deepan-g2/claude-statusline-plugin/issues
- **Discussions:** https://github.com/deepan-g2/claude-statusline-plugin/discussions
- **CHANGELOG:** https://github.com/deepan-g2/claude-statusline-plugin/blob/main/CHANGELOG.md

---

**Full Changelog**: https://github.com/deepan-g2/claude-statusline-plugin/compare/v1.0.0...v1.2.0
