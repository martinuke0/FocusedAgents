# Background Agent Command

Run agent in background for long-running or monitoring tasks.

## Purpose

Execute tasks asynchronously in background agents while primary agent remains available for other work.

## Usage

```bash
/background <task-description> [report-file]
```

## Arguments

- `task-description`: Task for background agent
- `report-file` (optional): Where to write progress (default: `.claude/bundles/background-report.md`)

## Examples

```bash
/background "Run full test suite and report results"
/background "Monitor code quality metrics" quality-report.md
/background "Generate complete API documentation" api-docs-status.md
```

## How It Works

```
Primary Agent (You):
├── Continue interactive work
├── Check background progress periodically
└── Review results when complete

Background Agent (Async):
├── Execute long-running task
├── Write progress to report file
└── Complete independently
```

## Output

```markdown
## Background Agent Started

**Task:** Run full test suite and report results
**Agent ID:** bg-abc123
**Report File:** .claude/bundles/background-report.md
**Started:** 2025-11-28 10:30 AM

### Monitoring
Check progress:
```bash
cat .claude/bundles/background-report.md
```

### Status
Background agent running...
Primary agent free for other work.

### When Complete
Background agent will write final results to report file.
Review results when ready.
```

## Report File Format

```markdown
## Background Task Progress

**Task:** Run full test suite
**Started:** 10:30 AM
**Status:** In Progress

### Progress Log
[10:30] Starting test execution
[10:32] Unit tests: 145/200 passed
[10:35] Integration tests: 23/45 passed
[10:38] Running security tests...

### Current Status
Running security tests (67% complete)

### Results (when complete)
Will appear here when task finishes
```

## Use Cases

### Long-Running Tests
```bash
/background "Run full test suite with coverage report"
# Continue working while tests run
```

### Documentation Generation
```bash
/background "Generate API documentation for all modules"
# Continue coding while docs generate
```

### Code Quality Monitoring
```bash
/background "Monitor code quality and report issues hourly"
# Long-running monitor in background
```

### Large Refactoring Analysis
```bash
/background "Analyze entire codebase for refactoring opportunities"
# Work on other tasks while analysis runs
```

## Best Practices

### DO:
- ✅ Use for long-running tasks (>10 minutes)
- ✅ Monitor progress periodically
- ✅ Use clear task descriptions
- ✅ Specify report file location

### DON'T:
- ❌ Use for quick tasks (<5 minutes)
- ❌ Forget to check results
- ❌ Run too many background agents (max 2-3)
- ❌ Use for tasks requiring interaction

## Background vs Delegation

| Feature | Background | Delegation (/delegate) |
|---------|------------|----------------------|
| Speed | Async (long) | Sync (returns result) |
| Duration | Minutes-hours | Seconds-minutes |
| Monitoring | Via report file | Immediate return |
| Use case | Long tasks | Quick focused tasks |
| Level | 4 | 2 |

## Monitoring Background Agents

```bash
# Check report file
cat .claude/bundles/background-report.md

# Or use watch for live updates
watch -n 5 cat .claude/bundles/background-report.md

# Kill if needed
# (Future: /background-kill <agent-id>)
```

## Troubleshooting

**Issue:** Background agent not starting
**Solution:** Check task description clarity

**Issue:** No progress updates
**Solution:** Check report file location

**Issue:** Task taking too long
**Solution:** Task might be too complex, break into smaller tasks

**Issue:** Multiple background agents
**Solution:** Limit to 2-3 concurrent background agents

## Related Commands

- `/parallel` - Run multiple agents simultaneously
- `/orchestrate` - Complex workflow orchestration
- `/expert` - Deep specialist agents

## See Also

- [Level 4 Guide](../../docs/level-4-agentic.md)
- [Background Agents](../../agents/background-agents/)
- [Workflows](../../workflows/)
