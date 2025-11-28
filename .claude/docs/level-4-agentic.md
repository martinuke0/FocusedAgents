# Level 4: Agentic - Multi-Agent Orchestration

Master multi-agent systems for production workflows.

## Goal
Orchestrate specialized agents (sub-agents, experts, background) for complex pipelines.

## Agent Types

### Expert Agents
Deep domain specialists (8-12 files each)
- security-auditor
- performance-optimizer
- architecture-reviewer
- api-designer

### Background Agents
Async monitoring
- code-monitor
- test-runner

## Commands
```bash
/expert security-auditor "Audit src/auth/"
/parallel agent1,agent2,agent3 "Review src/"
/background "Run full test suite"
/orchestrate code-review-pipeline src/
```

## Composition Patterns

### Sequential
Task → Agent A → Bundle → Agent B → Result

### Parallel
Task → [Agent A, B, C] → Aggregate → Result

### Background
Primary + Background Monitor → Result + Insights

## When to Use
- Critical systems
- Production deployment
- Complex multi-stage workflows
- Comprehensive analysis needed

## Mastery
You've mastered all 4 levels of context engineering!
