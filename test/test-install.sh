
#!/bin/bash
# Test the Claude Code Memory System installation

set -e

echo "🧪 Testing Claude Code Memory System Installation"

# Get the repository root directory (parent of test directory)
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "📁 Repository root: $REPO_ROOT"

# Create temp directory for testing
TEST_DIR="$REPO_ROOT/test-install-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$TEST_DIR"
echo "📦 Test directory: $TEST_DIR"

# Change to test directory
cd "$TEST_DIR"

# Run installer from repository root
echo "📦 Running installer..."
bash "$REPO_ROOT/install.sh" "TestProject"

# Validate structure
echo "🔍 Validating structure..."
REQUIRED_FILES=(
    ".claude/NORTH_STAR.md"
    ".claude/session/current.md"
    ".claude/context/architecture.md"
    ".claude/context/patterns.md"
    ".claude/context/environment.md"
    ".claude/context/performance-baseline.md"
    ".claude/context/dependencies.md"
    ".claude/session/log.md"
    ".claude/session/handoff.md"
    ".claude/session/validation.md"
    ".claude/knowledge/errors.md"
    ".claude/knowledge/solutions.md"
    ".claude/knowledge/optimizations.md"
    ".claude/knowledge/merge-conflicts.md"
    ".claude/knowledge/commands.md"
    ".claude/workspace/experiments/index.md"
    ".claude/tools/mcp-registry.md"
    ".claude/tools/agent-usage.md"
    ".claude/tools/tool-cache.md"
    "Claude.md"
)

FAILED=0
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        FAILED=1
    fi
done

# Check directories
echo ""
echo "🔍 Checking directories..."
REQUIRED_DIRS=(
    ".claude/context"
    ".claude/session"
    ".claude/knowledge"
    ".claude/workspace"
    ".claude/tools"
    ".claude/automation"
    ".claude/automation/scripts"
    ".claude/automation/hooks"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir exists"
    else
        echo "❌ $dir missing"
        FAILED=1
    fi
done

# Run validation script
echo ""
echo "🔍 Running validation script..."
if [ -f ".claude/automation/scripts/validate.sh" ]; then
    bash .claude/automation/scripts/validate.sh
else
    echo "❌ Validation script not found"
    FAILED=1
fi

# Cleanup
cd "$REPO_ROOT"
rm -rf "$TEST_DIR"

if [ $FAILED -eq 1 ]; then
    echo "❌ Tests failed!"
    exit 1
fi

echo ""
echo "✅ All tests passed!"
