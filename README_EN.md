# Claude Code One-Click Kit

> A one-click Windows launcher for Claude Code — just double-click and go.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue.svg)]()
[![Made by SoDam AI Studio](https://img.shields.io/badge/Made%20by-SoDam%20AI%20Studio-purple.svg)]()

---

## What is this?

Claude Code is an AI-powered coding tool that lets you build software through conversation.  
But opening a terminal and typing commands every time can be a hassle.

This single `.bat` file removes that friction entirely.

- **Auto-install check** — Installs Claude Code automatically if not found
- **Project auto-detect** — Detects project files and launches immediately
- **Menu-driven** — No terminal commands needed

---

## Features

| Menu | Description |
|------|-------------|
| **[0] AUTO** | Auto-detect project files in current folder and launch (Recommended) |
| **[1] HERE** | Launch Claude Code in the current folder |
| **[2] DESKTOP** | Navigate to Desktop and launch |
| **[3] DOCUMENTS** | Navigate to Documents and launch |
| **[4] DOWNLOADS** | Navigate to Downloads and launch |
| **[5] NEW PROJECT** | Create a new project folder and start immediately |
| **[6] SELECT FOLDER** | Pick any folder or type a custom path |
| **[Q] EXIT** | Quit |

---

## How to Use (No coding experience needed)

### Requirements

- **Windows 10 or 11** PC
- **Internet connection** (for initial installation)
- **Node.js** — Install below if you don't have it

### Install Node.js (one-time setup)

1. Visit [nodejs.org](https://nodejs.org)
2. Click the **LTS version** download button
3. Run the installer and click "Next" through the prompts

### Launch Claude Code

1. **Double-click** `Claude-Code_One-Click_Kit.bat`
2. On first run, Claude Code installs automatically (1–2 minutes)
3. When the green menu appears, type **0** and press Enter
4. Claude Code is now running!

> **Tip:** Just press `0`. It's the easiest option.

### Start a New Project

1. Double-click the batch file
2. Type **5** → Enter
3. Choose where to save (options 1–4)
4. Enter a project name
5. The folder is created and Claude Code starts automatically

---

## Folder Structure

```
Claude-Code_One-Click_Kit/
├── Claude-Code_One-Click_Kit.bat   ← This is all you need
├── README.md                        ← Korean Guide
└── README_EN.md                     ← English Guide (this file)
```

---

## FAQ

**Q. The window flashes and closes immediately.**  
A. Right-click `Claude-Code_One-Click_Kit.bat` → "Run as administrator".

**Q. I see "npm is not recognized" error.**  
A. Node.js is not installed. Download it from [nodejs.org](https://nodejs.org).

**Q. How do I log in to Claude Code?**  
A. Claude Code will prompt you to sign in with your Anthropic account on first launch. Follow the on-screen instructions.

**Q. Does this work on Windows 7 or 8?**  
A. No. Windows 10 or later is required.

---

## System Requirements

| Item | Minimum |
|------|---------|
| OS | Windows 10 (64-bit) or later |
| Node.js | v18 or higher |
| Internet | Required for first-time installation |
| Permissions | Standard user (no admin required) |

---

## License

MIT License © 2026 SoDam AI Studio  
See the [LICENSE](LICENSE) file for details.

---

## Made by

**SoDam AI Studio**  
Building AI tools that anyone can use.
