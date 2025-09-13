# Claude Code Memory System Audit Prompts

## 📑 Table of Contents

### 🔍 Core Audit Prompts
1. [📊 Quick Health Check Prompt](#-quick-health-check-prompt) - *2 minutes*
   - Comprehensive overview of system health
2. [🎯 Strategic File Deep Audit](#-strategic-file-deep-audit) - *15 minutes*
   - Deep analysis of product vision and roadmap files
3. [⚡ Efficiency & Bloat Audit](#-efficiency--bloat-audit) - *10 minutes*
   - Token optimization and file size analysis
4. [🔧 Migration & Update Assessment](#-migration--update-assessment) - *5 minutes*
   - Version compatibility and update needs
5. [📈 Knowledge Base Quality Audit](#-knowledge-base-quality-audit) - *10 minutes*
   - Practical value of knowledge files
6. [🎨 User Experience Audit](#-user-experience-audit) - *10 minutes*
   - Daily development workflow support
7. [🔄 Usage Patterns Analysis](#-usage-patterns-analysis) - *10 minutes*
   - System adoption and effectiveness

### 💡 Regular Maintenance Prompts
8. [Weekly Session Cleanup](#weekly-session-files-cleanup-5-minutes) - *5 minutes*
9. [Monthly Deep Cleanup](#monthly-cleanup-30-minutes) - *30 minutes*
10. [Pre-Sprint Preparation](#pre-sprint-audit-15-minutes) - *15 minutes*
11. [Post-Epic Knowledge Capture](#post-epic-review-20-minutes) - *20 minutes*

### 📋 Usage Guidelines
- [Audit Schedule Recommendations](#-audit-schedule-recommendations)
- [Regular Maintenance Schedule](#regular-maintenance-schedule)
- [Ad-Hoc Audit Triggers](#ad-hoc-audits)
- [Success Metrics](#success-metrics)

---

## 🎯 Quick Start Guide

### 🚀 First Time Setup
**New to auditing?** Start here:
1. Run `audit-memory.sh` for automated health check
2. Use [📊 Quick Health Check](#-quick-health-check-prompt) for immediate issues
3. Follow [Weekly Session Cleanup](#weekly-session-files-cleanup-5-minutes) for maintenance

### 🔧 Common Scenarios
| Problem | Solution | Time |
|---------|----------|------|
| **System feels slow/bloated** | [⚡ Efficiency & Bloat Audit](#-efficiency--bloat-audit) | 10 min |
| **Starting new sprint** | [Pre-Sprint Preparation](#pre-sprint-audit-15-minutes) | 15 min |
| **Completed major feature** | [Post-Epic Knowledge Capture](#post-epic-review-20-minutes) | 20 min |
| **Strategic planning needed** | [🎯 Strategic File Deep Audit](#-strategic-file-deep-audit) | 15 min |
| **System not being used** | [🔄 Usage Patterns Analysis](#-usage-patterns-analysis) | 10 min |
| **Daily workflow friction** | [🎨 User Experience Audit](#-user-experience-audit) | 10 min |
| **After memory system update** | [🔧 Migration & Update Assessment](#-migration--update-assessment) | 5 min |
| **Knowledge files feel stale** | [📈 Knowledge Base Quality Audit](#-knowledge-base-quality-audit) | 10 min |

---

## 📊 Quick Health Check Prompt

```markdown
# Memory System Health Check

Please perform a comprehensive audit of this Claude Code Memory installation:

## STEP 1: Structure Verification
1. Check that all required .claude/ directories and files exist
2. Verify Claude.md has current instructions
3. Report any missing or unexpected files

## STEP 2: Content Quality Analysis
1. Read .claude/INDEX.md and verify file size estimates match reality
2. Check 5 random memory files for:
   - Placeholder text that wasn't replaced
   - Generic vs. project-specific content
   - Outdated information
   - Proper markdown formatting

## STEP 3: Strategic Context Assessment  
1. Read .claude/longterm/product-overview.md - Does it clearly explain:
   - What problem this project solves
   - Who the target users are
   - Core value proposition
2. Read .claude/longterm/epics.md - Does it contain:
   - Specific, actionable epics
   - Clear success criteria
   - Realistic timelines

## STEP 4: Usability Analysis
1. Read .claude/session/current.md - Is it:
   - Up to date with current work
   - Specific about next actions
   - Clear about project state
2. Check .claude/knowledge/ files for:
   - Real examples from THIS project
   - Actionable solutions vs. generic advice
   - Recent learnings vs. stale information

## STEP 5: Token Efficiency Review
1. Identify files that are too long/detailed
2. Look for duplicate information across files
3. Suggest consolidation opportunities

Provide:
- Health score (0-100) with reasoning
- Top 3 improvement recommendations
- Specific examples of issues found
```

---

## 🎯 Strategic File Deep Audit

```markdown
# Strategic Context Files Audit

Focus specifically on the strategic planning files:

## AUDIT SCOPE
Analyze these files for strategic value:
- .claude/longterm/product-overview.md
- .claude/longterm/epics.md  
- .claude/NORTH_STAR.md

## EVALUATION CRITERIA

### Product Overview Assessment:
1. **Clarity**: Can a new developer understand what this project does?
2. **User Focus**: Are features described in terms of user value?
3. **Decision Support**: Does it help with architectural choices?
4. **Actionability**: Does it guide feature prioritization?

### Epics Assessment:
1. **Specificity**: Are epics concrete and measurable?
2. **Scope**: Are epics appropriately sized (2-8 weeks)?
3. **Dependencies**: Are epic relationships clear?
4. **Readiness**: Can epics be started when dependencies are met?

### North Star Assessment:
1. **Focus**: Is the current goal clear and specific?
2. **Alignment**: Does it align with the active epic?
3. **Boundaries**: Are exclusions clear?
4. **Actionability**: Can development start immediately?

## DELIVERABLE
For each file, rate (1-5) and provide specific improvement suggestions:
- Strategic value score
- Content quality score  
- Usability score
- 2-3 specific improvements needed
```

---

## ⚡ Efficiency & Bloat Audit

```markdown
# Memory System Efficiency Audit

Identify and fix efficiency issues:

## STEP 1: Size Analysis
1. List files over 5KB with their purpose
2. Identify any files over 10KB (likely too detailed)
3. Calculate total memory system size

## STEP 2: Redundancy Detection
1. Look for duplicate information across files
2. Identify content that could be consolidated
3. Find information that's in the wrong file

## STEP 3: Staleness Check
1. Find files with outdated information
2. Identify content that's no longer relevant
3. Look for TODO/FIXME items that are stale

## STEP 4: Token Optimization
1. Suggest which files could be combined
2. Identify content that could be shortened
3. Recommend information that could be removed

## STEP 5: Update Recommendations
1. Prioritize which files need immediate updates
2. Suggest a maintenance schedule
3. Identify automation opportunities

Provide specific recommendations with file paths and line numbers where possible.
```

---

## 🔧 Migration & Update Assessment

```markdown
# Memory System Version Audit

Check compatibility with current Claude Code Memory System version:

## STEP 1: Version Detection
1. Check .claude/INDEX.md for strategic file descriptions:
   - Should say "Product vision & user needs" not "App overview and features"
   - Should say "Feature roadmap & sprint planning" not "Major epics and milestones"
2. Check Claude.md for strategic context guidance
3. Look for longterm/ directory prominence in memory maps

## STEP 2: Missing Features Check
1. Verify all automation scripts exist in .claude/automation/
2. Check if git hooks are installed and working
3. Look for new file structures or templates

## STEP 3: Content Modernization
1. Check if INDEX.md has current Quick Queries
2. Verify Claude.md has token-efficient strategic planning guidance
3. Look for outdated prompts or instructions

## STEP 4: Migration Recommendations
Based on findings, provide:
- Required updates to match current version
- Optional improvements for better efficiency
- Specific commands to run for updates
- Risk assessment for changes

Rate compatibility (0-100) and provide migration priority.
```

---

## 📈 Knowledge Base Quality Audit

```markdown
# Knowledge Files Effectiveness Audit

Evaluate the practical value of knowledge files:

## AUDIT TARGETS
Focus on these knowledge files:
- .claude/knowledge/errors.md
- .claude/knowledge/solutions.md
- .claude/knowledge/commands.md
- .claude/knowledge/optimizations.md

## EVALUATION CRITERIA

### Content Relevance (Rate 1-5):
1. Are examples from THIS project?
2. Are solutions currently applicable?
3. Are commands actually used?
4. Are optimizations still relevant?

### Actionability (Rate 1-5):
1. Can solutions be implemented immediately?
2. Are commands copy-pasteable?
3. Are error fixes complete?
4. Are optimizations measurable?

### Completeness (Rate 1-5):
1. Are recent project issues documented?
2. Are successful patterns captured?
3. Are all useful commands included?
4. Are performance improvements tracked?

## IMPROVEMENT PLAN
For each file, provide:
- Current effectiveness score (0-20)
- 3 specific content gaps
- 2 actionable improvement suggestions
- Priority for updates (High/Medium/Low)

Identify the most valuable knowledge file and the least valuable.
```

---

## 🎨 User Experience Audit

```markdown
# Memory System UX Audit

Evaluate how well the memory system supports daily development:

## STEP 1: Navigation Efficiency
1. Test INDEX.md - Can you quickly find what's needed?
2. Check file organization - Is related info grouped well?
3. Evaluate descriptions - Are they trigger words vs. generic?

## STEP 2: Session Continuity  
1. Read session/current.md - Can work resume immediately?
2. Check session/handoff.md - Are next steps clear?
3. Review session/log.md - Is history useful?

## STEP 3: Decision Support
1. Can architectural decisions be made from context files?
2. Do knowledge files accelerate problem-solving?
3. Are strategic files helpful for feature planning?

## STEP 4: Maintenance Burden
1. How much effort to keep files current?
2. Are updates happening naturally?
3. Is information decay being managed?

## RECOMMENDATIONS
Provide:
- User experience score (0-100)
- Biggest friction point
- Most valuable aspect
- 3 UX improvements with impact estimates
```

---

## 🔄 Usage Patterns Analysis

```markdown
# Memory System Usage Analysis

Analyze how effectively the memory system is being used:

## STEP 1: Update Frequency Analysis
1. Check file modification dates across .claude/
2. Identify most/least updated files
3. Look for files that should be updated more often

## STEP 2: Content Evolution Tracking
1. Compare current content to what install script creates
2. Identify files with substantial customization
3. Find files still using template content

## STEP 3: Integration Assessment
1. Check if git hooks are adding session entries
2. Look for evidence of regular memory maintenance
3. Assess if knowledge is accumulating over time

## STEP 4: Value Realization
1. Identify clear examples where memory saved time
2. Look for patterns that indicate system effectiveness
3. Find gaps where memory could be more helpful

Provide usage effectiveness score and specific recommendations for better adoption.
```

---

## 💡 Quick Maintenance Prompts

### Weekly Session Files Cleanup (5 minutes)
```markdown
# Weekly Memory System Maintenance

Perform quick cleanup of active development files:

## TARGETS
Focus on these session files:
- .claude/session/current.md
- .claude/session/log.md  
- .claude/session/handoff.md

## TASKS
1. **Current.md cleanup**:
   - Remove completed todo items
   - Update project state and focus
   - Clear resolved blockers
   - Refresh session variables

2. **Log.md maintenance**:
   - Archive entries older than 2 weeks to brief summaries
   - Keep recent detailed entries
   - Ensure latest work is documented

3. **Handoff.md refresh**:
   - Update next session priorities
   - Remove outdated action items
   - Ensure commands are current

Goal: Keep active development context fresh and actionable.
```

### Monthly Cleanup (30 minutes)
```markdown
# Monthly Memory System Deep Cleanup

Comprehensive cleanup and optimization:

## STEP 1: Archive Old Content
1. Move resolved issues from knowledge/errors.md to brief summaries
2. Archive old experiments from workspace/experiments/
3. Clean up session/log.md entries older than 1 month
4. Remove stale TODO/FIXME items from knowledge files

## STEP 2: Update Stale Information
1. Refresh context/dependencies.md with current versions
2. Update context/environment.md with any setup changes
3. Verify knowledge/commands.md has current scripts
4. Check context/performance-baseline.md targets

## STEP 3: Consolidate Duplicates
1. Look for repeated information across files
2. Merge similar solutions in knowledge/solutions.md
3. Combine related patterns in context/patterns.md
4. Remove redundant content

## STEP 4: Optimize for Efficiency
1. Shorten overly detailed files (>10KB)
2. Update INDEX.md size estimates
3. Ensure files focus on current development needs
4. Preserve essential patterns and learnings

Deliverable: Streamlined memory system focused on active development.
```

### Pre-Sprint Audit (15 minutes)
```markdown  
# Pre-Sprint Planning Memory Audit

Ensure strategic files support sprint planning:

## STEP 1: Strategic Context Verification
1. Read .claude/longterm/product-overview.md:
   - Does it reflect current product vision?
   - Are user needs clearly defined?
   - Does it support feature prioritization?

2. Review .claude/longterm/epics.md:
   - Are epic definitions current and actionable?
   - Do timelines reflect realistic progress?
   - Are dependencies clearly mapped?

## STEP 2: Sprint Preparation  
1. Check .claude/NORTH_STAR.md:
   - Is previous sprint goal completed?
   - Are success criteria updated?
   - Are "do not work on" items current?

2. Verify .claude/session/current.md:
   - Clear of previous sprint artifacts
   - Ready for new sprint focus
   - No stale blockers or todos

## STEP 3: Planning Support
1. Ensure context files support decisions:
   - architecture.md reflects current system state
   - patterns.md has latest conventions
   - knowledge/solutions.md has relevant patterns

Ready to set new sprint goal with full context.
```

### Post-Epic Review (20 minutes)
```markdown
# Post-Epic Completion Review

Capture learnings and update strategic context:

## STEP 1: Epic Completion Documentation
1. Update .claude/longterm/epics.md:
   - Mark epic as completed with actual completion date
   - Document key learnings and insights
   - Note any scope changes or surprises
   - Update success metrics with actual results

## STEP 2: Capture Knowledge
1. Add to .claude/knowledge/solutions.md:
   - Successful patterns discovered
   - Architecture decisions that worked well
   - Reusable code patterns or approaches

2. Update .claude/knowledge/errors.md:
   - Common issues encountered during epic
   - Solutions that prevented future occurrences
   - Patterns to avoid in future development

## STEP 3: Context Updates
1. Refresh .claude/context/architecture.md if system changed
2. Update .claude/context/patterns.md with new conventions
3. Add new commands to .claude/knowledge/commands.md
4. Update .claude/context/performance-baseline.md with new metrics

## STEP 4: Strategic Alignment
1. Assess if .claude/longterm/product-overview.md needs updates
2. Check if epic completion changes overall roadmap
3. Update .claude/NORTH_STAR.md for next epic focus

Deliverable: Updated memory system reflecting epic learnings.
```

---

## 📋 Audit Schedule Recommendations

### Regular Maintenance Schedule

| Frequency | Task | Time | Prompt to Use |
|-----------|------|------|---------------|
| **Weekly** | Session files cleanup | 5 min | [Weekly Session Files Cleanup](#weekly-session-files-cleanup-5-minutes) |
| **Monthly** | Full content quality audit | 30 min | [Monthly Cleanup](#monthly-cleanup-30-minutes) |
| **Quarterly** | Strategic file deep review | 60 min | [Strategic File Deep Audit](#-strategic-file-deep-audit) |
| **After major changes** | Structure and efficiency audit | 15 min | [Efficiency & Bloat Audit](#-efficiency--bloat-audit) |
| **Before sprints** | Strategic context verification | 15 min | [Pre-Sprint Audit](#pre-sprint-audit-15-minutes) |
| **After epics** | Knowledge capture and updates | 20 min | [Post-Epic Review](#post-epic-review-20-minutes) |

### Ad-Hoc Audits

| When to Use | Purpose | Prompt |
|-------------|---------|--------|
| **Performance issues** | Memory system feels slow/bloated | [Efficiency & Bloat Audit](#-efficiency--bloat-audit) |
| **Version updates** | After updating memory system | [Migration & Update Assessment](#-migration--update-assessment) |
| **New team member** | Onboarding preparation | [User Experience Audit](#-user-experience-audit) |
| **Low adoption** | System not being used effectively | [Usage Patterns Analysis](#-usage-patterns-analysis) |
| **Quality concerns** | Content feels stale or unhelpful | [Quick Health Check](#-quick-health-check-prompt) |

### Automation Integration

- **Quick health checks**: Use `audit-memory.sh` script before manual audits
- **Git hooks**: Automatic session updates via post-commit hooks
- **Update scripts**: Use `update-memory.sh` for version compatibility

### Success Metrics

Track these indicators over time:
- **Health scores** from automated audits (target: >80%)
- **File freshness** (files updated in last 30 days)
- **Content relevance** (project-specific vs. template content)
- **Usage evidence** (session logs show memory system references)

Use the automated `audit-memory.sh` script for quick health checks, and these Claude prompts for deeper analysis!