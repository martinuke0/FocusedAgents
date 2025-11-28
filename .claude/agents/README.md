# Agents

Specialized agents for context engineering.

## Agent Types

### Sub-Agents (Level 2)
Quick, focused tasks (3-4 files each)
- Location: `sub-agents/`
- Usage: `/delegate [agent] [task]`

### Expert Agents (Level 4)
Deep domain specialists (8-12 files each)
- Location: `experts/`
- Usage: `/expert [agent] [task]`

### Background Agents (Level 4)
Async monitoring
- Location: `background-agents/`
- Usage: `/background [task]`

## Creating Custom Agents

### Sub-Agent
```bash
cp -r sub-agents/_TEMPLATE sub-agents/my-agent
# Edit system-prompt.md, README.md, config.json
```

### Expert Agent
```bash
cp -r experts/_TEMPLATE experts/my-expert
# Add checklist, templates, references, examples
```

## Agent Catalog

See individual agent directories for:
- Purpose and capabilities
- When to use
- How to invoke
- Examples
