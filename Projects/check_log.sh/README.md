# Check Log

## About

**Check Log** is a lightweight Bash script designed to validate a single `.log` file before further processing. It serves as the initial validation stage of the **Log Batch Auditor** project and uses no external dependencies.

## Purpose

Prevent downstream log-processing steps from receiving missing, unreadable, incorrectly named, or blank log files.

## Features

- Requires exactly one command-line argument.
- Checks that the file name ends in `.log`.
- Verifies that the path points to a readable regular file.
- Rejects empty files and files containing only spaces, tabs, or blank lines.
- Sends error messages to `stderr` and exits with status `1` when validation fails.
- Prints a success message to `stdout` and exits with status `0` when validation succeeds.

## Requirements

- Linux or another Unix-like environment
- Bash
- No external dependencies

## Usage

Make the script executable and pass one `.log` file as its only argument:

```bash
chmod +x check_log.sh
./check_log.sh path/to/check.log
```

Alternatively, run it with Bash:

```bash
bash check_log.sh path/to/check.log
```

## Example

### Input (`check.log`)

```log
Nov 20 09:14:22 server sshd[1498]: FAILED password for invalid user root from 192.168.1.45
```

### Output for a valid file

```text
OK: 'check.log' contains data. Continuing...
```

### Output for an empty or whitespace-only file

```text
Error: 'check.log' is empty or contains only whitespace.
```

## Limitations

- Validates only one `.log` file per run; batch processing is not part of this script.
- Does not search for patterns such as `FAILED` or `ERROR`, or generate audit reports.
- A hidden file named `.log` also matches the extension check unless explicitly rejected by the script.
- Does not detect intrusions and does not replace professional monitoring or SIEM tools.

## Version

`1.0` — Initial file-validation stage.
