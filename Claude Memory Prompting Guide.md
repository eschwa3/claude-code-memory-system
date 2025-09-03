# Claude Code Prompting Guide for Memory System

## 📋 Post-Installation Claude.md Cleanup Prompt

After successfully installing the Claude Memory System and completing the initial analysis, use this prompt to optimize your Claude.md file for ongoing development:

```markdown
# Post-Installation Claude.md Cleanup

Now that the memory system is fully installed and analyzed, please clean up Claude.md to focus on ongoing development workflow instead of first-time setup.

## CLEANUP INSTRUCTIONS

1. **Remove first-session analysis requirements** - The mandatory analysis checklist is no longer needed
2. **Remove memory population instructions** - All context files are now populated
3. **Keep token optimization guidance** - INDEX.md navigation is still critical
4. **Add streamlined development workflow** - Focus on daily usage patterns
5. **Preserve essential project rules** - Keep core principles but remove setup-specific content

## TARGET CLAUDE.MD STRUCTURE
The optimized Claude.md should contain only:
- Quick INDEX.md navigation reminder
- Development workflow patterns  
- Memory maintenance guidelines
- Essential project-specific rules
- Longterm memory integration notes

## EXPECTED RESULT
Reduce Claude.md from ~75 lines of setup instructions to ~25-30 lines of development-focused guidance that emphasizes:
- Starting with INDEX.md for token efficiency
- Regular memory updates during development
- Integration with longterm vision files
- Post-installation workflow patterns

Please create this streamlined version now.
```

---

# New Project Setup Prompt

## 🆕 Complete Analysis and Setup Prompt for NEW Projects

Copy and paste this entire prompt to Claude Code after installing the memory system in a new/empty project:

NOTE:  Make sure to fill in **PROJECT REQUIREMENTS:** section below with as much detail as you can.
---

```markdown
I've installed the Claude Memory System in this project. Before starting development, you MUST complete a full discovery of what already exists and properly set up the project structure.

## 📋 MANDATORY DISCOVERY AND SETUP CHECKLIST

### PHASE 1: Complete System Discovery

#### STEP 1: Read and Understand Memory System
1. **FIRST** read `.claude/INDEX.md` to understand the complete memory structure
2. Read `.claude/session/current.md` to see the current state
3. Read `.claude/NORTH_STAR.md` to check if any goals are already set
4. Read `.claude/session/validation.md` to verify system health

#### STEP 2: Discover What Already Exists
Run these discovery commands and document findings:
```bash
# Check what files already exist in the project
ls -la
find . -type f -name "*.*" ! -path "./.claude/*" ! -path "./.git/*"

# Check for any existing configuration
ls -la *.json *.yaml *.toml *.xml 2>/dev/null

