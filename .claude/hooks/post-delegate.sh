#!/bin/bash
# Post-Delegate Hook
# Process results after delegation

AGENT_NAME=$1
RESULT_FILE=$2

# Log delegation
echo "[$(date)] Delegated to $AGENT_NAME" >> .claude/delegation-log.txt

# Check for errors in results
if grep -qi "error\|failed" "$RESULT_FILE"; then
    echo "Warning: Delegation may have encountered issues"
fi

echo "Delegation complete"
exit 0
