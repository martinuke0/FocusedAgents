# Expert Agent Command

Invoke deep domain specialist for comprehensive analysis.

## Purpose

Delegate complex, domain-specific tasks to expert agents with specialized knowledge, tools, and comprehensive analysis frameworks.

## Usage

```bash
/expert <expert-name> <task-description>
```

## Available Experts

### Security
- `security-auditor` - Security vulnerability analysis
- `penetration-tester` - Penetration testing specialist

### Performance
- `performance-optimizer` - Performance analysis and optimization
- `scalability-reviewer` - Scalability assessment

### Architecture
- `architecture-reviewer` - System design review
- `api-designer` - REST API design specialist

### Code Quality
- `code-analyzer` - Deep code quality analysis
- `refactor-specialist` - Refactoring strategy expert

## Examples

```bash
/expert security-auditor "Comprehensive security audit of src/auth/"
/expert performance-optimizer "Analyze and optimize src/api/users.py"
/expert architecture-reviewer "Review microservices architecture design"
/expert api-designer "Design REST API for user management"
```

## Expert vs Sub-Agent

| Feature | Expert Agent | Sub-Agent |
|---------|--------------|-----------|
| Complexity | High (8-12 files) | Low (3-4 files) |
| Depth | Comprehensive | Focused |
| Token usage | 50-100K | 20-60K |
| Time | 10-30 min | 2-10 min |
| Supporting files | Many | Few |
| Use case | Deep analysis | Quick tasks |
| Level | 4 | 2 |

**Use sub-agents for most work. Use experts for critical deep dives.**

## Output Format

```markdown
## Expert Analysis: Security Audit

**Expert:** security-auditor
**Target:** src/auth/
**Completed:** 10:45 AM (15 minutes)

### Executive Summary
Found 12 security issues (2 CRITICAL, 4 HIGH, 6 MEDIUM).
Immediate action required on authentication vulnerabilities.

### Findings by Category

#### Authentication (CRITICAL)
1. [oauth.py:45] SQL injection in token validation
   - Severity: CRITICAL
   - Impact: Complete account takeover possible
   - CVE: Similar to CVE-2023-XXXXX
   - Fix: Use parameterized queries
   - Code example: [provided]

2. [login.py:78] Weak password hashing (MD5)
   - Severity: CRITICAL
   - Impact: Password database compromise leads to immediate access
   - Fix: Use bcrypt or Argon2
   - Migration path: [detailed steps]

#### Authorization (HIGH)
[... detailed findings ...]

### Security Checklist
✅ HTTPS enforced
❌ No rate limiting
❌ Weak password policy
✅ Session management secure
❌ CSRF protection missing
[... complete checklist ...]

### Recommended Remediation Order
1. Fix CRITICAL issues (1-2 days)
2. Address HIGH issues (3-5 days)
3. Implement MEDIUM fixes (1-2 weeks)

### References
- OWASP Top 10 2023
- CWE-89 (SQL Injection)
- Security best practices document: [link]

### Testing Recommendations
- Add security test suite
- Implement fuzzing
- Regular penetration testing
```

## Expert Capabilities

### security-auditor
- OWASP Top 10 analysis
- CVE database knowledge
- Secure coding patterns
- Penetration testing insights
- Compliance frameworks (GDPR, SOC2)

### performance-optimizer
- Profiling analysis
- Database optimization
- Caching strategies
- Algorithm complexity
- Scalability patterns

### architecture-reviewer
- Design patterns
- System architecture
- Scalability assessment
- Technology selection
- Trade-off analysis

### api-designer
- REST best practices
- OpenAPI 3.0 specs
- API versioning
- Authentication/authorization
- Rate limiting strategies

## Context Impact

```
Expert agent:
- Primary: 20K tokens (orchestration only)
- Expert: 80K tokens (isolated deep analysis)
- Total primary impact: 20K tokens

Result: Deep comprehensive analysis, primary stays lean
```

## Best Practices

### DO:
- ✅ Use for critical systems
- ✅ Use before production deployment
- ✅ Use for security-sensitive code
- ✅ Use for architecture decisions
- ✅ Use when expertise needed

### DON'T:
- ❌ Use for trivial code
- ❌ Use for quick questions
- ❌ Ignore expert recommendations
- ❌ Skip acting on CRITICAL findings

## When to Use Experts

**Use experts when:**
- Security is critical
- Performance is crucial
- Architecture decisions needed
- Production deployment pending
- Compliance required
- Domain expertise needed

**Use sub-agents when:**
- Quick analysis needed
- Non-critical code
- General tasks
- Learning/exploration

## Expert Composition

### Sequential with Experts
```bash
# Implement feature
# ... code ...
/expert security-auditor "Review implementation"
# Fix issues
/expert performance-optimizer "Optimize after fixes"
```

### Parallel with Experts
```bash
/parallel security-auditor,performance-optimizer,architecture-reviewer "Complete assessment"
```

## Cost vs Value

```
Sub-agent: 5 min, good quality
Expert: 15 min, excellent quality

Use sub-agents: Most code (80%)
Use experts: Critical code (20%)

Focus expert time where it matters most.
```

## Related Commands

- `/delegate` - Quick sub-agent delegation
- `/parallel` - Multiple agents simultaneously
- `/orchestrate` - Full workflow orchestration

## See Also

- [Expert Agents](../../agents/experts/)
- [Level 4 Guide](../../docs/level-4-agentic.md)
- [Expert Templates](../../agents/experts/_TEMPLATE/)
