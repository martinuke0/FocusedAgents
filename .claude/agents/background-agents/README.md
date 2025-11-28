# Background Agents

Async monitoring agents for Level 4.

## Available Background Agents
- `code-monitor` - Watch code quality metrics
- `test-runner` - Continuous test monitoring

## Usage
```bash
/background "[long-running task]"
```

## Creating Custom Background Agents
```bash
cp -r _TEMPLATE my-monitor
# Customize for async monitoring
```
