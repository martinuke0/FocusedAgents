# Getting Started with Context Engineering

Welcome! This 5-minute guide will get you up and running with context engineering.

## What You'll Learn

- What context engineering is and why it matters
- How to reduce context by 50-80% immediately
- Your first priming command
- Next steps for mastering the R&D framework

## What is Context Engineering?

**Context engineering** is the practice of managing your agent's context window - the most precious resource in agent-based development.

Think of it like RAM for your agent:
- Too much context = slower performance
- Unfocused context = worse results
- Lean, targeted context = fast, accurate responses

## The R&D Framework (5-Second Version)

**REDUCE:** Load only what you need
**DELEGATE:** Pass heavy work to specialized agents

That's it. Everything else builds on this.

## Your First Command: `/prime`

Right now, try this:

```bash
/prime
```

**What it does:**
- Reads your README
- Understands project structure
- Loads 2-5K tokens of focused context
- Saves you 15-20K tokens vs full load

**Result:** Agent understands your project without context bloat.

## Check Your Token Usage

Before `/prime`:
```bash
# Empty context: 0K tokens
```

After `/prime`:
```bash
# Focused context: 2-5K tokens
# Savings: 15-20K tokens
```

That's **50-80% context reduction** in one command!

## Level 1: Master Context Reduction

You're now ready for Level 1 (30 minutes):

1. **Read:** [Level 1 Guide](level-1-beginner.md)
2. **Try:**
   - `/prime` - Basic priming
   - `/prime-workflow feature` - Workflow-specific
   - `/mcp-check` - Verify MCP configuration

3. **Understand:** Why MCP and priming are game-changers

## Common Questions

**Q: When should I use context engineering?**
A: Always. Start every session with `/prime`.

**Q: Is this for large codebases only?**
A: No. Any codebase benefits from focused context.

**Q: Do I need to learn all 4 levels?**
A: No. Level 1 alone provides 50-80% benefit. Progress when needed.

**Q: How long to master this?**
A: Level 1: 30 min. Levels 1-2: 2 hours. All levels: 1 day.

## What's Next?

### Immediate (Now)
Try `/prime` on your current project.

### Soon (30 minutes)
Read [Level 1 Guide](level-1-beginner.md) and master context reduction.

### Later (1-2 hours)
Progress to [Level 2](level-2-intermediate.md) for sub-agent delegation.

### Eventually (2-4 hours)
Master [Level 3](level-3-advanced.md) and [Level 4](level-4-agentic.md) for advanced workflows.

## Key Principles to Remember

1. **A focused agent is a performant agent**
   - Load less, get better results

2. **It's about spending, not saving**
   - Spend tokens on the right context

3. **Progressive adoption**
   - Master one level at a time

4. **Measure and manage**
   - Check `/context` regularly

## Quick Wins

### Win 1: Start with `/prime`
Every session, every time.

### Win 2: Check MCP Servers
```bash
/mcp-check
```
Remove unused servers for instant token savings.

### Win 3: Use Workflow Priming
```bash
/prime-workflow feature    # For features
/prime-workflow bug        # For bugs
/prime-workflow refactor   # For refactoring
```

## You're Ready!

You now know:
- ✅ What context engineering is
- ✅ The R&D framework basics
- ✅ How to use `/prime`
- ✅ Next steps for learning

**Go try `/prime` right now!**

Then continue to → [Level 1: Beginner Guide](level-1-beginner.md)

---

**Remember:** A focused engineer is a performant engineer. Start simple, progress naturally.
