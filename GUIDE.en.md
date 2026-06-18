# User Guide — Step-by-Step for Absolute Beginners

> Even if computers/AI/electronics are new to you, **just follow along**.
> Jargon is kept to a minimum. Take it one line at a time.

📘 Full reference: [README.en.md](./README.en.md) · 🌐 Korean: [사용설명서.md](./사용설명서.md)

---

## 0. What is this?

- **Claude Code** = an AI that **does work for you** (organizing files, writing small programs) when you **ask in plain language**, made by Anthropic.
- This **One-Click Kit** = a small helper that lets you install, run, and manage Claude Code by **just pressing numbers**, with no commands to memorize.
- The kit runs from **two files**. **Keep them together in the same folder.**
  - `Claude-Code_One-Click_Kit.bat` → the file you double-click
  - `menu.ps1` → the Korean menu (actual logic)

---

## 1. Before you start (2 things)

1. **A paid plan or account**
   - Claude **Pro** or **Max** subscription, or an Anthropic **API** account.
   - ❗ **A free Claude.ai account will not work.** (Anthropic policy)
2. **Internet connection**

> No need to install Node.js or dev tools — the kit installs everything the official way.

---

## 2. How to choose a menu item (learn this first)

Double-click `Claude-Code_One-Click_Kit.bat` and a menu appears. There are **two ways** to choose — use whichever is easier.

- **Way A (easy):** Use **↑ ↓ arrows** to move to a line → **Enter**.
  - The current line is **highlighted**, so you confirm with your eyes before pressing — **fewer mistakes.**
- **Way B (fast):** Just press a **number key** (1–8) — it runs immediately (no Enter needed).
- **Quit:** the **`Q`** key.
- Press a wrong key? It tells you *"No such number, please choose again."*

---

## 3. Install (first time only)

1. **Double-click** `Claude-Code_One-Click_Kit.bat`.
   - (`menu.ps1` must be in the same folder)
2. Choose **`1` Install**.
3. Read the notice (requirements, official URL), press **Enter**, and installation runs automatically (1–2 min).
4. `Install complete!` means success.

### ⚠️ "Windows protected your PC" warning
- This is a **normal warning** for a file downloaded from the internet.
- Click the small **More info** link → then **Run anyway**.

### Already installed?
- The kit detects it and says *"Already installed"* without reinstalling. Just go to [3] Start.

---

## 4. Check the login/account guide (optional)

If you're unsure, press menu **`2` Login/account guide**. It explains:
- Which account you need (Pro/Max or API)
- How login works (the browser opens automatically the first time you press [3] Start)
- How to switch accounts (inside Claude: `/login`, `/logout`)

---

## 5. Start (open Claude)

1. Choose menu **`3` Start**.
2. Claude Code **opens right away** (it doesn't ask for a folder).
3. **On first run, a login screen appears.** The browser opens automatically — log in as you normally would.

---

## 6. Actually using it

- After login, just **ask in plain language** — no commands to memorize.
- Examples:
  - `sort the photos in this folder by date`
  - `make me a simple notepad program`
  - `summarize what this file is about`

### Handy commands (also in kit menu `4`)
Type these in the Claude prompt. *(usually not needed)*

| Command | Meaning |
|---|---|
| `/help` | Show all commands |
| `/exit` or `/quit` | Exit |
| `/clear` | Start a fresh conversation (keeps memory) |
| `/login` · `/logout` | Log in / log out |
| `/status` | Show current status |
| `/usage` | Show usage and cost |

### To quit
- Type **`/exit`** inside Claude; it closes and returns to the kit menu.

---

## 7. Update (get the latest)

- Menu **`5` Update** updates to the latest version.
- Native installs **auto-update in the background**, so an occasional check is enough.

---

## 8. When something goes wrong

First, press menu **`6` Diagnose/fix**. The auto check (`claude doctor`) reports what's wrong.

| Symptom | Fix |
|---|---|
| `claude not recognized` | **Close** the window and **re-run** the kit (common right after install) |
| Login fails | Verify your paid plan/account and internet |
| Garbled characters | Right-click title bar → Properties → font to **Malgun Gothic** or **D2Coding** |
| Install fails | Temporarily disable antivirus and retry, or check internet |
| `menu.ps1 not found` | Make sure `.bat` and `menu.ps1` are **in the same folder** |

If it still fails, reinstall via menu **`1` Install**.

---

## 9. Check the version

- Menu **`7` Version** shows the installed version. (Helpful to mention when asking for support.)

---

## 10. Clean uninstall

1. Choose menu **`8` Uninstall**.
2. Pick one:
   - **[1] Program only** → keeps settings and chat history (reusable later).
   - **[2] Everything** → deletes settings, login, and history too. **Irreversible.**
3. "Everything" asks for **one more Y/N confirmation** to prevent mistakes.

---

## 11. File/folder locations

- **Kit files**: `Claude-Code_One-Click_Kit.bat`, `menu.ps1`, `README.en.md`, `GUIDE.en.md`, `LICENSE`, `NOTICE`, and PDF docs (`README.en.pdf`, `GUIDE.en.pdf`, etc.) — all in **one folder**.
- **Where Claude Code installs**: `your user folder\.local\bin\claude.exe`
- **Settings/login/history**: the `your user folder\.claude` folder and `.claude.json`

---

## 12. FAQ

**Q. Does it cost money?**
A. The kit is free. But using Claude Code requires Anthropic's **paid plan or API** (paid).

**Q. Is it safe?**
A. Installation only comes from **Anthropic's official URL**. The kit downloads nothing else and collects no personal data.

**Q. The black window scares me.**
A. You only need arrows and numbers. If it still bothers you, use the **Desktop app** ([claude.com/download](https://claude.com/download)) — no terminal needed.

**Q. Can I keep just one of the two files?**
A. No. `.bat` and `menu.ps1` must **both be in the same folder**.

---

## 13. License/copyright (summary)

- This kit: **Apache License 2.0**, © 2026 SoDam AI Studio. Commercial use/modification/redistribution allowed (conditions: ship LICENSE & NOTICE, state changes, keep notices).
- This kit is an **unofficial** helper, **not affiliated with Anthropic**. Claude Code itself and its **commercial use** follow **Anthropic's terms**. (Details in [README.en.md](./README.en.md) §16)

---

Contact/License: [README.en.md](./README.en.md) / [LICENSE](./LICENSE) / [NOTICE](./NOTICE)
