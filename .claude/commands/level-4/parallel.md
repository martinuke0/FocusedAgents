# Parallel Agents Command

Execute multiple agents simultaneously for parallel analysis or processing.

## Purpose

Run multiple specialized agents in parallel, then aggregate results. Ideal for comprehensive analysis from multiple perspectives.

## Usage

```bash
/parallel <agent1,agent2,agent3> <task-description>
```

## Arguments

- `agent1,agent2,agent3`: Comma-separated list of agents
- `task-description`: Task for all agents

## Examples

```bash
/parallel code-analyzer,refactor-assistant,doc-writer "Analyze src/api/"
/parallel security-auditor,performance-optimizer "Review src/auth/oauth.py"
```

## How It Works

```
Task: Review authentication module

Primary Agent:
├── Launch 3 agents in parallel
├── agent-1 (security): Security audit
├── agent-2 (performance): Performance analysis
├── agent-3 (quality): Code quality review
├── Agents run simultaneously (isolated contexts)
├── Collect results from all agents
└── Aggregate and present findings

Result: Comprehensive multi-perspective analysis
```

## Output

```markdown
## Parallel Agent Execution

**Task:** Review src/auth/oauth.py
**Agents:** 3 (security-auditor, performance-optimizer, code-analyzer)
**Started:** 10:30 AM

### Agent Status

**security-auditor** ✅ Complete (2 min)
- Found: 2 CRITICAL, 3 HIGH security issues

**performance-optimizer** ✅ Complete (3 min)
- Found: 4 optimization opportunities

**code-analyzer** ✅ Complete (2 min)
- Found: Excellent structure, minor improvements

### Aggregated Results

#### CRITICAL (2) - Security
- [oauth.py:45] SQL injection in token validation
- [oauth.py:78] Weak password hashing

#### HIGH (3) - Security
- [oauth.py:23] Missing rate limiting
- [oauth.py:56] Token stored in plaintext logs
- [oauth.py:91] No CSRF protection

#### Performance Opportunities (4)
- [oauth.py:34] N+1 query in user lookup
- [oauth.py:67] Inefficient token generation
- [oauth.py:89] Missing database index
- [oauth.py:102] Redundant validation calls

#### Code Quality
- Overall: Good
- Minor: Improve error messages
- Minor: Add more logging

### Prioritized Actions
1. Fix CRITICAL security issues immediately
2. Address HIGH security issues before deployment
3. Implement performance optimizations
4. Polish code quality improvements

### Summary
Security requires immediate attention. Performance is acceptable but can be improved.
```

## Use Cases

### Comprehensive Code Review
```bash
/parallel security-auditor,performance-optimizer,code-analyzer "Review src/"
```

### Multi-Language Analysis
```bash
/parallel python-reviewer,typescript-reviewer "Review full-stack feature"
```

### Complete Feature Assessment
```bash
/parallel architecture-reviewer,security-auditor,test-generator "Assess new feature"
```

## Context Impact

```
Without parallel:
- Sequential: 3 agents × 60K tokens = 180K tokens in primary (impossible)
- Or 3 separate sessions: 3× time

With parallel:
- 3 agents × 60K tokens = 180K tokens (isolated, distributed)
- Primary agent: 15K tokens (aggregated results only)
- Time: Same as single agent (parallel)

Result: Comprehensive analysis in single-agent time, primary stays lean
```

## Best Practices

### DO:
- ✅ Use for comprehensive analysis
- ✅ Combine complementary agents
- ✅ Aggregate results by priority
- ✅ Limit to 3-4 agents (diminishing returns)

### DON'T:
- ❌ Use for simple tasks
- ❌ Run 10+ agents (overhead)
- ❌ Use redundant agents
- ❌ Ignore aggregation conflicts

## Agent Combinations

### Security-Focused
```bash
/parallel security-auditor,code-analyzer "Security review"
```

### Performance-Focused
```bash
/parallel performance-optimizer,code-analyzer "Performance audit"
```

### Complete Review
```bash
/parallel security-auditor,performance-optimizer,code-analyzer "Full review"
```

### Architecture Assessment
```bash
/parallel architecture-reviewer,security-auditor,performance-optimizer "Assess design"
```

## Parallel vs Sequential

| Feature | Parallel | Sequential (chain) |
|---------|----------|-------------------|
| Speed | Fast (simultaneous) | Slower (one by one) |
| Use case | Independent analysis | Dependent stages |
| Results | Multiple perspectives | Progressive refinement |
| Agents | Same task, different focus | Different tasks, same goal |
| Level | 4 | 3 |

**Use parallel when perspectives are independent. Use chain when stages depend on previous.**

## Troubleshooting

**Issue:** Too many agents
**Solution:** Limit to 3-4 most relevant agents

**Issue:** Conflicting recommendations
**Solution:** Prioritize by severity and expertise

**Issue:** Takes too long
**Solution:** Agents might be analyzing too much, narrow scope

**Issue:** Results unclear
**Solution:** Better task description, specify what to analyze

## Related Commands

- `/expert` - Single expert agent
- `/chain-agents` - Sequential agent chain
- `/orchestrate` - Full workflow orchestration

## See Also

- [Level 4 Guide](../../docs/level-4-agentic.md)
- [Parallel Composition](../../ARCHITECTURE.md#pattern-2-parallel-composition)
- [Expert Agents](../../agents/experts/)
