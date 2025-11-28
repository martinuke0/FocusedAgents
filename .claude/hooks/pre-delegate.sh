#!/bin/bash
# Pre-Delegate Hook
# Validates before delegation

AGENT_NAME=$1
TASK=$2

# Check agent exists
if [ ! -d ".claude/agents/sub-agents/$AGENT_NAME" ] && \
   [ ! -d ".claude/agents/experts/$AGENT_NAME" ]; then
    echo "Error: Agent '$AGENT_NAME' not found"
    exit 1
fi

# Check task provided
if [ -z "$TASK" ]; then
    echo "Error: Task description required"
    exit 1
fi

echo "Validation passed: Delegating to $AGENT_NAME"
exit 0
