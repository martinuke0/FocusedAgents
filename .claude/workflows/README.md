# Workflows

Multi-agent orchestration templates (Level 4).

## Available Workflows

- **feature-development.md** - Complete feature pipeline
- **code-review-pipeline.md** - Comprehensive review
- **security-audit.md** - Security assessment
- **refactoring-workflow.md** - Safe refactoring

## Usage

```bash
/orchestrate <workflow-name> <target>
```

## Examples

```bash
/orchestrate feature-development src/api/payments
/orchestrate code-review-pipeline src/auth/
/orchestrate security-audit src/
```

## Creating Custom Workflows

1. Create workflow file
```bash
vim my-workflow.md
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

3. Use it
```bash
/orchestrate my-workflow target/
```
