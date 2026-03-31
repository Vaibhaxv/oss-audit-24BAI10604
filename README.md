# 🐍 Python Audit — Open Source Software Capstone Project

> **Course:** Open Source Software  
> **Student Name:** Friend's Name  
> **Registration Number:** Friend's Reg No  
> **Environment:** Ubuntu / WSL (Windows Subsystem for Linux)

---

## 📋 Project Overview

This capstone project consists of **5 Bash shell scripts** written for an Ubuntu/WSL environment. Each script demonstrates a core Linux/Bash concept while auditing the Python3 ecosystem on the system. The scripts collectively cover system inspection, package management, file system analysis, log parsing, and interactive user input.

---

## 📁 Project Structure

```
capstone-oss-python-audit/
├── script1_system_identity.sh     # System Identity Report
├── script2_package_inspector.sh   # Python3 Package Inspector
├── script3_directory_auditor.sh   # Directory Permission Auditor
├── script4_log_analyzer.sh        # dpkg Log File Analyzer
├── script5_interactive_quiz.sh    # Interactive Open Source Quiz
└── README.md                      # This file
```

---

## ⚙️ Prerequisites

Before running these scripts, ensure the following are available on your system:

| Tool | Purpose | Install Command |
|------|---------|-----------------|
| `bash` | Script interpreter | Pre-installed on Ubuntu/WSL |
| `dpkg` | Package manager queries | Pre-installed on Ubuntu |
| `python3` | Runtime version check | `sudo apt install python3` |
| `stat`, `du`, `uptime` | System utilities | Pre-installed on Ubuntu |
| `grep`, `awk`, `sed` | Text processing | Pre-installed on Ubuntu |

---

## 🚀 How to Run the Scripts

### Step 1 — Clone or Download the Project

Place all `.sh` files in the same directory, for example:

```bash
mkdir ~/capstone-oss && cd ~/capstone-oss
# Copy all .sh files here
```

### Step 2 — Make Scripts Executable

You **must** grant execute permissions before running any script:

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_directory_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_interactive_quiz.sh
```

Or do it all at once:

```bash
chmod +x *.sh
```

### Step 3 — Run Each Script

```bash
# Script 1 — System Identity Report
./script1_system_identity.sh

# Script 2 — Package Inspector
./script2_package_inspector.sh

# Script 3 — Directory Auditor
./script3_directory_auditor.sh

# Script 4 — Log File Analyzer (may need sudo for log access)
./script4_log_analyzer.sh
# OR: sudo ./script4_log_analyzer.sh

# Script 5 — Interactive Quiz (follow on-screen prompts)
./script5_interactive_quiz.sh
```

---

## 📜 Script Descriptions

---

### 1. `script1_system_identity.sh` — System Identity Report

**Purpose:** Displays a complete identity snapshot of the current Linux system.

**What it shows:**
- Linux distribution name and version (reads `/etc/os-release`)
- Kernel version (uses `uname -r`)
- Current logged-in user, home directory, and shell
- System uptime (uses `uptime -p`)
- OS license information (reads `/usr/share/doc/base-files/copyright`)

**Sample Output:**
```
==============================================
         SYSTEM IDENTITY REPORT
==============================================

[1] DISTRIBUTION:
    Name        : Ubuntu
    Version     : 22.04.3 LTS (Jammy Jellyfish)

[2] KERNEL VERSION:
    5.15.90.1-microsoft-standard-WSL2

[3] CURRENT USER:
    Username    : student
    Home Dir    : /home/student
    Shell       : /bin/bash

[4] SYSTEM UPTIME:
    up 2 hours, 14 minutes
...
```

---

### 2. `script2_package_inspector.sh` — Package Inspector

**Purpose:** Uses `dpkg` to determine whether Python3 is installed and retrieves its full version details.

**Key Concepts Demonstrated:**
- `dpkg -l` to list installed packages
- `dpkg -s` to show full package status
- Conditional logic with `if/else`
- Command substitution with `$()`

**What it checks:**
- Whether `python3` is installed via `dpkg`
- The installed package version
- The runtime version via `python3 --version`
- Whether `pip3` is also available

---

### 3. `script3_directory_auditor.sh` — Directory Auditor

**Purpose:** Uses a `for` loop to audit four key system directories, reporting their disk usage and read/write permissions.

**Directories Audited:**
| Directory | Description |
|-----------|-------------|
| `/etc` | System-wide configuration files |
| `/var/log` | System and application log files |
| `/usr/bin` | User-accessible binary executables |
| `/etc/python3` | Python3 configuration directory |

**Key Concepts Demonstrated:**
- `for` loop iterating over a list
- `du -sh` for human-readable disk usage
- `-r` and `-w` permission tests
- `stat` for symbolic and octal permission strings

---

### 4. `script4_log_analyzer.sh` — Log File Analyzer

**Purpose:** Parses `/var/log/dpkg.log` using a `while` loop to find all lines containing the word `install`, then prints the **last 5 matches**.

**Key Concepts Demonstrated:**
- `while IFS= read -r line` loop for safe line-by-line file parsing
- Array accumulation of matching lines
- Handling missing log files and rotated logs (`/var/log/dpkg.log.*`)
- `grep -qi` for case-insensitive keyword matching

> **Note:** On some minimal WSL setups, `/var/log/dpkg.log` may not exist.  
> The script automatically searches for rotated log files as a fallback.  
> If no logs are found, install a package first: `sudo apt install tree`

---

### 5. `script5_interactive_quiz.sh` — Interactive Quiz

**Purpose:** Prompts the user to answer 3 open-source-themed questions and automatically saves their responses to a uniquely named `.txt` file.

**Questions Asked:**
1. What is Open Source Software?
2. Name one popular open-source project and explain its importance.
3. Explain the difference between Free Software (FSF) and Open Source Software (OSI).

**Key Concepts Demonstrated:**
- `read -r` for interactive user input
- Heredoc (`<< EOF`) for structured file writing
- Dynamic filename generation using `date +"%Y%m%d_%H%M%S"`
- File existence checking and output verification

**Output File:** Saved as `open_source_answers_YYYYMMDD_HHMMSS.txt` in the current directory.

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `Permission denied` when running | Run `chmod +x scriptname.sh` first |
| Script 4 says log not found | Run `sudo apt install tree` to generate dpkg log entries, then retry |
| `dpkg` command not found | You may be in a non-Debian environment; scripts require Ubuntu/Debian |
| Python3 shown as not installed | Run `sudo apt update && sudo apt install python3` |
| WSL clock skew warnings | Run `sudo hwclock -s` to sync the hardware clock |

---

## 📚 Key Bash Concepts Used

| Concept | Used In |
|--------|---------|
| `if/else` conditionals | Scripts 1, 2, 3, 4 |
| `for` loop | Script 3 |
| `while` loop | Script 4 |
| `read` (user input) | Script 5 |
| Arrays | Script 4 |
| Command substitution `$()` | All scripts |
| File I/O and Heredoc | Script 5 |
| Permission testing `-r`, `-w`, `-f` | Scripts 3, 4 |
| `dpkg` package queries | Script 2 |

---

## 📄 License

These scripts are written for academic/educational purposes as part of an Open Source Software course. They are free to use, modify, and redistribute.

---

*Capstone Project — Open Source Software | Ubuntu/WSL Bash Scripting*
