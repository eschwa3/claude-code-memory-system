#!/bin/bash
# Claude Memory System Update Script v2.0
# Updates existing installations to current version

set -e

echo "🔄 Claude Memory System Update Utility"
echo "====================================="

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
fi

# Cross-platform sed function
safe_sed() {
    local file=$1
    local pattern=$2
    local replacement=$3
    
    if [[ "$OS" == "mac" ]]; then
        sed -i '' "s/$pattern/$replacement/g" "$file"
    else
        sed -i "s/$pattern/$replacement/g" "$file"
    fi
}

# Check if Claude Memory is installed
if [ ! -d ".claude" ]; then
    echo "❌ No .claude directory found. Please run install.sh first."
    exit 1
fi

echo "📍 Detected existing Claude Memory installation"

# Create backup
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR=".claude-backup-$TIMESTAMP"

echo "📦 Creating backup at $BACKUP_DIR..."
cp -r .claude "$BACKUP_DIR"
echo "✅ Backup created"

# Update 1: Strategic file descriptions in INDEX.md
echo ""
echo "🔧 UPDATING INDEX.MD STRATEGIC DESCRIPTIONS"
echo "==========================================="

if [ -f ".claude/INDEX.md" ]; then
    # Update product overview description
    if grep -q "App overview and features" .claude/INDEX.md; then
        safe_sed ".claude/INDEX.md" "App overview and features" "Product vision & user needs"
        echo "✅ Updated product-overview.md description"
    else
        echo "ℹ️  Product overview description already current"
    fi
    
    # Update epics description
    if grep -q "Major epics and milestones" .claude/INDEX.md; then
        safe_sed ".claude/INDEX.md" "Major epics and milestones" "Feature roadmap & sprint planning"
        echo "✅ Updated epics.md description"
    else
        echo "ℹ️  Epics description already current"
    fi
else
    echo "⚠️  INDEX.md not found - skipping"
fi

# Update 2: Strategic context in Claude.md memory system map
echo ""
echo "🔧 UPDATING CLAUDE.MD STRATEGIC CONTEXT"
echo "======================================"

if [ -f "Claude.md" ]; then
    # Add longterm/ directory to memory system map if missing
    if ! grep -q "longterm/.*Product vision" Claude.md; then
        # Find the memory system map and add longterm/ entry
        if grep -q "├── NORTH_STAR.md" Claude.md; then
            # Add after NORTH_STAR line
            safe_sed "Claude.md" "├── NORTH_STAR.md ← Current sprint goal" "├── NORTH_STAR.md ← Current sprint goal\n├── longterm/     ← Product vision & development strategy"
            echo "✅ Added strategic context to memory system map"
        else
            echo "⚠️  Could not find memory system map to update"
        fi
    else
        echo "ℹ️  Strategic context already present"
    fi
    
    # Add strategic guidance to session recovery if missing
    if ! grep -q "For strategic decisions" Claude.md; then
        # Find always_read_first section and add strategic guidance
        if grep -q "always_read_first:" Claude.md; then
            safe_sed "Claude.md" "  - .claude/session/current.md  # Where we left off" "  - .claude/session/current.md  # Where we left off\n  - For strategic decisions: .claude/longterm/"
            echo "✅ Added strategic guidance to session recovery"
        else
            echo "⚠️  Could not find session recovery section to update"
        fi
    else
        echo "ℹ️  Strategic guidance already present"
    fi
else
    echo "⚠️  Claude.md not found - skipping"
fi

# Update 3: Ensure all required directories exist
echo ""
echo "🔧 ENSURING COMPLETE DIRECTORY STRUCTURE"
echo "======================================="

