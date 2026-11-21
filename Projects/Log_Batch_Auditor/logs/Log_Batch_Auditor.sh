# Define basic paths
SCRIPT_DIR=$(dirname "$0")
LOG_DIR="$1"

if [ -z "$LOG_DIR" ]; then
    LOG_DIR="$SCRIPT_DIR/logs"
fi

REPORT="$SCRIPT_DIR/audit_report.txt"

# Check if the directory exists and is readable
if [ ! -d "$LOG_DIR" ] || [ ! -r "$LOG_DIR" ]; then
    echo "Error: log directory not found or not readable: $LOG_DIR"
    exit 1
fi

# Create or clear the report file
> "$REPORT"

found=0

# Loop through all .log files in the directory
for file in "$LOG_DIR"/*.log; do
    # Avoid errors if no .log files exist
    if [ ! -f "$file" ]; then
        continue
    fi

    # Check read permission before running grep
    if [ ! -r "$file" ]; then
        echo "Error: could not read file: $file"
        exit 1
    fi

    found=1
    echo "Processing: $file"
    echo "Analyzed file: $file" >> "$REPORT"
    echo "------------------------" >> "$REPORT"

    grep -H -E "FAILED|ERROR" "$file" >> "$REPORT"
    echo "" >> "$REPORT"
done

# Notify if no .log files were found
if [ "$found" -eq 0 ]; then
    echo "No .log files found in: $LOG_DIR" | tee -a "$REPORT"
fi

echo "Report created: $REPORT"