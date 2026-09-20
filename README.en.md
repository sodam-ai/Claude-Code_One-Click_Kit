# Claude Code One-Click Kit

> A **Korean-first helper** that installs, runs, and manages Claude Code on Windows using **only numbers and arrow keys**.
> Written so that people using computers, AI, or electronic devices for the **first time** can follow along, with jargon explained in plain words.

**한국어**: [README.md](./README.md) · [README.html](./README.html) / **English**: [README.en.md](./README.en.md) · [README.en.html](./README.en.html)

Document date: 2026-09-20 · License: Apache License 2.0 · Unofficial helper (not affiliated with Anthropic)

> **Please read these 5 points before you start**
>
> 1. This kit is **unofficial**. Claude Code is a product of Anthropic; this kit is not affiliated with, endorsed by, or sponsored by Anthropic.
> 2. Using Claude Code requires a **paid plan or account**. A free Claude.ai account alone is not enough.
> 3. This kit is **Windows only**. (It does not work on macOS, Linux, or phones.)
> 4. Menu **[3] Start** launches Claude Code **and passes every fixed disk in your computer (C:, D:, and so on) as an "additional working directory".** Please read [13. Security and Data Flow](#13-security-and-data-flow).
> 5. Menu **[8] Uninstall** **really deletes files.** "Delete everything" in particular cannot be undone.

> **The kit's screens are in Korean.** The menu text, prompts, and messages are shown in Korean. This English guide translates every screen you will meet (see 7-2 and the tables in each section).

## Table of Contents

- [1. What is this kit?](#1-what-is-this-kit)
- [2. Prerequisites and Required Software](#2-prerequisites-and-required-software)
- [3. How to Download](#3-how-to-download)
- [4. How to Install](#4-how-to-install)
- [5. Quick Start (3 Steps)](#5-quick-start-3-steps)
- [6. How to Run](#6-how-to-run)
- [7. How to Use](#7-how-to-use)
- [8. How It Works](#8-how-it-works)
- [9. Command Reference](#9-command-reference)
- [10. Automatic Folder Registration (Optional)](#10-automatic-folder-registration-optional)
- [11. Workflow](#11-workflow)
- [12. How to Uninstall](#12-how-to-uninstall)
- [13. Security and Data Flow](#13-security-and-data-flow)
- [14. Troubleshooting](#14-troubleshooting)
- [15. Frequently Asked Questions (FAQ)](#15-frequently-asked-questions-faq)
- [16. Update Summary](#16-update-summary)
- [17. File and Document Locations](#17-file-and-document-locations)
- [18. License · Copyright · Trademarks · Commercial Use](#18-license--copyright--trademarks--commercial-use)
- [19. Disclaimer](#19-disclaimer)

## 1. What is this kit?

**Claude Code** is an AI tool made by Anthropic. You tell it what to do in plain language (Korean included) and it helps with jobs such as organizing files, summarizing documents, and building small programs. It is normally started by typing commands in a "black window" (a terminal).

The **One-Click Kit** is a small helper that **turns those hard-to-remember commands into a numbered menu.** It works with two files:

- `Claude-Code_One-Click_Kit.bat` — the **launcher** you double-click
- `menu.ps1` — the **main program** that contains the Korean menu

> The two files must always be in the **same folder**. If you move only one of them, the kit will not start.

### Plain-language glossary

| Term | What it means |
|---|---|
| Terminal (black window) | A window where you give the computer instructions as text. This kit's menu also appears in it. |
| PowerShell | A text-command program that already comes with Windows. This kit's menu runs on top of it. You do not have to install it. |
| Folder | A container for files (a directory). Claude Code works based on the folder you started it in. |
| Login | Proving the account is yours. On first start, Claude Code opens your web browser so you can log in. |
| Plan | A kind of paid Claude subscription: Pro, Max, Team, Enterprise, and so on. |
| Install script | A small bundle of commands that downloads and sets up a program. This kit uses only the one from Anthropic's official address. |
| Hook | A small program that runs automatically when another program does something. In this kit it is used only by the **optional feature** ([Chapter 10](#10-automatic-folder-registration-optional)). |
| Node.js | A tool for running JavaScript programs. The kit itself does not need it; only the **optional feature (Chapter 10)** does. |

### What the kit does / does not do

| It does | It does not |
|---|---|
| Shows a numbered menu. | **Bundle or redistribute Claude Code.** (It downloads it from the official address when you run it.) |
| Runs Claude Code's official install script. | **Handle accounts, payments, or API keys.** Claude Code handles login through your browser. |
| Starts Claude Code in the folder you choose. | **Update itself automatically.** You must download a new kit yourself. |
| Runs the update, diagnose, and version commands for you. | Support macOS or Linux. |
| Removes Claude Code (only if you choose to). | Contain any code that **collects or sends your information elsewhere.** (Except one request to download the install script; see [Chapter 13](#13-security-and-data-flow).) |

## 2. Prerequisites and Required Software

### 2-1. Checklist

- ☐ A computer with Windows 10 (version 1809 or later) or Windows 11
- ☐ An internet connection (needed for installing, logging in, and using)
- ☐ A web browser (used to open the login page)
- ☐ **A paid Claude plan or account** (see the table below)
- ☐ The kit files (Chapter 3 explains how to get them)

### 2-2. What you need and what you do not

| Item | Required? | Notes |
|---|---|---|
| Windows 10 1809 or later / Windows 11 | **Required** | Official Claude Code requirement. The kit was tested on Windows 11 on the author's PC; behavior on Windows 10 is **unconfirmed**. |
| 4 GB or more RAM, x64 or ARM64 processor | **Required** | Official Claude Code requirement. |
| Internet connection | **Required** | |
| A Claude account (Pro, Max, Team, Enterprise, or Console) | **Required** | The free Claude.ai plan does not include Claude Code. |
| Being in a country supported by Anthropic | **Required** | Official Anthropic requirement. See the list at [anthropic.com/supported-countries](https://www.anthropic.com/supported-countries). |
| Windows PowerShell 5.1 | Required (built in) | Included with Windows 10 and 11. **You do not need to install it.** |
| Node.js | **Not needed** | Not needed for Claude Code or for the kit itself. (Only the optional feature in Chapter 10 needs it.) |
| Git for Windows | Optional | If present, Claude Code can use its Bash tool. If absent, Claude Code uses PowerShell instead and works normally. |
| Administrator rights | **Not needed** | The official documentation says installing Claude Code does not require administrator rights. |

> These requirements come from Anthropic's official setup page (<https://code.claude.com/docs/en/setup>), **checked on 2026-09-20**. Anthropic may change them, so please check the official page before installing.

**Does the black window feel scary?** There is also a mouse-driven **Claude desktop app** ([claude.com/download](https://claude.com/download)). You do not need this kit for it, and the same account requirements apply.

## 3. How to Download

### 3-1. Getting the kit

Repository: <https://github.com/sodam-ai/Claude-Code_One-Click_Kit>

**Method A. Download a ZIP (easiest)**

1. Open the address above in your browser.
2. Click the green **Code** button, then **Download ZIP**.
3. **Right-click the ZIP file and choose "Extract All..."** (or a similar "extract" command). If you run the kit from inside the ZIP, it cannot find `menu.ps1` and fails.
4. Check that `Claude-Code_One-Click_Kit.bat` and `menu.ps1` are **both** in the extracted folder.

**Method B. Use git (if you know Git)**

```
git clone https://github.com/sodam-ai/Claude-Code_One-Click_Kit.git
```

**Recommended location:** a short folder path without special characters, for example `C:\ClaudeKit`. The launcher wraps the path in quotes so Korean characters and spaces are handled, but not every combination was tested. If you run into trouble, move the folder to a short English path.

> **The files you download may differ from this document.** The repository's release tag `v1.0.0` is the **initial version** from 2026-04-20; the folder picker, sorting, and other features described here were added after it. After downloading, press [3] Start: if a screen titled **"어느 폴더에서 시작할까요?" ("Which folder should we start in?")** appears, your version matches this document. If not, it is an older version. (GitHub state checked on 2026-09-20: a public repository, default branch `main`, only one release `v1.0.0`, and the last update to `main` was on 2026-06-18. **Until the new features described in this document are uploaded to the repository, the files you download do not have the folder picker screen.**)

**When Windows shows a warning**

- On first run you may see **"Windows protected your PC"** (shown in Korean on a Korean Windows: "Windows의 PC 보호"). This is a common warning for executable files downloaded from the internet. Click **More info → Run anyway**. If you are unsure about where you got the files, do not run them.
- If it still blocks you: right-click the file (`.bat` and `menu.ps1`) → **Properties** → tick **"Unblock"** at the bottom → OK.

### 3-2. Getting Claude Code (automatic)

- Choosing **[1] Install** in the kit downloads the install script from **Anthropic's official address** `https://claude.ai/install.ps1` and runs it immediately. You do not have to download anything else.
- To install without the kit (Anthropic's official instructions, in PowerShell):

```
irm https://claude.ai/install.ps1 | iex
```

- WinGet (`winget install Anthropic.ClaudeCode`) is another official method. Note that a WinGet install **does not update automatically** and is **not removed** by the kit's [8] Uninstall. (Remove it with WinGet.)

## 4. How to Install

### 4-1. Installing Claude Code (once)

1. **Double-click** `Claude-Code_One-Click_Kit.bat`. A Korean menu appears in a black window.
2. **Use the ↑↓ arrow keys to choose `1 설치하기` (Install) and press Enter.** (Pressing the number `1` key also works.)
3. The screen lists what you need (a paid plan, internet) and the install address. After reading, press **Enter** to start. (To cancel, close the window.)
4. Wait **1–2 minutes.** When you see `설치 완료!` ("Installation complete!"), it worked.
5. If you see `설치는 됐지만 이 창에서 아직 인식이 안 돼요` ("Installed, but this window doesn't recognize it yet"), **close the window and run the kit again.** This is common right after installing and is normal.

If it is already installed, the kit says `이미 설치되어 있어요.` ("Already installed.") and **does not install again.**

### 4-2. (Optional) Installing automatic folder registration

Install this only if you want folders you moved into by telling Claude `cd folder-path` in chat to **appear automatically in the [3] Start list.** See [Chapter 10](#10-automatic-folder-registration-optional) for details.

1. Install **Node.js** (<https://nodejs.org>).
2. In the kit folder, open the `tools\cd-hook` folder and **double-click** `install-cd-hook.cmd`.
3. If you see `[완료]` ("Done") and `자체 테스트: 통과` ("Self-test: passed") at the end, it worked.
4. It takes effect in a **new Claude Code session.**

## 5. Quick Start (3 Steps)

1. **Double-click** `Claude-Code_One-Click_Kit.bat`.
2. Choose **`1` Install** to install Claude Code. *(Only the first time.)*
3. Choose **`3` Start**. On the top **`D` (type a path manually)** line, press Enter and paste a folder path, or pick a folder from the list and press Enter. The first time, a **browser login** appears once. → Done!

After that, just tell it what to do. Example: `Sort the photos in this folder by date`

## 6. How to Run

**Everyday start (every time)**

1. Double-click `Claude-Code_One-Click_Kit.bat`.
2. In the menu, choose **`3` Start**.
3. Pick the folder you want from the **"어느 폴더에서 시작할까요?" ("Which folder should we start in?")** list and press Enter. (How to choose: [7-3](#7-3-the-folder-picker-screen-option-3).)
4. If that folder is being opened for the **first time**, a notice appears. Read it and follow [7-4](#7-4-the-do-you-trust-this-folder-prompt-in-a-folder-opened-for-the-first-time).
5. Claude Code starts. **On the very first start, your browser opens for login.** Log in the way you normally do.

**How to quit:** inside Claude, type `/exit` (or `/quit`). When you are back in the kit, press **Enter** to continue, and press **Q** (or Esc) in the menu to close the kit.

**If the menu does not start:** if the black window says `Could not start the menu`, check that `.bat` and `menu.ps1` are in the **same folder**. See [Chapter 14](#14-troubleshooting) for more.

## 7. How to Use

### 7-1. Menu controls

| Key | What it does |
|---|---|
| `↑` `↓` | Choose an item. (Going past the end wraps around.) |
| `Enter` | Run the chosen item. |
| Number `1`–`8` | Run that number **immediately.** |
| `Q` or `Esc` | Close the kit. |

The top of the screen shows `상태  설치됨` ("Status: installed", or `아직 설치 안 됨`, "not installed yet") and your Windows user name.

### 7-2. Full menu description

| No. | Name (on screen, Korean) | What it does |
|:---:|---|---|
| **1** | 설치하기 (Install) | Installs Claude Code. Skips if already installed. |
| **2** | 로그인·계정 안내 (Login and account guide) | Explains which account you need and how to log in. (Read-only.) |
| **3** | 시작하기 (Start) | Lets you choose a folder, then starts Claude Code. |
| **4** | 도움말·명령어 (Help and commands) | Shows the commands you can use inside Claude. (Read-only.) |
| **5** | 업데이트 (Update) | Runs `claude update`. |
| **6** | 진단·문제 해결 (Diagnose / troubleshoot) | Checks the installation with `claude doctor` and shows common problems. |
| **7** | 버전 확인 (Check version) | Runs `claude --version`. |
| **8** | 제거 (Uninstall) | Removes Claude Code. (See [Chapter 12](#12-how-to-uninstall).) |
| **Q** | 종료 (Quit) | Closes the kit. |

If Claude Code is not installed, items 3, 5, 6, and 7 say `아직 설치가 안 돼 있어요` ("It is not installed yet") and **tell you to do item 1 first.**

### 7-3. The folder picker screen (option 3)

Claude Code works **inside the folder it was started in**, so you choose a folder before it starts.

```
  ══════ 어느 폴더에서 시작할까요? ══════

   ▶ [D ]  경로 직접 입력                          목록에 없는 폴더
     [0 ]  홈 폴더                                지금까지 방식
     [1 ]  (recently used folder name)
     [2 ]  (recently used folder name)

   고른 곳 :  (full path of the highlighted line)
   ↑↓ 로 고르고 Enter.   숫자·D 키는 그 줄로 이동.   S: 정렬 전환.   취소는 Esc.   [정렬: 수정 최신순]
```

(The layout is an example. Real folder names and colors will differ.)

**When it first opens, the cursor is on the top `D` (type a path manually) line.** To start a new project, just press **Enter and paste the folder path.** To start in your home folder, press `↓` once (or the `0` key) and then Enter.

> **Why not start in the home folder and move with `cd`?** In what was observed while building this kit, even if you move the working folder with `cd` inside Claude, it **goes back to the original folder on the next command.** (This may differ between Claude Code versions.) So Claude must be **started in the folder you will work in**, and for a new project folder the `D` line is the most reliable way in.

| Screen text | Meaning |
|---|---|
| 어느 폴더에서 시작할까요? | Which folder should we start in? |
| 홈 폴더 / 지금까지 방식 | Home folder / the way it worked before |
| 경로 직접 입력 / 목록에 없는 폴더 | Type a path manually / a folder that is not in the list |
| 고른 곳 | Selected |
| ↑↓ 로 고르고 Enter. 숫자·D 키는 그 줄로 이동. S: 정렬 전환. 취소는 Esc. | Choose with ↑↓ and press Enter. Number and D keys jump to that line. S: change sort order. Esc: cancel. |
| ▲ 위에 더 있어요 / ▼ 아래에 더 있어요 | More above / more below |

| Key | What it does |
|---|---|
| `↑` `↓` | Choose a line. |
| `Enter` | Start Claude Code in the chosen folder. |
| Numbers, `D` | **Only jump** to that numbered line. (It does not run immediately, so confirm with Enter. This prevents mistakes with two-digit numbers such as 10 and above.) |
| `Home` `End` | Jump to the top / bottom. |
| `PageUp` `PageDown` | Scroll one screen at a time. |
| `S` | **Change the sort order** (table below). |
| `Esc` | Cancel and go back to the menu. |

**Where do the folders in the list come from?**

- Folders where you have **actually started** Claude Code before (from the project list Claude Code records in `.claude.json`)
- (If you installed the optional feature) folders you moved into with `cd` in chat (`menu-extra-folders.txt`, [Chapter 10](#10-automatic-folder-registration-optional))
- Automatically **left out:** your own user folder itself, the Windows folder, folders that no longer exist, and duplicates.
- If there are more lines than fit on screen, `▲ 위에 더 있어요` / `▼ 아래에 더 있어요` appear and the list **scrolls.** There is no limit on the number of folders.
- For a folder that is not in the list (a new project included), press Enter on the top **`D` line** and **paste the folder path.** (Pressing Enter with nothing typed cancels. If the folder does not exist, it says `그런 폴더가 없어요`, "No such folder".)

**The `S` key sort orders (each press moves to the next, in a loop)**

| Step | Name (on screen, Korean) | Order |
|:---:|---|---|
| 1 | 수정 최신순 (Modified, newest first) (default) | Folders with the most recent "date modified" first |
| 2 | 수정 오래된순 (Modified, oldest first) | Oldest "date modified" first |
| 3 | 생성 최신순 (Created, newest first) | Most recently created folders first |
| 4 | 생성 오래된순 (Created, oldest first) | Oldest created folders first |
| 5 | 이름순 (Name, A to Z) | By folder name, ascending |
| 6 | 이름역순 (Name, Z to A) | By folder name, descending |

- Changing the sort order **keeps the folder you have selected.** `경로 직접 입력` (Type a path manually) always stays at the top and `홈 폴더` (Home folder) always stays fixed on the second line. (Sorting applies only to the folders below them.)
- The sort order is **not saved.** Each time you open option 3 it starts with "Modified, newest first".
- "Date modified" is a value Windows stores for the folder; it usually changes when a file is created or deleted **directly inside** that folder.

> **When arrow keys cannot be read** (for example, in automated runs where input is redirected), the picker automatically switches to a **type-a-number style.** You type a number and press Enter; pressing Enter alone means `0`, the home folder.

### 7-4. The "Do you trust this folder?" prompt (in a folder opened for the first time)

In a folder it has never opened, Claude Code asks once: **"Do you trust this folder?"** The **default choice is `No, exit`**, so pressing Enter without thinking simply closes it. The kit therefore warns you in advance.

1. A notice appears: `[이 폴더는 Claude 로 처음 여는 곳이에요]` ("This folder is being opened with Claude for the first time").
2. When Claude's question appears shortly after, **press the down arrow (↓) to select `Yes, I trust this folder` and press Enter.**
3. Once done, that folder will not ask again.

> If the folder came from a source you do not trust, do not choose `Yes`. It lets Claude read and run things in that folder.

### 7-5. How to give Claude instructions

After logging in, there are no commands to memorize; just **talk to it naturally.**

- `Sort the photos in this folder by date`
- `Make me a simple notepad program`
- `Summarize what this file is about`

Tips:

- Be **specific.** ("Move the photos into folders by date" is better than "tidy up".)
- Ask for **one thing at a time.**
- Before asking it to delete or move files, **copy the important ones.** AI can make mistakes too.
- When Claude asks "may I do this?", **read what it wants to do** before you allow it.

## 8. How It Works

Here is what the kit does inside, step by step, explained without code.

1. **The `.bat` runs:** `Claude-Code_One-Click_Kit.bat` runs `powershell -NoProfile -ExecutionPolicy Bypass -File menu.ps1`. (The menu lives in PowerShell so Korean text displays safely; the `.bat` uses English (ASCII) only. `Bypass` applies to **this one window only** and does not change your Windows settings.)
2. **PATH boost:** so that `claude` can be found even right after installing, the kit adds `%USERPROFILE%\.local\bin` and `%APPDATA%\npm` to the search path for this window only.
3. **Menu:** it reads arrow keys and numbers and runs the chosen feature.
4. **[1] Install:** it first checks whether `claude` exists; if not, it downloads and runs the official install script.
5. **[3] Start:**
   1. It builds a list of fixed disks. (For example `C:/`, `D:/`)
   2. It builds the folder list and you choose a folder.
   3. It moves into that folder (`Set-Location`). If that fails (the folder was deleted or renamed), it stops and tells you.
   4. It only **reads** whether Claude already records that folder as "trusted"; if not, it shows the 7-4 notice.
   5. It runs `claude --add-dir <fixed disks>`. (If it finds no disks, plain `claude`.)
6. **[5][6][7]:** they run `claude update`, `claude doctor`, and `claude --version` as they are.
7. **[8] Uninstall:** see Chapter 12.

That is all the kit does. **The AI's answering itself is done by Claude Code (Anthropic).**

## 9. Command Reference

### 9-1. Commands inside Claude (type in the input box)

| Command | Meaning |
|---|---|
| `/help` | Show all commands |
| `/exit` or `/quit` | Quit Claude Code |
| `/clear` | Start a new conversation (memory is kept) |
| `/login` · `/logout` | Log in / log out (to switch accounts) |
| `/status` | Show current status |
| `/usage` | Check usage and cost |

This matches the list in the kit's [4] Help. Claude Code's commands can change between versions; use `/help` for the exact list.

### 9-2. Commands you can type in a terminal yourself (for reference)

| Command | Meaning | Kit menu |
|---|---|---|
| `claude` | Start Claude Code | 3 |
| `claude --version` | Check the installed version | 7 |
| `claude update` | Update to the latest version | 5 |
| `claude doctor` | Check installation and settings (read-only) | 6 |

The kit menu runs these for you, so beginners do not need to type them.

### 9-3. Optional feature tool commands (`tools\cd-hook` folder, Node.js required)

| Command | Meaning |
|---|---|
| Double-click `install-cd-hook.cmd` | Install automatic folder registration |
| `node install-cd-hook.cjs --dry-run` | **Only shows what it would do**, without installing (writes nothing) |
| `node check-cd-hook.cjs` | Check the installation (read-only) |

> Besides `--dry-run`, the installer **stops without doing anything if you give an unknown option (for example the typo `--dryrun`).** This keeps a typo from turning into a real installation.

## 10. Automatic Folder Registration (Optional)

### 10-1. Why is it useful?

The option 3 list shows folders where you have **actually started** Claude Code. But a folder you moved into with `cd folder-path` while chatting with an already-running Claude is not in that record, so it does not appear. This optional feature **adds such folders to the list automatically.**

### 10-2. How does it work?

- Using Claude Code's **hook** feature, a small program (`cd-folder-register.cjs`) runs just before a Bash or PowerShell command is executed.
- That program looks in the command text for a **folder path with a drive letter** after `cd` or `Set-Location` (`sl`). If the folder really exists, it adds one line to `%APPDATA%\claude-code\menu-extra-folders.txt`. (It does not add it twice.)
- It **never blocks or changes the command.** Whatever error occurs, it silently lets the command through.
- Each command takes about **0.1 second** longer. (Author's PC measurement: about 95 ms on average.)

### 10-3. Paths that are not registered (on purpose)

- Your own user folder, the Windows folder, anything inside `node_modules`, the Claude settings folder, and the `Temp\claude` temporary folder
- Folders that do not exist, files, and relative paths without a drive letter (such as `cd ..`)
- Commands that **start with** `echo`, `printf`, `Write-Host`, `Write-Output`, `cat`, or `type` (they only print text and do not move anywhere)

### 10-4. What the installer does (safety measures)

- It copies the hook file into `hooks` in the Claude settings folder (the `CLAUDE_CONFIG_DIR` environment variable, or `%USERPROFILE%\.claude` if it is not set).
- In `settings.json` in the same settings folder, it **only appends** two hook entries (Bash and PowerShell). Your existing settings stay as they are.
- It makes a **backup before** changing (`settings.json.bak-cd-hook-datetime`), **re-reads and verifies after** changing, and **automatically restores the original** if anything looks wrong.
- Running it several times gives the same result. (If already registered, it only says "already registered".)
- If `settings.json` is broken or has an unexpected format, it **stops without touching it.**
- At the end it runs a self-test in a temporary folder. (It does not touch your real registration file.)
- It **never modifies `.claude.json`.**

**To undo:** copy `settings.json.bak-cd-hook-datetime` over `settings.json` and you are back to the state before installation.

### 10-5. Limits (please note)

- This feature applies **only to this PC's Claude settings.** On another PC you must install it again on that PC.
- If Claude Code changes its hook feature, this may stop working. If a folder does not show up, see [Chapter 14](#14-troubleshooting).
- The hook runs on **every Bash and PowerShell command in every project.** (It only reads the command text and does not store it.)

## 11. Workflow

**For first-time users**

```
[ Double-click Claude-Code_One-Click_Kit.bat in the kit folder ]
                       │
                       ▼
             [ The Korean menu appears ]
                       │
        ┌──────────────┴───────────────┐
        ▼                              ▼
  [1] Install ──(optional)──▶ [2] Read the login/account guide
        │
        ▼
  [3] Start ─▶ Choose a folder ─▶ (if first time in that folder) trust notice
        │
        ▼
  Claude Code starts ─▶ (first time) browser login ─▶ give instructions in your language
        │
        ▼
  Type /exit ─▶ back in the menu ─▶ press Q to quit
```

**For everyday users**

```
Double-click .bat ─▶ [3] Start ─▶ Choose a folder ─▶ Use Claude ─▶ /exit ─▶ Q
```

**Occasional maintenance**

```
[5] Update  /  [6] Diagnose  /  [7] Check version  /  [8] Uninstall
```

## 12. How to Uninstall

### 12-1. Removing with the kit (menu 8)

1. Choose **`8` Uninstall** in the menu.
2. Choose one of three:
   - **[1] Remove the program only** — your settings, login, and conversation history are **kept.** (You can reinstall and continue later.)
   - **[2] Delete everything** — removes the program, **then** also removes settings, login, and conversation history. **This cannot be undone.**
   - **[3] Cancel**
   - Any other input (for example `9` or `n`) **deletes nothing**; it says `그 번호는 없어요` ("No such number") and goes back.
3. **Even if you choose [2], the program is removed first, immediately.** Then it asks `[경고] 설정·로그인·대화기록을 모두 삭제합니다. 정말 진행할까요?` ("[Warning] This deletes all settings, login, and conversation history. Continue?") with **Y/N**, and that question applies **only to deleting the settings.** If you answer `N`, the settings and history stay, but the program has already been removed.

**What gets removed, and where**

| What | Location | [1] | [2] |
|---|---|:---:|:---:|
| Program | `%USERPROFILE%\.local\bin\claude.exe` | Removed | Removed |
| Program files | `%USERPROFILE%\.local\share\claude` | Removed | Removed |
| npm global package | Runs `npm uninstall -g @anthropic-ai/claude-code`. (Its output is hidden so nothing shows on screen.) | Removed | Removed |
| Settings, login, conversation history | `%USERPROFILE%\.claude` folder, `%USERPROFILE%\.claude.json` file | Kept | Removed if Y |

**What the kit does not remove**

- Claude Code installed another way, such as WinGet (remove it that same way)
- The VS Code extension, the JetBrains plugin, and the desktop app (remove each separately. They also use `%USERPROFILE%\.claude`, so the folder can reappear if any of them remain.)
- If you moved the Claude settings folder somewhere else, that folder (for example `%APPDATA%\claude-code`)
- **The kit files themselves**, `menu-extra-folders.txt`, the optional hook, and the hook entries in `settings.json`

### 12-2. Removing the optional feature (automatic folder registration)

1. In `settings.json`, delete the two entries that contain `cd-folder-register.cjs` (Bash and PowerShell), or overwrite the file with the pre-install backup (`settings.json.bak-cd-hook-datetime`).
2. If you want, also delete `hooks\cd-folder-register.cjs`, `%APPDATA%\claude-code\menu-extra-folders.txt`, and `cd-hook-errors.log`.

## 13. Security and Data Flow

This chapter says plainly what runs, what is read, and what leaves your computer. It is based on **reading the kit's code directly** (`Claude-Code_One-Click_Kit.bat`, `menu.ps1`, `tools\cd-hook`).

### 13-1. Data flow at a glance

```
 [ Your computer ]                                     [ Internet ]
 Kit (.bat, menu.ps1) ──(once, only when installing)─▶ claude.ai/install.ps1  (download the install script)
        │
        └─ runs claude ────────────────────────────▶ Anthropic services  (Claude Code talks to them directly)
                 ▲
   (the kit takes no part in this communication)
```

- **The kit itself connects to the internet in exactly one place:** downloading `https://claude.ai/install.ps1` in [1] Install.
- The kit's code has **no part that collects or sends your files, conversations, or account information.**
- Communication after Claude Code starts (sending your conversation, and so on) is done by **Claude Code itself (Anthropic).** This document does not vouch for how that is processed; Anthropic's terms and privacy information apply.

### 13-2. What the kit reads / writes

| Target | What the kit does | Why |
|---|---|---|
| `%APPDATA%\claude-code\.claude.json`, `%USERPROFILE%\.claude.json` | **Read only** | To see the list of folders you worked in before and the "this folder is trusted" record. It does not store or send the contents, and it **does not modify** the file. (This file may contain account-related information, so it is handled carefully.) |
| `%APPDATA%\claude-code\menu-extra-folders.txt` | Read (written by the optional hook) | To add folders you moved into with `cd` to the list |
| The list of fixed disks | Read | To pass them with `--add-dir` in option 3 |
| The files and folders in Chapter 12, during Uninstall (8) | **Delete** | Only when you explicitly choose it |
| Any other user files | Not touched | |

### 13-3. Risks you should know, and what to do

| What | Why it can be risky | What to do |
|---|---|---|
| **Running a script downloaded from the internet right away** ([1] Install, the `irm ... \| iex` style) | It runs downloaded content without checking it, so a fake or hijacked address would be dangerous. | The kit uses **only one Anthropic official address.** If you are still uneasy, install directly from the official page (<https://code.claude.com/docs/en/setup>), which also explains how to verify the signature of the installer. |
| **Allowing every fixed disk with `--add-dir`** ([3] Start) | Claude is placed in a position where it can work with **files on every fixed disk** (C:, D:, and so on). Whether it asks before changing a file depends on Claude Code's permission settings, and this document does not vouch for those details. | Be careful on a PC that holds important data. If this bothers you, **run `claude` yourself in the folder you want** instead of using the kit's [3]. **Read what the AI asks to do** before you allow it. |
| **Trusting a folder ("Yes, I trust")** | It lets Claude read and run things in that folder. | Choose `Yes` only for folders whose source you know. |
| **Uninstall (8)** | It really deletes files. | Read Chapter 12 and choose carefully. |
| **The optional feature (hook)** | It reads the text of every Bash and PowerShell command. It modifies `settings.json`. | It does not store the command text and does not block commands. A backup is made automatically before installing. If you do not want it, do not install it. |

### 13-4. Logs and sensitive information

- If the hook fails with an error, it leaves **one line with only the time and the kind of error** in `%APPDATA%\claude-code\cd-hook-errors.log`. It never records the command itself, and stops writing once the file passes 50 KB.
- `menu-extra-folders.txt` contains **your folder paths.** When you report a problem or share a screen, **hide the paths (which include your user name).**
- The kit and this document **do not store** API keys, passwords, or tokens. Before publishing the repository, this was checked. (Based on a check at the time of writing.)
- When you report a problem, **do not paste account information, the contents of `.claude.json`, or passwords.**

## 14. Troubleshooting

First, try menu **`6` Diagnose / troubleshoot**. `claude doctor` will tell you the cause.

### 14-1. Problems starting or installing the kit

| Symptom | Cause and fix |
|---|---|
| `Could not start the menu` | Check that `.bat` and `menu.ps1` are in the **same folder.** This also happens if you run it without extracting the ZIP. Extract it and run again. |
| "Windows protected your PC" window | More info → Run anyway. Or right-click the file → Properties → **Unblock.** |
| The menu shows but `claude` is not found | Common right after installing. **Close the window and run the kit again.** |
| `[설치 실패] 인터넷 또는 보안 프로그램` ("[Install failed] internet or security program") | Check your internet, check whether antivirus or security software is blocking it, and try again. |
| Text shows as boxes | Right-click the top of the window → Properties → set the font to **Malgun Gothic** or **D2Coding.** Using Windows Terminal also helps. |
| Cannot log in | Check that you have a paid plan/account and that the internet works. To switch accounts, use `/logout` then `/login` inside Claude. |
| Closes right after `이 폴더는 Claude 로 처음 여는 곳이에요` ("This folder is being opened with Claude for the first time") | In the "trust" prompt, `No, exit` is the default, so pressing only Enter closes it. **Choose `Yes` with ↓** and press Enter. |
| Still not working | Try installing again with menu **1 Install.** |

### 14-2. Folder list problems

| Symptom | Cause and fix |
|---|---|
| `최근 작업한 기록을 못 찾았어요` ("Could not find recent work records") | It means there is no folder where Claude Code was started yet. Paste a path using the `D` line. |
| A folder I use is not in the list | If you **never started Claude Code in that folder**, there is no record. Enter it with `D`, or install the optional feature in Chapter 10. |
| I moved with `cd` but it does not appear | Check that the optional feature is installed and that you tried in a **new session.** Run the check command in 14-3 below. |
| Pressing `S` does not change the sort | Arrow keys and `S` do not work in a window where input is redirected; it switches to type-a-number style. Check that you are running it in a normal window (PowerShell or Windows Terminal). |
| `그런 폴더가 없어요` ("No such folder") | The path has a typo or the folder was deleted. Check the path again. |
| `그 폴더로 들어갈 수 없어요` ("Cannot enter that folder") | The folder was deleted or renamed after the list was built. Choose again from the menu. |

### 14-3. Checking the optional feature (hook)

Run the command below in the `tools\cd-hook` folder. It **only reads and changes nothing.**

```
node check-cd-hook.cjs
```

- If there is a `[문제]` ("problem") line, do what that sentence says. (Often it tells you to run `install-cd-hook.cmd` again.)
- `결과: 문제 없음` ("Result: no problems") at the end is normal. `[주의]` ("notice") lines are for information.
- If `%APPDATA%\claude-code\cd-hook-errors.log` exists, the hook has failed with an error at some point. It contains only the kind of error.
- If the installer shows `[중단]` ("stopped"), the reason is written there, and at that point it is in a state where **nothing was changed or the original was restored.**
- If you see `Node.js is required`, install Node.js and run it again.

## 15. Frequently Asked Questions (FAQ)

<details>
<summary>Q. Is this kit free? Is Claude Code free too?</summary>

The kit is **free** to use under the Apache License 2.0. But **Claude Code is not free.** You need one of a Pro, Max, Team, Enterprise, or Console account, and the free Claude.ai plan does not include it. Anthropic sets the prices.

</details>

<details>
<summary>Q. Did Anthropic make this kit? Is it safe?</summary>

No. It is an **unofficial** helper and is not affiliated with Anthropic. The kit's code is open for anyone to read, and Chapter 13 describes what it does. It does not promise that it is "safe". Use is at your own responsibility.

</details>

<details>
<summary>Q. Does it work on a Mac or a phone?</summary>

The kit is **Windows only.** Claude Code itself supports other operating systems (see the official documentation), but you cannot use this kit there.

</details>

<details>
<summary>Q. Do I have to install Node.js or Git?</summary>

No. Neither is needed for the kit itself or for installing Claude Code. Node.js is needed **only for the optional feature (Chapter 10)**, and Git is an **optional extra** that lets Claude Code work better if present.

</details>

<details>
<summary>Q. Why does option 3 ask me to choose a folder?</summary>

Claude Code works **inside the folder it was started in**, so starting it in the folder you want from the beginning is the most reliable. If you do not want to think about folders, choose the second line, `0 Home folder`. (The top first line is `D` type a path manually.)

</details>

<details>
<summary>Q. Why does it hand every disk to Claude? I want to turn that off.</summary>

It is a convenience so Claude can also work with files on other drives. But **the wider the access, the more careful you should be** (Chapter 13). There is no switch to turn it off. If you do not want it, run `claude` yourself in the folder you want instead of the kit's [3].

</details>

<details>
<summary>Q. Claude just closes in a folder I open for the first time.</summary>

Because the default choice in the "Do you trust this folder?" window is `No, exit`. **Choose `Yes, I trust this folder` with ↓ and press Enter.** (See 7-4.)

</details>

<details>
<summary>Q. Is my conversation sent anywhere through the kit?</summary>

The kit's code has no part that sends conversations, files, or account information. However, **Claude Code communicates with Anthropic's services**, and how that is handled follows Anthropic's terms and privacy information. For a work PC or sensitive material, check your organization's policy and Anthropic's terms first.

</details>

<details>
<summary>Q. May I use it for work (commercially) at my company?</summary>

The kit itself may be used commercially under Apache-2.0. But **whether Claude Code may be used for work or commercially is decided by the Anthropic terms that apply to your kind of account.** This document does not judge that. Read the terms for your own account at the links in Chapter 18.

</details>

<details>
<summary>Q. How do I switch the kit to a newer version?</summary>

The kit does not update itself. Download the new version again and **overwrite the existing folder** or extract it into a new folder. Claude Code itself is updated with menu **5 Update** (native installs also update themselves in the background as usual).

</details>

<details>
<summary>Q. Do I need to install automatic folder registration (the optional feature)?</summary>

No. All of the kit's basic features work without it. Install it only if you want folders you moved into with `cd` in chat to be added to the list automatically.

</details>

<details>
<summary>Q. Does the optional feature block or change my commands?</summary>

No. It only **reads** the command text, and whatever error occurs, the command runs unchanged. Each command takes about 0.1 second longer.

</details>

<details>
<summary>Q. Can I use it in several windows at once?</summary>

Several kit windows each work independently. The registration file of the optional feature is shared by multiple sessions.

</details>

<details>
<summary>Q. Does it remember my sort order?</summary>

No. Every time you open option 3 it starts with "Modified, newest first", and you change it with `S` as needed.

</details>

<details>
<summary>Q. I ran into a problem. Where do I report it?</summary>

Use the Issues page of the repository (<https://github.com/sodam-ai/Claude-Code_One-Click_Kit>). (Issues was confirmed to be turned on on 2026-09-20.) When you report, say **which menu you were in and what the screen said**, and do not paste passwords, account information, or the contents of `.claude.json`. Please also hide paths that contain your user name.

</details>

## 16. Update Summary

Click an item below to expand it. Version numbers follow the repository's tags and commit history, and content that has not been released yet is marked as such.

<details>
<summary>Next version in preparation (not yet released) · working copy as of 2026-09</summary>

**Improvements to option 3 (Start)**

- The folder picker works with **arrow keys (↑↓), numbers, and `D` for manual entry.** (Before, it did not ask for a folder and always started in the home folder.)
- Moved the **`D` (type a path manually) line to the top of the list.** You can paste a path right away when starting a new project, and the cursor is on that line when the screen first opens. (The home folder is the second line.)
- If the list is longer than the screen, it **scrolls.** All folders are shown with no limit. (`Home`, `End`, `PageUp`, `PageDown` are supported.)
- **Six sort orders with the `S` key** (modified newest/oldest, created newest/oldest, name ascending/descending). Your selected folder is kept when you change the sort.
- Added an **advance notice** that the "Do you trust this folder?" prompt appears in a folder opened for the first time. (Prevents the accident of closing because the default is `No, exit`.)
- If a folder in the list was deleted, it **stops and tells you** instead of starting somewhere unexpected.
- Made the kit able to read the folder list even in environments where Claude's settings file (`.claude.json`) has **duplicate keys and fails to parse.**
- Your own user folder, the Windows folder, non-existent folders, and duplicates are filtered out of the list.

**Automatic folder registration (optional feature, `tools\cd-hook`)**

- Added a **hook** that automatically adds folders you moved into with `cd` in chat to the list.
- Added a safe **installer** (backup, verification, automatic restore, `--dry-run`), a **status check tool**, and a double-click `.cmd`.
- Added **exclusion rules** so `node_modules`, the settings folder, and temporary folders are not registered, and **error-kind logging** so you can tell why something failed.

**Uninstall menu safety fix**

- Fixed a problem where an invalid input other than `1`, `2` or `3` on the uninstall screen (option 8), such as `9` or `n`, still removed the program. Now nothing is deleted and you only get a notice.
- Fixed a problem where the hook installer ignored an unknown option (for example the typo `--dryrun`) and went on to a real installation. It now stops and shows the usage.

**Documentation**

- **Completely rewrote** this README in Korean and English, in md and html. It corrects mistakes in the old README (that option 3 does not ask for a folder, and the order of the "Delete everything" confirmation).
- Fixed the same points in `사용설명서.md` too. (The folder picker, the uninstall order, the file list, the account types, and removed links to PDFs and the English guide.)

</details>

<details>
<summary>2026-06-18 · Overhaul to a PowerShell Korean menu</summary>

- Switched the menu to a **PowerShell-based Korean menu.** (The `.bat` uses English only and `menu.ps1` handles the menu, which prevents garbled text.)
- **Split install and start.** ([1] Install / [3] Start)
- Added **arrow keys + number** selection.
- Added the **diagnose, update, and uninstall** menus.
- Refined the Korean/English READMEs, the beginner's guide, `NOTICE`, and `LICENSE`.
- Cleaned up `.gitignore` so local tools and session by-products are not uploaded to the repository.

</details>

<details>
<summary>v1.0.0 · 2026-04-20 · Initial release</summary>

- The first public version of Claude Code One-Click Kit. (Its menu layout differs from what this document describes.)

</details>

### What could not be confirmed when this was written (known limits)

To be honest: the items below are ones **the author could not confirm directly** as of 2026-09-20, when this document was written.

- How the kit behaves on **Windows 10** (confirmed on Windows 11)
- How it behaves on **PowerShell 7** (confirmed only on Windows PowerShell 5.1)
- Running the optional feature's installer for the first time **on another PC**
- Whether the hook is actually called in a **new Claude Code session**, and how the `S` key behaves on a real terminal screen

## 17. File and Document Locations

### 17-1. The kit folder (this repository)

| Path | Role |
|---|---|
| `Claude-Code_One-Click_Kit.bat` | The double-click launcher (English ASCII only) |
| `menu.ps1` | The main Korean menu (the real features) |
| `README.md` · `README.html` | This document (Korean, md / html) |
| `README.en.md` · `README.en.html` | The English edition of this document (md / html) |
| `사용설명서.md` | A **short** step-by-step guide for absolute beginners (Korean). Its folder-picker and uninstall-order explanations were corrected to match this README. See this README for details. |
| `LICENSE` | Full text of the Apache License 2.0 |
| `NOTICE` | Copyright, trademark, and disclaimer notices |
| `tools\cd-hook\cd-folder-register.cjs` | (Optional) the hook itself |
| `tools\cd-hook\install-cd-hook.cjs` · `install-cd-hook.cmd` | (Optional) the installer / double-click launcher |
| `tools\cd-hook\check-cd-hook.cjs` | (Optional) status check tool (read-only) |
| `tools\cd-hook\README-cd-folder-register.md` | (Optional) a short guide just for the hook (Korean) |

### 17-2. Other locations on your computer (for reference)

| What | Location |
|---|---|
| Claude Code program | `%USERPROFILE%\.local\bin\claude.exe` (program files: `%USERPROFILE%\.local\share\claude`) |
| Claude settings, login, conversation history | The `%USERPROFILE%\.claude` folder and the `%USERPROFILE%\.claude.json` file (if you moved the settings folder, for example `%APPDATA%\claude-code`) |
| Automatic folder registration list (optional feature) | `%APPDATA%\claude-code\menu-extra-folders.txt` |
| Hook error log (optional feature) | `%APPDATA%\claude-code\cd-hook-errors.log` |
| Hook install location (optional feature) | `<Claude settings folder>\hooks` (`CLAUDE_CONFIG_DIR`, or `%USERPROFILE%\.claude` if not set) |
| Settings backup from before installing (optional feature) | `<Claude settings folder>\settings.json.bak-cd-hook-datetime` |

## 18. License · Copyright · Trademarks · Commercial Use

> This chapter was written to a **strict standard.** It is **not legal advice**, it is for reference, and it does not guarantee legal effect. For important decisions such as commercial use or redistribution, **confirm with a lawyer or other professional.** The final responsibility is yours.

### 18-1. This kit's license

- This kit (`Claude-Code_One-Click_Kit.bat`, `menu.ps1`, the files in `tools\cd-hook`, and the documents including this one) is distributed under the **Apache License, Version 2.0.** The full text is in [LICENSE](./LICENSE).
- **Copyright:** Copyright 2026 **SoDam AI Studio.** The notice text is in [NOTICE](./NOTICE).
- What the license terms mean is summarized below. (It is only a summary; **the full text takes precedence.**)

| What you want to do | Allowed? | What you must observe (LICENSE section 4, etc.) |
|---|---|---|
| **Use** it personally or at a company | Allowed | Nothing |
| **Use it commercially**, sell it, or include it in a paid service | Allowed | Observe the redistribution and trademark conditions below |
| **Modify** it and use it | Allowed | |
| **Redistribute** it as is or modified | Allowed | ① **Give recipients a copy of the LICENSE.** ② **Mark modified files as changed.** ③ **Keep the copyright, patent, trademark, and attribution notices** of the original source (except those that do not relate to your modified version). ④ **If there is a NOTICE file,** include its attribution notices in your redistributed modified version (in a NOTICE file, in documentation, or on screen: at least one place). |
| Add **your own copyright notice or other terms** to your modification | Allowed | The other LICENSE conditions must still be observed. |
| Use the **"SoDam AI Studio" name or trademarks** | **Not granted** | LICENSE section 6: no permission is given to use trademarks, trade names, or product names **outside reasonable and customary use** for describing the origin of the work and reproducing the NOTICE content. |
| Patents | Each contributor grants a patent license | Section 3: if you **file a lawsuit** claiming that this software infringes a patent, **your patent license ends.** |

- **No warranty, limited liability:** Under LICENSE sections 7 and 8 it is provided "AS IS" with no warranty of any kind, and liability for damage arising from its use is limited (except where the law requires otherwise).
- **Contributions:** If you submit a Contribution to the repository, the same license (Apache-2.0) applies unless you state otherwise. (Section 5)

### 18-2. Claude Code and trademarks (please keep these separate)

- This kit is an **UNOFFICIAL** helper and is **not affiliated with, endorsed by, or sponsored by Anthropic.** (Stated in NOTICE.)
- This kit **does not bundle or redistribute Claude Code.** It only downloads and installs it from **Anthropic's official address** (`https://claude.ai/install.ps1`) when you run it.
- **"Claude", "Claude Code", and "Anthropic" are trademarks of Anthropic.** This document uses those names **only to identify and describe** what it is about.
- **A recommendation if you redistribute the kit:** do not make it look like an official product or suggest that Anthropic endorses it. **Bundling** a Claude Code installer inside the kit is outside what this kit's license covers, and whether Anthropic permits it was **not confirmed by this document (unconfirmed).** Do not include one.

### 18-3. Commercial use standards (separated in a table)

| Subject | Commercial use | Basis |
|---|---|---|
| **This kit** (scripts and documents) | **Allowed** (when you observe the conditions in 18-1) | Apache License 2.0 |
| **Claude Code** (an Anthropic product) | **Decided by Anthropic's terms.** This document does **not judge** whether it is allowed. | The Anthropic terms that apply to your kind of account |
| **Windows and PowerShell** (Microsoft) | Microsoft licenses | The license of each product |
| **Node.js and Git** (optional) | The license of each project | This kit does not include or redistribute them; you install them yourself. |

> **You may use the kit commercially, but commercial use of Claude Code separately follows Anthropic's conditions.** Do not mix the two up.

**Anthropic's terms (the pages were confirmed to open on 2026-09-20. Contents may change, so read them yourself)**

- Personal services (Claude.ai and so on): [Consumer Terms of Service](https://www.anthropic.com/legal/consumer-terms)
- Business, API, and so on: [Commercial Terms of Service](https://www.anthropic.com/legal/commercial-terms)
- Usage rules: [Usage Policy](https://www.anthropic.com/legal/aup)
- **Which terms apply to your account** depends on your kind of account (individual Pro or Max, team or enterprise, API, and so on), and this document does not decide that.

### 18-4. Personal information

- The kit's code **does not collect or send** your personal information. (Within the scope checked in Chapter 13.)
- The conversation and file information processed when you use Claude Code follows **Anthropic's policies**, and this document does not vouch for it.
- Files left on this PC such as `menu-extra-folders.txt` contain folder paths, so be careful when sharing them.

## 19. Disclaimer

- This kit is provided **"AS IS"** and makes **no warranty of any kind.**
- **You are responsible for all results and damage** arising from using this kit.
- Installing, uninstalling, and the optional feature **create, change, or delete files and settings on your computer.** In particular, menu 8 "Delete everything" **cannot be undone.**
- **Costs, data handling, and the accuracy of results** from using Claude Code follow Anthropic's terms and your own judgment and responsibility. AI answers can be wrong, so check important things yourself.
- The external facts in this document (requirements, terms, addresses, and so on) were checked on 2026-09-20 and may change afterwards.

---

Copyright 2026 SoDam AI Studio · Apache License 2.0 · Unofficial helper (not affiliated with Anthropic)
