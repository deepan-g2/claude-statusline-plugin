#!/bin/bash
# Test script to see all available data in status line input

cat << 'EOF' | jq '.'
{
  "hook_event_name": "Status",
  "session_id": "test-session-123",
  "cwd": "/Users/dkumar/Github/myproject",
  "model": {
    "id": "claude-sonnet-4-5-20250929[1m]",
    "display_name": "Sonnet 4.5 (1M)"
  },
  "workspace": {
    "current_dir": "/Users/dkumar/Github/myproject",
    "project_dir": "/Users/dkumar/Github/myproject"
  },
  "version": "2.0.76",
  "output_style": {
    "style": "default"
  },
  "cost": {
    "total_cost_usd": 0.45,
    "total_duration_ms": 5400000,
    "lines_added": 320,
    "lines_removed": 145,
    "model_usage": {
      "claude-sonnet-4-5": {
        "requests": 25,
        "input_tokens": 450000,
        "output_tokens": 12000
      }
    }
  },
  "context_window": {
    "context_window_size": 1000000,
    "current_usage": {
      "input_tokens": 450000,
      "cache_creation_input_tokens": 0,
      "cache_read_input_tokens": 0,
      "output_tokens": 12000
    }
  }
}
EOF
