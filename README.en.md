# Claude Code One-Click Kit

> A Korean-first helper that **installs, runs, and manages Claude Code on Windows with a single double-click**.
> Written so that even **first-time** computer/AI/electronics users can follow along, with jargon kept to a minimum.

🌐 Korean docs: **[README.md](./README.md)** · Step-by-step guide: **[GUIDE.en.md](./GUIDE.en.md)** (Korean [사용설명서.md](./사용설명서.md))

---

## 📑 Table of Contents

1. [What is this?](#1-what-is-this)
2. [Quick Start (3 steps)](#2-quick-start-3-steps)
3. [Prerequisites / Required Programs](#3-prerequisites--required-programs)
4. [How to Download](#4-how-to-download)
5. [How to Install](#5-how-to-install)
6. [How to Run](#6-how-to-run)
7. [How to Use (How it Works)](#7-how-to-use-how-it-works)
8. [Full Menu Reference](#8-full-menu-reference)
9. [Commands](#9-commands)
10. [Full Workflow](#10-full-workflow)
11. [How to Update](#11-how-to-update)
12. [How to Uninstall](#12-how-to-uninstall)
13. [Troubleshooting](#13-troubleshooting)
14. [File / Doc / Install Locations](#14-file--doc--install-locations)
15. [Safety Notes](#15-safety-notes)
16. [License · Copyright · Commercial Use](#16-license--copyright--commercial-use)
17. [Disclaimer](#17-disclaimer)

---

## 1. What is this?

- **Claude Code** = an AI tool by Anthropic that **does work for you** (organizing files, summarizing documents, writing small programs) when you ask in plain language.
- **This One-Click Kit** = a small helper that lets you install, run, and manage Claude Code **with numbered menus instead of typing commands**.
- The kit runs from **two files**:
  - `Claude-Code_One-Click_Kit.bat` — the **launcher** you double-click
  - `menu.ps1` — the Korean **menu body** (the actual logic)
  - ⚠️ **These two files must stay together in the same folder.**

---

## 2. Quick Start (3 steps)

1. **Double-click** `Claude-Code_One-Click_Kit.bat`.
2. Choose **`1` Install** to install Claude Code. *(first time only)*
3. Choose **`3` Start** — Claude opens. The first time, a **browser login** appears once. → Done!

After that, just ask in plain language, e.g. `organize this folder`.

> 🖥️ **Afraid of the black window?** There is also a **Desktop app** (no terminal) → [claude.com/download](https://claude.com/download)
> A paid plan/account is still required.

---

## 3. Prerequisites / Required Programs

### Required
| Item | Detail |
|---|---|
| **OS** | Windows **10 (1809+)** or **Windows 11** |
| **Paid plan or account** | Claude **Pro** or **Max** subscription, or an Anthropic **API** account |
| **Internet** | Needed for install, login, and use |
| **Hardware** | 4 GB+ RAM, x64 or ARM64 |

> ❗ **A free Claude.ai account alone cannot use Claude Code.** (Anthropic policy)

### NOT required (no need to install)
- **Node.js / dev tools / Git** → not needed. The official **native installer** handles everything.
- `PowerShell` and `curl` used by the kit are **built into Windows**.

### Optional
- **Git for Windows** — lets Claude Code do a bit more in some tasks. Works fine without it.

---

## 4. How to Download

### (1) Get this kit
- The kit consists of **two files** (`Claude-Code_One-Click_Kit.bat`, `menu.ps1`) plus docs.
- If you got it from GitHub, **unzip it** and make sure the two files are **in the same folder**.

### (2) Get Claude Code (automatic)
- Pressing menu **`1` Install** downloads and installs it automatically from **Anthropic's official source**:
  - Official install script: `https://claude.ai/install.ps1`
- You do not need to download anything else manually.

---

## 5. How to Install

1. **Double-click** `Claude-Code_One-Click_Kit.bat` → the menu appears.
2. Choose **`1` Install** (use ↑↓ + Enter, or press the `1` key).
3. Read the notice and press **Enter** → installation runs automatically (1–2 min).
4. `Install complete!` means success.

> **Already installed?** The kit detects it and says "Already installed", without reinstalling.

### Manual install (reference)
In PowerShell:
```powershell
irm https://claude.ai/install.ps1 | iex
```

---

## 6. How to Run

1. **Double-click** `Claude-Code_One-Click_Kit.bat`.
2. Choose **`3` Start** → Claude Code opens.
   - It launches **immediately without asking for a folder** (start location: your user/home folder).
3. **On first run**, a browser opens for **login**. Log in as you normally would.

> To quit, type **`/exit`** (or `/quit`) inside Claude.

---

## 7. How to Use (How it Works)

- After login, just **ask in plain language** — no commands to memorize.
- Examples:
  - `sort the photos in this folder by date`
  - `make me a simple notepad program`
  - `summarize what this file is about`
- **How it works (brief):** the `.bat` launches the PowerShell menu (`menu.ps1`), which runs the official `claude` command. PowerShell renders the Korean UI to avoid character corruption.

---

## 8. Full Menu Reference

How to choose: **↑↓ arrows + Enter**, or press the **number key** directly. Quit with **`Q`**.

| No. | Function | What it does |
|:---:|---|---|
| **1** | Install | Installs Claude Code (first time). Skips if already present |
| **2** | Login/account guide | Explains which account you need and how login works |
| **3** | Start | **Runs Claude right away** (no folder prompt) |
| **4** | Help/commands | Shows in-app commands (`/help`, etc.) |
| **5** | Update | Updates to the latest version (`claude update`) |
| **6** | Diagnose/fix | Auto health check (`claude doctor`) + FAQ |
| **7** | Version | Shows installed version (`claude --version`) |
| **8** | Uninstall | Clean removal (2-step confirmation) |
| **Q** | Quit | Closes the kit |

---

## 9. Commands

### Inside Claude (type in the prompt)
| Command | Meaning |
|---|---|
| `/help` | Show all commands |
| `/exit` or `/quit` | Exit Claude Code |
| `/clear` | Start a fresh conversation (keeps project memory) |
| `/login` · `/logout` | Log in / log out |
| `/status` | Show current status |
| `/usage` | Show usage / cost |

### In the terminal (reference)
| Command | Meaning |
|---|---|
| `claude` | Run Claude Code |
| `claude --version` | Show installed version |
| `claude update` | Update to latest |
| `claude doctor` | Auto-diagnose install/config |

> The kit runs the terminal commands for you, so beginners never have to type them.

---

## 10. Full Workflow

```
[ Double-click Claude-Code_One-Click_Kit.bat ]
                │
                ▼
        ┌───────────────┐
        │  Korean menu  │  ← menu.ps1
        └───────────────┘
   First time:  [1] Install → [2] Login/account guide
   Use:         [3] Start → (first-time browser login) → work in plain language
   Manage:      [5] Update / [6] Diagnose / [7] Version / [8] Uninstall
```

1. **Install** `[1]` — once.
2. **Check login guide** `[2]` — know which account you need (optional).
3. **Start** `[3]` — run Claude. Browser login on first run.
4. **Use** — ask in plain language.
5. **Manage** — update / diagnose / uninstall as needed.

---

## 11. How to Update

- Menu **`5` Update** updates to the latest (`claude update`).
- Native installs **auto-update in the background**, so an occasional check is enough.

---

## 12. How to Uninstall

1. Choose menu **`8` Uninstall`**.
2. Pick one:
   - **[1] Program only** — keeps settings and chat history (reusable later).
   - **[2] Everything** — deletes settings, login, and history too. **Irreversible.**
3. "Everything" asks for **one more Y/N confirmation** to prevent mistakes.

> Removed locations: program `%USERPROFILE%\.local\bin\claude.exe`, config `%USERPROFILE%\.claude` and `%USERPROFILE%\.claude.json`

---

## 13. Troubleshooting

First, press menu **`6` Diagnose/fix** — the auto check (`claude doctor`) reports the cause.

| Symptom | Fix |
|---|---|
| `claude not recognized` | **Close** the window and **re-run** the kit (common right after install) |
| Login fails | Verify your paid plan/account and internet |
| Garbled characters | Right-click title bar → Properties → set font to **Malgun Gothic** or **D2Coding** |
| Install fails | Temporarily disable antivirus/security and retry, or check internet |
| `menu.ps1 not found` | Make sure `.bat` and `menu.ps1` are **in the same folder** |
| Menu shows but Korean is broken | Use Windows Terminal or change the font (above). Usually fine since it's PowerShell-based |

If it still fails, reinstall via menu **`1` Install**.

---

## 14. File / Doc / Install Locations

### Kit files (keep together)
| File | Role |
|---|---|
| `Claude-Code_One-Click_Kit.bat` | Double-click launcher (ASCII, opens the menu) |
| `menu.ps1` | Korean menu body (actual logic) |
| `README.md` / `README.en.md` | KO/EN reference |
| `사용설명서.md` / `GUIDE.en.md` | KO/EN step-by-step guide |
| `LICENSE` | Apache License 2.0 full text |
| `NOTICE` | Copyright/trademark/disclaimer |
| `README.pdf` / `README.en.pdf` | PDF version of the README (same folder) |
| `사용설명서.pdf` / `GUIDE.en.pdf` | PDF version of the guide (same folder) |

### Claude Code install locations (reference)
| Item | Path |
|---|---|
| Program | `%USERPROFILE%\.local\bin\claude.exe` |
| Config/login/history | `%USERPROFILE%\.claude` , `%USERPROFILE%\.claude.json` |

---

## 15. Safety Notes

- On first run, Windows SmartScreen may warn **"Windows protected your PC"** — normal for a downloaded file. → **More info → Run anyway**.
- The kit only uses **Anthropic's official URL (`https://claude.ai/install.ps1`)** for installation. It downloads nothing from other sources.
- The kit **does not collect or transmit** your personal data (runs locally).

---

## 16. License · Copyright · Commercial Use

> This section is written under **strict standards**. Please read before use.

### (1) This kit's license
- This kit (`Claude-Code_One-Click_Kit.bat`, `menu.ps1`, and docs) is distributed under the **Apache License 2.0**. Full text: [LICENSE](./LICENSE).
- **Copyright:** © 2026 **SoDam AI Studio**.
- Apache-2.0 permits **commercial use, modification, and redistribution**, provided you:
  - distribute the `LICENSE` and `NOTICE` files together;
  - state that you changed any modified files;
  - keep copyright/trademark/notice texts intact.

### (2) Rights to Claude Code and trademarks (important)
- This kit is an **unofficial** helper and is **not affiliated with, endorsed by, or sponsored by Anthropic**.
- This kit **does not bundle or redistribute** Claude Code. It only **downloads it from Anthropic's official source** at runtime.
- **"Claude", "Claude Code", "Anthropic"** are **trademarks of Anthropic**, used here only for identification/description.
- **Use of Claude Code itself** is governed entirely by **Anthropic's terms, policies, and license** (Anthropic Commercial Terms / Usage Policy).

### (3) Commercial use — keep these separate
| Subject | Commercial use |
|---|---|
| **This kit** (scripts/docs) | **Allowed** under Apache-2.0 (if conditions are met) |
| **Claude Code** (Anthropic product) | **Per Anthropic's terms.** Requires a paid plan/account. Check Anthropic's terms directly for scope |

> In short: **you may use the kit commercially, but commercial use of Claude Code is subject to Anthropic's separate terms.** Do not conflate the two.

---

## 17. Disclaimer

- This kit is provided **"AS IS"** with **no warranty of any kind**.
- **You are solely responsible** for any outcome or damage from using this kit.
- Install/uninstall features modify/delete files on your computer. **"Everything" removal is irreversible** — use with care.
- Fees, data handling, and the accuracy of outputs from Claude Code follow **Anthropic's terms** and your own responsibility.

---

© 2026 SoDam AI Studio · Apache License 2.0 · Unofficial helper (Not affiliated with Anthropic)
