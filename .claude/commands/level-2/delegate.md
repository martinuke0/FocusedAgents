# Delegate Command

Delegate focused tasks to specialized sub-agents to keep primary agent context lean.

## Purpose

Offload token-intensive, focused work to sub-agents that operate in isolated context windows. Primary agent receives only the concise results.

## Usage

```bash
/delegate <agent-name> <task-description>
```

## Arguments

- `agent-name`: Sub-agent to invoke (e.g., code-analyzer, refactor-assistant, doc-writer)
- `task-description`: What the sub-agent should do

## Available Sub-Agents

| Agent | Purpose | Typical Token Usage |
|-------|---------|---------------------|
| code-analyzer | Analyze code structure, dependencies | 40-60K (isolated) |
| refactor-assistant | Safe refactoring guidance | 30-50K (isolated) |
| doc-writer | Generate documentation | 20-40K (isolated) |

## Examples

```bash
# Analyze code structure
/delegate code-analyzer "Analyze src/api/ for dependencies and patterns"

# Get refactoring guidance
/delegate refactor-assistant "Suggest refactoring for src/auth/oauth.py"

# Generate documentation
/delegate doc-writer "Create API documentation for src/api/users.py"
```

## How It Works

### Without Delegation (Monolithic)
```
Primary Agent:
- Initial context: 10K tokens
- Load files to analyze: +40K tokens
- Perform analysis: +20K tokens
- Total: 70K tokens

Result: Primary agent bloated, slower performance
```

### With Delegation (Distributed)
```
Primary Agent:
- Initial context: 10K tokens
- Delegate to sub-agent: 0K tokens (system prompt)
- Receive results: +3K tokens
- Total: 13K tokens

Sub-Agent (isolated):
- Load files: 40K tokens
- Perform analysis: 20K tokens
- Total: 60K tokens (isolated, not added to primary)

Result: Primary stays lean (13K), fast performance
```

## Context Impact

```
Monolithic: Primary agent 70K+ tokens
Delegated: Primary agent 13K tokens, sub-agent 60K (isolated)
Savings to primary: 57K tokens
```

## Best Practices

### DO:
- ✅ Delegate at 50-60K tokens in primary
- ✅ Use for focused, well-defined tasks
- ✅ Let sub-agent complete fully
- ✅ Review results before continuing

### DON'T:
- ❌ Delegate tiny tasks (overhead not worth it)
- ❌ Delegate vague, open-ended work
- ❌ Interrupt sub-agent mid-task
- ❌ Delegate when primary is at 10K tokens (no need yet)

## When to Delegate

**Delegate when:**
- Primary agent hitting 50-60K tokens
- Task is focused and well-defined
- Analysis work is token-intensive
- You want parallel processing

**Don't delegate when:**
- Primary agent under 30K tokens
- Task requires back-and-forth
- Task is trivial (< 5 min)
- Results need integration with primary context

## Delegation Workflow

### Step 1: Recognize Need
```bash
# Check primary agent context
/context
# If 50K+, consider delegation
```

### Step 2: Choose Agent
```bash
# Pick appropriate sub-agent for task
# See agent catalog in /agents/sub-agents/
```

### Step 3: Delegate
```bash
/delegate <agent> "<clear task description>"
```

### Step 4: Review Results
```bash
# Sub-agent returns concise findings
# Integrate into primary workflow
```

## Sub-Agent vs Expert Agent

| Feature | Sub-Agent | Expert Agent |
|---------|-----------|--------------|
| Purpose | Quick, focused tasks | Deep domain analysis |
| Complexity | 3-4 files | 8-12 files |
| Token usage | 20-60K | 50-100K |
| Use case | Delegate at 50K | Complex analysis |
| Level | Level 2 | Level 4 |

**Use sub-agents for most delegation. Use expert agents for specialized deep dives.**

## Troubleshooting

**Issue:** Sub-agent takes too long
**Solution:** Task might be too broad, break into smaller tasks

**Issue:** Results not useful
**Solution:** Provide clearer task description with specifics

**Issue:** Primary still bloated
**Solution:** Ensure using delegation, not loading results fully

## Related Commands

- `/review-code` - Specialized code review delegation
- `/generate-tests` - Specialized test generation
- `/expert` - Deep specialist delegation (Level 4)

## See Also

- [Sub-Agents Directory](../../agents/sub-agents/)
- [Level 2 Guide](../../docs/level-2-intermediate.md)
- [Delegation Patterns](../../ARCHITECTURE.md#delegate-d-pass-work-to-specialized-agents)
