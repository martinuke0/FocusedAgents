# Code Review Pipeline

Comprehensive multi-perspective code review.

## Stages

### Stage 1: Code Analysis
**Agent:** code-analyzer (sub-agent)  
**Task:** Analyze code structure and quality  
**Output:** Analysis complete

### Stage 2: Parallel Expert Review
**Agents:** security-auditor, performance-optimizer, architecture-reviewer  
**Task:** Deep domain-specific reviews  
**Output:** Expert findings

### Stage 3: Aggregate & Prioritize
**Agent:** Primary  
**Task:** Combine findings, prioritize by severity  
**Output:** Prioritized action list

## Estimated Duration
20-30 minutes

## Usage
```bash
/orchestrate code-review-pipeline src/module/
```
