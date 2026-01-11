# How to Update Enhanced Status Line Plugin

## For Users Already on v1.0.0

### Step 1: Refresh the Marketplace
```bash
/plugin marketplace update deepan-statusline-plugins
```
This pulls the latest marketplace.json with v1.2.0 info.

### Step 2: Update the Plugin
```bash
claude plugin update enhanced-statusline@deepan-statusline-plugins
```

### Alternative: Force Refresh
```bash
# Remove and re-add marketplace
/plugin marketplace remove deepan-statusline-plugins
/plugin marketplace add deepan-g2/claude-statusline-plugin

# Then update
claude plugin update enhanced-statusline@deepan-statusline-plugins
```

## Verify Version

After updating, restart Claude and check:
```bash
/enhanced-statusline:show-config
```

Should show new commands available!

## What's New in v1.2.0

- 10 pre-built themes
- Feature toggle system  
- API call counter
- Cache hit ratio tracking
- Configuration management

Try: `/enhanced-statusline:theme` to switch themes!
