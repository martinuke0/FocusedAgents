# Prime Codebase Command

Deep project overview for comprehensive understanding.

## Purpose

Load comprehensive codebase context for complex tasks requiring full understanding. Use sparingly - this loads more context than `/prime`.

## Usage

```bash
/prime-codebase
```

## When to Use

**Use when:**
- Major refactoring across multiple modules
- Architecture decisions needed
- Comprehensive code review
- Learning unfamiliar codebase
- Documentation generation

**Don't use when:**
- Simple feature addition
- Bug fix in known area
- Focused refactoring
- Time-sensitive work

## Workflow

### 1. Project Overview
- Read README.md thoroughly
- Understand project goals and architecture
- Note all key dependencies

### 2. Directory Structure Analysis
- Map all directories and their purposes
- Identify module boundaries
- Note file organization patterns

### 3. Technology Stack Deep Dive
- Languages and versions
- Frameworks and libraries
- Build tools and configuration
- Testing infrastructure
- Development tools

### 4. Code Organization
- Entry points
- Core modules
- Utility functions
- Configuration management
- Testing structure

### 5. Key Files
- Main application entry points
- Configuration files
- Important utilities
- Test fixtures
- Documentation

### 6. Patterns and Conventions
- Code style
- Naming conventions
- Error handling patterns
- Logging approaches
- Testing patterns

## Output Format

```markdown
## Project Summary
- Name: [project name]
- Type: [application type]
- Purpose: [main purpose]
- Status: [development stage]

## Technology Stack
- Primary Language: [language + version]
- Frameworks: [list key frameworks]
- Key Dependencies: [important libraries]
- Build Tools: [build system]
- Testing: [test framework]

## Architecture
- Pattern: [MVC/microservices/monolith/etc.]
- Entry Points: [main files]
- Module Structure: [how code is organized]

## Directory Map
```
project/
├── src/           [description]
├── tests/         [description]
├── docs/          [description]
├── config/        [description]
└── [other dirs]   [description]
```

## Code Conventions
- Style: [style guide]
- Naming: [conventions]
- Testing: [test patterns]
- Documentation: [doc style]

## Key Insights
- [Important architectural decision 1]
- [Important architectural decision 2]
- [Important pattern or practice]

## Ready For
You now have comprehensive understanding to:
- [major task 1]
- [major task 2]
- [major task 3]
```

## Context Impact

```
Before: 0 tokens
After: ~8-15K tokens (comprehensive context)
Savings vs naive full load: 10-15K tokens
```

**Note:** This is heavier than `/prime` but still focused. Use `/prime` for most tasks.

## Best Practices

### DO:
- ✅ Use for major refactoring
- ✅ Use when learning new codebase
- ✅ Use for architecture decisions
- ✅ Combine with expert agents

### DON'T:
- ❌ Use for simple bug fixes
- ❌ Use for single-file changes
- ❌ Use when `/prime` would suffice
- ❌ Load without clear need

## Comparison: prime vs prime-codebase

| Command | Tokens | Use Case | Speed |
|---------|--------|----------|-------|
| `/prime` | 2-5K | Most tasks | Fast |
| `/prime-codebase` | 8-15K | Complex tasks | Slower |
| Full load | 20-30K+ | Never | Very slow |

**Rule of thumb:** Start with `/prime`. Only use `/prime-codebase` if needed.

## Related Commands

- `/prime` - Lightweight priming (use this first)
- `/prime-workflow` - Workflow-specific priming
- `/mcp-check` - Verify MCP configuration

## See Also

- [Level 1 Guide](../../docs/level-1-beginner.md)
- [Context Limits](../../config/context-limits.md)
- [Prime Command](prime.md)
