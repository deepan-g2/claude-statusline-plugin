---
description: Switch between status line color themes
---

# Switch Status Line Theme

IMMEDIATELY run these bash commands:

1. First, show available themes:
```bash
~/.claude/plugins/cache/deepan-statusline-plugins/enhanced-statusline/*/scripts/apply-theme.sh list
```

2. Show current theme:
```bash
~/.claude/plugins/cache/deepan-statusline-plugins/enhanced-statusline/*/scripts/apply-theme.sh current
```

3. Ask user which theme they want to apply from: default, dracula, nord, cyberpunk, solarized-dark, gruvbox, ocean, sunset, monochrome, matrix

4. Apply the chosen theme:
```bash
~/.claude/plugins/cache/deepan-statusline-plugins/enhanced-statusline/*/scripts/apply-theme.sh apply THEME_NAME
```

5. Tell user to restart Claude session to see the new theme.

DO NOT overthink this. Just run the commands and show the output.
