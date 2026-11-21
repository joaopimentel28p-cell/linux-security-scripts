# Top Failed IPs

## About

**Top Failed IPs** (`top_failed_ips.sh`) is a Bash script that parses a `.log`
file, filters out noise, extracts valid IPv4 addresses from failure events, and
prints a ranking ordered by frequency.

## Purpose

Accelerate initial log triage on Linux systems by highlighting which IP
addresses appear most often in failure entries, without manually sifting
through verbose `DEBUG` or `INFO` entries.

## Features

- Requires exactly one readable, non-empty `.log` file and rejects a file named
  literally `.log`.
- Discards lines containing the whole words `DEBUG` or `INFO`, case-insensitively.
- Filters remaining lines containing `FAIL`, `FALHA`, `ERROR`, `DENIED`, or
  `INVALID`, case-insensitively.
- Extracts IPv4 addresses with word-boundary matching and keeps addresses whose
  four octets are between `0` and `255`.
- Counts each matching IPv4 occurrence and sorts by count, highest first, then
  by IP for ties.
- Leaves the original log file untouched.

## Requirements

- Linux or another Unix-like environment
- Bash
- `grep`, `awk`, `sort`, and `uniq`
- GNU `grep`, because the script uses `\b` word boundaries

## Usage

From this directory, make the script executable and pass a `.log` file as the
only argument:

```bash
chmod +x top_failed_ips.sh
./top_failed_ips.sh path/to/access.log
```

Alternatively, run it with Bash:

```bash
bash top_failed_ips.sh path/to/access.log
```

## Example

### Input (`auth.log`)

```log
Nov 21 10:01:12 server app[101]: INFO User login succeeded from 192.168.1.10
Nov 21 10:02:05 server sshd[1420]: FAILED password for root from 203.0.113.45
Nov 21 10:02:19 server sshd[1425]: Invalid user admin from 203.0.113.45
Nov 21 10:03:01 server app[101]: DEBUG Connection check from 198.51.100.7
Nov 21 10:04:11 server sshd[1432]: Access DENIED for guest from 198.51.100.22
```

### Output

```text
=== Top Failed IPs ===
COUNT    IP
------------------------
2        203.0.113.45
1        198.51.100.22
```

## Limitations

- Extracts IPv4 addresses only; IPv6 addresses and hostnames are ignored.
- Counts every valid IPv4 address on a matching failure line. If both source and
  destination addresses appear, both are counted; the script does not parse a
  specific log format to identify the source address.
- Relies on fixed keywords and may miss failures logged under other terms.
- Does not independently detect intrusions or replace professional monitoring,
  IDS/IPS, or SIEM tools.
- If no valid IPv4 address is found on a matching line, it prints a warning and
  exits successfully. Invalid arguments, unreadable files, and empty files
  produce an error and a non-zero exit status.

## Version

`1.0` — Initial complete version.
