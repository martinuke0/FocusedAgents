# Bundle Save Command

Save current context as a bundle for later use or agent handoff.

## Purpose

Preserve context state when approaching token limits, enabling fresh agent to continue work without information loss.

## Usage

```bash
/bundle-save <name> [description]
```

## Arguments

- `name`: Bundle identifier (e.g., `oauth-impl`, `feature-auth`)
- `description` (optional): What's been done and what's next

## Examples

```bash
# Save with auto-generated description
/bundle-save auth-feature

# Save with custom description
/bundle-save oauth-impl "OAuth2 flow complete, token refresh pending"

# Save before context overload
/bundle-save large-refactor "Refactored 15/25 modules, continue with api/"
```

## What Gets Saved

### Context Information
- Current task and goals
- Key files modified
- Important decisions made
- Progress summary
- Current token count

### Metadata
- Timestamp
- Session ID
- Agent configuration
- Context window state

### Recommendations
- Suggested next agent
- Next steps
- Critical files to read

## Bundle Format

```json
{
  "name": "oauth-impl",
  "created": "2025-11-28T10:30:00Z",
  "session_id": "abc123",
  "context": {
    "task": "Implement OAuth2 authentication",
    "files_modified": [
      "src/auth/oauth.py",
      "tests/test_oauth.py",
      "config/oauth_config.json"
    ],
    "decisions": [
      "Using authlib library for OAuth2",
      "JWT tokens with 1-hour expiry",
      "Refresh tokens stored in Redis"
    ],
    "progress": "Core OAuth flow implemented (70% complete)",
    "next_steps": [
      "Implement token refresh logic",
      "Add error handling for expired tokens",
      "Write integration tests"
    ]
  },
  "tokens": 125000,
  "next_agent": "security-auditor",
  "next_task": "Review OAuth implementation for security vulnerabilities"
}
```

## When to Save

### Token Thresholds
```
0-60K:    🟢 No need yet
60-100K:  🟡 Consider saving if approaching complex work
100-120K: 🟠 Prepare to save
120-150K: 🔴 Save immediately
150K+:    ❌ Emergency save (performance degraded)
```

**Best practice:** Save at 120K tokens, before emergency.

## Context Impact

```
Before save:
- Agent 1: 125K tokens (degraded performance)

After load in new agent:
- Agent 2: 5K tokens (bundle summary)
- Full context preserved
- Performance restored
```

## Output

```markdown
## Bundle Saved Successfully

**Name:** oauth-impl
**Location:** .claude/bundles/oauth-impl.json
**Size:** 5.2 KB
**Tokens saved:** 125,000

### Context Summary
- Task: Implement OAuth2 authentication
- Progress: 70% complete
- Files modified: 3
- Decisions recorded: 3

### Next Steps
1. Start fresh agent
2. Run: /bundle-load oauth-impl
3. Continue with token refresh implementation

### Recommended Next Agent
security-auditor (for security review after completion)
```

## Best Practices

### DO:
- ✅ Save at 120K tokens
- ✅ Use descriptive names
- ✅ Include progress percentage
- ✅ Note next steps clearly

### DON'T:
- ❌ Wait until 150K+ tokens
- ❌ Use vague names
- ❌ Save without documenting decisions
- ❌ Forget to note next steps

## Agent Chaining Workflow

```bash
# Agent 1 (Fresh -> 125K tokens)
/prime-workflow feature
# ... implement feature ...
# Context: 125K tokens
/bundle-save feature-impl "Implemented core, tests pending"

# Agent 2 (Fresh -> continues work)
/bundle-load feature-impl
# Context: 5K tokens (restored)
# ... complete tests ...
# Context: 80K tokens
/bundle-save feature-complete "Feature and tests done, ready for review"

# Agent 3 (Review)
/bundle-load feature-complete
/expert python-reviewer src/
```

## Related Commands

- `/bundle-load` - Load saved bundle
- `/bundle-list` - List all bundles
- `/chain-agents` - Full agent chain workflow

## See Also

- [Level 3 Guide](../../docs/level-3-advanced.md)
- [Context Bundles](../../bundles/)
- [Agent Chaining](../../ARCHITECTURE.md#agent-composition-patterns)
