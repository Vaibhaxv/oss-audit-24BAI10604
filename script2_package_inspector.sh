#!/bin/bash
# ============================================================
#  Script 2: Package Inspector
#  Course: Open Source Software — Python Audit
#  Description: Uses dpkg to check if Python3 is installed
#               and prints its version details.
# ============================================================

echo "=============================================="
echo "           PACKAGE INSPECTOR                 "
echo "=============================================="
echo ""

PACKAGE="python3"

echo "[*] Checking installation status of: $PACKAGE"
echo ""

# --- Check with dpkg ---
dpkg_status=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii")

if [ -n "$dpkg_status" ]; then
    echo "[+] STATUS  : $PACKAGE is INSTALLED"
    echo ""

    # --- Installed Version (from dpkg) ---
    installed_version=$(dpkg -l "$PACKAGE" | grep "^ii" | awk '{print $3}')
    echo "    Installed Version (dpkg) : $installed_version"

    # --- Runtime Version (from binary) ---
    if command -v python3 &>/dev/null; then
        runtime_version=$(python3 --version 2>&1)
        echo "    Runtime Version         : $runtime_version"
        echo "    Executable Path         : $(which python3)"
    fi

    echo ""

    # --- Package Details ---
    echo "[*] FULL PACKAGE DETAILS (dpkg -s):"
    echo "----------------------------------------------"
    dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Package|Version|Status|Architecture|Maintainer|Description)" | sed 's/^/    /'

    echo ""

    # --- Check pip3 as well ---
    echo "[*] CHECKING pip3:"
    if command -v pip3 &>/dev/null; then
        pip_version=$(pip3 --version 2>&1)
        echo "    [+] pip3 is available : $pip_version"
    else
        echo "    [-] pip3 is NOT found on this system."
    fi

else
    echo "[-] STATUS  : $PACKAGE is NOT INSTALLED"
    echo ""
    echo "    To install it, run:"
    echo "    sudo apt-get update && sudo apt-get install python3"
fi

echo ""
echo "=============================================="
echo "          END OF PACKAGE INSPECTOR           "
echo "=============================================="
