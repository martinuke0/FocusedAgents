# Sub-Agents

Quick, focused task agents for Level 2 delegation.

## Available Sub-Agents
- `code-analyzer` - Analyze code structure and dependencies
- `refactor-assistant` - Safe refactoring guidance
- `doc-writer` - Generate documentation

## Usage
```bash
/delegate [agent-name] "[task description]"
```

## Creating Custom Sub-Agents
```bash
cp -r _TEMPLATE my-agent
# Customize system-prompt.md and README.md
```

## Template
Use `_TEMPLATE/` as starting point for custom agents.
