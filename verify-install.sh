#!/bin/bash
# Claude Memory System - Installation Verification
# Quick script to verify your system can run the installer

set -e

echo "🔍 Claude Memory System - Installation Verification"
echo "================================================="

# Colors for output (cross-platform compatible)
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    GREEN=$(tput setaf 2)
    RED=$(tput setaf 1)
    YELLOW=$(tput setaf 3)
    NC=$(tput sgr0)
else
    GREEN=""
    RED=""
    YELLOW=""
    NC=""
fi

# Track status
ERRORS=0

# Function to check command
check_command() {
    local cmd=$1
    local version_flag=$2
    local min_version=$3
    
    if command -v "$cmd" >/dev/null 2>&1; then
        if [[ -n "$version_flag" ]]; then
            local version=$($cmd $version_flag 2>/dev/null | head -1)
            echo "${GREEN}✅${NC} $cmd: $version"
        else
            echo "${GREEN}✅${NC} $cmd: available"
        fi
    else
        echo "${RED}❌${NC} $cmd: not found"
        ERRORS=$((ERRORS + 1))
    fi
}

echo ""
echo "🛠️  Checking Required Tools"
echo "-------------------------"

# Check bash version
if [[ -n "$BASH_VERSION" ]]; then
    echo "${GREEN}✅${NC} bash: $BASH_VERSION"
    
    # Extract major version
    BASH_MAJOR=$(echo "$BASH_VERSION" | cut -d. -f1)
    if [[ "$BASH_MAJOR" -lt 4 ]]; then
        echo "${YELLOW}⚠️${NC}  Warning: bash version 4.0+ recommended, you have $BASH_VERSION"
    fi
else
    echo "${RED}❌${NC} bash: version not detected"
    ERRORS=$((ERRORS + 1))
fi

# Check other required tools
check_command "git" "--version"
check_command "sed" ""
check_command "find" ""
check_command "grep" ""
check_command "date" ""
check_command "chmod" ""
check_command "mkdir" ""

echo ""
echo "🌐 Checking Network Tools (for one-line install)"
echo "-----------------------------------------------"

check_command "curl" "--version"
if ! command -v curl >/dev/null 2>&1; then
    check_command "wget" "--version"
fi

echo ""
echo "🖥️  System Information"
echo "--------------------"
echo "${GREEN}Platform:${NC} $OSTYPE"
echo "${GREEN}Shell:${NC} $SHELL"
echo "${GREEN}Working Directory:${NC} $(pwd)"

# Check if current directory is writable
if [[ -w "." ]]; then
    echo "${GREEN}✅${NC} Current directory is writable"
else
    echo "${RED}❌${NC} Current directory is not writable"
    ERRORS=$((ERRORS + 1))
fi

# Check if .git exists (optional)
if [[ -d ".git" ]]; then
    echo "${GREEN}✅${NC} Git repository detected"
    
    # Check git status
    if git rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || "unknown")
        echo "${GREEN}📍${NC} Current branch: $BRANCH"
    fi
else
    echo "${YELLOW}⚠️${NC}  No git repository (git hooks will be skipped)"
fi

echo ""
echo "🧪 Testing Basic Operations"
echo "--------------------------"

# Test file creation
if touch test-claude-memory.tmp 2>/dev/null; then
    echo "${GREEN}✅${NC} File creation works"
    rm -f test-claude-memory.tmp
else
    echo "${RED}❌${NC} Cannot create files"
    ERRORS=$((ERRORS + 1))
fi

# Test directory creation
if mkdir -p test-claude-dir.tmp 2>/dev/null; then
    echo "${GREEN}✅${NC} Directory creation works"
    rmdir test-claude-dir.tmp
else
    echo "${RED}❌${NC} Cannot create directories"
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "📊 Verification Summary"
echo "====================="

if [[ $ERRORS -eq 0 ]]; then
    echo "${GREEN}🎉 All checks passed! Your system is ready for Claude Memory System.${NC}"
    echo ""
    echo "To install, run:"
    echo "  ${GREEN}curl -sSL https://raw.githubusercontent.com/eschwa3/claude-memory-system/main/install.sh | bash${NC}"
    exit 0
else
    echo "${RED}⚠️  Found $ERRORS issue(s). Please resolve before installing.${NC}"
    echo ""
    echo "Common solutions:"
    echo "• Install missing tools using your package manager"
    echo "• Use Git Bash on Windows instead of Command Prompt"
    echo "• Run in a directory where you have write permissions"
    echo "• Update bash to version 4.0+ if possible"
    echo ""
    echo "See: https://github.com/eschwa3/claude-memory-system/blob/main/docs/FAQ.md"
    exit 1
fi