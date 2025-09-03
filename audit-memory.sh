#!/bin/bash
# Claude Memory System Audit Script v2.0
# Comprehensive health check for existing installations

set -e

# Colors for output (cross-platform)
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    NC=""
else
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
fi

# Initialize counters
TOTAL_CHECKS=0
PASSED_CHECKS=0
WARNINGS=0
ERRORS=0
SCORE=0

echo "🔍 Claude Memory System Audit"
echo "============================="

# Helper functions
check_pass() {
    ((TOTAL_CHECKS++))
    ((PASSED_CHECKS++))
    echo -e "${GREEN}✅ $1${NC}"
}

check_warn() {
    ((TOTAL_CHECKS++))
    ((WARNINGS++))
    echo -e "${YELLOW}⚠️  $1${NC}"
}

check_fail() {
    ((TOTAL_CHECKS++))
    ((ERRORS++))
    echo -e "${RED}❌ $1${NC}"
}

check_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# 1. STRUCTURE AUDIT
echo ""
echo "📁 STRUCTURE AUDIT"
echo "=================="

# Check if .claude directory exists
if [ -d ".claude" ]; then
    check_pass "Claude memory directory exists"
else
    check_fail "No .claude directory found - memory system not installed"
    exit 1
fi

# Check required directories
REQUIRED_DIRS=(
    ".claude/longterm"
    ".claude/context" 
    ".claude/session"
    ".claude/knowledge"
    ".claude/workspace"
    ".claude/workspace/experiments"
    ".claude/tools"
    ".claude/automation"
    ".claude/automation/scripts"
    ".claude/automation/hooks"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        check_pass "$dir exists"
    else
        check_fail "$dir missing"
    fi
done

# Check required files
REQUIRED_FILES=(
    ".claude/INDEX.md"
    ".claude/NORTH_STAR.md"
    ".claude/longterm/product-overview.md"
    ".claude/longterm/epics.md"
    ".claude/context/architecture.md"
    ".claude/context/patterns.md" 
    ".claude/context/environment.md"
    ".claude/context/performance-baseline.md"
    ".claude/context/dependencies.md"
    ".claude/session/current.md"
    ".claude/session/log.md"
    ".claude/session/handoff.md"
    ".claude/session/validation.md"
    ".claude/knowledge/errors.md"
    ".claude/knowledge/solutions.md"
    ".claude/knowledge/commands.md"
    ".claude/knowledge/optimizations.md"
    ".claude/knowledge/merge-conflicts.md"
    ".claude/workspace/experiments/index.md"
    ".claude/tools/mcp-registry.md"
    ".claude/tools/agent-usage.md"
    ".claude/tools/tool-cache.md"
    "Claude.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        check_pass "$file exists"
    else
        check_fail "$file missing"
    fi
done

# 2. CONTENT QUALITY AUDIT  
echo ""
echo "📝 CONTENT QUALITY AUDIT"
echo "======================="

# Check for placeholder content
PLACEHOLDER_PATTERNS=(
    "TO BE DETERMINED"
    "TIMESTAMP_PLACEHOLDER"
    "PROJECT_NAME_PLACEHOLDER"
    "_No .* documented yet_"
    "_To be added_"
    "\\[Add .*\\]"
    "\\[Fill in .*\\]"
)

PLACEHOLDER_FOUND=false
for pattern in "${PLACEHOLDER_PATTERNS[@]}"; do
    if grep -r "$pattern" .claude/ >/dev/null 2>&1; then
        if ! $PLACEHOLDER_FOUND; then
            check_warn "Placeholder content found:"
            PLACEHOLDER_FOUND=true
        fi
        grep -r "$pattern" .claude/ 2>/dev/null | head -3 | sed 's/^/    /'
    fi
done

if ! $PLACEHOLDER_FOUND; then
    check_pass "No placeholder content found"
fi

# Check file sizes (basic content check)
check_info "Checking file sizes for content..."

MIN_SIZES=(
    ".claude/INDEX.md:1500"
    ".claude/NORTH_STAR.md:500" 
    ".claude/longterm/product-overview.md:800"
    ".claude/longterm/epics.md:1000"
    ".claude/context/architecture.md:800"
    ".claude/context/patterns.md:600"
    ".claude/session/current.md:600"
)

for size_check in "${MIN_SIZES[@]}"; do
    file="${size_check%%:*}"
    min_size="${size_check##*:}"
    
    if [ -f "$file" ]; then
        actual_size=$(wc -c < "$file" 2>/dev/null || echo 0)
        if [ "$actual_size" -gt "$min_size" ]; then
            check_pass "$file has substantial content ($actual_size bytes)"
        else
            check_warn "$file is small ($actual_size bytes) - may lack content"
        fi
    fi
done

# Check for recent updates
check_info "Checking update recency..."
STALE_DAYS=30

find .claude -name "*.md" -type f -mtime +$STALE_DAYS 2>/dev/null | while read -r file; do
    check_warn "$file not updated in $STALE_DAYS+ days"
done

# 3. VERSION COMPATIBILITY AUDIT
echo ""
echo "🔄 VERSION COMPATIBILITY AUDIT"
echo "============================="

# Check for new strategic file features
if grep -q "Product vision & user needs" .claude/INDEX.md 2>/dev/null; then
    check_pass "INDEX.md has strategic file descriptions (v2.0+)"
else
    check_warn "INDEX.md may be using old file descriptions"
fi

if grep -q "longterm/.*Product vision & development strategy" Claude.md 2>/dev/null; then
    check_pass "Claude.md has strategic context guidance (v2.0+)"
else
    check_warn "Claude.md may be missing strategic context guidance"
fi

# Check for git hooks
if [ -f ".git/hooks/pre-commit" ] && grep -q "Claude Memory" .git/hooks/pre-commit 2>/dev/null; then
    check_pass "Git pre-commit hook installed"
else
    check_warn "Git pre-commit hook missing or not configured"
fi

if [ -f ".git/hooks/post-commit" ] && grep -q "Claude Memory" .git/hooks/post-commit 2>/dev/null; then
    check_pass "Git post-commit hook installed"
else
    check_warn "Git post-commit hook missing or not configured"
fi

# 4. EFFICIENCY AUDIT
echo ""
echo "⚡ EFFICIENCY AUDIT"
echo "=================="

# Check for bloated files (>10KB is probably too detailed)
check_info "Checking for bloated files..."
find .claude -name "*.md" -type f -size +10k 2>/dev/null | while read -r file; do
    size=$(du -h "$file" 2>/dev/null | cut -f1)
    check_warn "$file is large ($size) - may be too detailed"
done

# Check for temp files that should be ignored
if find .claude/workspace/temp -type f 2>/dev/null | head -1 | grep -q .; then
    check_warn "Temp files found - check .gitignore configuration"
else
    check_pass "No temp files in workspace"
fi

# Check if INDEX.md file sizes match reality
if [ -f ".claude/INDEX.md" ]; then
    check_info "Verifying INDEX.md size estimates..."
    
    # Extract size claims from INDEX.md and compare with actual
    grep "| \*\*.*\*\* |.*| ~.*KB |" .claude/INDEX.md 2>/dev/null | head -5 | while IFS='|' read -r _ file_col size_col _; do
        # Extract file path and expected size
        file_path=$(echo "$file_col" | grep -o '`[^`]*`' | tr -d '`' | head -1)
        expected_kb=$(echo "$size_col" | grep -o '[0-9]\+' | head -1)
        
        if [ -n "$file_path" ] && [ -n "$expected_kb" ] && [ -f "$file_path" ]; then
            actual_bytes=$(wc -c < "$file_path" 2>/dev/null || echo 0)
            actual_kb=$((actual_bytes / 1024))
            
            # Allow 50% variance
            if [ $actual_kb -gt $((expected_kb * 150 / 100)) ]; then
                check_warn "$file_path is larger than INDEX.md claims (${actual_kb}KB vs ${expected_kb}KB)"
            fi
        fi
    done
fi

# 5. CALCULATE HEALTH SCORE
echo ""
echo "📊 AUDIT SUMMARY"
echo "================"

if [ $TOTAL_CHECKS -gt 0 ]; then
    SCORE=$(( (PASSED_CHECKS * 100) / TOTAL_CHECKS ))
fi

echo "Total checks: $TOTAL_CHECKS"
echo "Passed: $PASSED_CHECKS"
echo "Warnings: $WARNINGS" 
echo "Errors: $ERRORS"
echo ""

if [ $SCORE -ge 90 ]; then
    echo -e "${GREEN}🎉 HEALTH SCORE: $SCORE% - Excellent!${NC}"
    echo "Your Claude Memory system is in great shape."
elif [ $SCORE -ge 75 ]; then
    echo -e "${YELLOW}📈 HEALTH SCORE: $SCORE% - Good${NC}"
    echo "Some minor improvements recommended."
elif [ $SCORE -ge 50 ]; then
    echo -e "${YELLOW}⚠️  HEALTH SCORE: $SCORE% - Needs attention${NC}"
    echo "Several issues should be addressed."
else
    echo -e "${RED}🚨 HEALTH SCORE: $SCORE% - Poor${NC}"
    echo "Significant problems found. Consider reinstalling."
fi

# 6. RECOMMENDATIONS
echo ""
echo "💡 RECOMMENDATIONS"
echo "=================="

if [ $ERRORS -gt 0 ]; then
    echo "🔴 Critical Issues:"
    echo "  • Missing files or directories detected"
    echo "  • Run: bash install.sh to repair installation"
    echo ""
fi

if [ $WARNINGS -gt 0 ]; then
    echo "🟡 Improvements:"
    if $PLACEHOLDER_FOUND; then
        echo "  • Replace placeholder content with project-specific information"
    fi
    echo "  • Update old files with recent project information"
    echo "  • Consider running content quality audit with Claude (see prompts below)"
    echo ""
fi

if [ $SCORE -ge 75 ]; then
    echo "✅ Maintenance:"
    echo "  • Run this audit monthly"
    echo "  • Use Claude content audit for deeper analysis"
    echo "  • Keep memory files updated as project evolves"
fi

echo ""
echo "🤖 For deeper content analysis, use the Claude audit prompts:"
echo "   See: Claude Memory Prompting Guide.md (search for 'audit')"
echo ""
echo "Audit complete! $(date)"