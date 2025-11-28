# Context Priming Command

Prime the agent with focused, task-specific context instead of loading everything.

## Purpose

Load minimal, targeted context to understand the codebase structure and prepare for the specific task type.

## Usage

```bash
/prime [focus-area]
```

## Arguments

- `focus-area` (optional): Specific area to focus on
  - `feature` - Feature development
  - `bug` - Bug fixing
  - `refactor` - Refactoring
  - `review` - Code review
  - `docs` - Documentation
  - (omit for general overview)

## Examples

```bash
/prime                    # General codebase overview
/prime feature            # Prime for feature development
/prime bug                # Prime for bug fixing
/prime refactor           # Prime for refactoring work
/prime review             # Prime for code review
```

## Workflow

### 1. Read Core Files
- README.md or README (project overview)
- Project structure (ls/tree of directories)
- Configuration files (package.json, pyproject.toml, Cargo.toml, etc.)

### 2. Understand Architecture
- Identify main modules/packages
- Note technology stack
- Understand project type (web app, library, CLI, etc.)
- Identify key directories (src/, tests/, docs/, etc.)

### 3. Focus Area Specifics

**For `feature` focus:**
- Locate feature implementation areas
- Find similar existing features
- Identify testing patterns

**For `bug` focus:**
- Find error handling patterns
- Locate logging/debugging utilities
- Identify testing infrastructure

**For `refactor` focus:**
- Understand current architecture
- Find code patterns and conventions
- Identify test coverage

**For `review` focus:**
- Find style guides
- Locate linting configurations
- Identify code standards

### 4. Report Findings

Provide concise summary:
- Project purpose and type
- Main directories and their roles
- Key technologies and frameworks
- Suggested next steps based on focus area

## Output Format

```markdown
## Project Overview
- Type: [web app/library/CLI/service/etc.]
- Tech Stack: [languages, frameworks, key dependencies]
- Structure: [brief directory layout]

## Key Directories
- src/: [description]
- tests/: [description]
- [other important directories]

## Architecture Notes
[Key architectural patterns or decisions]

## Ready For
Based on [focus-area], you're now primed to:
- [specific task 1]
- [specific task 2]
- [specific task 3]

## Next Steps
[Suggested actions based on focus area]
```

## Context Impact

```
Before: 0 tokens (empty context)
After: ~2-5K tokens (focused context)
Savings vs full load: 15-20K tokens
```

## Best Practices

### DO:
- ✅ Use at start of every session
- ✅ Specify focus area when known
- ✅ Review output before proceeding
- ✅ Re-prime if switching task types

### DON'T:
- ❌ Load entire codebase
- ❌ Read every file "just in case"
- ❌ Skip priming and wonder why context is bloated
- ❌ Use without understanding your task

## When to Use

**Always use when:**
- Starting a new coding session
- Switching to a new task type
- Fresh agent after bundle load
- Context window has been reset

**Especially important for:**
- Large codebases (>100 files)
- Unfamiliar projects
- Complex architectures
- Multi-language projects

## Related Commands

- `/prime-codebase` - Deep project overview
- `/prime-workflow` - Workflow-specific priming
- `/mcp-check` - Verify MCP configuration

## Troubleshooting

**Issue:** Too much context loaded
**Solution:** Specify focus area to narrow scope

**Issue:** Not enough context
**Solution:** Use `/prime-codebase` for deeper understanding

**Issue:** Wrong focus area
**Solution:** Re-run with correct focus area

## See Also

- [Level 1 Guide](../../docs/level-1-beginner.md)
- [Context Limits](../../config/context-limits.md)
- [Architecture](../../ARCHITECTURE.md)
