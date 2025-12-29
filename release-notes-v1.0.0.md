# 🎉 Initial Release: Enhanced Status Line Plugin v1.0.0

A beautiful, informative status line for Claude Code CLI that displays real-time session metrics.

## ✨ Features

- 📁 **Directory Display** - Current working directory
- ⎇ **Git Integration** - Branch name, uncommitted changes (*), unpushed commits (↑N)
- ◉ **Smart Context Tracking** - Percentage + actual token count with color coding
  - Green (< 60%) - All good
  - Yellow (60-80%) - Watch it
  - Orange (> 80%) - Warning!
- ⏱️ **Session Duration** - Track how long you've been working
- +/- **Code Changes** - Lines added and removed in session
- 💰 **Cost Monitoring** - Real-time cost tracking

## 📦 Installation

```bash
/plugin marketplace add deepan-g2/claude-statusline-plugin
/plugin install enhanced-statusline@deepan-statusline-plugins
```

## 🎨 Customization

Fully customizable with 256 terminal colors! Edit `scripts/statusline.sh` to personalize your experience.

## 📚 Documentation

Full documentation available in the [README](https://github.com/deepan-g2/claude-statusline-plugin#readme)

## 🙏 Feedback Welcome

This is the initial release! Please open issues or discussions with any feedback, bug reports, or feature requests.

---

**Full Changelog**: https://github.com/deepan-g2/claude-statusline-plugin/commits/v1.0.0
