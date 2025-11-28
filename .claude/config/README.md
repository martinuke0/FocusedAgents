# MCP Configuration

Model Context Protocol (MCP) servers offload file/git/database access from your agent's context window, providing dramatic token reduction.

## Quick Start

```bash
# Copy template
cp mcp-config-template.json ~/.config/claude/mcp.json

# Or use recommended config
cp mcp-recommended.json ~/.config/claude/mcp.json

# Verify MCP servers loaded
/mcp-check
```

## Why MCP Matters

**Without MCP:**
- File reads add tokens to context
- Git operations consume context
- Database queries load into memory
- 20K+ tokens for basic operations

**With MCP:**
- File access offloaded
- Git operations external
- Database queries isolated
- 50-80% context reduction

## Token Savings Example

```
Without MCP:
- Default MCP servers loaded: 24K tokens
- File reads: 10K tokens
- Git operations: 5K tokens
Total: 39K tokens (~20% of context window)

With Targeted MCP:
- Only file-server loaded: 6K tokens
- On-demand file access: 0K tokens (offloaded)
- On-demand git: 0K tokens (offloaded)
Total: 6K tokens (~3% of context window)

Savings: 33K tokens (17% of context window)
```

## Configuration Files

### mcp-config-template.json
Empty template for custom configuration.

### mcp-recommended.json
Curated MCP servers for most projects:
- **file-system**: File operations
- **git**: Version control
- **web-fetch**: HTTP requests

## Best Practices

### 1. Don't Use Default MCP Files
Delete `defaultmcp.json` - it loads everything always.

### 2. Load On-Demand
Only load MCP servers when you need them:
```bash
# Load specific config
claude --mcp-config path/to/mcp-config.json
```

### 3. Monitor Token Usage
Check tokens before and after MCP configuration:
```bash
# Before
/context  # Note token count

# After loading MCP
/context  # Compare token count
```

### 4. Use Strict Mode
Override globals with `-d-strict mcp config` when needed.

## Recommended MCP Servers

### Essential (Load Always)
- `file-system` - File operations (6K tokens)
- `git` - Version control (5K tokens)

### Optional (Load When Needed)
- `web-fetch` - HTTP requests (4K tokens)
- `database` - Database access (8K tokens)
- `shell` - Shell commands (3K tokens)

## Context Limits

See [context-limits.md](context-limits.md) for token budgets per proficiency level.

## Troubleshooting

**Issue:** MCP servers not loading
**Solution:** Check config path and syntax

**Issue:** Too many tokens used
**Solution:** Remove unused MCP servers

**Issue:** File operations fail
**Solution:** Ensure file-system MCP server loaded

## Further Reading

- [Level 1 Guide](../docs/level-1-beginner.md)
- [Context Limits](context-limits.md)
- [Architecture](../ARCHITECTURE.md)
