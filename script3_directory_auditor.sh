#!/bin/bash
# ============================================================
#  Script 3: Directory Auditor
#  Course: Open Source Software — Python Audit
#  Description: Uses a for loop to audit sizes and read/write
#               permissions of key system directories.
# ============================================================

echo "=============================================="
echo "           DIRECTORY AUDITOR                 "
echo "=============================================="
echo ""

# List of directories to audit
DIRECTORIES=("/etc" "/var/log" "/usr/bin" "/etc/python3")

printf "%-20s %-12s %-10s %-10s %-s\n" "DIRECTORY" "SIZE" "READABLE" "WRITABLE" "PERMISSIONS"
echo "----------------------------------------------------------------------"

for dir in "${DIRECTORIES[@]}"; do

    # --- Check if directory exists ---
    if [ ! -e "$dir" ]; then
        printf "%-20s %-12s %-10s %-10s %-s\n" "$dir" "N/A" "N/A" "N/A" "[ NOT FOUND ]"
        continue
    fi

    # --- Get size using du ---
    dir_size=$(du -sh "$dir" 2>/dev/null | awk '{print $1}')
    if [ -z "$dir_size" ]; then
        dir_size="N/A"
    fi

    # --- Check read permission ---
    if [ -r "$dir" ]; then
        readable="YES"
    else
        readable="NO"
    fi

    # --- Check write permission ---
    if [ -w "$dir" ]; then
        writable="YES"
    else
        writable="NO"
    fi

    # --- Get symbolic permissions ---
    perms=$(stat -c "%A" "$dir" 2>/dev/null)

    printf "%-20s %-12s %-10s %-10s %-s\n" "$dir" "$dir_size" "$readable" "$writable" "$perms"

done

echo ""
echo "----------------------------------------------------------------------"
echo "LEGEND:"
echo "  SIZE      — Disk usage of the directory (human-readable)"
echo "  READABLE  — Whether the current user can READ the directory"
echo "  WRITABLE  — Whether the current user can WRITE to the directory"
echo "  PERMISSIONS — Symbolic permission string (e.g., drwxr-xr-x)"
echo ""

# --- Detailed breakdown per directory ---
echo "=============================================="
echo "         DETAILED PERMISSION BREAKDOWN       "
echo "=============================================="
echo ""

for dir in "${DIRECTORIES[@]}"; do
    if [ ! -e "$dir" ]; then
        echo "  [$dir] — NOT FOUND on this system."
        echo ""
        continue
    fi

    echo "  Directory : $dir"
    echo "  Owner     : $(stat -c '%U' "$dir" 2>/dev/null)"
    echo "  Group     : $(stat -c '%G' "$dir" 2>/dev/null)"
    echo "  Octal     : $(stat -c '%a' "$dir" 2>/dev/null)"
    echo "  Symbolic  : $(stat -c '%A' "$dir" 2>/dev/null)"

    # Count items inside (if readable)
    if [ -r "$dir" ]; then
        item_count=$(ls -1 "$dir" 2>/dev/null | wc -l)
        echo "  Items     : $item_count files/subdirectories"
    fi

    echo ""
done

echo "=============================================="
echo "          END OF DIRECTORY AUDITOR           "
echo "=============================================="
