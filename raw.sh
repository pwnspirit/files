#!/bin/bash

# github-raw.sh - Convert GitHub URLs to raw content URLs

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo "Usage: $0 <github-url>"
    echo ""
    echo "Examples:"
    echo "  $0 https://github.com/user/repo/blob/main/path/to/file.png"
    echo "  $0 github.com/user/repo/blob/main/path/to/file.png"
    exit 1
}

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No URL provided${NC}"
    usage
fi

URL="$1"

# Add https:// if not present
if [[ ! "$URL" =~ ^https?:// ]]; then
    URL="https://$URL"
fi

# Check if it's a GitHub URL
if [[ ! "$URL" =~ github\.com ]]; then
    echo -e "${RED}Error: Not a GitHub URL${NC}"
    exit 1
fi

# Convert to raw URL
RAW_URL=$(echo "$URL" | sed -e 's/github\.com/raw.githubusercontent.com/' -e 's/\/blob\//\//')

# Output the result
echo -e "${GREEN}Raw URL:${NC}"
echo "$RAW_URL"

# Optional: Copy to clipboard (requires xclip on Linux or pbcopy on macOS)
if command -v xclip &> /dev/null; then
    echo "$RAW_URL" | xclip -selection clipboard
    echo -e "${GREEN}✓ Copied to clipboard!${NC}"
elif command -v pbcopy &> /dev/null; then
    echo "$RAW_URL" | pbcopy
    echo -e "${GREEN}✓ Copied to clipboard!${NC}"
fi
