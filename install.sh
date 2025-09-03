#!/bin/bash
# Claude Memory System Installer v2.0 - Complete Cross-Platform Version
# Works on Unix, Linux, macOS, and Windows (Git Bash/WSL)

set -e

PROJECT_NAME=${1:-$(basename "$PWD")}

echo "🚀 Installing Claude Memory System for: $PROJECT_NAME"
echo "📍 Platform: $OSTYPE"
echo "================================================"

# Detect OS for platform-specific commands
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
else
    OS="linux"  # Default to linux for unknown systems
fi

echo "🖥️  Detected OS: $OS"

# Function for cross-platform sed
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

# Function to get current timestamp (cross-platform)
get_timestamp() {
    if command -v gdate &> /dev/null; then
        # GNU date on macOS (if installed via homebrew)
        gdate -u +%Y-%m-%dT%H:%M:%SZ
    elif date --version >/dev/null 2>&1; then
        # GNU date on Linux
        date -u +%Y-%m-%dT%H:%M:%SZ
    else
        # BSD date on macOS or fallback
        date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ"
    fi
}

TIMESTAMP=$(get_timestamp)

# Detect if this is an existing project FIRST
IS_EXISTING_PROJECT="false"
if [ -f "package.json" ] || [ -f "requirements.txt" ] || [ -f "Gemfile" ] || [ -f "go.mod" ] || [ -f "Cargo.toml" ] || [ -f "pom.xml" ] || [ -f "build.gradle" ] || [ -f ".gitignore" ]; then
    IS_EXISTING_PROJECT="true"
    echo "📊 Detected existing project - will prompt Claude to analyze"
fi

# ================== BACKUP EXISTING FILES (BEFORE CREATING ANYTHING) ====================
# Backup existing Claude.md if it exists
if [ -f "Claude.md" ]; then
    echo ""
    echo "⚠️  Warning: Existing Claude.md found!"
    echo "   The installation will backup the current Claude.md."
    read -p "   Continue with installation? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Installation cancelled. Your files are unchanged."
        exit 1
    else
        BACKUP_NAME="Claude.md.backup-$(date +%Y%m%d-%H%M%S)"
        echo "📦 Backing up existing Claude.md to $BACKUP_NAME"
        cp Claude.md "$BACKUP_NAME"
        echo "✅ Backup created: $BACKUP_NAME"
    fi
fi

    
# .claude directory check and backup
if [ -d ".claude" ]; then
    echo ""
    echo "⚠️  Warning: Existing .claude directory found!"
    echo "   The installation will backup the current .claude directory."
    read -p "   Continue with installation? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Installation cancelled. Your files are unchanged."
        exit 1
    else
        BACKUP_DIR=".claude.backup-$(date +%Y%m%d-%H%M%S)"
        echo "📦 Backing up existing .claude directory to $BACKUP_DIR"
        cp -r .claude "$BACKUP_DIR"
        echo "✅ Backup created: $BACKUP_DIR"
    fi
fi

# NOW create directory structure (AFTER backup checks)
echo "📁 Creating complete directory structure..."
mkdir -p .claude/{longterm,context,session,knowledge,workspace/{experiments,temp/$(date +%Y-%m-%d)},tools,automation/{hooks,scripts,templates},archive/$(date +%Y-%m)}

# ================== CREATE INDEX.md ====================
cat > .claude/INDEX.md << 'EOFINDEX'
# 🗂️ Claude Memory System Index
**Purpose**: Quick reference to locate information without reading multiple files
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🎯 Quick Navigation

### Priority Files (Read First)
1. **Product Vision**: `longterm/product-overview.md` - What we're building
2. **Development Phase**: `longterm/epics.md` - Major development themes  
3. **Current Goal**: `NORTH_STAR.md` - Sprint goal and priorities
4. **Current State**: `session/current.md` - Where we left off
5. **Quick Status**: `session/validation.md` - System health

### 📍 Where to Find Information

| Need | File | Size | Description |
|------|------|------|-------------|
| **Product vision** | `longterm/product-overview.md` | ~2KB | Product vision & user needs |
| **Development roadmap** | `longterm/epics.md` | ~3KB | Feature roadmap & sprint planning |
| **Current sprint goal** | `NORTH_STAR.md` | ~2KB | What we're building NOW |
| **Where we left off** | `session/current.md` | ~3KB | Active todos and context |
| **Architecture overview** | `context/architecture.md` | ~3KB | System design, tech stack |
| **Code patterns** | `context/patterns.md` | ~2KB | Naming, style, conventions |
| **Setup instructions** | `context/environment.md` | ~2KB | Dev environment, tools |
| **Performance metrics** | `context/performance-baseline.md` | ~2KB | Targets and benchmarks |
| **Dependencies** | `context/dependencies.md` | ~2KB | External packages, APIs |
| **Recent work** | `session/log.md` | ~5KB | Session history |
| **Next session prep** | `session/handoff.md` | ~1KB | What to do next |
| **Known errors** | `knowledge/errors.md` | ~3KB | Error patterns and fixes |
| **Working solutions** | `knowledge/solutions.md` | ~3KB | Proven approaches |
| **Project commands** | `knowledge/commands.md` | ~2KB | Quick command reference |
| **Performance tips** | `knowledge/optimizations.md` | ~2KB | Speed improvements |
| **Merge conflicts** | `knowledge/merge-conflicts.md` | ~2KB | Conflict patterns |
| **Experiments** | `workspace/experiments/index.md` | ~2KB | Test results |
| **Tool effectiveness** | `tools/mcp-registry.md` | ~2KB | Which tools work best |
| **Agent usage** | `tools/agent-usage.md` | ~2KB | Sub-agent recommendations |
| **Tool cache** | `tools/tool-cache.md` | ~2KB | Performance metrics |

## 🔍 Quick Queries

### "What is this product supposed to do?"
→ Read: `longterm/product-overview.md`

### "What major features are we working on?"
→ Read: `longterm/epics.md` + `NORTH_STAR.md`

### "What should I work on?"
→ Read: `NORTH_STAR.md` + `session/current.md`

### "How do we handle errors?"
→ Read: `knowledge/errors.md` + `context/patterns.md`

### "What's the setup process?"
→ Read: `context/environment.md` + `context/dependencies.md`

### "What did we do recently?"
→ Read: `session/log.md` + `session/handoff.md`

### "How is the code organized?"
→ Read: `context/architecture.md` + `context/patterns.md`

### "What commands can I run?"
→ Read: `knowledge/commands.md`

### "What have we learned?"
→ Read: `knowledge/solutions.md` + `knowledge/errors.md`

## 📊 Token Usage Guide

### Minimal Context (Start of Session) - ~7KB total
1. `INDEX.md` (this file) - 2KB
2. `longterm/product-overview.md` - 2KB
3. `NORTH_STAR.md` - 2KB  
4. `session/current.md` - 3KB

### Task-Specific Contexts

**For Strategic Planning** - ~10KB total
- `INDEX.md` + `longterm/product-overview.md` + `longterm/epics.md` + `NORTH_STAR.md`

**For Bug Fixing** - ~7KB total
- `INDEX.md` + `knowledge/errors.md` + `session/current.md`

**For New Feature** - ~10KB total
- `INDEX.md` + `longterm/epics.md` + `NORTH_STAR.md` + `context/architecture.md` + `context/patterns.md`

**For Performance Work** - ~6KB total
- `INDEX.md` + `context/performance-baseline.md` + `knowledge/optimizations.md`

**For Code Review** - ~7KB total
- `INDEX.md` + `context/patterns.md` + `session/log.md`

## 🔄 Update Frequency

| File | Update Frequency | When to Update |
|------|-----------------|----------------|
| `session/current.md` | Every 15-30 min | During work |
| `session/log.md` | End of session | Before closing |
| `session/handoff.md` | End of session | Before closing |
| `knowledge/errors.md` | When errors occur | As discovered |
| `knowledge/solutions.md` | When solutions found | As proven |
| `NORTH_STAR.md` | Sprint changes | Weekly/biweekly |
| `context/*` | Major changes | As architecture evolves |

