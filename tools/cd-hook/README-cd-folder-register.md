# cd-folder-register 훅 (원클릭 키트 폴더 목록 자동 등록)

채팅에서 `cd <폴더>` 로 이동하면 그 폴더를 `menu-extra-folders.txt` 에 자동으로 넣어 줍니다.
원클릭 키트 `[3] 시작하기` 목록이 이 파일을 함께 읽습니다. (명령 실행은 절대 막지 않음)

## 다른 PC에 옮기려면 (2단계)

1. 키트 폴더를 통째로 새 PC에 복사하면 이 `tools\cd-hook` 폴더도 함께 옮겨집니다. (이 폴더만 옮길 때는 아래 파일을 **같은 폴더에 그대로** 복사)
   - `cd-folder-register.cjs` (훅 본체)
   - `install-cd-hook.cjs` (설치기)
   - `install-cd-hook.cmd` (더블클릭용)
   - `check-cd-hook.cjs` (상태 점검용, 선택 — `node check-cd-hook.cjs` 로 실행하면 읽기만 하고 아무것도 바꾸지 않음)
2. 새 PC에서 `install-cd-hook.cmd` 를 **더블클릭** (Node.js 필요 — 없으면 안내가 뜹니다)

설치기가 하는 일: 훅 파일 복사 → `settings.json` 에 훅 2개(Bash, PowerShell)를 **덧붙이기만** 함 → 자체 테스트.

- 안전장치: 수정 전 백업(`settings.json.bak-cd-hook-날짜`) → 수정 후 재검증 → 이상하면 자동 복구
- 여러 번 실행해도 결과가 같음(이미 있으면 "이미 등록" 안내만 하고 아무것도 안 바꿈)
- `settings.json` 형식이 이상하거나 깨져 있으면 **손대지 않고 중단**하고 이유를 알려 줌
- 무엇을 할지만 미리 보려면 명령창에서 `node install-cd-hook.cjs --dry-run` (아무것도 쓰지 않음)
- 설정 폴더는 환경변수 `CLAUDE_CONFIG_DIR`, 없으면 `~/.claude`. 그 폴더가 없으면 중단(Claude Code를 한 번 실행한 뒤 다시)

설치 후: **새 세션**을 열어 아무 폴더로 `cd` 하고, `%APPDATA%\claude-code\menu-extra-folders.txt` 에 들어갔는지 확인하세요.
(훅은 이 위치를 고정으로 씁니다. 키트 `menu.ps1` 도 같은 위치를 읽습니다)

## 등록되지 않는 경로 (의도된 제외)
- 홈 폴더, Windows 폴더, `node_modules` 하위, Claude 설정 폴더, `Temp\claude` 임시 폴더
- 존재하지 않는 폴더, 파일 경로, 드라이브 문자가 없는 상대경로

## 목록에 안 뜰 때 점검
- `%APPDATA%\claude-code\cd-hook-errors.log` 이 있으면 훅이 오류로 실패한 것 — 오류 "종류"만 기록됨 (50KB 넘으면 기록 중단)
- 로그가 없는데도 안 뜨면 `settings.json` 에 훅이 있는지(`cd-folder-register.cjs` 검색), 폴더가 실제로 존재하는지, `disableAllHooks` 가 꺼져 있는지 확인

## 되돌리기
`settings.json.bak-cd-hook-날짜` 파일을 `settings.json` 으로 덮어쓰면 설치 전 상태로 돌아갑니다.
