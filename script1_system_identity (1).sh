#!/bin/bash
# ============================================================
#  Script 1: System Identity Report
#  Course: Open Source Software — Python Audit
#  Description: Displays distro, kernel, user, uptime, and
#               OS license information.
# ============================================================

echo "=============================================="
echo "         SYSTEM IDENTITY REPORT              "
echo "=============================================="
echo ""

# --- Distribution Info ---
echo "[1] DISTRIBUTION:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "    Name        : $NAME"
    echo "    Version     : $VERSION"
    echo "    Pretty Name : $PRETTY_NAME"
else
    echo "    /etc/os-release not found."
fi
echo ""

# --- Kernel Version ---
echo "[2] KERNEL VERSION:"
echo "    $(uname -r)"
echo ""

# --- Current User ---
echo "[3] CURRENT USER:"
echo "    Username    : $(whoami)"
echo "    Home Dir    : $HOME"
echo "    Shell       : $SHELL"
echo ""

# --- System Uptime ---
echo "[4] SYSTEM UPTIME:"
uptime_info=$(uptime -p 2>/dev/null || uptime)
echo "    $uptime_info"
echo ""

# --- OS License ---
echo "[5] OS LICENSE:"
if [ -f /usr/share/doc/base-files/copyright ]; then
    echo "    License file found at: /usr/share/doc/base-files/copyright"
    echo "    --- First 10 lines ---"
    head -10 /usr/share/doc/base-files/copyright | sed 's/^/    /'
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "    License     : Open Source / Free Software"
    echo "    Details     : $HOME_URL"
    echo "    Distributor : ${NAME}"
    echo "    Note        : Ubuntu is distributed under the GNU GPL and"
    echo "                  various other open-source licenses."
else
    echo "    License information not found on this system."
fi

echo ""
echo "=============================================="
echo "          END OF SYSTEM IDENTITY REPORT      "
echo "=============================================="
