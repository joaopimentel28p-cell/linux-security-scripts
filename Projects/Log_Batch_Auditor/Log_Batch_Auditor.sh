#!/usr/bin/env bash

# Resolve the script location and configure the input and report paths.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${1:-"$SCRIPT_DIR/logs"}"
REPORT="$SCRIPT_DIR/relatorio_auditoria.txt"

# Stop when the input directory does not exist or cannot be accessed.
if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: log directory not found: $LOG_DIR" >&2
    exit 1
fi

if [[ ! -r "$LOG_DIR" ]]; then
    echo "Error: log directory is not readable: $LOG_DIR" >&2
    exit 1
fi

# Collect matching log files and prepare a clean report.
shopt -s nullglob
ARQUIVOS=("$LOG_DIR"/*.log)

: > "$REPORT" || {
    echo "Error: could not create report: $REPORT" >&2
    exit 1
}

# Process each log file and record matching FAILED or ERROR lines.
if ((${#ARQUIVOS[@]} == 0)); then
    echo "No .log files found in: $LOG_DIR"
    echo "No .log files found in: $LOG_DIR" >> "$REPORT"
else
    for arquivo in "${ARQUIVOS[@]}"
    do
        echo "Processing file: $arquivo"
        echo "File analyzed: $arquivo" >> "$REPORT"
        echo "------------------------" >> "$REPORT"

        grep -H -E 'FAILED|ERROR' "$arquivo" >> "$REPORT"
        GREP_STATUS=$?

        if [[ "$GREP_STATUS" -gt 1 ]]; then
            echo "Error: could not read file: $arquivo" >&2
            exit 1
        elif [[ "$GREP_STATUS" -eq 1 ]]; then
            echo "No FAILED or ERROR occurrences found." >> "$REPORT"
        fi

        echo "" >> "$REPORT"
    done
fi

# Display the path of the completed report.
echo "Report created: $REPORT"
