#!/usr/bin/env bash
set -euo pipefail

# Require exactly one valid file ending in .log.
if [[ $# -ne 1 || "${1##*/}" != ?*.log ]]; then
    echo "Error: provide exactly one file ending in .log." >&2
    echo "Usage: $0 file.log" >&2
    exit 1
fi

log_file="$1"

# Verify that the path points to a regular, readable, non-empty file.
if [[ ! -f "$log_file" || ! -r "$log_file" ]]; then
    echo "Error: '$log_file' does not exist or cannot be read." >&2
    exit 1
fi

if [[ ! -s "$log_file" ]]; then
    echo "Error: '$log_file' is empty." >&2
    exit 1
fi

# Discard DEBUG/INFO lines, filter failures, extract and validate IPv4, count, and sort.
# The || true prevents grep with no matches from exiting the script due to
# set -e and pipefail; in that case, ranking stays empty and the warning is printed below.
ranking=$(
    grep -Eiv '\b(DEBUG|INFO)\b' "$log_file" \
        | grep -Ei 'FAIL|FALHA|ERROR|DENIED|INVALID' \
        | grep -Eo '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' \
        | awk -F. 'NF == 4 && $1 <= 255 && $2 <= 255 && $3 <= 255 && $4 <= 255' \
        | LC_ALL=C sort \
        | uniq -c \
        | LC_ALL=C sort -k1,1nr -k2,2 || true
)

if [[ -z "$ranking" ]]; then
    echo "Warning: no valid IP associated with a failure was found in '$log_file'."
    exit 0
fi

echo "=== Top Failed IPs ==="
printf "%-8s %s\n" "COUNT" "IP"
echo "------------------------"
awk '{printf "%-8s %s\n", $1, $2}' <<< "$ranking"   