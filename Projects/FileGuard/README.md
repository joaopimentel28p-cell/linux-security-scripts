# FileGuard

## About

FileGuard is a simple Bash script created to practice Linux administration and basic security checks.

## Purpose

The purpose of this project is to check whether a file exists and if the current user has permission to read it.

## Features

- Checks if a file exists.
- Checks if the current user has permission to read the file.
- Displays a message according to the result.

## Requirements

- Linux operating system.
- Bash shell.

## Usage

1. Open the terminal.
2. Navigate to the project directory.
3. Run the script:

```bash
chmod +x fileguard.sh
./fileguard.sh
```

4. Enter the file path when requested.

## Limitations

- Does not scan files for malware.
- Does not modify file permissions.
- Does not guarantee that the file will remain accessible after the check.

## Version

**Version:** 1.0