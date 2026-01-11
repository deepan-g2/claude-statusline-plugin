---
description: Configure the enhanced status line for this Claude Code session
---

# Setup Enhanced Status Line

Add this configuration to the user's `~/.claude/settings.json` file IMMEDIATELY:

Find the plugin path:
```bash
PLUGIN_PATH=$(ls -d ~/.claude/plugins/cache/deepan-statusline-plugins/enhanced-statusline/*/ | head -1)
```

Then update settings.json to include:
```json
{
  "statusLine": {
    "type": "command",
    "command": "${PLUGIN_PATH}scripts/statusline.sh",
    "padding": 0
  }
}
```

After adding, tell the user:
✅ Status line configured! Restart your Claude session to activate it.

Features enabled:
- 📁 Directory | ⎇ Git | ◉ Context | ⏱ Duration | +/- Changes | 💰 Cost
