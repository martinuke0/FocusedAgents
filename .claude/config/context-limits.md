# Context Token Budgets

## Overview

Each proficiency level has recommended token budgets to maintain performance.

## Token Budget by Level

### Level 1: Beginner (REDUCE)
**Budget:** 0-30K tokens
**Focus:** Minimize context

**Breakdown:**
- MCP servers: 6-11K tokens (file + git only)
- claude.md: <500 tokens
- Context priming: 2-5K tokens
- Working context: 10-15K tokens
- **Buffer:** 5-10K tokens

**Actions:**
- Use `/prime` instead of full file loads
- Keep claude.md slim
- Load MCP servers on-demand

### Level 2: Intermediate (DELEGATE)
**Budget:** 30-60K tokens
**Focus:** Delegate before hitting limits

**Breakdown:**
- Base context: 30K tokens (from Level 1)
- Task context: 20-30K tokens
- **Delegation threshold:** 50K tokens

**Actions:**
- Delegate tasks at 50K tokens
- Use sub-agents for focused work
- Monitor token usage actively

### Level 3: Advanced (R&D)
**Budget:** 60-150K tokens
**Focus:** Save bundles before overload

**Breakdown:**
- Base context: 30K tokens
- Complex task context: 50-80K tokens
- **Bundle save threshold:** 120K tokens
- **Critical threshold:** 150K tokens

**Actions:**
- Save bundle at 120K tokens
- Never exceed 150K tokens
- Chain agents via bundles

### Level 4: Agentic (ORCHESTRATION)
**Budget:** Unlimited (distributed)
**Focus:** Orchestrate specialized agents

**Breakdown:**
- Primary agent: 20-40K tokens (orchestration only)
- Expert agents: 50-100K tokens each (isolated)
- Background agents: 30-60K tokens each (isolated)
- **No single agent exceeds 150K tokens**

**Actions:**
- Keep primary agent lean (orchestration only)
- Delegate deep work to experts
- Run monitors in background
- Aggregate results

## Context Stages

### Stage 1: Fresh (0-20K tokens)
**Status:** 🟢 Optimal
**Action:** Work normally

### Stage 2: Growing (20K-60K tokens)
**Status:** 🟡 Monitor
**Action:** Consider delegation

### Stage 3: Large (60K-120K tokens)
**Status:** 🟠 Warning
**Action:** Delegate or prepare bundle

### Stage 4: Critical (120K-150K tokens)
**Status:** 🔴 Alert
**Action:** Save bundle immediately

### Stage 5: Overload (150K+ tokens)
**Status:** ❌ Danger
**Action:** Emergency bundle save, fresh agent

## Token Savings Strategies

### Strategy 1: MCP Optimization
**Savings:** 15-25K tokens
- Remove default MCP files
- Load only essential servers
- Use on-demand loading

### Strategy 2: Context Priming
**Savings:** 15-20K tokens
- Slim claude.md to <500 tokens
- Use `/prime` commands
- Load focused context only

### Strategy 3: Sub-Agent Delegation
**Savings:** 20-40K tokens per task
- Delegate to sub-agents
- Work happens in isolated context
- Results returned concisely

### Strategy 4: Context Bundles
**Savings:** 100K+ tokens (effective)
- Save state before overload
- Fresh agent with preserved context
- Continue work efficiently

### Strategy 5: Expert Agents
**Savings:** Unlimited (parallel)
- Distribute work across specialists
- Each agent stays under limits
- Aggregate results

## Performance Impact

### Context Size vs Performance

```
0-30K tokens:    ⚡️⚡️⚡️⚡️⚡️ Excellent (fastest, best quality)
30-60K tokens:   ⚡️⚡️⚡️⚡️   Good (slight slowdown)
60-100K tokens:  ⚡️⚡️⚡️     Moderate (noticeable impact)
100-150K tokens: ⚡️⚡️       Poor (significant degradation)
150K+ tokens:    ⚡️         Critical (severe issues)
```

## Monitoring Tools

### Built-in Commands
```bash
/context              # Check current token usage
/mcp-check           # Verify MCP server tokens
/bundle-list         # See saved bundles
```

### Custom Hooks
```bash
# context-monitor.sh runs automatically
# Alerts at 80K, 120K, 150K thresholds
```

## Best Practices

### 1. Start Lean
Begin every agent with minimal context (Level 1 techniques).

### 2. Monitor Actively
Check `/context` regularly, especially before large operations.

### 3. Delegate Early
Don't wait until 150K tokens to delegate - delegate at 50-60K.

### 4. Bundle Proactively
Save bundles at 120K tokens, not at emergency 150K.

### 5. Specialize Deeply
Use expert agents for focused, deep work - keep primary lean.

## Anti-Patterns

### ❌ Ignoring Token Usage
**Problem:** Continue working until context explodes
**Fix:** Monitor `/context` regularly

### ❌ Late Delegation
**Problem:** Delegate at 140K tokens
**Fix:** Delegate at 50-60K tokens

### ❌ No Bundling
**Problem:** Lose all context at 150K+
**Fix:** Bundle at 120K tokens

### ❌ Kitchen Sink Loading
**Problem:** Load everything "just in case"
**Fix:** Load minimal, focused context

## Real-World Examples

### Example 1: Feature Development
```
Start: 0K tokens (fresh agent)
/prime: 5K tokens (project context)
Implement: 45K tokens (code + tests)
Delegate review: Back to 15K tokens (results only)
Final: 50K tokens (under budget)
```

### Example 2: Large Refactoring
```
Start: 0K tokens
/prime: 5K tokens
Analyze: 80K tokens (full codebase understanding)
/bundle-save refactor-plan: Bundle saved
Fresh agent: 0K tokens
/bundle-load: 5K tokens (context restored)
Implement: 70K tokens
Complete: 75K tokens (under budget per agent)
```

### Example 3: Multi-Agent Review
```
Primary: 20K tokens (orchestration)
├── Expert 1 (python-reviewer): 60K tokens
├── Expert 2 (security-auditor): 70K tokens
└── Expert 3 (performance-optimizer): 55K tokens
Aggregate: 25K tokens (findings)
Total effective: 25K tokens primary (experts isolated)
```

## Summary

- **Level 1:** Stay under 30K tokens
- **Level 2:** Delegate at 50-60K tokens
- **Level 3:** Bundle at 120K tokens
- **Level 4:** Keep primary <40K, distribute work

**Remember:** It's not about saving tokens, it's about spending them properly.
