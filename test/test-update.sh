#!/bin/bash
# Test the update functionality

set -e

echo "🧪 Testing Claude Memory System Update"

# Create temp directory
TEST_DIR="test-update-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# First install
echo "📦 Initial installation..."
bash ../../install.sh "UpdateTest"

# Create some memory files
echo "Test content" > .claude/session/test.md

# Run update
echo "🔄 Running update..."
bash ../../update.sh

# Check if memory preserved
if [ -f ".claude/session/test.md" ]; then
    echo "✅ Memory preserved during update"
else
    echo "❌ Memory lost during update"
    exit 1
fi

# Cleanup
cd ../..
rm -rf "$TEST_DIR"

echo "✅ Update test passed!"
