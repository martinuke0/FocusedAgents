# Level 3: Advanced - Context Bundles & Agent Chaining

Master agent chaining via context bundles.

## Goal
Chain agents together using saved context bundles for massive tasks.

## Core Concept
**Context Bundle** = Saved state enabling agent handoffs

## Workflow
```bash
# Agent 1
/prime-workflow feature
# Work... 120K tokens
/bundle-save feature-impl

# Agent 2 (fresh)
/bundle-load feature-impl     # 5K tokens restored
# Continue work...
```

## Commands
```bash
/bundle-save <name>           # Save context
/bundle-load <name>           # Load context
/bundle-list                  # List bundles
/chain-agents feature "..."   # Automated chain
```

## When to Use
- Context hitting 120K tokens
- Multi-stage complex tasks
- Agent handoffs needed

## Next Level
Progress to [Level 4](level-4-agentic.md) for orchestration.
