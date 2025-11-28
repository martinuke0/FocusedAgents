# Refactoring Workflow

Safe, systematic refactoring process.

## Stages

### Stage 1: Current State Analysis
**Agent:** code-analyzer  
**Task:** Understand current architecture and patterns  
**Output:** Current state bundle

### Stage 2: Refactoring Plan
**Agent:** architecture-reviewer  
**Task:** Design refactoring strategy  
**Output:** Refactoring plan bundle

### Stage 3: Implementation
**Agent:** Primary  
**Task:** Execute refactoring incrementally  
**Output:** Refactored code bundle

### Stage 4: Verification
**Agents:** test-generator, code-analyzer  
**Task:** Verify correctness and improvements  
**Output:** Verification complete

## Estimated Duration
40-60 minutes

## Usage
```bash
/orchestrate refactoring-workflow src/legacy/
```
