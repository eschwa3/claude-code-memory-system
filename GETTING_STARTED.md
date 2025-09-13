# 🚀 Getting Started with Claude Code Memory System

This guide will get you up and running with the Claude Code Memory System in under 5 minutes.

## Step 1: Verify Your System (Optional)

Before installing, you can check if your system has all required tools:

```bash
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/verify-install.sh | bash
```

This will check for:
- bash (4.0+)
- git (2.20+) 
- Standard Unix utilities (sed, find, grep, etc.)

## Step 2: Install the Memory System

### Option A: One-Line Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh | bash
```

### Option B: Manual Install
```bash
# Download the installer
curl -O https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh

# Make it executable
chmod +x install.sh

# Run it
./install.sh
```

## Step 3: Verify Installation

After installation, you should see:

```
✅ Claude Code Memory System v2.0 Installed!

📋 Next Steps:
1. Edit .claude/NORTH_STAR.md with your current goal
2. Review .claude/INDEX.md for efficient navigation
3. Run 'claude' to start coding
```

Check that everything was created:
```bash
ls -la .claude/
cat .claude/INDEX.md
```

## Step 4: 🚨 CRITICAL - Use the Setup Prompts

**This is the most important step!** The memory system needs to be properly initialized using the prompts in [`Claude Code Memory Prompting Guide.md`](Claude%20Code%20Memory%20Prompting%20Guide.md).

### For New Projects:
1. Open [`Claude Code Memory Prompting Guide.md`](Claude%20Code%20Memory%20Prompting%20Guide.md)
2. Copy the **"Complete Analysis and Setup Prompt for NEW Projects"** section
3. Fill in your project requirements
4. Paste the entire prompt to Claude Code
5. **After analysis is complete**: Use the "Post-Installation Claude.md Cleanup Prompt" to optimize your `Claude.md`

### For Existing Projects:
1. Open [`Claude Code Memory Prompting Guide.md`](Claude%20Code%20Memory%20Prompting%20Guide.md)
2. Copy the **"Complete Analysis and Setup Prompt for EXISTING Projects"** section
3. Paste the entire prompt to Claude Code
4. **After analysis is complete**: Use the "Post-Installation Claude.md Cleanup Prompt" to optimize your `Claude.md`

> **⚠️ Without using these prompts, the memory system won't be properly configured!**

## Step 5: Start Coding with Claude Code

The memory system is now ready! When you start a Claude Code session:

1. **Claude will automatically read** `.claude/INDEX.md` first
2. **Navigate efficiently** by only reading the files you need
3. **Context persists** across all coding sessions with longterm product vision
4. **Strategic alignment** maintained through `longterm/product-overview.md` and `longterm/epics.md`
5. **Memory updates** automatically as you work

### Example Claude Code Workflow:
```
You: "Let's continue working on the authentication system"

Claude: [Reads .claude/INDEX.md → .claude/NORTH_STAR.md → .claude/session/current.md]
"I can see we're working on JWT authentication. Based on the memory files, 
we left off implementing the token validation middleware..."
```

## Step 6: Daily Usage

### Starting a New Session
Claude Code will automatically:
- Read `.claude/INDEX.md` for navigation
- Check `.claude/NORTH_STAR.md` for current goals
- Review `.claude/session/current.md` for where you left off

### During Development
The memory system automatically tracks:
- Current work state
- Code patterns discovered
- Error solutions found
- Architecture decisions made

### Ending a Session
Memory is automatically updated through git hooks, but you can manually sync:
```bash
.claude/automation/scripts/sync.sh
```

## Maintenance Commands

### Memory System Maintenance
```bash
# Comprehensive memory system audit and optimization
./audit-memory.sh

# Update memory system with latest features and improvements
./update-memory.sh
```

### System Health and Updates
```bash
# Check system health
.claude/automation/scripts/validate.sh

# Clean up old files  
.claude/automation/scripts/prune.sh

# Update to latest version
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/update.sh | bash
```

### Memory Maintenance Best Practices
- **Audit regularly**: Run `./audit-memory.sh` weekly or after major development phases
- **Update features**: Use `./update-memory.sh` to get latest longterm memory enhancements
- **Clean Claude.md**: Use the cleanup prompt from [`Claude Code Code Memory Prompting Guide.md`](Claude%20Code%20Memory%20Prompting%20Guide.md) after initial setup

## Understanding the Memory Structure

```
.claude/
├── INDEX.md              # 🗂️  Start here - navigation map
├── NORTH_STAR.md         # 🎯  Current sprint goals (aligned with epics)
├── longterm/             # 🎭  Strategic product vision and development roadmap  
│   ├── product-overview.md  # Product identity, features, value proposition
│   └── epics.md             # Major development milestones and roadmap
├── context/              # 🏗️  Architecture and patterns
├── session/              # 💾  Current work state
├── knowledge/            # 🧠  Learned solutions
├── workspace/            # 🧪  Experiments and scratch work
├── tools/                # ⚙️  Tool effectiveness tracking
└── automation/           # 🤖  Scripts and git hooks
```

## Platform-Specific Notes

### Windows Users
- Use **Git Bash** (comes with Git for Windows)
- Alternatively, use **Windows Subsystem for Linux (WSL)**
- Avoid Command Prompt or PowerShell for running the installer

### macOS Users  
- If you get `sed` errors, install GNU coreutils: `brew install coreutils`
- The installer will automatically detect and adapt to BSD vs GNU utilities

### Linux Users
- Most distributions work out of the box
- Ensure you have `git` installed: `sudo apt install git` (Ubuntu/Debian)

## Troubleshooting

**Installation fails?**
- Check the [FAQ](docs/FAQ.md#installation-issues)
- Run the verification script first
- Ensure you have write permissions in the current directory

**Memory not updating?**
- Verify git hooks are installed: `ls -la .git/hooks/`
- Manually sync: `.claude/automation/scripts/sync.sh`

**Claude Code not reading memory?**
- **Most common issue**: You didn't use the setup prompts in [`Claude Code Memory Prompting Guide.md`](Claude%20Code%20Memory%20Prompting%20Guide.md)
- **Second most common**: `Claude.md` still contains first-session setup instructions instead of development workflow
- Ensure `Claude.md` exists in project root and is optimized for ongoing development
- Check that `.claude/INDEX.md` is properly formatted
- Use the "Post-Installation Claude.md Cleanup Prompt" if Claude.md needs updating

## Need Help?

- **Setup Prompts**: [Claude Code Memory Prompting Guide.md](Claude%20Code%20Memory%20Prompting%20Guide.md) - Essential for proper initialization
- **Memory Maintenance**: [Claude Code Memory Audit Prompts.md](Claude%20Code%20Memory%20Audit%20Prompts.md) - Keep your system optimized
- **Documentation**: [README.md](README.md) and [docs/](docs/)
- **Common Issues**: [FAQ](docs/FAQ.md)
- **Report Bugs**: [GitHub Issues](https://github.com/eschwa3/claude-code-memory-system/issues)
- **Ask Questions**: [GitHub Discussions](https://github.com/eschwa3/claude-code-memory-system/discussions)

---

**🎉 You're all set! The Claude Code Memory System will now maintain context across all your coding sessions.**