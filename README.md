# Claude Code One-Click Kit

> Claude Code를 **더블클릭 한 번**으로 시작하는 Windows 전용 원클릭 실행기

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue.svg)]()
[![Made by SoDam AI Studio](https://img.shields.io/badge/Made%20by-SoDam%20AI%20Studio-purple.svg)]()

---

## 이게 뭔가요?

Claude Code는 AI와 대화하며 코드를 만드는 도구입니다.  
하지만 매번 터미널을 열고 명령어를 입력하는 게 번거롭죠.

이 배치파일(.bat) 하나로 그 번거로움을 없앴습니다.

- **설치 자동 확인** — Claude Code가 없으면 알아서 설치합니다
- **폴더 자동 감지** — 프로젝트 파일이 있으면 바로 실행합니다
- **메뉴 방식** — 터미널 명령어 몰라도 됩니다

---

## 주요 기능

| 메뉴 | 설명 |
|------|------|
| **[0] AUTO** | 현재 폴더의 프로젝트 파일을 자동 감지 후 실행 (추천) |
| **[1] HERE** | 지금 있는 폴더에서 바로 Claude Code 실행 |
| **[2] DESKTOP** | 바탕화면 폴더로 이동 후 실행 |
| **[3] DOCUMENTS** | 문서 폴더로 이동 후 실행 |
| **[4] DOWNLOADS** | 다운로드 폴더로 이동 후 실행 |
| **[5] NEW PROJECT** | 새 프로젝트 폴더를 만들고 바로 시작 |
| **[6] SELECT FOLDER** | 원하는 폴더를 직접 선택하거나 경로 입력 |
| **[Q] EXIT** | 종료 |

---

## 사용 방법 (개발 경험 없어도 OK)

### 준비물

- **Windows 10 또는 11** PC
- **인터넷 연결** (최초 설치 시 필요)
- **Node.js** — 없으면 아래에서 설치

### Node.js 설치 (처음 한 번만)

1. [nodejs.org](https://nodejs.org) 접속
2. **LTS 버전** 다운로드 버튼 클릭
3. 설치 파일 실행 → 계속 "다음" 클릭

### Claude Code 실행하기

1. `Claude-Code_One-Click_Kit.bat` 파일을 **더블클릭**
2. 처음 실행 시 Claude Code 자동 설치 (1~2분 소요)
3. 초록색 메뉴 화면이 나타나면 **숫자 0 입력** 후 엔터
4. Claude Code가 실행됩니다!

> **팁:** 그냥 `0`만 누르세요. 제일 편합니다.

### 새 프로젝트 시작하기

1. 배치파일 더블클릭
2. **5** 입력 → 엔터
3. 저장 위치 선택 (1~4 중 하나)
4. 프로젝트 이름 입력
5. 자동으로 폴더가 만들어지고 Claude Code가 시작됩니다

---

## 폴더 구조

```
Claude-Code_One-Click_Kit/
├── Claude-Code_One-Click_Kit.bat   ← 이것만 있으면 됩니다
├── README.md                        ← 한국어 가이드 (지금 읽는 파일)
└── README_EN.md                     ← English Guide
```

---

## 자주 묻는 질문

**Q. 배치파일을 실행했는데 까만 창만 뜨고 사라져요**  
A. `Claude-Code_One-Click_Kit.bat` 파일을 마우스 오른쪽 클릭 → "관리자 권한으로 실행" 해보세요.

**Q. "npm is not recognized" 오류가 나와요**  
A. Node.js가 설치되지 않은 것입니다. [nodejs.org](https://nodejs.org)에서 설치하세요.

**Q. Claude Code 로그인은 어떻게 하나요?**  
A. Claude Code가 처음 실행되면 Anthropic 계정 로그인을 안내합니다. 화면의 지시를 따라주세요.

**Q. Windows 7이나 8에서도 되나요?**  
A. Windows 10 이상에서만 지원합니다.

---

## 시스템 요구사항

| 항목 | 최소 요구사항 |
|------|-------------|
| 운영체제 | Windows 10 (64bit) 이상 |
| Node.js | v18 이상 |
| 인터넷 | 최초 설치 시 필요 |
| 권한 | 일반 사용자 권한 (관리자 불필요) |

---

## 라이선스

MIT License © 2026 SoDam AI Studio  
자세한 내용은 [LICENSE](LICENSE) 파일을 참고하세요.

---

## 만든 곳

**SoDam AI Studio**  
AI 도구를 누구나 쉽게 쓸 수 있도록 만들고 있습니다.
