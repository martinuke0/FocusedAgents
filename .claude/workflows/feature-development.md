# Feature Development Workflow

Complete end-to-end feature development pipeline.

## Stages

### Stage 1: Architecture Review
**Agent:** architecture-reviewer  
**Task:** Validate feature design and architecture  
**Output:** Design recommendations bundle

### Stage 2: Implementation
**Agent:** Primary  
**Task:** Implement core feature functionality  
**Output:** Working implementation bundle

### Stage 3: Test Generation
**Agent:** test-generator (sub-agent)  
**Task:** Generate comprehensive test suite  
**Output:** Tests complete bundle

### Stage 4: Review (Parallel)
**Agents:** security-auditor, performance-optimizer  
**Task:** Security and performance review  
**Output:** Review findings bundle

### Stage 5: Polish
**Agent:** Primary  
**Task:** Address review findings  
**Output:** Production-ready feature

## Estimated Duration
45-60 minutes

## Usage
```bash
/orchestrate feature-development src/api/new-feature
```
