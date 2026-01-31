#!/bin/bash
#
# Update Homebrew Formula for new release
#
# Usage: ./update-formula.sh <version>
# Example: ./update-formula.sh 2.0.5

set -e

VERSION="${1:-}"
REPO="brucedombrowski/security-toolkit"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 2.0.5"
    exit 1
fi

# Remove 'v' prefix if present
VERSION="${VERSION#v}"

echo "Updating formula for version $VERSION..."

# Download tarball and compute SHA256
URL="https://github.com/$REPO/archive/refs/tags/v${VERSION}.tar.gz"
echo "Fetching: $URL"

SHA256=$(curl -sL "$URL" | shasum -a 256 | cut -d' ' -f1)

if [ -z "$SHA256" ] || [ "$SHA256" = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" ]; then
    echo "Error: Could not fetch tarball or release doesn't exist"
    exit 1
fi

echo "SHA256: $SHA256"

# Update formula
FORMULA="Formula/security-toolkit.rb"
sed -i '' "s|url \"https://github.com/$REPO/archive/refs/tags/v[^\"]*\"|url \"https://github.com/$REPO/archive/refs/tags/v${VERSION}.tar.gz\"|" "$FORMULA"
sed -i '' "s|sha256 \"[^\"]*\"|sha256 \"${SHA256}\"|" "$FORMULA"

echo ""
echo "Updated $FORMULA:"
grep -E "(url|sha256)" "$FORMULA" | head -2
echo ""
echo "Don't forget to commit and push:"
echo "  git add Formula/security-toolkit.rb"
echo "  git commit -m \"Update security-toolkit to v${VERSION}\""
echo "  git push"
