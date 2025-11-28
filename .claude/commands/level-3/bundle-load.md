# Bundle Load Command

Load saved context bundle to continue work in fresh agent.

## Purpose

Restore context from previous agent session, enabling continuation of work without information loss but with fresh token budget.

## Usage

```bash
/bundle-load <name>
```

## Arguments

- `name`: Bundle identifier to load

## Examples

```bash
/bundle-load oauth-impl
/bundle-load feature-auth
/bundle-load large-refactor
```

## What Gets Loaded

### Context Restoration
- Task and goals
- Files previously modified
- Decisions made
- Progress summary
- Next steps

### Efficient Loading
- Bundle summary: ~5K tokens
- Key context only
- No full file reloads
- Focused understanding

## Output

```markdown
## Bundle Loaded Successfully

**Name:** oauth-impl
**Created:** 2025-11-28 10:30 AM (2 hours ago)
**Original tokens:** 125,000
**Current tokens:** 5,000 (loaded summary)

### Task Context
Implement OAuth2 authentication for API

### Progress
Core OAuth flow implemented (70% complete)

### Files Modified
- src/auth/oauth.py (234 lines)
- tests/test_oauth.py (145 lines)
- config/oauth_config.json (45 lines)

### Key Decisions
1. Using authlib library for OAuth2
2. JWT tokens with 1-hour expiry
3. Refresh tokens stored in Redis

### Next Steps
1. Implement token refresh logic
2. Add error handling for expired tokens
3. Write integration tests

### Ready To Continue
You can now continue implementation with fresh context.
Files to read if needed:
- src/auth/oauth.py (current implementation)
- tests/test_oauth.py (existing tests)
```

## Context Impact

```
Without bundle:
- Start from scratch: Need to re-understand everything
- Or continue bloated: 150K+ tokens, degraded performance

With bundle:
- Load summary: 5K tokens
- Full context preserved
- Performance optimal
```

## Workflow

### Step 1: Load Bundle
```bash
/bundle-load feature-name
```

### Step 2: Review Context
Read the output to understand:
- What was done
- What decisions were made
- What's next

### Step 3: Continue Work
```bash
# Read key files if needed
# Continue implementation
```

### Step 4: Save When Done (or approaching limit)
```bash
/bundle-save feature-name-v2 "Additional context..."
```

## Best Practices

### DO:
- ✅ Load immediately in fresh agent
- ✅ Review context before continuing
- ✅ Read key files if needed
- ✅ Save again when approaching limits

### DON'T:
- ❌ Load in already-bloated agent
- ❌ Skip reviewing context
- ❌ Reload all files unnecessarily
- ❌ Ignore "next steps" guidance

## Bundle Chain Pattern

```bash
# Agent 1
/prime
# Work... 120K tokens
/bundle-save task-v1

# Agent 2
/bundle-load task-v1    # 5K tokens
# Work... 115K tokens
/bundle-save task-v2

# Agent 3
/bundle-load task-v2    # 5K tokens
# Work... complete!
```

## Multiple Bundle Loading

```bash
# Load primary context
/bundle-load feature-impl

# Can also reference related bundles
/bundle-load related-refactor
# Merge understanding, but keep focused
```

## Troubleshooting

**Issue:** Bundle not found
**Solution:** Check bundle name with `/bundle-list`

**Issue:** Bundle outdated
**Solution:** Check creation time, might need fresh start

**Issue:** Context still unclear
**Solution:** Read key files mentioned in bundle

**Issue:** Too many bundles
**Solution:** Clean old bundles, use clear naming

## Related Commands

- `/bundle-save` - Save current context
- `/bundle-list` - List all bundles
- `/chain-agents` - Automated chain workflow

## See Also

- [Level 3 Guide](../../docs/level-3-advanced.md)
- [Context Bundles](../../bundles/)
- [Bundle Examples](../../bundles/examples/)