---
**Remember**: Start with INDEX.md to find exactly what you need. Don't read everything unless necessary!
EOFINDEX

# ================== CREATE NORTH_STAR.md ====================
cat > .claude/NORTH_STAR.md << 'EOFNORTHSTAR'
# 🎯 PROJECT NORTH STAR
**THE ONE FILE TO RULE THEM ALL**
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🚨 CURRENT SPRINT GOAL
> [One clear sentence about what we're building RIGHT NOW]

## ✅ Success Criteria
- [ ] [Specific measurable outcome]
- [ ] [Another specific outcome]
- [ ] [Third specific outcome]

## 🚫 Do NOT Work On
- ❌ [Thing that seems important but isn't right now]
- ❌ [Another distraction to avoid]
- ❌ [Third thing to ignore]

## 🤔 If Confused, Default To
1. **First**: Check failing tests and fix them
2. **Then**: Complete the current feature
3. **Finally**: Update documentation

## 📜 Project Mantras
- "Make it work, then make it pretty"
- "Test coverage before new features"
- "Document as you go"

## 🎓 Key Decisions
| Decision | Rationale | Date |
|----------|-----------|------|
| [Example: Chose React] | [Fast development] | [2024-01-01] |

## 🔗 Quick Links
- **Dev Server**: http://localhost:3000
- **API Docs**: http://localhost:3000/api/docs
- **Staging**: [URL]
- **Production**: [URL]
EOFNORTHSTAR

# ================== LONGTERM FILES ====================
# product-overview.md - different for existing vs new projects
if [ "$IS_EXISTING_PROJECT" = "true" ]; then
    cat > .claude/longterm/product-overview.md << 'EOFPRODUCTOVERVIEW'
# Product Overview
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Status**: 🔍 REQUIRES ANALYSIS

## 🚨 Claude: ANALYZE AND POPULATE THIS FILE

### Step 1: Project Discovery
Run these commands and analyze the results:
```bash
# Find project identity
find . -maxdepth 2 -name "package.json" -o -name "README*" -o -name "*.toml" -o -name "*.yaml" | head -10

# Check for documentation
find . -name "docs" -o -name "documentation" -type d
find . -name "*.md" ! -path "./.claude/*" | head -20

# Look for user-facing features
find . -type f \( -name "*.js" -o -name "*.ts" -o -name "*.py" \) -exec grep -l "user\|User\|auth\|Auth" {} \; | head -10
```

### Step 2: Fill in This Template

## 🎯 Product Identity
- **Name**: [CHECK package.json, README, or app title]
- **Tagline**: [One sentence description]
- **Problem**: [What problem does this solve?]
- **Solution**: [How does it solve it?]
- **Target Users**: [Who uses this application?]

## 🌟 Core Features
[ANALYZE CODE AND DOCUMENTATION TO IDENTIFY]
### Primary Features
- [Feature 1]: [Description]
- [Feature 2]: [Description]
- [Feature 3]: [Description]

### Secondary Features
- [Feature A]: [Description]
- [Feature B]: [Description]

## 🎨 User Experience
[ANALYZE UI/UX PATTERNS]
- **User Flow**: [Main user journey]
- **Interface Type**: [Web/Mobile/Desktop/CLI]
- **Key Interactions**: [How users interact]

## 📊 Success Metrics
[LOOK FOR ANALYTICS, LOGGING, OR METRICS CODE]
- **Primary**: [Main success indicator]
- **Secondary**: [Supporting metrics]
- **Technical**: [Performance/reliability metrics]

## 🔑 Value Proposition
[DETERMINE FROM ANALYSIS]
- **For Users**: [What value users get]
- **Differentiator**: [What makes this unique]
- **Business Value**: [Why this matters]

## 🎓 Key Constraints
[IDENTIFY FROM CODE/CONFIG]
- **Technical**: [Platform/technology limitations]
- **Business**: [Budget/time constraints]
- **User**: [Usability requirements]
EOFPRODUCTOVERVIEW
else
    cat > .claude/longterm/product-overview.md << 'EOFPRODUCTOVERVIEW'
# Product Overview
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🎯 Product Identity
- **Name**: PROJECT_NAME_PLACEHOLDER
- **Tagline**: [One sentence description of what this does]
- **Problem**: [What problem does this solve?]
- **Solution**: [How does your product solve it?]
- **Target Users**: [Who will use this application?]

## 🌟 Core Features
### Primary Features
- **Feature 1**: [Main feature description]
- **Feature 2**: [Second major feature]
- **Feature 3**: [Third key feature]

### Secondary Features
- **Feature A**: [Supporting feature]
- **Feature B**: [Nice-to-have feature]
- **Feature C**: [Future enhancement]

## 🎨 User Experience
- **User Flow**: [Describe main user journey]
- **Interface Type**: [Web App/Mobile/Desktop/CLI/API]
- **Key Interactions**: [How users interact with the product]
- **Design Principles**: [UX guidelines to follow]

## 📊 Success Metrics
- **Primary**: [Main KPI - downloads/users/revenue/etc.]
- **Secondary**: [Supporting metrics - engagement/retention/etc.]
- **Technical**: [Performance targets - speed/uptime/etc.]

## 🔑 Value Proposition
- **For Users**: [What value do users get?]
- **Differentiator**: [What makes this unique?]
- **Market Position**: [How does this fit in the market?]

## 🎓 Key Constraints
- **Technical**: [Platform limitations, performance requirements]
- **Business**: [Budget constraints, timeline, resources]
- **User**: [Accessibility requirements, usability standards]
- **Regulatory**: [Compliance requirements, data privacy]

## 🚀 Vision Statement
> [One paragraph describing the long-term vision for this product]

## 📋 Assumptions
- [Key assumption about users]
- [Key assumption about market]
- [Key assumption about technology]
EOFPRODUCTOVERVIEW
fi

# epics.md - different for existing vs new projects  
if [ "$IS_EXISTING_PROJECT" = "true" ]; then
    cat > .claude/longterm/epics.md << 'EOFEPICS'
# Development Epics
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Status**: 🔍 REQUIRES ANALYSIS

## 🚨 Claude: ANALYZE AND POPULATE THIS FILE

### Step 1: Discover Current Development State
Run these commands to understand the development phase:
```bash
# Check recent work patterns
git log --oneline -20
git branch -a

# Look for feature branches
git branch | grep -E "feature|feat|epic"

# Check for project planning files
find . -name "ROADMAP*" -o -name "CHANGELOG*" -o -name "TODO*" -o -name "*plan*" | head -10

# Look for issue tracking or project boards
find . -name ".github" -type d
ls -la .github/ 2>/dev/null
```

### Step 2: Fill in This Template

## 📊 Epic Status Overview
| Epic | Status | Progress | Target Date |
|------|--------|----------|-------------|
| [Epic 1] | [Active/Planned/Complete] | [0-100%] | [Date] |
| [Epic 2] | [Active/Planned/Complete] | [0-100%] | [Date] |

## 🏃‍♂️ Active Epics
[IDENTIFY FROM GIT HISTORY AND CODE ANALYSIS]

### EPIC-1: [Name from analysis]
**Status**: 🟡 In Progress
**Start Date**: [Estimated from git history]
**Target Date**: [Estimate based on scope]
**Description**: [What this epic accomplishes]

**Acceptance Criteria**:
- [ ] [Criteria 1 based on code analysis]
- [ ] [Criteria 2 based on requirements found]
- [ ] [Criteria 3 based on patterns seen]

**Dependencies**:
- [Dependency 1]
- [Dependency 2]

**Current Blockers**:
- [Any blockers found in TODO/FIXME comments]

---

## 📅 Planned Epics
[LOOK FOR TODO COMMENTS, ISSUE TRACKERS, OR ROADMAP FILES]

### EPIC-2: [Name from planning documents]
**Status**: 🔵 Planned
**Priority**: High/Medium/Low
**Estimated Duration**: [Duration estimate]
**Description**: [What this will accomplish]

**Prerequisites**:
- [ ] [What needs to be done first]

---

## ✅ Completed Epics
[CHECK GIT HISTORY FOR MAJOR COMPLETED FEATURES]

### EPIC-0: [Name from git history analysis]
**Status**: ✅ Completed
**Completed**: [Date from git log]
**Description**: [What was accomplished]

**Key Learnings**:
- [Learning from completed work]
- [Technical insights gained]

---

## 🗺️ Epic Dependencies
```mermaid
graph TD
    A[Epic 1] --> B[Epic 2]
    B --> C[Epic 3]
    D[Infrastructure] --> A
    D --> B
```

## 📈 Progress Tracking
- **Overall Project**: [X]% complete
- **Current Sprint**: [Epic name and progress]
- **Next Milestone**: [Target and date]

## 🎯 Epic Success Metrics
| Epic | Success Metric | Target | Current |
|------|---------------|---------|---------|
| [Epic] | [Metric] | [Target] | [Current] |
EOFEPICS
else
    cat > .claude/longterm/epics.md << 'EOFEPICS'
# Development Epics
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 📊 Epic Status Overview
| Epic | Status | Progress | Target Date |
|------|--------|----------|-------------|
| Setup & Foundation | 🟡 Active | 20% | Week 2 |
| Core Features | 🔵 Planned | 0% | Week 6 |
| Polish & Launch | 🔵 Planned | 0% | Week 12 |

## 🏃‍♂️ Active Epics

### EPIC-1: Setup & Foundation
**Status**: 🟡 In Progress  
**Start Date**: [Today's date]
**Target Date**: [2 weeks from now]
**Description**: Establish project foundation, development environment, and core architecture

**Acceptance Criteria**:
- [ ] Development environment fully configured
- [ ] Core architecture implemented
- [ ] Basic CI/CD pipeline set up
- [ ] Testing framework in place
- [ ] Documentation started

**Dependencies**:
- Technology stack decisions finalized
- Development tools installed

**Current Blockers**:
- None

---

## 📅 Planned Epics

### EPIC-2: Core Features
**Status**: 🔵 Planned
**Priority**: High
**Estimated Duration**: 4 weeks
**Description**: Implement the main features that deliver core user value

**Acceptance Criteria**:
- [ ] [Primary feature 1] implemented
- [ ] [Primary feature 2] implemented
- [ ] [Primary feature 3] implemented
- [ ] User authentication working
- [ ] Data persistence implemented

**Prerequisites**:
- [ ] Foundation epic completed
- [ ] Architecture decisions finalized

---

### EPIC-3: Polish & Launch
**Status**: 🔵 Planned
**Priority**: Medium
**Estimated Duration**: 6 weeks
**Description**: Polish the user experience and prepare for launch

**Acceptance Criteria**:
- [ ] UI/UX polished and responsive
- [ ] Performance optimized
- [ ] Security audit completed
- [ ] Documentation comprehensive
- [ ] Deployment automation working

**Prerequisites**:
- [ ] Core features epic completed
- [ ] Testing coverage >80%

---

## ✅ Completed Epics
*No completed epics yet - project just started*

---

## 🗺️ Epic Dependencies
```mermaid
graph TD
    A[Setup & Foundation] --> B[Core Features]
    B --> C[Polish & Launch]
    D[Architecture Decisions] --> A
    A --> E[Testing Framework]
    E --> B
```

## 📈 Progress Tracking
- **Overall Project**: 5% complete (just started)
- **Current Sprint**: Setup & Foundation
- **Next Milestone**: Working development environment

## 🎯 Epic Success Metrics
| Epic | Success Metric | Target | Current |
|------|---------------|---------|---------|
| Foundation | Dev environment ready | 100% setup | 20% |
| Core Features | Features implemented | All 3 features | 0 |
| Polish & Launch | Launch-ready product | Deployed live | Not started |

## 📝 Epic Planning Notes
### How to Use This File
- **Update status regularly** as work progresses
- **Add new epics** when requirements change
- **Mark epics complete** and capture learnings
- **Adjust timelines** based on actual progress
- **Track dependencies** to avoid blockers

### Epic Lifecycle
1. **Planned** 🔵 - Defined but not started
2. **Active** 🟡 - Currently being worked on  
3. **Blocked** 🔴 - Waiting on dependencies
4. **Completed** ✅ - Done with learnings captured

### Adding New Epics
```markdown
### EPIC-N: [Epic Name]
**Status**: 🔵 Planned
**Priority**: High/Medium/Low
**Estimated Duration**: X weeks
**Description**: [What this epic accomplishes]

**Acceptance Criteria**:
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]

**Prerequisites**:
- [ ] [What must be done first]
```
EOFEPICS
fi

# ================== CONTEXT FILES ====================
# architecture.md - different for existing vs new projects
if [ "$IS_EXISTING_PROJECT" = "true" ]; then
    cat > .claude/context/architecture.md << 'EOFARCH'
# System Architecture
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Status**: 🔍 REQUIRES ANALYSIS

## 🚨 Claude: ANALYZE AND POPULATE THIS FILE

### Step 1: Project Discovery
Run these commands and document findings:
```bash
# Find project type
ls -la
find . -maxdepth 2 -type f \( -name "*.json" -o -name "*.toml" -o -name "*.yaml" \) | head -20

# Examine main files
find . -type f \( -name "index.*" -o -name "main.*" -o -name "app.*" \) | head -10
```

### Step 2: Fill in This Template

## 🏗️ Project Identity
- **Name**: [CHECK package.json, go.mod, or similar]
- **Type**: [Determine: Web App/API/Library/CLI/Mobile/Desktop]
- **Purpose**: [Read README.md or analyze code to determine]
- **Started**: [Check git log --reverse | head -1]
- **Stage**: [Development/Beta/Production - check for .env files]

## 🎨 Architecture Overview
[ANALYZE THE CODE AND CREATE A DIAGRAM]

## 📚 Technology Stack
### Core Technologies
- **Language**: [Detect from file extensions and package files]
- **Framework**: [Check dependencies]
- **Database**: [Look for database config files or .env]
- **Testing**: [Check for test directories and test dependencies]

### File Structure
[ANALYZE AND DOCUMENT]

## 🔑 Key Components
[IDENTIFY MAIN COMPONENTS BY ANALYZING THE CODE]

## 🚨 Critical Paths
[TRACE THROUGH CODE TO FIND CRITICAL USER FLOWS]
EOFARCH
else
    cat > .claude/context/architecture.md << 'EOFARCH'
# System Architecture
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🏗️ Project Identity
- **Name**: PROJECT_NAME_PLACEHOLDER
- **Type**: [Web App/API/Library/CLI Tool]
- **Purpose**: [What this project does in one sentence]
- **Started**: $(date +%Y-%m-%d)
- **Stage**: [Development/Beta/Production]

## 🎨 Architecture Overview
```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Frontend  │────▶│     API     │────▶│   Database  │
└─────────────┘     └─────────────┘     └─────────────┘
```

## 📚 Technology Stack
### Core Technologies
- **Language**: [Primary language]
- **Framework**: [Main framework]
- **Database**: [Database type]
- **Testing**: [Test framework]

### File Structure
```
src/
├── index.js         # Entry point
├── components/      # UI components
├── services/        # Business logic
├── models/          # Data models
└── tests/           # Test files
```

## 🔑 Key Design Decisions
| Decision | Rationale | Date | Impact |
|----------|-----------|------|--------|
| [Example] | [Why] | [When] | [Result] |

## 🚨 Critical Paths
1. **User Flow**: entry → auth → dashboard
2. **Data Flow**: request → validate → process → respond
EOFARCH
fi

# patterns.md
cat > .claude/context/patterns.md << 'EOFPATTERNS'
# Code Patterns & Conventions
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 📝 Naming Conventions
- **Variables**: camelCase
- **Functions**: camelCase
- **Classes**: PascalCase
- **Files**: kebab-case
- **Constants**: UPPER_SNAKE_CASE

## 🎨 Code Style
```javascript
// Standard function pattern
const functionName = async (param1, param2) => {
  try {
    // Implementation
    return result;
  } catch (error) {
    console.error('Error in functionName:', error);
    throw error;
  }
};
```

## 🧪 Testing Pattern
```javascript
describe('ComponentName', () => {
  it('should do something specific', () => {
    // Arrange
    // Act
    // Assert
  });
});
```

## 📁 File Organization
- One component per file
- Related files in same directory
- Tests next to implementation
- Shared utilities in utils/

## 🔄 Git Commit Patterns
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Formatting
- refactor: Code restructuring
- test: Adding tests
- chore: Maintenance
EOFPATTERNS

# environment.md
cat > .claude/context/environment.md << 'EOFENV'
# Development Environment
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🛠️ Required Tools
- Node.js: v18+ (or your language/version)
- npm: v9+ (or your package manager)
- Git: v2.30+

## 🔧 Setup Instructions
```bash
# 1. Install dependencies
npm install

# 2. Copy environment file
cp .env.example .env

# 3. Start development server
npm run dev
```

## 📋 Environment Variables
```bash
# Required (don't commit actual values!)
DATABASE_URL=
API_KEY=
NODE_ENV=development
PORT=3000
```

## 🐛 Common Setup Issues
| Issue | Solution |
|-------|----------|
| Port already in use | kill -9 $(lsof -t -i:3000) |
| Dependencies missing | rm -rf node_modules && npm install |
| Database connection failed | Check DATABASE_URL in .env |
| Permission denied | Check file permissions with ls -la |

## 🖥️ IDE Configuration
### VS Code Extensions
- ESLint
- Prettier
- GitLens

### Settings
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```
EOFENV

# performance-baseline.md
cat > .claude/context/performance-baseline.md << 'EOFPERF'
# Performance Baselines
**Last Updated**: TIMESTAMP_PLACEHOLDER

## ⚡ Target Metrics
| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Page Load | <2s | TBD | 🟡 |
| API Response | <200ms | TBD | 🟡 |
| Build Time | <60s | TBD | 🟡 |
| Test Suite | <5min | TBD | 🟡 |
| Bundle Size | <500KB | TBD | 🟡 |
| Memory Usage | <512MB | TBD | 🟡 |

## 🔍 Known Bottlenecks
- [Identify any known slow areas]

## 📊 Optimization Opportunities
- [ ] Implement caching
- [ ] Optimize bundle size
- [ ] Add lazy loading
- [ ] Database query optimization
- [ ] Image optimization

## 📈 Performance History
| Date | Metric | Value | Notes |
|------|--------|-------|-------|
| [Date] | [Metric] | [Value] | [What changed] |
EOFPERF

# dependencies.md
cat > .claude/context/dependencies.md << 'EOFDEPS'
# External Dependencies
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 📦 Package Dependencies
### Production Dependencies
| Package | Version | Purpose | License |
|---------|---------|---------|---------|
| [package] | [version] | [why needed] | [MIT/Apache/etc] |

### Development Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| [package] | [version] | [why needed] |

## 🔗 External APIs
| Service | Purpose | Auth Type | Rate Limits |
|---------|---------|-----------|-------------|
| [API Name] | [What it does] | [OAuth/Key/JWT] | [Requests/min] |

## 🌐 CDN Resources
| Resource | Version | Purpose | Fallback |
|----------|---------|---------|----------|
| [CDN URL] | [version] | [why needed] | [local fallback] |

## 🔄 Update Policy
- Security updates: Immediate
- Major versions: Quarterly review
- Minor versions: Monthly
- Patches: Automatic

## ⚠️ Known Issues
| Dependency | Issue | Workaround | Fix ETA |
|------------|-------|------------|---------|
| [package] | [issue description] | [temporary fix] | [date] |
EOFDEPS

# ================== SESSION FILES ====================
# current.md - different for existing vs new projects
if [ "$IS_EXISTING_PROJECT" = "true" ]; then
    cat > .claude/session/current.md << 'EOFCURRENT'
# Current Session State
**Session Started**: TIMESTAMP_PLACEHOLDER
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Branch**: main
**Focus**: 🔍 ANALYZING EXISTING PROJECT

## 🚨 CRITICAL: INITIAL ANALYSIS REQUIRED
**Claude, you MUST complete this analysis before any other work:**

### 📋 Analysis Checklist
1. **Project Discovery** (REQUIRED)
   - [ ] Identify project type (web app, API, library, etc.)
   - [ ] Determine primary language and framework
   - [ ] Find entry point files (main, index, app, etc.)
   - [ ] Identify package manager and dependencies

2. **Architecture Analysis** (REQUIRED)
   - [ ] Map out directory structure
   - [ ] Identify core components/modules
   - [ ] Document data flow
   - [ ] Find configuration files
   - [ ] Update .claude/context/architecture.md with findings

3. **Pattern Recognition** (REQUIRED)
   - [ ] Identify coding style and conventions
   - [ ] Find common patterns used
   - [ ] Document file naming conventions
   - [ ] Update .claude/context/patterns.md with findings

4. **Environment Setup** (REQUIRED)
   - [ ] Check for .env.example or config files
   - [ ] Identify required environment variables
   - [ ] Document development setup steps
   - [ ] Update .claude/context/environment.md with findings

5. **Current State Assessment** (REQUIRED)
   - [ ] Check for existing tests
   - [ ] Run tests if they exist
   - [ ] Check for build/compile errors
   - [ ] Identify any TODO/FIXME comments
   - [ ] Check git status for uncommitted changes

## 🎯 Active Todo List
- [ ] Complete full project analysis (see checklist above)
- [ ] Update all context files with discoveries
- [ ] Set appropriate sprint goal in NORTH_STAR.md
- [ ] Document any immediate issues found
- [ ] Create initial session log entry

## 📍 Current Context
### What We're Analyzing
> Analyzing existing project structure to populate memory system

### Files to Examine First
```yaml
priority_files:
  - package.json / requirements.txt / go.mod / etc.
  - README.md or README.*
  - src/index.* or main.* or app.*
  - .env.example or config files
  - test directories
  - .gitignore
```

## 💾 Session Variables
```json
{
  "analysis_started": "TIMESTAMP_PLACEHOLDER",
  "project_files_found": 0,
  "analysis_complete": false,
  "memory_populated": false
}
```
EOFCURRENT
else
    cat > .claude/session/current.md << 'EOFCURRENT'
# Current Session State
**Session Started**: TIMESTAMP_PLACEHOLDER
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Branch**: main
**Focus**: New project initialization

## 🎯 Active Todo List
- [x] Initialize Claude Memory System
- [ ] Set up project structure
- [ ] Create initial files
- [ ] Set up development environment
- [ ] Define project architecture

## 📍 Current Context
### What We're Building
> Starting a new project with Claude Memory System

### Files in Focus
```yaml
primary: ".claude/NORTH_STAR.md"
secondary: "README.md"
config: "package.json"
```

### Current Approach
1. Initialize memory system ✅
2. Define project requirements
3. Set up development environment
4. Create initial structure

## 🚧 Blockers & Decisions
| Decision Needed | Options | Recommendation |
|----------------|---------|----------------|
| Project type | Web app, API, Library, CLI | Define based on requirements |
| Language/Framework | Node/React, Python/Django, etc. | Choose based on needs |
| Database | PostgreSQL, MongoDB, SQLite | Depends on data structure |

## 💾 Session Variables
```json
{
  "git_branch": "main",
  "project_initialized": true,
  "memory_system_ready": true,
  "tests_passing": null,
  "server_running": false
}
```

## 📝 Session Notes
- Memory system initialized for new project
- Ready to begin development
- Awaiting project requirements and goals
EOFCURRENT
fi

# log.md
cat > .claude/session/log.md << 'EOFLOG'
# Session Log
**Project Started**: $(date +%Y-%m-%d)

---

## $(date +%Y-%m-%d) - Session 1
**Duration**: $(date +%H:%M) - [End Time]
**Focus**: Initial Setup

### Accomplished
- [x] Installed Claude Memory System
- [x] Created directory structure
- [x] Initialized memory files

### Discovered
- [Key findings will be documented here]

### Issues Encountered
- [Any problems and their solutions]

### Files Modified
- `.claude/*` - Initial setup

### Next Session
- Review existing codebase (if applicable)
- Set sprint goals in NORTH_STAR.md
- Begin feature development

---
EOFLOG

# handoff.md
cat > .claude/session/handoff.md << 'EOFHANDOFF'
# Session Handoff Notes
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🎯 Next Session Should
1. Read NORTH_STAR.md for current goal
2. Check current.md for exact position
3. Continue from where we left off

## 📋 Quick Status
- **Last Action**: Initialized memory system
- **Next Action**: Begin development
- **Blocked By**: Nothing

## 🔄 State to Restore
```bash
# Commands to run at session start
npm install  # If needed
npm run dev  # Start dev server
```

## 📝 Context for Next Session
- [Important context to remember]
- [Any decisions made]
- [Things to be aware of]
EOFHANDOFF

# validation.md
cat > .claude/session/validation.md << 'EOFVALIDATION'
# Memory System Validation
**Last Validated**: TIMESTAMP_PLACEHOLDER
**Status**: ✅ VALID

## 🔍 Validation Checklist
- [x] Directory structure created
- [x] Memory files initialized
- [x] Git hooks installed
- [x] Claude.md present
- [ ] First development session completed

## 📊 System Health
| Component | Status | Last Updated |
|-----------|--------|--------------|
| INDEX.md | ✅ Active | Just now |
| current.md | ✅ Active | Just now |
| NORTH_STAR.md | ✅ Ready | Just now |
| architecture.md | ✅ Initialized | Just now |
| patterns.md | ✅ Created | Just now |

## 🔐 File Integrity
```yaml
memory_version: "2.0.0"
installation_date: "$(date +%Y-%m-%d)"
last_validation: "TIMESTAMP_PLACEHOLDER"
schema_intact: true
```

## 🚨 Validation Errors
```markdown
# No errors detected
```

## 🔧 Validation Commands
```bash
# Quick validation
.claude/automation/scripts/validate.sh

# Full validation with repair
.claude/automation/scripts/validate.sh --repair

# Clean old files
.claude/automation/scripts/prune.sh
```
EOFVALIDATION

# ================== KNOWLEDGE FILES ====================
cat > .claude/knowledge/errors.md << 'EOFERRORS'
# Error Pattern Library
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Total Patterns**: 0

## 🔴 Critical Errors
_No errors documented yet_

## 🟡 Common Warnings
_No warnings documented yet_

## 🟢 Resolved Issues
_No resolved issues yet_

## 📝 Error Template
```markdown
### Error: [Error message]
**Date**: [First occurrence]
**Frequency**: [Low/Medium/High]
**Category**: [Build/Runtime/Test/Deploy]
**Root Cause**: [Why it happens]
**Solution**:
\```bash
# Fix commands
\```
**Prevention**: [How to avoid]
**Related Issues**: [Links to issues/PRs]
```

## 📊 Error Decision Tree
```mermaid
graph TD
    A[Error Occurs] --> B{Build Error?}
    B -->|Yes| C[Check package.json]
    B -->|No| D{Runtime Error?}
    C --> E[Run npm install]
    D -->|Yes| F{Type Error?}
    D -->|No| G{Network Error?}
    F --> H[Check null handling]
    G --> I[Check API status]
```
EOFERRORS

cat > .claude/knowledge/solutions.md << 'EOFSOLUTIONS'
# Working Solutions
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Total Solutions**: 0

## ✅ Proven Solutions
_No solutions documented yet_

## 🧪 Experimental Solutions
_No experiments documented yet_

## 📝 Solution Template
```markdown
### Problem: [Description]
**Date Solved**: [Date]
**Solution Type**: [Performance/Bug Fix/Feature/Architecture]
**Implementation**:
\```javascript
// Code solution
\```
**Results**: [Measurable improvement]
**Side Effects**: [Any tradeoffs]
**Future Improvements**: [Potential optimizations]
```

## 🏆 Best Practices Discovered
- [Best practice will be documented here]

## 📚 Reusable Code Snippets
```javascript
// Useful snippets will be collected here
```
EOFSOLUTIONS

cat > .claude/knowledge/optimizations.md << 'EOFOPT'
# Performance Optimizations
**Last Updated**: TIMESTAMP_PLACEHOLDER

## ⚡ Implemented Optimizations
_No optimizations implemented yet_

## 🎯 Planned Optimizations
- [ ] [Optimization to implement]
- [ ] [Another optimization]

## 📊 Performance Gains
| Optimization | Before | After | Improvement | Date |
|--------------|--------|-------|-------------|------|
| [What was optimized] | [Metric] | [Metric] | [%] | [Date] |

## 🔧 Optimization Techniques
### Frontend
- Code splitting
- Lazy loading
- Bundle optimization
- Caching strategies

### Backend
- Query optimization
- Caching layers
- Connection pooling
- Async processing

### Database
- Index optimization
- Query optimization
- Denormalization where appropriate
- Connection pooling

## 📝 Optimization Template
```markdown
### Optimization: [Name]
**Type**: [Frontend/Backend/Database/Infrastructure]
**Impact**: [High/Medium/Low]
**Effort**: [High/Medium/Low]
**Metrics**:
- Before: [measurement]
- After: [measurement]
- Improvement: [percentage]
**Implementation**: [How it was done]
**Tradeoffs**: [Any downsides]
```
EOFOPT

cat > .claude/knowledge/merge-conflicts.md << 'EOFMERGE'
# Merge Conflict Resolution Patterns
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🔄 Common Conflict Patterns
### package-lock.json / yarn.lock
**Resolution**: Always regenerate
```bash
rm package-lock.json
npm install
```

### Import statements
**Resolution**: Combine both sets of imports, remove duplicates

### Configuration files
**Resolution**: Carefully merge, keeping all necessary settings

## 📝 Conflict Resolution Log
| Date | Files | Branches | Resolution | Notes |
|------|-------|----------|------------|-------|
| [Date] | [Files] | [branch1 → branch2] | [How resolved] | [Any issues] |

## 🛠️ Resolution Strategies
1. **Always pull latest main** before starting work
2. **Make small, focused commits** to reduce conflicts
3. **Communicate** about shared files
4. **Use feature flags** for parallel development

## 🚨 Danger Zones
- Database migrations (always review carefully)
- Configuration files (can break deployments)
- Package files (can introduce vulnerabilities)

## 📋 Conflict Resolution Checklist
- [ ] Understand both changes
- [ ] Test after resolution
- [ ] Run linter/formatter
- [ ] Verify no functionality lost
- [ ] Update documentation if needed
EOFMERGE

cat > .claude/knowledge/commands.md << 'EOFCOMMANDS'
# Project Commands
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🚀 Development
```bash
# Start development
npm run dev

# Run tests
npm test

# Build project
npm run build

# Type checking
npm run type-check

# Linting
npm run lint

# Format code
npm run format
```

## 🔧 Debugging
```bash
# Debug mode
npm run dev:debug

# Check for issues
npm run lint

# Fix formatting
npm run format:fix

# Clean install
rm -rf node_modules package-lock.json && npm install

# Clear all caches
npm cache clean --force
```

## 🧹 Maintenance
```bash
# Update dependencies
npm update

# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Check outdated packages
npm outdated

# Clean build
npm run clean
```

## 🚨 Emergency
```bash
# Kill all node processes
killall node

# Reset git changes
git reset --hard HEAD

# Revert last commit
git revert HEAD

# Force rebuild
npm rebuild

# Clear all caches
npm cache clean --force
```

## 📊 Analysis
```bash
# Bundle size analysis
npm run analyze

# Test coverage
npm run test:coverage

# Performance profiling
npm run profile

# Dependency graph
npm ls --depth=0
```

## 🔍 Search Commands
```bash
# Find TODO comments
grep -r "TODO\|FIXME\|HACK" --exclude-dir=node_modules .

# Find large files
find . -type f -size +1M ! -path "./node_modules/*"

# Find recently modified
find . -type f -mtime -1 ! -path "./node_modules/*"
```

## 🎯 Project-Specific Shortcuts
```bash
# Add custom shortcuts here as you discover them
```
EOFCOMMANDS

# ================== WORKSPACE FILES ====================
cat > .claude/workspace/experiments/index.md << 'EOFEXP'
# Experiments Registry
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Total Experiments**: 0
**Success Rate**: N/A

## 🔬 Active Experiments
_No active experiments_

## ✅ Successful Experiments
_No completed experiments_

## ❌ Failed Experiments
_No failed experiments_

## 📝 Experiment Template
```markdown
### EXP-XXX: [Title]
**Date**: [Start date]
**Status**: 🟡 In Progress | ✅ Success | ❌ Failed
**Branch**: exp/[feature-name]
**Hypothesis**: [What we expect]
**Success Criteria**: [Measurable outcome]
**Files**:
- experiments/YYYY-MM-DD/[filename]
**Results**: [Actual outcome]
**Decision**: [ ] Implement | [ ] Reject | [ ] Modify
**Learnings**: [Key takeaways]
```

## 📊 Experiment Metrics
| Category | Count | Success Rate | Avg Duration |
|----------|-------|--------------|--------------|
| Performance | 0 | - | - |
| UX | 0 | - | - |
| Architecture | 0 | - | - |
| Testing | 0 | - | - |

## 🗂️ Archive Policy
- Successful experiments: Keep for 30 days, then archive
- Failed experiments: Keep for 7 days, then archive
- Archive location: `.claude/archive/YYYY-MM/experiments/`
EOFEXP

# ================== TOOLS FILES ====================
cat > .claude/tools/mcp-registry.md << 'EOFMCP'
# MCP Tools Registry
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🛠️ Available Tools
### grep
- **Purpose**: Search for text patterns in files
- **Best For**: Finding specific strings, function names, variables
- **Effectiveness**: ⭐⭐⭐⭐⭐
- **Usage Pattern**: grep -r "pattern" --exclude-dir=node_modules .
- **Notes**: Fast for simple searches

### ripgrep (rg)
- **Purpose**: Faster alternative to grep
- **Best For**: Large codebases, complex patterns
- **Effectiveness**: ⭐⭐⭐⭐⭐
- **Usage Pattern**: rg "pattern" --type js
- **Notes**: Respects .gitignore by default

### ast-grep
- **Purpose**: Search and transform code using AST
- **Best For**: Refactoring, finding code patterns
- **Effectiveness**: ⭐⭐⭐⭐
- **Usage Pattern**: ast-grep --pattern 'console.log($$$)'
- **Notes**: Language-aware searching

## 📊 Tool Effectiveness Log
| Tool | Task | Date | Effectiveness (1-5) | Notes |
|------|------|------|-------------------|-------|
| [tool] | [what it did] | [date] | [rating] | [observations] |

## 🔗 Recommended Tool Chains
### For Bug Investigation
1. grep/rg - Find error message
2. ast-grep - Analyze code structure
3. git blame - Find recent changes

### For Refactoring
1. ast-grep - Find all instances
2. Multiple file edit - Apply changes
3. Test runner - Verify changes

### For Performance Analysis
1. Profiler - Identify bottlenecks
2. ast-grep - Find problematic patterns
3. Benchmark tool - Measure improvements

## ⚙️ Tool Configuration
```json
{
  "preferred_tools": {
    "search": ["ripgrep", "grep"],
    "refactor": ["ast-grep"],
    "debug": ["debugger", "console"]
  }
}
```
EOFMCP

cat > .claude/tools/agent-usage.md << 'EOFAGENT'
# Sub-Agent Usage Guide
**Last Updated**: TIMESTAMP_PLACEHOLDER

## 🤖 Sub-Agent Recommendations
### Code Review Agent
- **Best For**: Reviewing PRs, finding bugs, suggesting improvements
- **Trigger Conditions**: Before merging, after major changes
- **Effectiveness**: ⭐⭐⭐⭐⭐
- **Usage Notes**: Provide full context and specific concerns

### Refactoring Agent
- **Best For**: Code cleanup, pattern implementation, optimization
- **Trigger Conditions**: Technical debt sprints, performance issues
- **Effectiveness**: ⭐⭐⭐⭐
- **Usage Notes**: Clear goals and constraints needed

### Testing Agent
- **Best For**: Writing tests, improving coverage, test strategies
- **Trigger Conditions**: New features, bug fixes, low coverage
- **Effectiveness**: ⭐⭐⭐⭐
- **Usage Notes**: Provide examples of existing test patterns

## 📊 Agent Effectiveness Tracking
| Agent | Task Type | Date Used | Effectiveness | Notes |
|-------|-----------|-----------|---------------|-------|
| [agent] | [task] | [date] | [1-5 stars] | [observations] |

## 🔄 Agent Workflows
### For Complex Debugging
1. Analysis Agent - Initial investigation
2. Debug Agent - Deep dive into issue
3. Fix Agent - Implement solution
4. Test Agent - Verify fix

### For Feature Development
1. Design Agent - Architecture planning
2. Implementation Agent - Code writing
3. Test Agent - Test creation
4. Review Agent - Final review

## 📋 Agent Context Sharing
```yaml
always_provide:
  - NORTH_STAR.md
  - Current task from current.md
  - Relevant patterns.md sections
  
sometimes_provide:
  - Error history from errors.md
  - Performance baselines
  - Recent session logs
```

## 🎯 Agent Specializations
- **Performance**: Use for optimization tasks
- **Security**: Use for vulnerability assessments
- **Architecture**: Use for design decisions
- **Documentation**: Use for writing docs
EOFAGENT

cat > .claude/tools/tool-cache.md << 'EOFTOOLCACHE'
# Tool Performance Cache
**Last Updated**: TIMESTAMP_PLACEHOLDER
**Cache Version**: 1.0.0

## 📊 Performance Metrics
```json
{
  "grep": {
    "calls": 0,
    "avg_response_ms": 0,
    "success_rate": 0,
    "last_used": null,
    "effectiveness": {
      "finding_definitions": 0,
      "searching_strings": 0,
      "large_files": 0
    }
  },
  "ast-grep": {
    "calls": 0,
    "avg_response_ms": 0,
    "success_rate": 0,
    "effectiveness": {
      "syntax_search": 0,
      "refactoring": 0,
      "pattern_matching": 0
    }
  },
  "ripgrep": {
    "calls": 0,
    "avg_response_ms": 0,
    "success_rate": 0,
    "effectiveness": {
      "speed": 0,
      "accuracy": 0,
      "regex_support": 0
    }
  }
}
```

## 🔗 Optimal Tool Chains
### Bug Investigation Chain
```yaml
chain: bug_investigation
effectiveness: 0
avg_time: "0 seconds"
steps:
  1: { tool: "grep", purpose: "Find error" }
  2: { tool: "ast-grep", purpose: "Analyze structure" }
  3: { tool: "git-blame", purpose: "Find changes" }
```

### Refactoring Chain
```yaml
chain: refactoring
effectiveness: 0
avg_time: "0 seconds"
steps:
  1: { tool: "ast-grep", purpose: "Find patterns" }
  2: { tool: "multi-edit", purpose: "Apply changes" }
  3: { tool: "test", purpose: "Verify" }
```

## 📈 Effectiveness Trends
- Week 1: No data yet
- Month 1: No data yet

## 🚫 Tool Blacklist
```json
{
  "blacklisted": [],
  "reason": {}
}
```

## 🔄 Cache Invalidation Rules
- Invalidate after major version updates
- Refresh metrics weekly
- Clear if success rate < 70%
- Reset on tool configuration change
EOFTOOLCACHE

# ================== AUTOMATION SCRIPTS ====================
cat > .claude/automation/scripts/validate.sh << 'EOFVALIDATESH'
#!/bin/bash
# Claude Memory System Validation

set -e

echo "🔍 Claude Memory System Validation"
echo "=================================="

# Colors for output (work on all platforms)
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # Windows Git Bash
    RED=""
    GREEN=""
    YELLOW=""
    NC=""
else
    # Unix/Linux/Mac
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m'
fi

# Check directory structure
echo "📁 Checking directory structure..."
REQUIRED_DIRS=(
    ".claude/context"
    ".claude/session"
    ".claude/knowledge"
    ".claude/workspace"
    ".claude/tools"
    ".claude/automation"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✅ $dir exists${NC}"
    else
        echo -e "${RED}❌ $dir missing${NC}"
        exit 1
    fi
done

# Check key files
echo ""
echo "📄 Checking key files..."
REQUIRED_FILES=(
    ".claude/INDEX.md"
    ".claude/NORTH_STAR.md"
    ".claude/longterm/product-overview.md"
    ".claude/longterm/epics.md"
    ".claude/session/current.md"
    ".claude/context/architecture.md"
    "Claude.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
    else
        echo -e "${RED}❌ $file missing${NC}"
        exit 1
    fi
done

# Check git branch
echo ""
echo "🌿 Checking git status..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD)
    echo -e "${GREEN}✅ Git repository (branch: $BRANCH)${NC}"
else
    echo -e "${YELLOW}⚠️  Not a git repository${NC}"
fi

# Clean old temp files
echo ""
echo "🧹 Checking temp files..."
if [ -d ".claude/workspace/temp" ]; then
    # Cross-platform find command
    if command -v find &> /dev/null; then
        OLD_FILES=$(find .claude/workspace/temp -type f -mtime +7 2>/dev/null | wc -l | tr -d ' ')
        if [ "$OLD_FILES" -gt 0 ]; then
            echo -e "${YELLOW}⚠️  Found $OLD_FILES old temp files (>7 days)${NC}"
            if [ "$1" = "--clean" ]; then
                find .claude/workspace/temp -type f -mtime +7 -delete
                echo -e "${GREEN}✅ Cleaned old temp files${NC}"
            fi
        else
            echo -e "${GREEN}✅ No old temp files${NC}"
        fi
    else
        echo "⚠️  'find' command not available - skipping temp file check"
    fi
fi

echo ""
echo "=================================="
echo -e "${GREEN}✅ Validation complete!${NC}"
EOFVALIDATESH

cat > .claude/automation/scripts/prune.sh << 'EOFPRUNESH'
#!/bin/bash
# Claude Memory System Cleanup

echo "🧹 Claude Memory System Cleanup"
echo "================================"

# Create archive directory
ARCHIVE_DIR=".claude/archive/$(date +%Y-%m)"
mkdir -p "$ARCHIVE_DIR"

# Clean old temp files
echo "📦 Cleaning temp files older than 7 days..."
if [ -d ".claude/workspace/temp" ]; then
    if command -v find &> /dev/null; then
        find .claude/workspace/temp -type f -mtime +7 -delete 2>/dev/null
        echo "✅ Temp files cleaned"
    else
        echo "⚠️  'find' command not available"
    fi
fi

# Archive old experiments
echo "📦 Archiving old experiments..."
if [ -d ".claude/workspace/experiments" ]; then
    if command -v find &> /dev/null; then
        find .claude/workspace/experiments -type f -mtime +30 -exec mv {} "$ARCHIVE_DIR/" \; 2>/dev/null
        echo "✅ Old experiments archived"
    fi
fi

# Clean empty directories
echo "🗑️  Removing empty directories..."
if command -v find &> /dev/null; then
    find .claude -type d -empty -delete 2>/dev/null || true
fi
echo "✅ Empty directories removed"

# Report disk usage
echo ""
echo "💾 Current disk usage:"
du -sh .claude/* 2>/dev/null | sort -h || ls -la .claude/

echo ""
echo "✅ Cleanup complete!"
EOFPRUNESH

cat > .claude/automation/scripts/sync.sh << 'EOFSYNCH'
#!/bin/bash
# Claude Memory System Sync

echo "🔄 Syncing Claude Memory System"
echo "================================"

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
fi

# Get timestamp
if command -v gdate &> /dev/null; then
    DATE=$(gdate -u +%Y-%m-%dT%H:%M:%SZ)
elif date --version >/dev/null 2>&1; then
    DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)
else
    DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ")
fi

# Update Last Updated fields in markdown files
find .claude -name "*.md" -type f | while read -r file; do
    if grep -q "Last Updated" "$file"; then
        if [[ "$OS" == "mac" ]]; then
            sed -i '' "1,10s/\*\*Last Updated\*\*: .*/\*\*Last Updated\*\*: $DATE/" "$file"
        else
            sed -i "1,10s/\*\*Last Updated\*\*: .*/\*\*Last Updated\*\*: $DATE/" "$file"
        fi
        echo "✅ Updated: $file"
    fi
done

# Update git branch in current.md
if [ -f ".claude/session/current.md" ] && git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD)
    if [[ "$OS" == "mac" ]]; then
        sed -i '' "s/\*\*Branch\*\*: .*/\*\*Branch\*\*: $BRANCH/" .claude/session/current.md
    else
        sed -i "s/\*\*Branch\*\*: .*/\*\*Branch\*\*: $BRANCH/" .claude/session/current.md
    fi
    echo "✅ Updated branch: $BRANCH"
fi

echo ""
echo "✅ Sync complete!"
EOFSYNCH

# ================== GIT HOOKS ====================
cat > .claude/automation/hooks/pre-commit << 'EOFPRECOMMIT'
#!/bin/bash
# Git pre-commit hook for Claude Memory

# Don't commit temp files
if git diff --cached --name-only | grep -q "\.claude/workspace/temp"; then
    echo "❌ Error: Attempting to commit temp files"
    echo "Remove with: git reset HEAD .claude/workspace/temp/"
    exit 1
fi

# Skip timestamp updates during commits to prevent unnecessary file modifications
# Timestamps should be updated manually when needed via: .claude/automation/scripts/sync.sh

echo "✅ Claude memory check passed"
EOFPRECOMMIT

cat > .claude/automation/hooks/post-commit << 'EOFPOSTCOMMIT'
#!/bin/bash
# Git post-commit hook for Claude Memory

# Update session log with commit info
COMMIT_MSG=$(git log -1 --pretty=%B)
DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)

# Add commit entry to session log
echo "" >> .claude/session/log.md
echo "### Commit: $COMMIT_MSG" >> .claude/session/log.md
echo "**Time**: $DATE" >> .claude/session/log.md
EOFPOSTCOMMIT

# Make all scripts executable (cross-platform)
if [[ "$OS" != "windows" ]] || [[ -n "$WSL_DISTRO_NAME" ]]; then
    chmod +x .claude/automation/scripts/*.sh 2>/dev/null || true
    chmod +x .claude/automation/hooks/* 2>/dev/null || true
fi

# ================== MAIN CLAUDE.MD ====================


if [ "$IS_EXISTING_PROJECT" = "true" ]; then
    cat > Claude.md << 'EOFCLAUDEMD'
# PROJECT_NAME_PLACEHOLDER - Claude Code Instructions

## 🚨 CRITICAL: EXISTING PROJECT DETECTED - ANALYSIS REQUIRED
**THIS IS AN EXISTING PROJECT - YOU MUST ANALYZE IT FIRST**

### 🎯 TOKEN OPTIMIZATION: USE INDEX FIRST
**ALWAYS read `.claude/INDEX.md` first to locate exactly what you need**
- INDEX.md maps all information to specific files
- Only read the files you need for the current task
- This reduces token usage by 70-80%

### 🔴 MANDATORY FIRST SESSION TASK
Before ANY development work, you MUST:
1. **READ**: `.claude/INDEX.md` - File navigation map
2. **READ**: `.claude/session/current.md` - Contains your analysis checklist
3. **ANALYZE**: The entire project structure
4. **POPULATE**: All memory files with your findings
5. **UPDATE**: NORTH_STAR.md with current development goals

### 📋 Required Analysis Steps
```yaml
REQUIRED_ANALYSIS:
  1_project_discovery:
    - Identify project type and purpose
    - Find main entry points
    - Detect language and framework
    - List all dependencies
    
  2_architecture_mapping:
    - Document directory structure
    - Map component relationships
    - Identify data flow
    - Find API endpoints
    
  3_pattern_recognition:
    - Coding conventions used
    - File naming patterns
    - Testing patterns
    - Error handling patterns
    
  4_state_assessment:
    - Current git branch and status
    - Uncommitted changes
    - Test suite status
    - Build status
    
  5_populate_memory:
    - Update context/architecture.md
    - Update context/patterns.md
    - Update context/environment.md
    - Update context/dependencies.md
    - Set goals in NORTH_STAR.md
```

## 🧠 Memory System Map
```
.claude/
├── INDEX.md      ← START HERE ALWAYS
├── NORTH_STAR.md ← UPDATE with discovered goals
├── longterm/     ← ANALYZE product vision & roadmap
├── context/      ← POPULATE with architecture analysis
├── session/      ← TRACK your analysis progress
├── knowledge/    ← DOCUMENT any issues found
├── workspace/    ← USE for test scripts
└── tools/        ← CONFIGURE based on project
```

## 📏 Project Rules
1. **FIRST SESSION**: Complete full analysis
2. **ALWAYS**: Start by reading INDEX.md
3. **DOCUMENT**: Every discovery in memory files
4. **NEVER**: Skip the analysis phase
5. **VERIFY**: Analysis with validation script

---

**REMEMBER**: This is an EXISTING PROJECT. Your first job is to understand it completely and populate the memory system. Only then can you begin development work.
EOFCLAUDEMD
else
    cat > Claude.md << 'EOFCLAUDEMD'
# PROJECT_NAME_PLACEHOLDER - Claude Code Instructions

## 🚨 CRITICAL: MEMORY SYSTEM PROTOCOL
**YOU MUST FOLLOW THIS PROTOCOL AT THE START OF EVERY SESSION**

### 🎯 TOKEN OPTIMIZATION: USE INDEX FIRST
**ALWAYS read `.claude/INDEX.md` first to locate exactly what you need**
- INDEX.md maps all information to specific files
- Only read the files you need for the current task
- This reduces token usage by 70-80%

Example efficient workflow:
1. Read INDEX.md (2KB)
2. Identify needed files from index
3. Read only those specific files
Total: 5-7KB instead of 20-30KB

### 📍 Session State Recovery
```yaml
priority: HIGHEST
always_read_first:
  - .claude/INDEX.md          # Navigation map
  - .claude/NORTH_STAR.md      # Current goal
  - .claude/session/current.md  # Where we left off
  - For strategic decisions: .claude/longterm/
never_ask:
  - "What should I work on?"   # It's in NORTH_STAR.md
  - "Where did we leave off?"   # It's in current.md
```

## 🧠 Memory System Map
```
.claude/
├── INDEX.md      ← START HERE (navigation map)
├── NORTH_STAR.md ← Current sprint goal
├── longterm/     ← Product vision & development strategy
├── context/      ← Project architecture & patterns
├── session/      ← Current work state
├── knowledge/    ← Learned solutions & errors
├── workspace/    ← Experiments & temp files
└── tools/        ← Tool effectiveness
```

## 🔄 Continuous Updates (IMPORTANT!)
**During work**, update these files:
- `session/current.md` - Every 15-30 minutes
- `workspace/experiments/index.md` - When trying new things
- `knowledge/errors.md` - When hitting errors
- `knowledge/solutions.md` - When finding fixes

**End of session**, always update:
1. `session/log.md` - Summary of what was done
2. `session/handoff.md` - Next steps for tomorrow
3. `session/current.md` - Exact stopping point

## 💻 Development Commands
```bash
# Core commands
npm run dev          # Start development
npm test            # Run tests
npm run build       # Build project

# Memory commands
.claude/automation/scripts/validate.sh  # Check memory health
.claude/automation/scripts/prune.sh     # Clean old files
.claude/automation/scripts/sync.sh      # Update timestamps
```

## 📏 Project Rules
1. **ALWAYS** read INDEX.md first
2. **NEVER** commit `.claude/workspace/temp/` files
3. **FOLLOW** patterns in `.claude/context/patterns.md`
4. **CHECK** `.claude/knowledge/errors.md` before debugging
5. **UPDATE** memory files continuously

---

**REMEMBER**: The memory system is your persistent brain. Trust it, maintain it, and it will maintain you.

**ALWAYS START WITH**: `.claude/INDEX.md` → `.claude/NORTH_STAR.md` → `.claude/session/current.md`
EOFCLAUDEMD
fi

# Update project name and timestamps in all files
echo ""
echo "📝 Updating project name and timestamps..."

# Update timestamps
find .claude -type f -name "*.md" | while read -r file; do
    safe_sed "$file" "TIMESTAMP_PLACEHOLDER" "$TIMESTAMP"
done

# Update project name
find .claude -type f -name "*.md" | while read -r file; do
    safe_sed "$file" "PROJECT_NAME_PLACEHOLDER" "$PROJECT_NAME"
done
safe_sed "Claude.md" "PROJECT_NAME_PLACEHOLDER" "$PROJECT_NAME"

# Install git hooks if in a git repo
if [ -d ".git" ]; then
    echo "🔗 Installing git hooks..."
    if [[ "$OS" == "windows" ]] && [[ -z "$WSL_DISTRO_NAME" ]]; then
        # Windows without WSL - just copy
        cp .claude/automation/hooks/* .git/hooks/ 2>/dev/null || true
    else
        # Unix/Linux/Mac/WSL - copy and make executable
        cp .claude/automation/hooks/* .git/hooks/ 2>/dev/null || true
        chmod +x .git/hooks/* 2>/dev/null || true
    fi
    echo "✅ Git hooks installed"
fi

# Update .gitignore
echo "📝 Updating .gitignore..."
if [ -f ".gitignore" ]; then
    # Check if already added
    if ! grep -q "Claude Memory System" .gitignore; then
        echo "" >> .gitignore
        echo "# Claude Memory System" >> .gitignore
        echo ".claude/workspace/temp/" >> .gitignore
        echo ".claude/archive/" >> .gitignore
        echo "*.bak" >> .gitignore
        echo "✅ .gitignore updated"
    fi
else
    # Create new .gitignore
    cat > .gitignore << 'EOFGITIGNORE'
# Claude Memory System
.claude/workspace/temp/
.claude/archive/
*.bak

# Common
node_modules/
.env
.DS_Store
*.log
dist/
build/
EOFGITIGNORE
    echo "✅ .gitignore created"
fi

# Final validation
echo ""
echo "🔍 Running validation..."
bash .claude/automation/scripts/validate.sh

echo ""
echo "================================================"
echo "✅ Claude Memory System v2.0 Installed!"
echo "🖥️  Platform: $OS"
echo ""
echo "📋 CRITICAL Next Steps:"
echo "1. 🚨 FIRST: Use the setup prompts in 'Claude Memory Prompting Guide.md'"
echo "   - For NEW projects: Copy the 'NEW Projects' setup prompt"
echo "   - For EXISTING projects: Copy the 'EXISTING Projects' setup prompt"
echo "   - This step is REQUIRED for the memory system to work!"
echo "2. Review .claude/INDEX.md for efficient navigation"
echo "3. Run 'claude' to start coding"
echo ""
echo "💡 Quick Start Commands:"
echo "   cat .claude/INDEX.md                    # View navigation map"
echo "   cat .claude/NORTH_STAR.md              # See current goal"
echo "   cat .claude/session/current.md         # See current state"
echo "   .claude/automation/scripts/validate.sh # Check health"
echo ""
echo "📚 Full directory structure created:"
echo "   .claude/"
echo "   ├── INDEX.md (START HERE - Navigation Map)"
echo "   ├── NORTH_STAR.md (Current Goal)"
echo "   ├── longterm/ (2 files)"
echo "   │   ├── product-overview.md (Product Vision)"
echo "   │   └── epics.md (Development Roadmap)"
echo "   ├── context/ (5 files)"
echo "   ├── session/ (4 files)"
echo "   ├── knowledge/ (5 files)"
echo "   ├── workspace/experiments/"
echo "   ├── tools/ (3 files)"
echo "   └── automation/scripts/ (3 scripts)"
echo ""
echo "🎯 Token Usage Optimization:"
echo "   Reading INDEX.md first reduces token usage by 70-80%"
echo "   Only read the specific files you need!"
echo ""
echo "================================================"