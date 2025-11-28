# Prime Workflow Command

Workflow-specific context priming for specialized tasks.

## Purpose

Load context optimized for specific development workflows. More targeted than `/prime`, focused on workflow patterns.

## Usage

```bash
/prime-workflow <workflow-type>
```

## Workflow Types

### feature
Prime for feature development:
- Feature implementation patterns
- Testing requirements
- Integration points
- Documentation standards

### bug
Prime for bug fixing:
- Error handling patterns
- Logging infrastructure
- Debugging tools
- Test reproduction steps

### refactor
Prime for refactoring:
- Current architecture
- Code patterns to maintain
- Testing coverage
- Breaking change considerations

### test
Prime for test writing:
- Testing framework setup
- Test fixtures and mocks
- Coverage requirements
- Test organization patterns

### docs
Prime for documentation:
- Documentation structure
- Style guide
- Examples and templates
- API documentation patterns

### security
Prime for security review:
- Authentication/authorization patterns
- Security best practices used
- Sensitive data handling
- Security testing approaches

### performance
Prime for performance optimization:
- Performance-critical paths
- Profiling tools
- Optimization patterns
- Performance testing

## Examples

```bash
/prime-workflow feature      # Feature development
/prime-workflow bug          # Bug fixing
/prime-workflow refactor     # Refactoring
/prime-workflow test         # Test writing
/prime-workflow docs         # Documentation
/prime-workflow security     # Security work
/prime-workflow performance  # Performance tuning
```

## Workflow-Specific Output

### Feature Development
```markdown
## Feature Development Context

### Existing Patterns
- Feature structure: [how features are organized]
- Testing approach: [feature test patterns]
- Documentation: [feature doc requirements]

### Integration Points
- APIs: [relevant APIs]
- Database: [data layer patterns]
- Frontend: [UI patterns if applicable]

### Similar Features
- [feature 1]: [location]
- [feature 2]: [location]

### Ready To
- Implement feature following [pattern]
- Write tests using [approach]
- Document using [template]
```

### Bug Fixing
```markdown
## Bug Fixing Context

### Error Handling
- Pattern: [error handling approach]
- Logging: [logging framework]
- Monitoring: [monitoring tools]

### Debugging Tools
- [tool 1]: [usage]
- [tool 2]: [usage]

### Test Infrastructure
- Reproduction: [how to write reproduction tests]
- Fixtures: [available test fixtures]

### Ready To
- Reproduce bug with test
- Fix using [pattern]
- Verify fix works
```

### Refactoring
```markdown
## Refactoring Context

### Current Architecture
- Pattern: [current design pattern]
- Dependencies: [key dependencies]
- Boundaries: [module boundaries]

### Constraints
- Breaking changes: [policy]
- Test coverage: [requirements]
- Performance: [considerations]

### Refactoring Patterns
- [pattern 1]: [when to use]
- [pattern 2]: [when to use]

### Ready To
- Refactor safely following [approach]
- Maintain compatibility
- Update tests appropriately
```

## Context Impact

```
/prime-workflow: ~3-6K tokens (workflow-specific)
vs /prime: ~2-5K tokens (general)
vs /prime-codebase: ~8-15K tokens (comprehensive)
```

## Best Practices

### DO:
- ✅ Use when you know your workflow type
- ✅ Switch workflows with new `/prime-workflow` call
- ✅ Combine with focused file reading
- ✅ Use for repetitive workflow types

### DON'T:
- ❌ Use without knowing workflow type
- ❌ Mix multiple workflow types in one session
- ❌ Skip when workflow-specific patterns exist
- ❌ Overload with too much initial context

## When to Use

**Use `/prime-workflow` when:**
- You have a specific workflow in mind
- Project has established patterns for that workflow
- You want workflow-specific guidance
- You're repeating similar types of work

**Use `/prime` when:**
- You're exploring or uncertain
- Task doesn't fit a specific workflow
- You need general codebase understanding

**Use `/prime-codebase` when:**
- You need comprehensive understanding
- Working across multiple workflows
- Making architectural decisions

## Workflow Comparison

| Workflow | Focus | Common Tasks |
|----------|-------|--------------|
| feature | New functionality | Add endpoints, UI, features |
| bug | Fix issues | Debug, patch, test |
| refactor | Improve code | Restructure, optimize |
| test | Increase coverage | Write tests, fixtures |
| docs | Documentation | Write guides, API docs |
| security | Security review | Audit, harden, fix vulns |
| performance | Optimization | Profile, optimize, benchmark |

## Related Commands

- `/prime` - General priming
- `/prime-codebase` - Deep priming
- `/mcp-check` - Verify MCP

## See Also

- [Level 1 Guide](../../docs/level-1-beginner.md)
- [Workflow Templates](../../workflows/)
- [Context Limits](../../config/context-limits.md)
