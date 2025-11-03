#!/bin/bash

# Update MTA ARM64 Pterodactyl Egg Configuration
# This script updates the egg JSON file with your GitHub username

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}  MTA ARM64 Egg Configuration Update${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# Check if username is provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage: ./update-egg.sh YOUR-GITHUB-USERNAME [YOUR-EMAIL]${NC}"
    echo ""
    echo "Example:"
    echo "  ./update-egg.sh johndoe"
    echo "  ./update-egg.sh johndoe john@example.com"
    exit 1
fi

USERNAME=$1
EMAIL=${2:-"${USERNAME}@users.noreply.github.com"}
EGG_FILE="egg-multi-theft-auto-arm64.json"

# Check if egg file exists
if [ ! -f "$EGG_FILE" ]; then
    echo -e "${RED}Error: $EGG_FILE not found!${NC}"
    exit 1
fi

echo "Updating egg configuration..."
echo "  GitHub Username: $USERNAME"
echo "  Email: $EMAIL"
echo ""

# Create backup
cp "$EGG_FILE" "${EGG_FILE}.backup"
echo -e "${GREEN}✓${NC} Created backup: ${EGG_FILE}.backup"

# Update the egg file
sed -i.tmp "s|ghcr.io/yourusername/pterodactyl-mta-arm64|ghcr.io/${USERNAME}/pterodactyl-mta-arm64|g" "$EGG_FILE"
sed -i.tmp "s|\"author\": \"your@email.com\"|\"author\": \"${EMAIL}\"|" "$EGG_FILE"

# Clean up temp file
rm -f "${EGG_FILE}.tmp"

echo -e "${GREEN}✓${NC} Updated Docker image path to: ghcr.io/${USERNAME}/pterodactyl-mta-arm64:latest"
echo -e "${GREEN}✓${NC} Updated author email to: ${EMAIL}"
echo ""

# Update Dockerfile labels
if [ -f "Dockerfile" ]; then
    sed -i.tmp "s|LABEL author=\"Your Name\"|LABEL author=\"${USERNAME}\"|" Dockerfile
    sed -i.tmp "s|maintainer=\"your@email.com\"|maintainer=\"${EMAIL}\"|" Dockerfile
    sed -i.tmp "s|https://github.com/yourusername/|https://github.com/${USERNAME}/|" Dockerfile
    rm -f Dockerfile.tmp
    echo -e "${GREEN}✓${NC} Updated Dockerfile labels"
    echo ""
fi

echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}  Configuration Updated Successfully!${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo "Next steps:"
echo "1. Commit and push your changes:"
echo "   git add ."
echo "   git commit -m 'Updated egg configuration'"
echo "   git push"
echo ""
echo "2. GitHub Actions will automatically build your Docker image"
echo ""
echo "3. Make your image public:"
echo "   Go to: https://github.com/${USERNAME}?tab=packages"
echo "   Click your package → Settings → Change visibility → Public"
echo ""
echo "4. Import the egg to Pterodactyl and create your server!"
echo ""