# Migration Guide

Adopt context engineering in existing projects.

## Quick Setup (5 minutes)

1. Copy .claude directory to your project
```bash
cp -r /path/to/.claude ./
```

2. Customize MCP configuration
```bash
# Edit .claude/config/mcp-recommended.json
# Adjust for your project
```

3. Test basic priming
```bash
/prime
```

Done! You're using context engineering.

## Gradual Adoption

### Week 1: Level 1
- Use `/prime` to start sessions
- Configure MCP servers
- Slim down claude.md

### Week 2: Level 2
- Try `/delegate` for focused tasks
- Use `/review-code` before merges

### Week 3: Level 3
- Save bundles at 120K tokens
- Practice agent chaining

### Week 4: Level 4
- Use expert agents for critical code
- Set up workflow orchestration

## Integration

### With CI/CD
Use expert agents in pre-commit hooks

### With Team
Share .claude directory in git

### With Existing Tools
Context engineering complements, doesn't replace

## Success Metrics
- Context usage: Down 50-80%
- Agent speed: Noticeably faster
- Code quality: Expert-reviewed

Ready to start? → [Getting Started](getting-started.md)
