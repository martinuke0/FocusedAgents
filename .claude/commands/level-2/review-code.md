# Review Code Command

Quick code review using specialized code review sub-agent.

## Purpose

Delegate code review to a focused sub-agent, keeping primary agent lean while getting comprehensive review feedback.

## Usage

```bash
/review-code <file-or-directory>
```

## Examples

```bash
/review-code src/api/users.py
/review-code src/auth/
/review-code tests/test_oauth.py
```

## Output

```markdown
## Code Review Summary

### Files Reviewed
- src/api/users.py (234 lines)
- src/api/auth.py (156 lines)

### Findings by Severity

#### HIGH (2)
- [users.py:45] SQL injection vulnerability in user search
- [auth.py:78] Password stored in plaintext

#### MEDIUM (5)
- [users.py:12] Missing type hints
- [users.py:89] Inefficient database query
- [auth.py:23] Missing error handling
- [auth.py:45] Deprecated API usage
- [users.py:167] No input validation

#### LOW (3)
- [users.py:5] Import ordering
- [auth.py:12] Docstring formatting
- [users.py:201] Variable naming

### Positive Observations
- Good test coverage (85%)
- Clear function separation
- Consistent code style

### Recommendations
1. Fix HIGH severity issues immediately
2. Address MEDIUM issues before merge
3. LOW issues can be deferred

### Overall: NEEDS WORK
Code requires security fixes before approval.
```

## Context Impact

```
Without delegation: 40-60K tokens in primary
With delegation: 5-8K tokens in primary (summary only)
Savings: 35-50K tokens
```

## Review Focus Areas

Sub-agent checks:
- Code quality and style
- Potential bugs
- Security vulnerabilities
- Performance issues
- Best practices
- Test coverage
- Documentation

## Best Practices

### DO:
- ✅ Review before merging
- ✅ Address HIGH/CRITICAL first
- ✅ Use for unfamiliar code
- ✅ Review after major changes

### DON'T:
- ❌ Skip security findings
- ❌ Ignore systematic issues
- ❌ Review without fixing
- ❌ Over-rely without understanding

## Comparison: review-code vs Expert Agents

| Feature | /review-code | /expert python-reviewer |
|---------|--------------|-------------------------|
| Speed | Fast | Slower |
| Depth | Good | Comprehensive |
| Level | 2 | 4 |
| Use case | Quick review | Deep audit |

**Use `/review-code` for most reviews. Use `/expert` for critical code.**

## Related Commands

- `/delegate` - Generic delegation
- `/generate-tests` - Generate tests
- `/expert` - Deep specialist review (Level 4)

## See Also

- [Sub-Agents](../../agents/sub-agents/)
- [Level 2 Guide](../../docs/level-2-intermediate.md)
