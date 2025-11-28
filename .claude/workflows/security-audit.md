# Security Audit Workflow

Comprehensive security assessment.

## Stages

### Stage 1: Code Security Scan
**Agent:** security-auditor  
**Task:** OWASP Top 10 analysis  
**Output:** Security findings

### Stage 2: Dependency Audit
**Agent:** security-auditor  
**Task:** Check for vulnerable dependencies  
**Output:** Dependency report

### Stage 3: Configuration Review
**Agent:** security-auditor  
**Task:** Review security configurations  
**Output:** Configuration recommendations

### Stage 4: Remediation Plan
**Agent:** Primary  
**Task:** Create prioritized fix plan  
**Output:** Action plan

## Estimated Duration
30-45 minutes

## Usage
```bash
/orchestrate security-audit src/
```
