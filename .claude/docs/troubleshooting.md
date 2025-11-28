# Troubleshooting

Common issues and solutions.

## Issue: Context Still Too High

**Symptoms:** Token usage >30K after priming

**Solutions:**
1. Check MCP servers: `/mcp-check`
2. Remove unused servers
3. Slim claude.md to <500 tokens
4. Use `/prime` not `/prime-codebase`

## Issue: Delegation Not Working

**Symptoms:** Sub-agent not executing

**Solutions:**
1. Check agent name spelling
2. Verify agent exists in `.claude/agents/sub-agents/`
3. Check task description clarity
4. Review sub-agent system-prompt.md

## Issue: Bundle Loading Fails

**Symptoms:** `/bundle-load` returns error

**Solutions:**
1. Check bundle name: `/bundle-list`
2. Verify bundle file exists in `.claude/bundles/`
3. Check JSON syntax if edited manually
4. Try creating new bundle

## Issue: Expert Agent Too Slow

**Symptoms:** Expert takes >30 minutes

**Solutions:**
1. Narrow scope of analysis
2. Use sub-agent for quicker task
3. Break into smaller tasks
4. Check if task appropriate for expert

## Issue: Commands Not Found

**Symptoms:** `/prime` not recognized

**Solutions:**
1. Verify .claude/commands/ exists
2. Check file structure matches plan
3. Restart Claude Code
4. Verify command file format

## Getting Help

Still stuck? Check:
- [Architecture](../ARCHITECTURE.md)
- [Commands Reference](../commands/)
- [Agent Catalog](../agents/)

Or ask in discussions/issues.
