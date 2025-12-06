#!/bin/bash

# Helper script to calculate SHA256 checksums for all platform binaries
# Run this after creating all tar.gz files

set -e

# Update this version as needed
VERSION="1.0.0"

echo "=== Targetly CLI Release Checksums ==="
echo ""

platforms=("darwin-amd64" "darwin-arm64" "linux-amd64" "linux-arm64")

for platform in "${platforms[@]}"; do
    file="targetly-${platform}-${VERSION}.tar.gz"
    if [ -f "$file" ]; then
        echo "${platform}:"
        shasum -a 256 "$file" | awk '{print $1}'
        echo ""
    else
        echo "⚠️  Warning: $file not found"
        echo ""
    fi
done

echo "=== Formula Update Instructions ==="
echo "Copy these checksums to Formula/tly.rb:"
echo "  - darwin-amd64 → PLACEHOLDER_SHA256_DARWIN_AMD64"
echo "  - darwin-arm64 → PLACEHOLDER_SHA256_DARWIN_ARM64"
echo "  - linux-amd64  → PLACEHOLDER_SHA256_LINUX_AMD64"
echo "  - linux-arm64  → PLACEHOLDER_SHA256_LINUX_ARM64"
