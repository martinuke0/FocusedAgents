# Level 1: Beginner - Context Reduction (REDUCE)

Master context reduction for 50-80% token savings.

## Goal
Minimize context entering the primary agent through MCP management and context priming.

## Core Techniques

### 1. MCP Server Management
Remove unused MCP servers:
```bash
/mcp-check                # Check current servers
# Edit ~/.config/claude/mcp.json
# Remove unused servers
```

**Token Savings:** 12-20K tokens

### 2. Context Priming
Load focused context dynamically:
```bash
/prime                    # General overview
/prime-workflow feature   # Feature-specific
/prime-codebase          # Deep understanding
```

**Token Savings:** 15-20K tokens

### 3. Slim claude.md
Keep memory file under 500 tokens. Move everything else to priming commands.

**Token Savings:** 10-20K tokens

## Total Impact
**50-80% context reduction** = faster, better responses

## Commands Reference
- `/prime` - Basic priming
- `/prime-workflow` - Workflow-specific
- `/mcp-check` - Verify MCP
- See [commands/level-1/](../commands/level-1/)

## Next Level
Progress to [Level 2](level-2-intermediate.md) for delegation.
