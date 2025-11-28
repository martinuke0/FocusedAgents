# Level 2: Intermediate - Sub-Agent Delegation (DELEGATE)

Master task delegation to keep primary agent lean.

## Goal
Delegate focused tasks to specialized sub-agents operating in isolated contexts.

## Core Concept
**Sub-agents** = Single-purpose agents for quick, focused tasks

## Commands
```bash
/delegate code-analyzer "Analyze src/"
/review-code src/api/
/generate-tests src/utils.py
```

## Context Impact
- Without: Primary 70K+ tokens
- With: Primary 13K tokens, sub-agent isolated

**Savings:** 50K+ tokens to primary

## When to Delegate
- Primary hitting 50-60K tokens
- Focused, well-defined task
- Token-intensive analysis

## Available Sub-Agents
- code-analyzer
- refactor-assistant
- doc-writer

## Next Level
Progress to [Level 3](level-3-advanced.md) for bundles.
