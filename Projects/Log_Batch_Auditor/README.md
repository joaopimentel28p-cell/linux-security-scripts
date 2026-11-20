# Log Batch Auditor

## About

Log Batch Auditor is a Bash script designed to analyze multiple `.log` files in a directory. It searches for critical keywords related to errors and failed operations, collecting the matching lines into a single text report (`audit_report.txt`).

## Purpose

Reviewing log files individually is slow and error-prone. This project simplifies basic log auditing by automating the search for relevant events, such as authentication failures and system errors, in one consolidated file.

## Features

- Scans multiple `.log` files in a default (`./logs`) or user-specified directory.
- Validates directory existence and read permissions before processing files.
- Searches for lines containing `FAILED` or `ERROR`.
- Generates a consolidated report named `audit_report.txt` grouped by source file.
- Handles directories without `.log` files cleanly.

## Requirements

- Linux or another Unix-like operating system
- Bash shell (`/bin/bash`)
- `grep` utility

## Usage

1. Make the script executable:

```bash
chmod +x log_batch_auditor.sh
```

2. Run using the default `./logs` directory:

```bash
./log_batch_auditor.sh
```

3. *(Optional)* Run using a custom log directory:

```bash
./log_batch_auditor.sh /path/to/logs
```

The generated report is saved as `audit_report.txt` in the script's directory.

## Example

### Input (`./logs/auth.log`)

```text
2026-11-20 08:10:15 SUCCESS: User admin logged in
2026-11-20 08:12:30 FAILED: Invalid password for user john
2026-11-20 08:13:05 FAILED: Invalid password for user john
```

### Output (`audit_report.txt`)

```text
Analyzed file: ./logs/auth.log
------------------------
./logs/auth.log:2026-11-20 08:12:30 FAILED: Invalid password for user john
./logs/auth.log:2026-11-20 08:13:05 FAILED: Invalid password for user john
```

## Limitations

- Searches strictly for uppercase `FAILED` and `ERROR` keywords (case-sensitive).
- Does not search inside subdirectories.
- Does not perform automated intrusion detection or anomaly analysis.
- Does not replace professional monitoring or SIEM tools.

## Version

`1.0`