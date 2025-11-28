# Bundle List Command

List all saved context bundles.

## Purpose

View available context bundles for loading or reference.

## Usage

```bash
/bundle-list
```

## Output

```markdown
## Saved Context Bundles

### Recent Bundles (Last 7 days)

**oauth-impl** (2 hours ago)
- Task: Implement OAuth2 authentication
- Progress: 70% complete
- Tokens: 125K
- Files: 3
- Status: Ready to continue

**feature-auth** (1 day ago)
- Task: Add authentication system
- Progress: Complete
- Tokens: 98K
- Files: 8
- Status: Completed

**large-refactor** (3 days ago)
- Task: Refactor API layer
- Progress: 60% complete (15/25 modules)
- Tokens: 142K
- Files: 25
- Status: In progress

### Older Bundles

**api-redesign** (2 weeks ago)
- Task: Redesign REST API
- Progress: Complete
- Tokens: 115K
- Status: Archived

### Summary
- Total bundles: 4
- Active: 2
- Completed: 2
- Total storage: 18.5 KB

### Actions
- Load: /bundle-load <name>
- Clean old: Consider removing bundles older than 30 days
```

## Bundle Status

**Ready to continue:** Active work, can be loaded immediately
**Completed:** Task finished, kept for reference
**In progress:** Ongoing work, may need continuation
**Archived:** Old bundle, consider cleaning

## Filtering

```bash
# List all bundles
/bundle-list

# Future: Filter by status, date, etc.
# /bundle-list --active
# /bundle-list --recent
```

## Bundle Management

### When to Clean
- Completed tasks older than 30 days
- Failed attempts no longer needed
- Experimental work not continued

### How to Clean
```bash
# Manual: Delete from .claude/bundles/
rm .claude/bundles/old-bundle.json
```

## Best Practices

### DO:
- ✅ Review periodically
- ✅ Clean old bundles
- ✅ Use descriptive names
- ✅ Check before creating new bundle

### DON'T:
- ❌ Accumulate hundreds of bundles
- ❌ Use unclear names
- ❌ Keep failed attempts forever
- ❌ Delete active work bundles

## Related Commands

- `/bundle-save` - Save context
- `/bundle-load` - Load context
- `/chain-agents` - Automated chain

## See Also

- [Level 3 Guide](../../docs/level-3-advanced.md)
- [Context Bundles](../../bundles/)
