#!/bin/bash
# ============================================================
#  Script 4: Log File Analyzer
#  Course: Open Source Software — Python Audit
#  Description: Uses a while loop to parse /var/log/dpkg.log
#               for the keyword 'install' and prints the
#               last 5 matching entries.
# ============================================================

echo "=============================================="
echo "           LOG FILE ANALYZER                 "
echo "=============================================="
echo ""

LOG_FILE="/var/log/dpkg.log"
KEYWORD="install"
MAX_RESULTS=5

echo "[*] Log File : $LOG_FILE"
echo "[*] Keyword  : '$KEYWORD'"
echo "[*] Showing  : Last $MAX_RESULTS matches"
echo ""

# --- Check if log file exists ---
if [ ! -f "$LOG_FILE" ]; then
    echo "[-] ERROR: Log file '$LOG_FILE' not found."
    echo ""
    echo "    Possible reasons:"
    echo "    1. You may be running in a minimal/container environment."
    echo "    2. dpkg logging may be disabled."
    echo "    3. Try: ls /var/log/dpkg* to check for rotated logs."
    echo ""

    # --- Attempt to find rotated dpkg logs ---
    rotated=$(ls /var/log/dpkg.log.* 2>/dev/null | head -3)
    if [ -n "$rotated" ]; then
        echo "    [!] Found rotated log(s):"
        echo "$rotated" | sed 's/^/        /'
        echo ""
        echo "    [!] Reading from most recent rotated log instead..."
        LOG_FILE=$(ls -t /var/log/dpkg.log.* 2>/dev/null | head -1)
    else
        echo "    [!] No rotated dpkg logs found either."
        echo ""
        echo "=============================================="
        echo "          END OF LOG FILE ANALYZER          "
        echo "=============================================="
        exit 1
    fi
fi

echo "----------------------------------------------"
echo "  LAST $MAX_RESULTS LINES CONTAINING '$KEYWORD'"
echo "----------------------------------------------"
echo ""

# --- Use while loop to read file and collect matches ---
match_count=0
declare -a matches

while IFS= read -r line; do
    # Case-insensitive search for the keyword
    if echo "$line" | grep -qi "$KEYWORD"; then
        matches+=("$line")
    fi
done < "$LOG_FILE"

total_found=${#matches[@]}

echo "[*] Total matches found in log: $total_found"
echo ""

if [ "$total_found" -eq 0 ]; then
    echo "    No lines containing '$KEYWORD' were found in $LOG_FILE."
else
    # Print the last MAX_RESULTS entries
    start_index=$(( total_found - MAX_RESULTS ))
    if [ "$start_index" -lt 0 ]; then
        start_index=0
    fi

    counter=1
    for (( i=start_index; i<total_found; i++ )); do
        echo "  [$counter] ${matches[$i]}"
        (( counter++ ))
    done
fi

echo ""
echo "----------------------------------------------"
echo "[*] Analysis Summary:"
echo "    Log file parsed    : $LOG_FILE"
echo "    Total matches      : $total_found"
echo "    Entries displayed  : $(( total_found < MAX_RESULTS ? total_found : MAX_RESULTS ))"
echo "----------------------------------------------"
echo ""
echo "=============================================="
echo "          END OF LOG FILE ANALYZER           "
echo "=============================================="