REQUIRED_DIRS=(
    ".claude/longterm"
    ".claude/context"
    ".claude/session"
    ".claude/knowledge"
    ".claude/workspace/experiments"
    ".claude/workspace/temp/$(date +%Y-%m-%d)"
    ".claude/tools"
    ".claude/automation/hooks"
    ".claude/automation/scripts"
    ".claude/automation/templates"
    ".claude/archive/$(date +%Y-%m)"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "✅ Created missing directory: $dir"
    fi
done

# Update 4: Ensure all required files exist with current templates
echo ""
echo "🔧 CHECKING FOR MISSING FILES"
echo "============================"

# Create missing longterm files if they don't exist
if [ ! -f ".claude/longterm/product-overview.md" ]; then
    cat > .claude/longterm/product-overview.md << 'EOF'
# Product Overview
**Last Updated**: $(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)
**Status**: 🔍 REQUIRES ANALYSIS

## 🎯 Product Identity
- **Name**: [Analyze from package.json, README, or code]
- **Tagline**: [One sentence description]
- **Problem**: [What problem does this solve?]
- **Solution**: [How does it solve it?]
- **Target Users**: [Who uses this application?]

## 🌟 Core Features
### Primary Features
- [Feature 1]: [Description from code analysis]
- [Feature 2]: [Description from code analysis]
- [Feature 3]: [Description from code analysis]

### Secondary Features
- [Feature A]: [Description]
- [Feature B]: [Description]

## 📊 Success Metrics
- **Primary**: [Main success indicator]
- **Secondary**: [Supporting metrics]
- **Technical**: [Performance/reliability metrics]

## 🔑 Value Proposition
- **For Users**: [What value users get]
- **Differentiator**: [What makes this unique]
- **Business Value**: [Why this matters]
EOF
    echo "✅ Created missing product-overview.md"
fi

if [ ! -f ".claude/longterm/epics.md" ]; then
    cat > .claude/longterm/epics.md << 'EOF'
# Development Epics
**Last Updated**: $(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)
**Status**: 🔍 REQUIRES ANALYSIS

## 📊 Epic Status Overview
| Epic | Status | Progress | Target Date |
|------|--------|----------|-------------|
| [Epic 1] | [Active/Planned/Complete] | [0-100%] | [Date] |
| [Epic 2] | [Active/Planned/Complete] | [0-100%] | [Date] |

## 🏃‍♂️ Active Epics
### EPIC-1: [Name from analysis]
**Status**: 🟡 In Progress
**Description**: [What this epic accomplishes]

**Acceptance Criteria**:
- [ ] [Criteria 1 based on code analysis]
- [ ] [Criteria 2 based on requirements found]
- [ ] [Criteria 3 based on patterns seen]

## 📅 Planned Epics
### EPIC-2: [Name from planning documents]
**Status**: 🔵 Planned
**Priority**: High/Medium/Low
**Description**: [What this will accomplish]

## ✅ Completed Epics
### EPIC-0: [Name from git history analysis]
**Status**: ✅ Completed
**Description**: [What was accomplished]
EOF
    echo "✅ Created missing epics.md"
fi

# Update 5: Update .gitignore if needed
echo ""
echo "🔧 UPDATING .GITIGNORE"
echo "===================="

if [ -f ".gitignore" ]; then
    if ! grep -q "Claude Memory System" .gitignore; then
        echo "" >> .gitignore
        echo "# Claude Memory System" >> .gitignore
        echo ".claude/workspace/temp/" >> .gitignore
        echo ".claude/archive/" >> .gitignore
        echo "*.bak" >> .gitignore
        echo "✅ Updated .gitignore"
    else
        echo "ℹ️  .gitignore already configured"
    fi
fi

# Update 6: Install/update automation scripts
echo ""
echo "🔧 UPDATING AUTOMATION SCRIPTS"
echo "============================="

# Only create automation scripts if the automation directory exists
if [ -d ".claude/automation/scripts" ]; then
    # Create/update validate.sh if it's missing or outdated
    if [ ! -f ".claude/automation/scripts/validate.sh" ] || ! grep -q "v2.0" .claude/automation/scripts/validate.sh; then
        echo "✅ Would update validate.sh (implementation in main install.sh)"
    fi
    
    # Create/update sync.sh
    if [ ! -f ".claude/automation/scripts/sync.sh" ] || ! grep -q "v2.0" .claude/automation/scripts/sync.sh; then
        echo "✅ Would update sync.sh (implementation in main install.sh)"
    fi
fi

# Update 7: Update git hooks if git repo exists
echo ""
echo "🔧 UPDATING GIT HOOKS"
echo "===================="

if [ -d ".git" ]; then
    # Copy hooks from .claude/automation/hooks if they exist
    if [ -d ".claude/automation/hooks" ]; then
        if [ -f ".claude/automation/hooks/pre-commit" ]; then
            cp .claude/automation/hooks/pre-commit .git/hooks/
            chmod +x .git/hooks/pre-commit 2>/dev/null || true
            echo "✅ Updated pre-commit hook"
        fi
        
        if [ -f ".claude/automation/hooks/post-commit" ]; then
            cp .claude/automation/hooks/post-commit .git/hooks/
            chmod +x .git/hooks/post-commit 2>/dev/null || true
            echo "✅ Updated post-commit hook"
        fi
    fi
else
    echo "ℹ️  No git repository - skipping hook installation"
fi

# Update 8: Update timestamps in all files
echo ""
echo "🔧 UPDATING TIMESTAMPS"
echo "===================="

TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)

# Update Last Updated fields
find .claude -name "*.md" -type f | while read -r file; do
    if grep -q "Last Updated" "$file"; then
        safe_sed "$file" "\*\*Last Updated\*\*: .*" "**Last Updated**: $TIMESTAMP"
        echo "✅ Updated timestamps in $(basename "$file")"
    fi
done

# Final validation
echo ""
echo "🔍 RUNNING VALIDATION"
echo "===================="

if [ -f "audit-memory.sh" ]; then
    echo "Running automated audit..."
    bash audit-memory.sh
else
    echo "ℹ️  audit-memory.sh not found - manual validation recommended"
fi

echo ""
echo "================================================"
echo "✅ CLAUDE MEMORY SYSTEM UPDATE COMPLETE!"
echo "================================================"
echo ""
echo "📋 WHAT WAS UPDATED:"
echo "• Strategic file descriptions in INDEX.md"
echo "• Strategic context guidance in Claude.md"
echo "• Directory structure completed"
echo "• Missing files created"
echo "• Git hooks updated"
echo "• Timestamps refreshed"
echo ""
echo "📦 BACKUP LOCATION:"
echo "   $BACKUP_DIR"
echo ""
echo "🔄 RECOMMENDED NEXT STEPS:"
echo "1. Review the updates in your memory files"
echo "2. Run: bash audit-memory.sh (if available)"
echo "3. Update longterm/ files with project-specific content"
echo "4. Test the memory system with Claude"
echo ""
echo "📚 FOR HELP:"
echo "• See Claude Memory Audit Prompts.md for content quality checks"
echo "• Use Claude Memory Prompting Guide.md for usage patterns"
echo ""
echo "Update completed: $(date)"