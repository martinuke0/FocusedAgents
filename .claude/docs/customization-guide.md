# Customization Guide

Create custom agents for your domain.

## Creating a Sub-Agent

1. Copy template
```bash
cp -r .claude/agents/sub-agents/_TEMPLATE .claude/agents/sub-agents/my-agent
```

2. Edit system-prompt.md
```markdown
# My Custom Agent

You are a specialized [domain] expert...
```

3. Edit README.md with usage

4. Test
```bash
/delegate my-agent "Test task"
```

## Creating an Expert Agent

1. Copy expert template
```bash
cp -r .claude/agents/experts/_TEMPLATE .claude/agents/experts/my-expert
```

2. Add supporting files:
- system-prompt.md (role, responsibilities)
- checklist.md (domain checklist)
- templates/ (reusable templates)
- references/ (reference materials)
- examples/ (example outputs)

3. Test
```bash
/expert my-expert "Test analysis"
```

## Creating a Workflow

1. Create workflow file
```bash
vim .claude/workflows/my-workflow.md
```

2. Define stages
```markdown
## Stage 1: Analysis
Agent: code-analyzer
Task: ...

## Stage 2: Implementation
Agent: primary
Task: ...
```

3. Test
```bash
/orchestrate my-workflow target/
```

## Best Practices
- Keep agents focused (single purpose)
- Provide clear system prompts
- Include examples
- Document usage

Ready to create? Use templates in [agents/](../agents/)
