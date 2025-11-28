# Chain Agents Command

Automated agent chaining workflow using context bundles.

## Purpose

Orchestrate sequential agent execution with automatic bundle management for complex, multi-stage tasks.

## Usage

```bash
/chain-agents <workflow-type> <task-description>
```

## Workflow Types

- `feature` - Feature development (analyze → implement → test → review)
- `refactor` - Refactoring (analyze → plan → implement → verify)
- `review` - Code review (analyze → review → suggest → verify)
- `debug` - Debugging (reproduce → fix → test → verify)

## Examples

```bash
/chain-agents feature "Add OAuth2 authentication"
/chain-agents refactor "Modernize auth module"
/chain-agents review "Review API security"
/chain-agents debug "Fix token expiration issue"
```

## Feature Development Chain

```
Agent 1 (Analysis): Analyze requirements and plan architecture
    ↓ bundle-save: feature-plan
Agent 2 (Implementation): Implement core functionality
    ↓ bundle-save: feature-impl
Agent 3 (Testing): Generate and run comprehensive tests
    ↓ bundle-save: feature-tested
Agent 4 (Review): Expert review for quality and security
    ↓ Result: Complete, reviewed feature
```

## Output

```markdown
## Agent Chain: Feature Development

### Chain Configuration
- Workflow: feature
- Task: Add OAuth2 authentication
- Agents: 4 (analysis, implementation, testing, review)
- Est. time: 30-45 minutes

### Agent 1: Analysis & Planning
Status: Running...
Progress: Analyzing requirements
Tokens: 15K

### Agent 2: Implementation
Status: Waiting (will load bundle: feature-plan)
Progress: Not started
Tokens: 0K

### Agent 3: Testing
Status: Queued
Progress: Not started
Tokens: 0K

### Agent 4: Review
Status: Queued
Progress: Not started
Tokens: 0K

### Monitor Progress
Check status: /chain-status feature-oauth
View logs: .claude/bundles/feature-oauth-chain.log
```

## Chain Workflow Details

### Feature Development
1. **Analysis Agent**
   - Understand requirements
   - Plan architecture
   - Identify dependencies
   - Output: Architecture plan bundle

2. **Implementation Agent**
   - Load plan bundle
   - Implement core feature
   - Write initial tests
   - Output: Implementation bundle

3. **Testing Agent**
   - Load implementation bundle
   - Generate comprehensive tests
   - Run test suite
   - Output: Tested feature bundle

4. **Review Agent**
   - Load tested bundle
   - Expert code review
   - Security audit
   - Output: Review findings + recommendations

### Refactoring Chain
1. Analysis → 2. Planning → 3. Implementation → 4. Verification

### Review Chain
1. Code Analysis → 2. Expert Review → 3. Recommendations → 4. Verification

### Debug Chain
1. Reproduction → 2. Root Cause → 3. Fix → 4. Verification

## Context Management

Each agent:
- Starts fresh (0K tokens)
- Loads previous bundle (~5K tokens)
- Completes work (typically 60-100K tokens)
- Saves bundle before handoff
- Next agent starts fresh

**Result:** No single agent exceeds limits, full context preserved throughout chain.

## Best Practices

### DO:
- ✅ Use for multi-stage tasks
- ✅ Monitor chain progress
- ✅ Review bundle handoffs
- ✅ Use clear task descriptions

### DON'T:
- ❌ Chain simple tasks (overhead not worth it)
- ❌ Ignore agent failures
- ❌ Skip reviewing final output
- ❌ Chain too many stages (>5)

## Manual Chain Alternative

```bash
# Agent 1
/prime-workflow feature
# ... work ...
/bundle-save task-v1

# Agent 2 (fresh)
/bundle-load task-v1
# ... work ...
/bundle-save task-v2

# Agent 3 (fresh)
/bundle-load task-v2
# ... complete ...
```

## Related Commands

- `/bundle-save` - Manual save
- `/bundle-load` - Manual load
- `/bundle-list` - View bundles
- `/orchestrate` - Level 4 orchestration

## See Also

- [Level 3 Guide](../../docs/level-3-advanced.md)
- [Workflows](../../workflows/)
- [Sequential Composition](../../ARCHITECTURE.md#pattern-1-sequential-composition)
