# MCP Check Command

Verify MCP server configuration and token usage.

## Purpose

Check which MCP servers are loaded and how many tokens they're consuming. Essential for Level 1 context reduction.

## Usage

```bash
/mcp-check
```

## What It Does

1. Lists all loaded MCP servers
2. Shows approximate token usage per server
3. Identifies unused or heavy servers
4. Suggests optimization opportunities

## Output Format

```markdown
## MCP Server Status

### Loaded Servers
- file-system: 6,000 tokens ✅
- git: 5,000 tokens ✅
- web-fetch: 4,000 tokens ⚠️ (not used recently)
- database: 8,000 tokens ⚠️ (heavy, consider removing)

### Total MCP Tokens
23,000 tokens (~11.5% of context window)

### Recommendations
1. Remove 'web-fetch' if not using HTTP requests (saves 4K tokens)
2. Remove 'database' if not querying databases (saves 8K tokens)
3. Consider loading MCP servers on-demand only

### Optimal Configuration
Recommended servers for most projects:
- file-system: Essential for file operations
- git: Essential for version control

Estimated savings: 12,000 tokens (6% of context window)

### Next Steps
1. Edit MCP config: ~/.config/claude/mcp.json
2. Remove unused servers
3. Restart Claude Code
4. Run /mcp-check again to verify
```

## Context Impact

```
Current: 23K tokens in MCP servers
Optimized: 11K tokens (file + git only)
Savings: 12K tokens (6% of context window)
```

## Common Scenarios

### Scenario 1: Default MCP File
```
Problem: All MCP servers loaded
Servers: 8-10 servers
Tokens: 40-60K tokens (20-30% of context!)
Solution: Delete default MCP file, load selectively
```

### Scenario 2: Unused Servers
```
Problem: Servers loaded but not used
Example: web-fetch loaded but no HTTP requests
Tokens: 4-8K tokens wasted
Solution: Remove unused servers
```

### Scenario 3: Heavy Servers
```
Problem: Resource-heavy servers loaded
Example: database server for non-DB project
Tokens: 8-12K tokens per heavy server
Solution: Only load when actually needed
```

## Best Practices

### DO:
- ✅ Run after every MCP configuration change
- ✅ Run at start of sessions to verify setup
- ✅ Remove unused servers immediately
- ✅ Load servers on-demand

### DON'T:
- ❌ Ignore high token counts
- ❌ Load "just in case"
- ❌ Use default MCP configurations
- ❌ Forget to restart after changes

## Optimization Guide

### Step 1: Identify Current Usage
```bash
/mcp-check
# Note which servers you actually use
```

### Step 2: Create Minimal Config
```bash
# Edit ~/.config/claude/mcp.json
# Include only essential servers
```

### Step 3: Verify Savings
```bash
# Restart Claude Code
/mcp-check
# Confirm token reduction
```

### Step 4: Load On-Demand
```bash
# For special tasks, use specific configs
claude --mcp-config path/to/special-mcp.json
```

## MCP Server Reference

### Essential (Most Projects)
| Server | Tokens | Purpose |
|--------|--------|---------|
| file-system | ~6K | File operations |
| git | ~5K | Version control |

### Optional (Load When Needed)
| Server | Tokens | Purpose |
|--------|--------|---------|
| web-fetch | ~4K | HTTP requests |
| database | ~8K | Database queries |
| shell | ~3K | Shell commands |

### Specialized (Rare Use)
| Server | Tokens | Purpose |
|--------|--------|---------|
| docker | ~7K | Container operations |
| aws | ~10K | AWS operations |
| kubernetes | ~12K | K8s operations |

## Target Token Budgets

| Level | MCP Tokens | Total Budget |
|-------|------------|--------------|
| Beginner | 6-11K | 30K |
| Intermediate | 11-15K | 60K |
| Advanced | 11-15K | 120K |
| Agentic | 6-11K | 40K (primary) |

**Goal:** Keep MCP servers under 15K tokens (7.5% of context).

## Troubleshooting

### Issue: Too Many Tokens
**Symptoms:** MCP servers using 30K+ tokens
**Solution:** Remove unused servers, use minimal config

### Issue: Servers Not Loaded
**Symptoms:** File operations fail, git commands fail
**Solution:** Check config path, verify server names

### Issue: Config Not Taking Effect
**Symptoms:** Changes not reflected in /mcp-check
**Solution:** Restart Claude Code completely

### Issue: Don't Know Which Servers to Keep
**Symptoms:** Unsure what's needed
**Solution:** Start with file-system + git only

## Related Commands

- `/prime` - Context priming after MCP optimization
- See [MCP Configuration Guide](../../config/README.md)

## See Also

- [Config Directory](../../config/)
- [Level 1 Guide](../../docs/level-1-beginner.md)
- [Context Limits](../../config/context-limits.md)
