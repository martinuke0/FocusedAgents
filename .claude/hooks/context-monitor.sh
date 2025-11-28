#!/bin/bash
# Context Monitor Hook
# Monitor and alert on token usage

CURRENT_TOKENS=$1

# Alert thresholds
YELLOW=60000
ORANGE=100000
RED=120000
CRITICAL=150000

if [ "$CURRENT_TOKENS" -ge "$CRITICAL" ]; then
    echo "🔴 CRITICAL: $CURRENT_TOKENS tokens! Save bundle immediately!"
elif [ "$CURRENT_TOKENS" -ge "$RED" ]; then
    echo "🔴 WARNING: $CURRENT_TOKENS tokens. Save bundle soon."
elif [ "$CURRENT_TOKENS" -ge "$ORANGE" ]; then
    echo "🟠 ALERT: $CURRENT_TOKENS tokens. Consider delegation or bundle."
elif [ "$CURRENT_TOKENS" -ge "$YELLOW" ]; then
    echo "🟡 NOTICE: $CURRENT_TOKENS tokens. Monitor usage."
else
    echo "🟢 OK: $CURRENT_TOKENS tokens"
fi

exit 0
