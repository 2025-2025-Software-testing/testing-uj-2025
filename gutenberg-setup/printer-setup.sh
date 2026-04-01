#!/bin/bash

# Check for sudo privileges
if [ "$EUID" -ne 0 ]; then 
    echo "This script must be run with sudo privileges"
    echo "Usage: sudo $0"
    exit 1
fi

# Check and install cups if not present
if ! command -v cupsd &> /dev/null; then
    echo "CUPS is not installed. Installing..."
    apt-get update && apt-get install -y cups
else
    echo "CUPS is already installed"
fi

# Check and install cups-pdf if not present
if ! dpkg -l | grep -q cups-pdf; then
    echo "cups-pdf is not installed. Installing..."
    apt-get install -y cups-pdf
else
    echo "cups-pdf is already installed"
fi

# Get script directory and create output path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../printer-output"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
chmod 1777 "$OUTPUT_DIR"

echo "Output directory created: $OUTPUT_DIR"

# Configure cups-pdf
CUPS_PDF_CONF="/etc/cups/cups-pdf.conf"

if [ -f "$CUPS_PDF_CONF" ]; then
    # Backup configuration file
    cp "$CUPS_PDF_CONF" "${CUPS_PDF_CONF}.backup"
    
    # Modify configuration to change output directory
    sed -i "s|^Out .*|Out $OUTPUT_DIR|g" "$CUPS_PDF_CONF"
    
    echo "Configuration updated in $CUPS_PDF_CONF"
    echo "Output directory set to: $OUTPUT_DIR"
    
    # Restart CUPS to apply changes
    systemctl restart cups
    echo "CUPS service restarted"
else
    echo "Warning: Configuration file not found at $CUPS_PDF_CONF"
    exit 1
fi

echo ""
echo "============================================================================="
echo ""
echo "Configuration completed successfully"
echo "In order to delete the printer run \`sudo apt purge printer-driver-cups-pdf\`"
