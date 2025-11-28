# Hooks

Automation hooks for context engineering.

## Available Hooks

- **pre-delegate.sh** - Validation before delegation
- **post-delegate.sh** - Processing after delegation
- **bundle-autosave.sh** - Auto-save at thresholds
- **context-monitor.sh** - Monitor token usage

## How Hooks Work

Hooks are shell scripts that run at specific events:
- Before/after delegation
- At token thresholds
- On context changes

## Usage

Hooks run automatically when configured in Claude Code settings.

## Creating Custom Hooks

1. Create hook script
2. Make executable: `chmod +x hook.sh`
3. Configure in Claude Code
4. Test with dry-run

## Best Practices

- Keep hooks fast (<1 second)
- Handle errors gracefully
- Log to hook-specific files
- Don't block agent operations
