# Orchestrate Command

Execute complete multi-agent workflows for complex tasks.

## Purpose

Run predefined workflows that orchestrate multiple agents (sub-agents, experts, background agents) in coordinated sequences for end-to-end task completion.

## Usage

```bash
/orchestrate <workflow-name> <target>
```

## Available Workflows

### feature-development
Complete feature development pipeline:
1. Architecture review
2. Implementation
3. Test generation
4. Security audit
5. Performance check

### code-review-pipeline
Comprehensive code review:
1. Code analysis
2. Security audit (parallel)
3. Performance review (parallel)
4. Aggregate findings

### security-audit
Deep security assessment:
1. Code security scan
2. Dependency audit
3. Configuration review
4. Penetration testing recommendations

### refactoring-workflow
Safe refactoring process:
1. Current state analysis
2. Refactoring plan
3. Implementation guidance
4. Verification strategy

## Examples

```bash
/orchestrate feature-development src/api/payments
/orchestrate code-review-pipeline src/auth/
/orchestrate security-audit src/
/orchestrate refactoring-workflow src/legacy/
```

## Feature Development Workflow

```
Stage 1: Architecture Review
├── Expert: architecture-reviewer
├── Output: Design validation, recommendations
└── Bundle: feature-architecture

Stage 2: Implementation
├── Agent: Primary (with architecture bundle)
├── Output: Working implementation
└── Bundle: feature-implemented

Stage 3: Testing
├── Sub-agent: test-generator
├── Output: Comprehensive test suite
└── Bundle: feature-tested

Stage 4: Security & Performance (Parallel)
├── Expert: security-auditor
├── Expert: performance-optimizer
├── Output: Security + performance findings
└── Bundle: feature-reviewed

Stage 5: Final Polish
├── Agent: Primary (address findings)
├── Output: Production-ready feature
└── Complete: Feature ready for deployment
```

## Output

```markdown
## Orchestrated Workflow: Feature Development

**Workflow:** feature-development
**Target:** src/api/payments
**Started:** 10:00 AM
**Estimated:** 45-60 minutes

### Stage 1: Architecture Review ✅ Complete (5 min)
**Agent:** architecture-reviewer

**Findings:**
- Design: Excellent separation of concerns
- Recommendations: Add idempotency for payment operations
- Concerns: Consider using distributed transactions

**Next:** Proceed to implementation with recommendations

---

### Stage 2: Implementation 🔄 In Progress (25 min elapsed)
**Agent:** Primary
**Bundle loaded:** feature-architecture

**Progress:**
- Core payment processing: ✅ Complete
- Idempotency layer: ✅ Complete
- Error handling: 🔄 In Progress
- Integration tests: ⏳ Pending

---

### Stage 3: Testing ⏳ Queued
**Agent:** test-generator
**Bundle:** feature-implemented (when ready)

---

### Stage 4: Review (Parallel) ⏳ Queued
**Agents:** security-auditor, performance-optimizer
**Bundle:** feature-tested (when ready)

---

### Stage 5: Polish ⏳ Queued
**Agent:** Primary
**Bundle:** feature-reviewed (when ready)

---

### Overall Progress
██████░░░░░░░░░░░░░░ 35% (2/5 stages complete)

### Monitor
Check status: /orchestrate-status payments
View logs: .claude/workflows/payments-log.md
```

## Workflow Patterns

### Sequential Pattern
```
Stage 1 → Bundle → Stage 2 → Bundle → Stage 3
```
Each stage builds on previous. Use for dependent work.

### Parallel Pattern
```
Stage 1 → Bundle → [Stage 2a, Stage 2b, Stage 2c] → Aggregate
```
Multiple agents analyze simultaneously. Use for independent perspectives.

### Hybrid Pattern
```
Stage 1 → Stage 2 → [Stage 3a, Stage 3b] → Stage 4
```
Mix sequential and parallel. Most workflows use this.

## Custom Workflows

Create your own workflows in `.claude/workflows/`:

```markdown
# my-custom-workflow.md

## Workflow: Custom Review

### Stage 1: Initial Analysis
Agent: code-analyzer
Task: Analyze code structure
Bundle: analysis-complete

### Stage 2: Parallel Review
Agents: security-auditor, performance-optimizer
Task: Comprehensive review
Bundle: review-complete

### Stage 3: Recommendations
Agent: architecture-reviewer
Task: Provide strategic recommendations
Output: Final recommendations
```

Then run:
```bash
/orchestrate my-custom-workflow src/
```

## Context Management

```
Primary Agent (Orchestrator):
- Context: 20-30K tokens (orchestration only)
- Never participates in heavy work
- Manages workflow state
- Aggregates results

Stage Agents (Workers):
- Fresh context each stage (0K → 100K)
- Isolated from primary
- Save bundles for next stage
- Primary receives summaries only

Result: Orchestrator stays lean, workers handle heavy lifting
```

## Best Practices

### DO:
- ✅ Use for complex multi-stage tasks
- ✅ Monitor workflow progress
- ✅ Review stage outputs
- ✅ Use predefined workflows
- ✅ Create custom workflows for repeated patterns

### DON'T:
- ❌ Orchestrate simple tasks (overhead too high)
- ❌ Create workflows with >7 stages
- ❌ Mix unrelated stages
- ❌ Ignore stage failures
- ❌ Skip bundle review between stages

## Workflow Selection Guide

| Task | Workflow | Duration |
|------|----------|----------|
| New feature | feature-development | 45-60 min |
| Code review | code-review-pipeline | 15-25 min |
| Security check | security-audit | 20-35 min |
| Refactoring | refactoring-workflow | 30-50 min |
| Bug fix | debug-workflow | 15-30 min |

## Troubleshooting

**Issue:** Workflow taking too long
**Solution:** Check if stage is stuck, may need intervention

**Issue:** Stage failed
**Solution:** Review stage output, fix issue, restart from that stage

**Issue:** Results not aggregating properly
**Solution:** Check bundle handoffs between stages

**Issue:** Too complex
**Solution:** Break into smaller workflows or manual stages

## Related Commands

- `/chain-agents` - Simpler sequential chaining
- `/parallel` - Parallel agents only
- `/expert` - Single expert agent
- `/background` - Background execution

## See Also

- [Workflows](../../workflows/)
- [Level 4 Guide](../../docs/level-4-agentic.md)
- [Workflow Templates](../../workflows/)
- [Orchestration Patterns](../../ARCHITECTURE.md#agent-composition-patterns)
