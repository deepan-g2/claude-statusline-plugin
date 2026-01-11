# Enhanced Status Line Plugin for Claude Code

[![GitHub stars](https://img.shields.io/github/stars/deepan-g2/claude-statusline-plugin?style=social)](https://github.com/deepan-g2/claude-statusline-plugin/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/deepan-g2/claude-statusline-plugin?style=social)](https://github.com/deepan-g2/claude-statusline-plugin/network/members)
[![GitHub watchers](https://img.shields.io/github/watchers/deepan-g2/claude-statusline-plugin?style=social)](https://github.com/deepan-g2/claude-statusline-plugin/watchers)
[![Visitor Count](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fdeepan-g2%2Fclaude-statusline-plugin&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=visitors&edge_flat=false)](https://hits.seeyoufarm.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/github/v/release/deepan-g2/claude-statusline-plugin)](https://github.com/deepan-g2/claude-statusline-plugin/releases)

A beautiful, informative status line for Claude Code that displays real-time session metrics, git status, token usage, and more.

## 🎨 Features

### Core Metrics
- **📁 Directory Display** - Current working directory (always shown)
- **⎇ Git Integration** - Branch name, uncommitted changes (*), unpushed commits (↑N)
- **◉ Smart Context Tracking** - Percentage + actual token count with color coding
  - Green (< 60%) - All good
  - Yellow (60-80%) - Watch it
  - Orange (> 80%) - Warning!
- **⏱ Session Duration** - Track how long you've been working
- **+/- Code Changes** - Lines added and removed in session
- **💰 Cost Monitoring** - Real-time cost tracking
- **⚡ API Call Counter** - Number of API requests in session (NEW in v1.2.0)
- **📦 Cache Hit Ratio** - Prompt caching efficiency (NEW in v1.2.0, optional)

### Customization
- **10 Pre-built Themes** - Dracula, Nord, Cyberpunk, Solarized, Gruvbox, Ocean, Sunset, Monochrome, Matrix
- **Feature Toggles** - Show/hide any component
- **256 Color Support** - Full terminal color customization
- **Persistent Config** - Your preferences saved across sessions

## 📸 Preview

![Status Line Preview](images/statusline-preview.png)

**Example output:**
```
📁 myproject │ ⎇ main*↑3 │ ◉ 45% (450K) │ ⏱ 1h30m │ +320/-145 │ $0.450 │ ⚡25 │ 📦85%
```

**With cache tracking enabled:**
- ⚡25 = 25 API calls
- 📦85% = 85% cache hit rate (green = good caching!)

## 📦 Installation

### From GitHub (Recommended)

```bash
# Add the plugin marketplace
/plugin marketplace add deepan-g2/claude-statusline-plugin

# Install the plugin
/plugin install enhanced-statusline@deepan-statusline-plugins
```

### 🔄 Updating to Latest Version

If you already have the plugin installed, update to get new features:

```bash
# Update to latest version
claude plugin update enhanced-statusline@deepan-statusline-plugins
```

Or enable auto-updates (inside Claude Code):
```bash
/plugin
# Go to: Marketplaces → deepan-statusline-plugins → Enable auto-update
```

**Current Version:** v1.2.0 (Released: 2026-01-11)
**Previous Version:** v1.0.0

See [CHANGELOG.md](CHANGELOG.md) for all version changes.

### Local Development

```bash
# Clone the repository
git clone https://github.com/deepan-g2/claude-statusline-plugin.git
cd claude-statusline-plugin

# Test locally
claude --plugin-dir ./
```

## 🚀 Quick Start

After installation, activate the status line:

```bash
# Inside Claude Code
/enhanced-statusline:setup-statusline
```

Or manually add to your `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/plugins/enhanced-statusline/scripts/statusline.sh",
    "padding": 0
  }
}
```

Then restart your Claude Code session!

## 🎨 Customization

### Change Colors

Edit the script at `scripts/statusline.sh` (lines 86-96):

```bash
CYAN="\033[38;5;87m"      # Change to any 0-255 color
GREEN="\033[38;5;46m"
YELLOW="\033[38;5;228m"
ORANGE="\033[38;5;214m"
PURPLE="\033[38;5;141m"
```

### Popular Color Schemes

**Dracula Theme:**
```bash
CYAN="\033[38;5;117m"
GREEN="\033[38;5;84m"
ORANGE="\033[38;5;215m"
PURPLE="\033[38;5;141m"
```

**Ocean Blue:**
```bash
CYAN="\033[38;5;81m"
GREEN="\033[38;5;48m"
ORANGE="\033[38;5;116m"
PURPLE="\033[38;5;69m"
```

### View All Colors

```bash
for i in {0..255}; do
  echo -e "\033[38;5;${i}m${i}\033[0m"
done
```

## 📚 Available Commands

### 🚀 Method 1: Direct CLI (Fastest - Recommended!)

Use the included CLI tool **outside of Claude** for instant results:

```bash
# Create an alias (add to ~/.zshrc or ~/.bashrc)
alias statusline-cli='~/.claude/plugins/cache/deepan-statusline-plugins/enhanced-statusline/*/scripts/statusline-cli.sh'

# Then use it:
statusline-cli themes list          # List all themes
statusline-cli themes apply dracula # Apply Dracula theme
statusline-cli toggle git           # Toggle git display
statusline-cli config show          # Show current config
```

**Why use this?** Instant execution, no Claude overhead, no autocomplete errors!

### 🐌 Method 2: Plugin Commands (Inside Claude)

If you prefer to use commands inside Claude Code:

**Setup & Configuration:**
- `/enhanced-statusline:setup-statusline` - Initial status line configuration
- `/enhanced-statusline:show-config` - View current theme and settings

**Theme Management:**
- `/enhanced-statusline:theme` - Switch between 10 pre-built themes

**Feature Toggles:**
- `/enhanced-statusline:toggle-git` - Show/hide git branch and status
- `/enhanced-statusline:toggle-cost` - Show/hide cost monitoring
- `/enhanced-statusline:toggle-duration` - Show/hide session duration

**Note:** Plugin commands may be slower as they go through Claude's command parser.

## 🔧 Requirements

- Claude Code CLI
- `jq` (for JSON parsing)
- `bc` (for calculations)
- Git (optional, for git status features)

Install dependencies:

```bash
# macOS
brew install jq bc

# Linux
apt-get install jq bc
```

## 📖 Documentation

### Status Line Components

| Component | Description | Example |
|-----------|-------------|---------|
| 📁 Directory | Current folder name | `📁 myproject` |
| ⎇ Git | Branch + status | `⎇ main*↑3` |
| ◉ Context | Token usage % + count | `◉ 45% (450K)` |
| ⏱ Duration | Session time | `⏱ 1h30m` |
| +/- Lines | Code changes | `+320/-145` |
| 💰 Cost | Session cost | `$0.450` |

### Git Status Indicators

- `*` - Uncommitted changes present
- `↑N` - N unpushed commits
- No indicator - Clean working tree

### Context Warning Levels

- **Green ◉** - Less than 60% context used
- **Yellow ◉** - 60-80% context used
- **Orange ⚠** - More than 80% context used (consider compacting)

## 🛠 Troubleshooting

### Update Not Working?

If `claude plugin update` doesn't show the latest version:

```bash
# Option 1: Uninstall and reinstall (Recommended)
claude plugin uninstall enhanced-statusline
claude plugin install enhanced-statusline@deepan-statusline-plugins

# Option 2: Force marketplace refresh
/plugin marketplace remove deepan-statusline-plugins
/plugin marketplace add deepan-g2/claude-statusline-plugin
claude plugin install enhanced-statusline@deepan-statusline-plugins

# Option 3: Clear cache (if above don't work)
# Exit Claude, then:
rm -rf ~/.claude/plugins/cache/deepan-statusline-plugins
# Restart Claude and reinstall
claude plugin install enhanced-statusline@deepan-statusline-plugins
```

### New Commands Not Showing?

After updating to v1.2.0, if new commands aren't available:
- **Restart Claude Code completely** (exit and start new session)
- Verify you're on v1.2.0: Check `~/.claude/plugins/installed_plugins.json`
- The new commands should appear: `/enhanced-statusline:theme`, `/enhanced-statusline:toggle-git`, etc.

### Colors not showing?
```bash
# Check terminal color support
echo $TERM  # Should be xterm-256color or similar
export TERM=xterm-256color
```

### jq not found?
```bash
# Install jq
brew install jq  # macOS
apt-get install jq  # Linux
```

### Status line not updating?
- Restart Claude Code session
- Check script permissions: `chmod +x ~/.claude/plugins/cache/*/enhanced-statusline/*/scripts/statusline.sh`
- Test manually: `echo '{}' | ~/.claude/statusline.sh`

### Theme Command Error?
If you get an error running `/enhanced-statusline:theme`:
- Make sure you're on v1.2.0 (see "Update Not Working" above)
- Check that `scripts/themes.json` exists in your plugin directory
- Try running setup again: `/enhanced-statusline:setup-statusline`

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

MIT License - feel free to use and modify!

## 🌟 Credits

Created by Deepan Kumar ([@deepan-g2](https://github.com/deepan-g2)). Inspired by Oh-My-Zsh themes and Starship prompt.

## 📮 Support

- Report issues: [GitHub Issues](https://github.com/deepan-g2/claude-statusline-plugin/issues)
- Discussions: [GitHub Discussions](https://github.com/deepan-g2/claude-statusline-plugin/discussions)
- Documentation: [Wiki](https://github.com/deepan-g2/claude-statusline-plugin/wiki)

---

Made with ❤️ for the Claude Code community
