# Python Code Reviewer Expert Agent

A specialized agent for comprehensive Python code review focusing on quality, style, security, and best practices.

## Purpose

This agent performs deep analysis of Python code with expertise in:
- PEP 8 style compliance
- Type safety and type hints
- Performance optimization opportunities
- Security vulnerabilities
- Pythonic idioms and patterns
- Test coverage assessment

## When to Use

Use this agent when:
- Conducting code reviews for Python projects
- Ensuring code quality before merging PRs
- Learning Python best practices
- Identifying technical debt
- Preparing code for production deployment
- Enforcing team coding standards

## How to Invoke

### Via Claude Code
```
Review this Python code: [file path or code snippet]
```

### As Part of Composition Pattern
```
Sequential: code → python-reviewer → python-security-auditor → approve
Parallel: [python-reviewer + python-security-auditor + python-performance-optimizer]
```

## Input Requirements

The agent can review:
- Individual Python files
- Entire modules or packages
- Code snippets
- Pull requests

Simply provide file paths or paste code directly.

## Output Format

The agent provides structured feedback:

```markdown
## Summary
Brief assessment of overall code quality

## Findings

### CRITICAL
- [file:line] Security vulnerability or major bug
  - Impact: Potential consequences
  - Recommendation: Specific fix with code example

### HIGH
- [file:line] Performance issue or poor design
  - Recommendation: How to fix

### MEDIUM
- [file:line] Style violation or missing type hint
  - Recommendation: Correction needed

### LOW
- [file:line] Minor improvement suggestion
  - Recommendation: Optional enhancement

## Positive Observations
Good patterns and practices identified

## Overall Assessment
Final verdict: approve | approve with changes | needs work | reject
```

## Supporting Files

This agent uses several supporting files for comprehensive reviews:

### checklist.md
Detailed checklist covering:
- PEP 8 compliance (50+ items)
- Type safety requirements
- Security best practices
- Performance considerations
- Modern Python features (3.8+)

### references/pep8-quick-ref.md
Quick reference for Python style guidelines and common patterns.

### references/common-antipatterns.md
Catalog of Python antipatterns to avoid with explanations and fixes.

### examples/
Sample reviews demonstrating:
- Good review format
- How to categorize findings
- Actionable recommendations

## Composition Suggestions

### Quality Gate Pipeline
```
1. python-reviewer (style, quality, basics)
2. python-security-auditor (security deep-dive)
3. python-performance-optimizer (performance analysis)
4. objective-critic (reality check)
```

### Parallel Analysis
```
Run all Python agents simultaneously for comprehensive analysis:
- python-reviewer
- python-security-auditor
- python-performance-optimizer

Then aggregate results.
```

### Pre-Commit Hook
```
Use python-reviewer as automated pre-commit check:
- Fast feedback loop
- Catches issues before CI/CD
- Enforces team standards
```

## What This Agent Does NOT Do

- **Does not** write or refactor code (review only)
- **Does not** fix issues (provides recommendations)
- **Does not** run tests (assesses testability)
- **Does not** replace static analysis tools (complements them)

## Best Practices

1. **Provide context**: Mention project type (web app, library, script)
2. **Specify concerns**: "Focus on security" or "Check performance"
3. **Include tests**: Review test files alongside implementation
4. **Review iteratively**: Address CRITICAL/HIGH first, then MEDIUM/LOW
5. **Use with automation**: Integrate into CI/CD pipeline

## Integration with Other Agents

### Before python-reviewer
- No prerequisite agents needed
- Can run immediately on code

### After python-reviewer
- **python-security-auditor**: Deep security analysis
- **python-performance-optimizer**: Profiling and optimization
- **objective-critic**: Challenge the approach

### Parallel with python-reviewer
- **python-test-generator**: Generate tests while reviewing code
- Other language reviewers: Cross-language projects

## Example Usage

### Basic Review
```
User: Review this Python module: src/api/users.py
Agent: [Comprehensive review with findings by severity]
```

### Focused Review
```
User: Review src/utils/parser.py focusing on performance
Agent: [Performance-focused review with optimization suggestions]
```

### PR Review
```
User: Review the changes in PR #123
Agent: [Review of diff with specific line-by-line feedback]
```

## Configuration

This agent follows PEP 8 with modern conventions:
- Line length: 88 characters (Black standard)
- Python version: 3.8+ (includes modern features)
- Type checking: Encouraged but not required
- Docstring style: Flexible (Google, NumPy, or Sphinx)

Adjust expectations by specifying your project's standards in the review request.

## Related Agents

- `python-test-generator`: Generate tests for reviewed code
- `python-security-auditor`: Deep security analysis
- `python-performance-optimizer`: Performance profiling
- `generic-reviewer`: Fallback for non-Python code
- `objective-critic`: Challenge assumptions and approach

## Source

Based on expert agent principles from: https://martinuke0.github.io/posts/expert-agents/
