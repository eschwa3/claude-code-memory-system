# 🧠 Claude Code Memory System

**Persistent memory for Claude Code** - Never lose context between coding sessions again.

[![GitHub Actions](https://github.com/eschwa3/claude-code-memory-system/workflows/Test%20Installation/badge.svg)](https://github.com/eschwa3/claude-code-memory-system/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/eschwa3/claude-code-memory-system/releases)

## 🚀 Quick Start

### One-Line Install
```bash
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh | bash
```

### Verify Your System First (Optional)
```bash
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/verify-install.sh | bash
```
*This quick check ensures your system has all required tools before installation.*

> **📋 NEXT STEP AFTER INSTALL**: You MUST use the setup prompts in [`Claude Code Memory Prompting Guide.md`](Claude_Code_Memory_Prompting_Guide.md) to properly initialize your project - this is critical for the memory system to work correctly!

### Alternative Install Methods
<details>
<summary>Click to expand installation options</summary>

**Download and Run:**
```bash
# Using wget (Linux/macOS)
wget https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh
chmod +x install.sh
./install.sh

# Using curl (Linux/macOS/Windows Git Bash)
curl -O https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh
chmod +x install.sh
./install.sh
```

**Clone Repository:**
```bash
git clone https://github.com/eschwa3/claude-code-memory-system.git
cd claude-code-memory-system
./install.sh
```
</details>

## ✨ What This Does

The Claude Code Memory System creates a persistent, organized memory structure that Claude Code can use to:

- 🧠 **Remember context** between coding sessions
- 📊 **Track project goals** and maintain focus with longterm vision
- 📚 **Learn from mistakes** and accumulate solutions
- ⚡ **Reduce token usage** by 70-80% through smart navigation
- 🔄 **Maintain state** across Git commits and branches
- 🎯 **Strategic alignment** with product roadmap and epics

## 🛠️ System Requirements

**✅ Works on all platforms:**
- **Linux** (Ubuntu, CentOS, Debian, etc.)
- **macOS** (Intel and Apple Silicon)
- **Windows** (Git Bash, WSL, or PowerShell)

**Required tools:**
- `bash` (version 4.0+)
- `git` (version 2.20+)
- Standard Unix utilities (`sed`, `find`, `grep`)

*Most systems have these pre-installed. If not, see our [setup guide](docs/FAQ.md#installation-issues).*

## 📁 What Gets Installed

The installer creates a `.claude/` directory in your project with:

```
.claude/
├── INDEX.md              # 🗂️  Smart navigation (start here)
├── NORTH_STAR.md         # 🎯  Current sprint goals
├── context/              # 🏗️  Project architecture & patterns
├── session/              # 💾  Current work state
├── knowledge/            # 🧠  Accumulated learning
├── workspace/            # 🧪  Experiments & scratch work
├── tools/                # ⚙️  Tool effectiveness tracking
├── longterm/             # 🎭  Product vision & roadmap
└── automation/           # 🤖  Scripts & git hooks
```

Plus:
- `Claude.md` - Streamlined development workflow instructions
- `audit-memory.sh` - Health check and optimization script
- `update-memory.sh` - System update and maintenance utility
- Git hooks for automatic memory updates
- Cross-platform validation and maintenance scripts

## 🎯 How It Works

1. **Install once** in any project directory
2. **Use the setup prompts** from [`Claude Code Memory Prompting Guide.md`](Claude_Code_Memory_Prompting_Guide.md)
3. **Claude Code reads** the memory files automatically  
4. **Context persists** across all coding sessions
5. **Memory updates** automatically as you work

> **⚠️ IMPORTANT**: After installation, you MUST use the prompts in [`Claude Code Memory Prompting Guide.md`](Claude_Code_Memory_Prompting_Guide.md) to properly initialize your project!

### Before vs After
| Without Memory System | With Memory System |
|-----------------------|-------------------|
| "What were we working on?" | Instant context from `NORTH_STAR.md` |
| "How do we handle errors here?" | Solution patterns in `knowledge/` |
| "What's the project structure?" | Architecture diagram in `context/` |
| Start from scratch each session | Pick up exactly where you left off |

## 🔧 Usage

### For New Projects
```bash
mkdir my-new-project
cd my-new-project
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh | bash
```

### For Existing Projects
```bash
cd existing-project
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/install.sh | bash
# The system will analyze your project automatically
```

### Daily Workflow
1. **First time**: Use setup prompts from [`Claude Code Memory Prompting Guide.md`](Claude_Code_Memory_Prompting_Guide.md)
2. **Start coding** - Claude Code reads `.claude/INDEX.md` first
3. **Work normally** - Memory updates happen automatically
4. **End session** - State is preserved for next time

## 📊 Token Efficiency

The memory system reduces Claude Code token usage by **70-80%** through:
- **Smart navigation** via `INDEX.md` (only read what you need)
- **Focused context** rather than reading entire codebases
- **Persistent learning** that builds up over time

## 🔍 Validation & Maintenance

```bash
# Comprehensive memory system audit
./audit-memory.sh

# Update memory system to latest features
./update-memory.sh

# Check system health
.claude/automation/scripts/validate.sh

# Clean up old files
.claude/automation/scripts/prune.sh

# Update memory timestamps
.claude/automation/scripts/sync.sh

# Update to latest version
curl -sSL https://raw.githubusercontent.com/eschwa3/claude-code-memory-system/main/update.sh | bash
```

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

**Quick contribution workflow:**
```bash
# Fork the repo, then:
git clone https://github.com/YOUR-USERNAME/claude-code-memory-system.git
cd claude-code-memory-system
# Make changes
./test/test-install.sh  # Test your changes
# Submit PR
```

## 📚 Documentation

### 🚨 Essential Setup (Start Here!)
- **[Claude Code Memory Prompting Guide](Claude_Code_Memory_Prompting_Guide.md)** - **REQUIRED POST-INSTALL PROMPTS** and post-installation Claude.md cleanup
- **[Claude Code Memory Audit Prompts](Claude_Code_Memory_Audit_Prompts.md)** - Memory maintenance and optimization prompts

### Complete Documentation  
- **[Getting Started Guide](GETTING_STARTED.md)** - Step-by-step setup walkthrough
- **[FAQ](docs/FAQ.md)** - Common questions and troubleshooting
- **[Architecture](docs/ARCHITECTURE.md)** - How the system works
- **[Contributing Guide](docs/CONTRIBUTING.md)** - How to contribute

## 📈 Project Status

- **Version:** 2.0.0 (Production Ready)
- **New Features:** Longterm memory system, audit scripts, maintenance utilities
- **Platforms:** Linux, macOS, Windows
- **Testing:** Automated CI/CD with GitHub Actions
- **License:** MIT

## ⚠️ Important Notes

- **Backup existing files**: The installer will prompt before overwriting
- **Git integration**: Optional but recommended for team collaboration
- **Privacy**: All memory is stored locally - nothing is sent to external services
- **Customization**: All templates can be modified after installation

## 🆘 Support

**Issues?** Check our [FAQ](docs/FAQ.md) or [open an issue](https://github.com/eschwa3/claude-code-memory-system/issues).

**Questions?** Start a [discussion](https://github.com/eschwa3/claude-code-memory-system/discussions).

---

**⭐ If this helps your Claude Code workflow, please star the repository!**