# Check for existing code
find . -type f \( -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.java" -o -name "*.go" \) 2>/dev/null

# Check for existing documentation
find . -name "README*" -o -name "*.md" ! -path "./.claude/*" 2>/dev/null

# Check git status if initialized
git status 2>/dev/null || echo "No git repository"

# Check for any build artifacts or dependencies
ls -la node_modules/ vendor/ target/ build/ dist/ 2>/dev/null
```

Document your findings in `.claude/session/current.md` under "Existing Project Assets"

#### STEP 3: Analyze Available Tools and Agents
1. Read `.claude/tools/mcp-registry.md` to see available MCP tools
2. Read `.claude/tools/agent-usage.md` to understand available sub-agents
3. Read `.claude/tools/tool-cache.md` for tool performance data
4. Document which tools are applicable for this project type

### PHASE 2: Project Requirements Analysis

#### STEP 4: Define Project Specifications
Based on these requirements, determine and document:

**PROJECT REQUIREMENTS:**
[YOUR PROJECT REQUIREMENTS HERE]

Analyze and document in `.claude/context/architecture.md`:
- Project Type: [Web App/API/CLI/Library/Mobile/Desktop/Service]
- Primary Purpose: [What problem does this solve?]
- Target Users: [Who will use this?]
- Technical Constraints: [Any specific requirements?]
- Performance Requirements: [Speed/Scale/Reliability needs?]
- Security Requirements: [Auth/Encryption/Compliance needs?]

#### STEP 5: Technology Stack Selection
Based on requirements and existing assets, decide and document:
- Primary Language: [Choose based on requirements]
- Framework: [Select appropriate framework]
- Database: [If needed, which type?]
- Testing Framework: [Unit/Integration/E2E approach]
- Build Tools: [Webpack/Vite/Rollup/etc.]
- Package Manager: [npm/yarn/pnpm/pip/go mod/etc.]

Update `.claude/context/environment.md` with these decisions

### PHASE 3: Complete Memory Population

#### STEP 6: Update ALL Context Files

##### 6.1 FULLY POPULATE `.claude/context/architecture.md`
Document the planned architecture:
- System design diagram (ASCII)
- Component breakdown
- Data flow design
- API structure (if applicable)
- File organization plan
- Scalability considerations
- Security architecture

##### 6.2 ESTABLISH `.claude/context/patterns.md`
Define patterns BEFORE coding:
- Naming conventions to follow
- Code style guide
- File organization patterns
- Git commit message format
- Error handling strategy
- Testing patterns
- Documentation standards

##### 6.3 COMPLETE `.claude/context/environment.md`
Set up complete environment:
- Required tools and versions
- Installation instructions
- Environment variables needed
- IDE configuration
- Development workflow
- Debugging setup
- Hot reload configuration

##### 6.4 SET `.claude/context/performance-baseline.md`
Establish targets:
- Performance goals
- Bundle size limits
- Load time targets
- Memory usage limits
- API response time goals
- Database query limits

##### 6.5 PLAN `.claude/context/dependencies.md`
Document planned dependencies:
- Core dependencies needed
- Development tools required
- External services/APIs
- CDN resources
- Security considerations
- License compatibility

#### STEP 7: Configure Session Files

##### 7.1 UPDATE `.claude/session/current.md`
- Clear the initialization state
- Set current focus to "Project Setup"
- Create detailed TODO list for setup
- Document any existing assets found
- Set session variables for project type

##### 7.2 INITIALIZE `.claude/session/log.md`
Add entry for project initialization:
- Project type decision
- Technology choices made
- Existing assets found
- Setup steps planned

##### 7.3 PREPARE `.claude/session/handoff.md`
Document immediate next steps:
- Project structure creation
- Initial file setup
- Dependency installation
- Environment configuration

#### STEP 8: Set Up Knowledge Base

##### 8.1 PREPARE `.claude/knowledge/commands.md`
Add project-specific commands:
```bash
# Development
dev: [start command based on stack]
test: [test command based on framework]
build: [build command based on tools]
lint: [linting command]
format: [formatting command]

# Project-specific
[Add commands based on project type]
```

##### 8.2 INITIALIZE `.claude/knowledge/errors.md`
Prepare for common errors in chosen stack:
- List known issues with chosen framework
- Document common setup problems
- Prepare debugging strategies

##### 8.3 SET UP `.claude/knowledge/solutions.md`
Document planned solutions:
- Architecture decisions
- Pattern choices
- Library selections
- Performance strategies

#### STEP 9: Configure Tools for Project

##### 9.1 UPDATE `.claude/tools/mcp-registry.md`
Mark which tools are relevant:
- Which MCP tools apply to this project
- Recommended tool chains for this stack
- Tools to avoid for this project type

##### 9.2 CONFIGURE `.claude/tools/agent-usage.md`
Plan agent strategy:
- Which agents to use for different tasks
- Parallel execution opportunities
- Agent specialization for this project

#### STEP 10: Set Project Goals

##### 10.1 POPULATE `.claude/longterm/product-overview.md`
Define the complete product vision:
- Product identity and value proposition
- Target users and their needs
- Core and secondary features
- User experience principles
- Success metrics and constraints
- Long-term vision statement

#### 10.2 POPULATE `.claude/longterm/epics.md`
Plan the development roadmap:
- Break work into major epics (2-8 week chunks)
- Define acceptance criteria for each epic
- Establish dependencies between epics
- Set realistic timelines and milestones
- Plan success metrics for each epic

#### 💡 Strategic Context Files - Critical for Decision Making
The `longterm/` directory contains your **strategic context** - Claude should consult these files whenever:
- Planning features or sprints
- Making architectural decisions  
- Defining user requirements
- Prioritizing development work

These files provide the "why" behind every development decision.

#### 10.3 COMPLETELY REWRITE `.claude/NORTH_STAR.md`
Based on product-overview and first epic, set:
- Clear sprint goal for initial development (aligned with first epic)
- Success criteria for first milestone
- What NOT to work on initially
- Project mantras from product vision
- Key architectural decisions made
- Quick links (even if placeholder)

Example format:
```markdown
## 🚨 CURRENT SPRINT GOAL
> Set up foundational architecture and create first working prototype of [main feature]

## ✅ Success Criteria
- [ ] Project structure established
- [ ] Development environment working
- [ ] Basic [main feature] implemented
- [ ] Tests passing
- [ ] Documentation started

## 🚫 Do NOT Work On
- ❌ Advanced features (focus on MVP)
- ❌ Optimization (functionality first)
- ❌ Complex integrations (keep it simple initially)
```

### PHASE 4: Project Initialization

#### STEP 11: Create Project Structure
Based on your analysis, create the initial structure:

```bash
# Create source directories
mkdir -p [appropriate directories based on stack]

# Initialize package manager
[npm init -y / go mod init / poetry init / etc.]

# Create entry point
touch [index.js / main.py / app.go / etc.]

# Create initial configuration files
touch [.env.example / config.yaml / etc.]

# Set up git if not exists
git init (if needed)

# Create README.md
echo "# Project Name" > README.md
```

Document each created file in `.claude/session/log.md`

#### STEP 12: Install Core Dependencies
```bash
# Install based on chosen stack
[npm install express / pip install flask / go get gin / etc.]

# Install dev dependencies
[npm install -D typescript eslint / pip install black pytest / etc.]

# Verify installation
[npm list / pip list / go list / etc.]
```

Update `.claude/context/dependencies.md` with installed packages

#### STEP 13: Create Initial Implementation
Create the foundational code structure:
1. Entry point file with basic setup
2. Configuration management
3. Basic folder structure
4. Initial tests
5. Development scripts in package.json/Makefile

#### STEP 14: Verify Available Agents
Check which sub-agents can help with this project:
- Can UI agents help? (for web projects)
- Can API agents help? (for backend projects)
- Can data agents help? (for database work)
- Can test agents help? (always yes)

Document strategy in `.claude/tools/agent-usage.md`

#### STEP 15: Final Verification
Complete these checks:
1. ✅ All memory files updated with project-specific content
2. ✅ No "TO BE DETERMINED" placeholders remain
3. ✅ Project structure created and documented
4. ✅ Dependencies installed and recorded
5. ✅ Development environment verified working
6. ✅ Git repository initialized
7. ✅ First commit made with initial structure

### PHASE 5: Summary and Handoff

#### STEP 16: Create Setup Summary
In `.claude/session/log.md`, document:
- Project type chosen
- Technology stack selected
- Structure created
- Dependencies installed
- Tools configured
- Next steps defined

#### STEP 17: Update INDEX.md
Verify the INDEX.md accurately reflects:
- All files that now have content
- Accurate file sizes
- Correct descriptions
- Project-specific notes

## ⚠️ CRITICAL REQUIREMENTS

1. **DO NOT SKIP** discovering what already exists
2. **DO NOT ASSUME** the project is empty - check first
3. **DO NOT PROCEED** with coding until memory is fully populated
4. **DO NOT USE** generic patterns - establish project-specific ones
5. **DO NOT FORGET** to check available tools and agents

## 🎯 Success Criteria

After completing this setup, you should have:
- Complete understanding of what exists
- Fully populated memory system
- Project structure created
- Development environment working
- Clear plan for next steps
- All tools and agents configured

## 🚀 Only After Completion

Only after ALL above steps are complete, proceed with actual feature development using:
1. The patterns established in `context/patterns.md`
2. The architecture defined in `context/architecture.md`
3. The tools identified in `tools/mcp-registry.md`
4. The agents configured in `tools/agent-usage.md`

Begin the complete discovery and setup process now. Take your time to be thorough - a proper setup saves days of work later.
```

### Best Practices for New Projects

#### Sprint Planning Prompt
```markdown
I want to build [PROJECT DESCRIPTION]. Please:
1. Read .claude/INDEX.md first
2. Update .claude/NORTH_STAR.md with a clear sprint goal
3. Create a project plan in .claude/session/current.md
4. Set up the initial architecture and document it in .claude/context/architecture.md

Focus on: [SPECIFIC FIRST SPRINT GOAL]
Don't work on: [THINGS TO AVOID]
```

#### Daily Work Session Prompt
```markdown
Starting a new work session. Please:
1. Read .claude/INDEX.md to navigate files efficiently  
2. Check .claude/NORTH_STAR.md for our current goal
3. Read .claude/session/current.md to see where we left off
4. Continue with the next todo items
5. Update current.md every 15-30 minutes with progress
```

#### Feature Development Prompt
```markdown
Time to implement [FEATURE]. Please:
1. Check .claude/INDEX.md first
2. Review .claude/context/patterns.md for our code conventions
3. Check .claude/knowledge/solutions.md for any relevant patterns
4. Implement the feature
5. Document any new patterns discovered
6. Update session/current.md with progress
```

---

## 📂 For EXISTING Projects

### Initial Analysis Prompt (CRITICAL - First Time Only)
```markdown
# Exhaustive Analysis Prompt for Existing Projects

## 🔴 MANDATORY COMPLETE ANALYSIS PROMPT

Copy and paste this entire prompt to Claude Code after installing the memory system in an existing project:

---

```markdown
I've installed the Claude Memory System in this existing project. You MUST complete a FULL analysis and populate EVERY memory file before doing any other work.

## 📋 MANDATORY ANALYSIS CHECKLIST

### STEP 1: Read Navigation Files
1. Read `.claude/INDEX.md` to understand the complete memory structure
2. Read `.claude/session/current.md` to see your analysis checklist

### STEP 2: Complete Project Discovery
Analyze the ENTIRE project structure by:
1. Running `find . -type f -name "*.json" -o -name "*.toml" -o -name "*.yaml" -o -name "*.xml" | grep -v node_modules | head -50`
2. Running `ls -la` in root directory
3. Checking for README files: `find . -name "README*" -type f`
4. Listing all directories: `find . -type d -maxdepth 3 | grep -v node_modules`
5. Identifying the tech stack from package files

### STEP 3: Populate ALL Context Files (5 files)

#### 3.1 UPDATE `.claude/context/architecture.md`
You MUST fill in:
- Project Identity section: Name (from package.json/go.mod/etc), Type (Web App/API/Library/CLI/Mobile), Purpose (from README or code analysis), Started date (git log --reverse | head -1), Stage (Development/Production based on configs)
- Architecture Overview: Create an ASCII diagram showing component relationships
- Technology Stack: List ALL languages, frameworks, databases, and tools found
- File Structure: Document the ACTUAL directory structure using tree command or equivalent
- Key Components: List and describe each major module/component found
- Critical Paths: Trace through the code to identify main user flows
- Integration Points: Document all external APIs and services
- Data Flow: Describe how data moves through the system

#### 3.2 UPDATE `.claude/context/patterns.md`
You MUST identify and document:
- Naming Conventions: Analyze files to determine actual naming patterns (camelCase/snake_case/etc)
- Code Style: Find and document the actual code formatting patterns used
- Testing Patterns: Look in test directories to identify testing approach
- File Organization: How are files grouped and organized?
- Git Commit Patterns: Run `git log --oneline -30` to identify commit message patterns
- Error Handling Patterns: Search for try/catch, error handlers, etc.
- Common Utilities: Identify frequently used utility functions
- State Management: How is application state managed?

#### 3.3 UPDATE `.claude/context/environment.md`
You MUST document:
- Required Tools: Check package.json/requirements.txt for version requirements
- Setup Instructions: Based on README or package scripts, document EXACT setup steps
- Environment Variables: Check for .env.example, config files, search for process.env or os.getenv
- Common Setup Issues: Check for issues in README, CONTRIBUTING, or comments
- IDE Configuration: Look for .vscode/, .idea/, or editor config files
- Development Scripts: List all npm scripts, make targets, or other dev commands
- Database Setup: Any migrations, seeds, or database initialization
- External Service Requirements: APIs, cloud services, etc.

#### 3.4 UPDATE `.claude/context/performance-baseline.md`
You MUST analyze and document:
- Target Metrics: Look for any performance requirements in docs or comments
- Current Performance: Check for existing benchmarks or performance tests
- Known Bottlenecks: Search for TODO/FIXME/HACK comments about performance
- Optimization Opportunities: Identify obvious areas for improvement
- Bundle Size: Check build output or package sizes
- Database Queries: Look for complex queries or N+1 problems
- Caching Strategy: Identify what's currently cached and how

#### 3.5 UPDATE `.claude/context/dependencies.md`
You MUST document:
- Production Dependencies: List ALL from package.json/requirements.txt with versions
- Development Dependencies: List ALL dev dependencies with their purposes
- External APIs: Search code for API calls, find all external service integrations
- CDN Resources: Look in HTML files or build configs for CDN usage
- Version Constraints: Note any specific version requirements or conflicts
- Security Vulnerabilities: Run `npm audit` or equivalent if possible
- License Information: Check package licenses for compliance issues
- Update History: When were dependencies last updated?

### STEP 4: Populate ALL Session Files (4 files)

#### 4.1 UPDATE `.claude/session/current.md`
- Set Branch: Get from `git branch --show-current`
- Update Focus: Change from "ANALYZING" to specific current work
- Complete ALL checkboxes in the analysis checklist as you go
- List actual active TODOs from code comments or issue trackers
- Document current build/test status
- Note any uncommitted changes
- Add session variables with real values

#### 4.2 UPDATE `.claude/session/log.md`
- Add entry for this analysis session
- Document what you discovered
- List all files you examined
- Note any immediate issues found

#### 4.3 UPDATE `.claude/session/handoff.md`
- Document next steps after analysis
- List any critical issues that need immediate attention
- Provide commands to run for next session
- Note any blockers or dependencies

#### 4.4 UPDATE `.claude/session/validation.md`
- Run actual validation checks
- Update file integrity hashes
- Note any missing expected files
- Document actual validation status

### STEP 5: Populate ALL Knowledge Files (5 files)

#### 5.1 ANALYZE AND UPDATE `.claude/knowledge/errors.md`
Search for existing error patterns by:
- Searching for try/catch blocks
- Looking for error handling code
- Checking test files for error cases
- Reviewing any error logs if present
- Document any error patterns found

#### 5.2 UPDATE `.claude/knowledge/solutions.md`
Document discovered solutions by:
- Identifying clever code solutions
- Finding workarounds in comments
- Noting optimization techniques used
- Documenting reusable patterns

#### 5.3 UPDATE `.claude/knowledge/optimizations.md`
- Search for existing optimizations in code
- Look for memoization, caching, lazy loading
- Document database optimizations found
- Note any performance-related code

#### 5.4 UPDATE `.claude/knowledge/merge-conflicts.md`
- Check git history for merge commits: `git log --merges`
- Look for conflict markers in git history
- Document any complex merges found
- Note conflict-prone files

#### 5.5 UPDATE `.claude/knowledge/commands.md`
Extract ALL commands from:
- package.json scripts section
- Makefile targets
- README instructions
- Shell scripts in the project
- Docker commands if present
- Database commands
- Deployment commands

### STEP 6: Populate ALL Tools Files (3 files)

#### 6.1 UPDATE `.claude/tools/mcp-registry.md`
- List which MCP tools would be most effective for this codebase
- Document recommended search patterns
- Note which tools to avoid based on project structure

#### 6.2 UPDATE `.claude/tools/agent-usage.md`
- Recommend which sub-agents would help with this codebase
- Document agent workflows for common tasks
- Note agent context requirements

#### 6.3 UPDATE `.claude/tools/tool-cache.md`
- Initialize performance metrics for this project
- Document which tools work best for searching this codebase
- Set up tool chains for common operations

### STEP 7: Check Workspace Files (1 file)

#### 7.1 UPDATE `.claude/workspace/experiments/index.md`
- Check for any experimental or prototype code
- Look for feature flags or experimental branches
- Document any A/B tests or experiments found

### STEP 8: Populate Long-term Vision and Roadmap

#### 8.1 ANALYZE AND POPULATE `.claude/longterm/product-overview.md`
Based on your project analysis:
- Extract product identity from README, package.json, or app descriptions
- Identify core features by analyzing main user-facing functionality
- Determine target users from documentation or user-facing code
- Document the value proposition and problem being solved
- Note any success metrics found in analytics or logging code
- Capture technical and business constraints from configs or docs

#### 8.2 ANALYZE AND POPULATE `.claude/longterm/epics.md`
Based on git history, branches, and code analysis:
- Identify current active epics from recent git branches and commits
- Document completed epics from git history and major feature releases
- Plan future epics based on TODO comments and issue trackers
- Establish dependencies between epics based on code architecture
- Set realistic timelines based on team velocity and project scope
- Define success metrics for each epic

#### 🎯 Making Longterm Files Actionable
After populating these files, ensure they contain:
- **Clear decision triggers**: When should Claude read product-overview.md? (new features, architecture changes)
- **Actionable roadmap**: Each epic should have clear "ready to start" criteria
- **User-focused language**: Frame features in terms of user needs, not technical requirements

These files should answer "why are we building this?" not just "what are we building?"

### STEP 9: Update Navigation and Goals

#### 9.1 COMPLETELY REWRITE `.claude/NORTH_STAR.md`
Based on your analysis and longterm files:
- Set the ACTUAL current sprint goal (aligned with active epic from epics.md)
- Define success criteria based on current epic's acceptance criteria
- List what NOT to work on (from product-overview constraints)
- Add actual project mantras from contributing guides or team docs
- Document real key decisions from architecture or history
- Add actual quick links to project resources

#### 9.2 UPDATE `.claude/INDEX.md`
- Verify all file sizes are approximately correct
- Update descriptions based on actual content
- Add any project-specific navigation hints

### STEP 10: Final Verification
Run these checks:
1. Verify every .md file in .claude/ has been updated with real content
2. Ensure no placeholders like [TO BE DETERMINED] remain
3. Confirm all code snippets are from the actual project
4. Verify all paths and commands actually work
5. Make sure file counts and metrics are accurate

### STEP 11: Create Analysis Summary
After completing ALL above steps, create a summary in `.claude/session/log.md`:
- Total files analyzed
- Key technologies identified
- Critical issues found
- Recommended immediate actions
- Time taken for analysis

## ⚠️ CRITICAL REQUIREMENTS

1. You MUST complete ALL steps above - no skipping
2. You MUST replace ALL placeholder text with actual findings
3. You MUST use real code examples from THIS project
4. You MUST verify all commands and paths work
5. You MUST document everything you find, even if it seems minor

## 🔍 Search Commands to Use

Run these to ensure thorough analysis:
- `find . -type f -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" | wc -l` (count source files)
- `grep -r "TODO\|FIXME\|HACK\|BUG\|XXX" --exclude-dir=node_modules .` (find issues)
- `find . -type f -size +1M` (find large files)
- `git log --oneline --graph --all -20` (understand recent work)
- `find . -name "test*" -o -name "*test*" -o -name "spec*" | head -20` (find tests)

Take your time. This analysis is critical for all future work. A thorough analysis now saves hours later.

Begin the analysis now and don't proceed with ANY other work until ALL memory files are completely populated with accurate information from this specific project.
```

---

## 📊 Expected Results

After Claude completes this exhaustive analysis, you should have:

### ✅ **Fully Populated Memory System**
- **27+ files** all filled with project-specific content
- **No placeholders** remaining
- **Real code examples** from your project
- **Accurate documentation** of current state

### 📈 **Metrics Claude Should Report**
- Files analyzed: [number]
- Lines of code reviewed: [number]  
- Dependencies documented: [number]
- Patterns identified: [number]
- Issues found: [number]
- Time taken: [duration]

### 🎯 **Quality Checks**

After analysis, verify:
1. Open `.claude/NORTH_STAR.md` - Should reflect actual project goals
2. Open `.claude/context/architecture.md` - Should have complete system diagram
3. Open `.claude/context/patterns.md` - Should show your actual code style
4. Open `.claude/knowledge/commands.md` - Should list all your npm scripts
5. Search for "TO BE DETERMINED" - Should return 0 results

## 💡 **Pro Tips**

1. **Give Claude time** - This analysis can take 10-15 minutes for large projects
2. **Don't interrupt** - Let Claude complete the full analysis
3. **Review after** - Check the populated files and correct any misunderstandings
4. **Save the analysis** - Commit the memory files once verified

## 🔄 **Follow-Up Prompt**

After analysis is complete:

```markdown
Now that the analysis is complete, please:
1. Show me a summary of what you found
2. List any critical issues that need immediate attention
3. Recommend the top 3 things we should work on first
4. Confirm all memory files are populated
```

This exhaustive prompt ensures Claude thoroughly analyzes and documents every aspect of your existing project!
```

### After Initial Analysis - Regular Work Sessions

#### Resuming Work Prompt
```markdown
Continuing work on this project. Please:
1. Read .claude/INDEX.md first for efficient navigation
2. Check .claude/NORTH_STAR.md for current sprint goal  
3. Read .claude/session/current.md for where we left off
4. Read .claude/session/handoff.md for any important notes
5. Continue from exactly where we stopped
```

#### Bug Fixing Prompt
```markdown
I need to fix [BUG DESCRIPTION]. Please:
1. Check .claude/INDEX.md first
2. Look in .claude/knowledge/errors.md to see if we've encountered this before
3. Review .claude/context/patterns.md for our error handling patterns
4. Fix the bug
5. Document the solution in .claude/knowledge/solutions.md
6. Add the error pattern to .claude/knowledge/errors.md for future reference
```

#### Refactoring Prompt
```markdown
Time to refactor [COMPONENT/FEATURE]. Please:
1. Read .claude/INDEX.md for navigation
2. Review .claude/context/architecture.md to understand current structure
3. Check .claude/context/patterns.md for our conventions
4. Review .claude/knowledge/optimizations.md for performance considerations
5. Perform the refactoring
6. Update architecture.md if structure changes
7. Document improvements in knowledge/optimizations.md
```

#### Epic Management Prompt
```markdown
Epic update needed. Please:
1. Read .claude/INDEX.md for navigation
2. Check .claude/longterm/epics.md for current epic status
3. Update epic progress based on recent work
4. Move completed epics to completed section with learnings
5. Add new epics if scope has changed
6. Update .claude/NORTH_STAR.md if current sprint focus shifts
7. Update dependencies if architecture changed
```

#### Sprint Planning Prompt  
```markdown
Time for sprint planning. Please:
1. Read .claude/INDEX.md first
2. Review .claude/longterm/product-overview.md for overall vision
3. Check .claude/longterm/epics.md for available work
4. Review completed work in .claude/session/log.md
5. Update .claude/NORTH_STAR.md with new sprint goal
6. Align sprint goal with current active epic
7. Update .claude/session/current.md with new focus
```

---

## 🎯 Power User Prompts

### Efficient Token-Saving Prompt
```markdown
Working on [TASK]. Please:
1. Read ONLY .claude/INDEX.md first
2. From INDEX, identify and read ONLY the files needed for this task
3. Complete the task
4. Update only the relevant memory files

Minimize token usage by not reading unnecessary files.
```

### Strategic Planning Token-Efficient Prompt
```markdown
Planning/architecture work on [TASK]. Please:
1. Read .claude/INDEX.md first
2. Read .claude/longterm/ files for strategic context
3. Read only other files identified as needed from INDEX
4. Make decisions aligned with product vision
5. Update relevant memory files

This ensures strategic decisions are grounded in vision without reading everything.
```

### Sprint Review Prompt
```markdown
End of sprint review. Please:
1. Read .claude/INDEX.md
2. Review .claude/session/log.md for all work done
3. Check .claude/NORTH_STAR.md goals vs accomplishments
4. Update .claude/session/handoff.md with status
5. Propose next sprint goals for NORTH_STAR.md
6. Summarize learnings in .claude/knowledge/solutions.md
```

### Knowledge Transfer Prompt
```markdown
New developer joining. Please:
1. Read .claude/INDEX.md
2. Create a comprehensive onboarding summary from:
   - longterm/product-overview.md (what we're building)
   - longterm/epics.md (where we are in development)
   - context/architecture.md (system overview)
   - context/patterns.md (coding standards)
   - context/environment.md (setup)
   - knowledge/commands.md (useful commands)
3. List any gotchas from knowledge/errors.md
```

### Product Strategy Review Prompt
```markdown
Time for product strategy review. Please:
1. Read .claude/INDEX.md
2. Review .claude/longterm/product-overview.md for current vision
3. Analyze .claude/longterm/epics.md for roadmap progress
4. Check .claude/session/log.md for recent accomplishments
5. Assess if product vision needs updating based on learnings
6. Update epics.md with new priorities if needed
7. Align NORTH_STAR.md with updated strategy
```

### Epic Completion Prompt
```markdown
Epic [EPIC-NAME] is complete. Please:
1. Read .claude/INDEX.md
2. Update .claude/longterm/epics.md:
   - Mark epic as completed
   - Document key learnings
   - Update progress metrics
3. Check if next epic can start early
4. Update .claude/NORTH_STAR.md with next focus
5. Document lessons learned in knowledge/solutions.md
```

---

## 📝 Template Prompts for Common Scenarios

### Morning Startup
```markdown
Good morning! Starting work for the day.
Check memory system (.claude/INDEX.md first, then NORTH_STAR.md and current.md).
What's our focus today and where did we leave off?
```

### End of Day
```markdown
End of day. Please:
1. Update .claude/session/log.md with today's accomplishments
2. Update .claude/session/handoff.md with tomorrow's priorities
3. Update .claude/session/current.md with exact stopping point
4. Commit memory updates
```

### Quick Task
```markdown
Quick task: [TASK DESCRIPTION]
Check .claude/INDEX.md and read ONLY relevant files.
Complete the task and update current.md.
```

### Performance Investigation
```markdown
Performance issue with [FEATURE]. Please:
1. Check .claude/INDEX.md
2. Review .claude/context/performance-baseline.md
3. Check .claude/knowledge/optimizations.md for previous optimizations
4. Investigate and propose solutions
5. Document findings in optimizations.md
```

---

## ⚠️ Common Mistakes to Avoid

### ❌ DON'T Do This:
```markdown
"Continue working on the project"  # Too vague, Claude won't know where to look
"What did we do yesterday?"       # Without directing to memory files
"Fix all the bugs"                # Without checking error patterns first
```

### ✅ DO This Instead:
```markdown
"Check .claude/session/current.md and continue from where we left off"
"Read .claude/session/log.md and summarize yesterday's work"  
"Check .claude/knowledge/errors.md for known issues, then fix the highest priority"
```

---

## 🚀 First-Time Setup Checklist

### For New Projects:
- [ ] Run installer: `claude-memory "ProjectName"`
- [ ] Edit `.claude/NORTH_STAR.md` with your sprint goal
- [ ] Give Claude the "Initial Setup Prompt" above
- [ ] Let Claude populate the memory system

### For Existing Projects:
- [ ] Run installer: `claude-memory "ProjectName"`  
- [ ] Give Claude the "Initial Analysis Prompt" above
- [ ] Let Claude analyze thoroughly (this may take 5-10 minutes)
- [ ] Review Claude's analysis and correct if needed
- [ ] Start regular development with "Resuming Work Prompt"

---

## 💡 Pro Tips

### 1. Start Every Session with INDEX
Always mention `.claude/INDEX.md` first in your prompts. This reduces token usage by 70-80%.

### 2. Be Specific About Memory Updates
Tell Claude explicitly which memory files to update:
```markdown
"Update session/current.md with progress and add any errors to knowledge/errors.md"
```

### 3. Use Memory for Complex Debugging
```markdown
"Check knowledge/errors.md for similar issues, then investigate using the patterns in knowledge/solutions.md"
```

### 4. Batch Memory Updates
```markdown
"Complete these 3 tasks, then update all relevant memory files at once"
```

### 5. Trust the System
After initial setup, you can use simple prompts:
```markdown
"Check memory and continue working"
"Memory check, then implement the next feature"
```

### Clean up Memory every so often
After some time, you can use a simple clean up prompt:
```markdown
" 🧠 Claude Memory Maintenance

  Goal: Keep memory system clean, current, and token-efficient

  Instructions:
  1. Archive resolved issues - Move completed bugs/fixes to brief historical summaries
  2. Update current status - Refresh session state, git branch, active URLs in session/current.md       
  3. Clean redundant content - Remove duplicate information across files
  4. Preserve essential patterns - Keep architectural solutions, code snippets, best practices
  5. Focus on active development - Emphasize current priorities over historical details

  Key files to maintain:
  - session/current.md - Keep current, remove resolved bug details
  - knowledge/errors.md - Active issues only, summarize resolved ones
  - knowledge/solutions.md - Essential patterns, not step-by-step historical fixes

  Maintenance frequency: After major milestones or when memory feels cluttered with historical
  content

  Success criteria: Memory loads faster, focuses on current development needs preserves lessons learned without excessive detail"
```

---

## 📊 Expected Behavior

When properly prompted, Claude should:

1. **Always start by reading INDEX.md** (2KB) instead of all files (20KB+)
2. **Navigate directly to needed files** based on INDEX
3. **Update memory continuously** without being reminded
4. **Pick up exactly where it left off** between sessions
5. **Build knowledge over time** in the knowledge/ directory
6. **Never ask what to work on** if NORTH_STAR.md is populated

---

## 🎬 Example Full Session

### Developer's Prompts Throughout a Day:

**9:00 AM:**
```markdown
Good morning! Check .claude/INDEX.md, then NORTH_STAR.md and current.md. 
Continue from where we left off yesterday.
```

**10:30 AM:**
```markdown
Getting a TypeError. Check knowledge/errors.md for similar issues, 
then fix it and document the solution.
```

**2:00 PM:**
```markdown
Implement user authentication. Check INDEX first, review our patterns,
then implement. Update current.md with progress.
```

**5:00 PM:**
```markdown
End of day. Update session/log.md with accomplishments,
handoff.md with tomorrow's tasks, and current.md with stopping point.
```

This structured approach ensures Claude uses the memory system efficiently and maintains perfect continuity across all sessions!