# Commands

Slash commands organized by proficiency level for context engineering.

## Command Structure

```
commands/
├── level-1/          # REDUCE: Context reduction
├── level-2/          # DELEGATE: Sub-agent delegation
├── level-3/          # ADVANCED: Context bundles
└── level-4/          # AGENTIC: Multi-agent orchestration
```

## Quick Reference

### Level 1: Context Reduction
```bash
/prime                # Basic context priming
/prime-codebase       # Project overview
/prime-workflow       # Workflow-specific context
/mcp-check            # Verify MCP servers
```

### Level 2: Sub-Agent Delegation
```bash
/delegate             # Generic delegation
/review-code          # Quick code review
/generate-tests       # Generate test suite
```

### Level 3: Context Bundles
```bash
/bundle-save          # Save current context
/bundle-load          # Load saved context
/bundle-list          # List bundles
/chain-agents         # Chain multiple agents
```

### Level 4: Multi-Agent Orchestration
```bash
/background           # Run agent in background
/parallel             # Parallel execution
/expert               # Invoke expert agent
/orchestrate          # Full workflow
```

## Usage Patterns

### Pattern 1: Start Fresh
```bash
/prime                # Load focused context
# Work on task
```

### Pattern 2: Delegate Task
```bash
/prime-codebase       # Understand project
/delegate code-analyzer src/  # Analyze code
# Primary agent stays lean
```

### Pattern 3: Chain Agents
```bash
# Agent 1
/prime-workflow feature
# ... implement feature (120K tokens)
/bundle-save feature-impl

# Agent 2 (fresh)
/bundle-load feature-impl
# ... continue work
```

### Pattern 4: Multi-Agent Review
```bash
/orchestrate code-review-pipeline src/
# Runs parallel expert agents
# Aggregates results
```

## Command Guidelines

### DO:
- Use priming at start of every session
- Delegate when context hits 50-60K tokens
- Save bundles at 120K tokens
- Orchestrate for complex workflows

### DON'T:
- Load everything "just in case"
- Wait until 150K tokens to delegate
- Skip context monitoring
- Use monolithic approaches for large tasks

## Further Reading

- [Level 1 Guide](../docs/level-1-beginner.md)
- [Level 2 Guide](../docs/level-2-intermediate.md)
- [Level 3 Guide](../docs/level-3-advanced.md)
- [Level 4 Guide](../docs/level-4-agentic.md)
