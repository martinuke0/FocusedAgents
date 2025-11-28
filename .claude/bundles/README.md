# Context Bundles

Saved context states for agent chaining (Level 3).

## What are Bundles?

Context bundles preserve agent state for handoffs:
- Task and goals
- Files modified
- Decisions made
- Progress summary
- Next steps

## Commands

```bash
/bundle-save <name>    # Save current context
/bundle-load <name>    # Load saved context
/bundle-list           # List all bundles
```

## Bundle Format

```json
{
  "name": "feature-name",
  "created": "2025-11-28T10:30:00Z",
  "context": {
    "task": "Task description",
    "files_modified": ["file1", "file2"],
    "decisions": ["decision1", "decision2"],
    "progress": "Progress summary"
  },
  "next_agent": "suggested-agent",
  "next_task": "Next steps"
}
```

## Best Practices

- Save at 120K tokens
- Use descriptive names
- Document decisions clearly
- Note next steps

## Examples

See `examples/` for sample bundles.
