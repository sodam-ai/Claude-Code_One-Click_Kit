# ============================================================
#  Claude Code 원클릭 키트 - 메뉴 (PowerShell)
#  한글 UI는 여기(PowerShell)에서 처리합니다.
#  PowerShell은 글자코드(코드페이지)와 무관하게 한글을 안전히 표시하므로
#  cmd(.bat)의 UTF-8 파서 오류를 원천적으로 피합니다.
# ============================================================

try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

# --- PATH 보강: 네이티브 설치 위치 + npm 전역 (설치 직후에도 인식되게) ---
$nativeBin = Join-Path $env:USERPROFILE '.local\bin'
$npmGlobal = Join-Path $env:APPDATA 'npm'
$env:PATH = "$nativeBin;$npmGlobal;$env:PATH"

function Has-Claude { [bool](Get-Command claude -ErrorAction SilentlyContinue) }

function Wait-Key {
    Write-Host ''
    [void](Read-Host '  계속하려면 Enter 를 누르세요')
}

function Show-Line($t, $c = 'Gray') { Write-Host $t -ForegroundColor $c }

# ============================================================
#  [1] 설치하기  (설치만 — 실행은 [3])
# ============================================================
function Invoke-Install {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     설치하기' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    if (Has-Claude) {
        Show-Line '   이미 설치되어 있어요.' 'Green'
        Write-Host '   최신으로 맞추려면 메뉴 [5] 업데이트 를 누르세요.'
        Wait-Key; return
    }
    Write-Host '   Claude Code 를 컴퓨터에 깔아드립니다.'
    Write-Host ''
    Write-Host '   필요한 것'
    Write-Host '     1) 유료 플랜  Claude Pro 또는 Max  또는 API 계정'
    Write-Host '        (무료 Claude.ai 계정만으로는 사용할 수 없어요)'
    Write-Host '     2) 인터넷 연결'
    Write-Host ''
    Write-Host '   설치 주소 :  https://claude.ai/install.ps1   (Anthropic 공식)' -ForegroundColor DarkGray
    [void](Read-Host '   설치를 시작하려면 Enter (취소는 창 닫기)')
    Write-Host ''
    Write-Host '   설치 중이에요... 1~2분 걸릴 수 있어요.' -ForegroundColor Yellow
    try {
        Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
    } catch {
        Write-Host ''
        Show-Line '   [설치 실패] 인터넷 또는 보안 프로그램 때문일 수 있어요.' 'Red'
        Write-Host '   - 인터넷을 확인하고 다시 시도해 주세요.'
        Wait-Key; return
    }
    $env:PATH = "$nativeBin;$npmGlobal;$env:PATH"
    Write-Host ''
    if (Has-Claude) {
        Show-Line '   설치 완료!' 'Green'
        Write-Host '   다음은  [2] 로그인·계정 안내  를 보거나  [3] 시작하기  를 누르세요.'
    } else {
        Show-Line '   설치는 됐지만 이 창에서 아직 인식이 안 돼요.' 'Yellow'
        Write-Host '   이 창을 닫고 키트를 다시 실행하면 정상 인식됩니다.'
    }
    Wait-Key
}

# ============================================================
#  [2] 로그인·계정 안내
# ============================================================
function Show-LoginGuide {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     로그인·계정 안내' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    Write-Host '   1) 어떤 계정이 필요한가요?'
    Write-Host '      - Claude Pro 또는 Max 구독, 또는 Anthropic API 계정'
    Write-Host '      - 무료 Claude.ai 계정만으로는 Claude Code 를 쓸 수 없어요.' -ForegroundColor Yellow
    Write-Host ''
    Write-Host '   2) 로그인은 어떻게?'
    Write-Host '      - [3] 시작하기 를 처음 누르면, 브라우저가 자동으로 열려요.'
    Write-Host '      - 평소 쓰던 방식으로 로그인하면 끝입니다.'
    Write-Host ''
    Write-Host '   3) 나중에 계정을 바꾸려면?'
    Write-Host '      - Claude 안에서  /login  또는  /logout  을 입력하세요.'
    Wait-Key
}

# ============================================================
#  [3] 시작하기  (폴더 질문 없이 바로 실행 - 홈 폴더에서)
# ============================================================
function Invoke-Start {
    if (-not (Has-Claude)) {
        Clear-Host
        Show-Line '   아직 설치가 안 돼 있어요.' 'Yellow'
        Write-Host '   메뉴 [1] 설치하기 를 먼저 해주세요.'
        Wait-Key; return
    }
    Set-Location $env:USERPROFILE
    Clear-Host
    Show-Line "   실행 위치 : $env:USERPROFILE" 'DarkGray'
    Write-Host '   Claude Code 를 켭니다.'
    Write-Host '   처음이면 브라우저 로그인 화면이 먼저 나와요.'
    Write-Host '   끝낼 때는 Claude 안에서  /exit  입력.'
    Write-Host ''
    claude
    Wait-Key
}

# ============================================================
#  [4] 도움말·명령어
# ============================================================
function Show-Help {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     도움말 - 자주 쓰는 명령어' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    Write-Host '   Claude Code 가 켜진 상태에서 입력창에 칩니다.'
    Write-Host ''
    Write-Host '     /help      모든 명령 보기'
    Write-Host '     /exit      끝내기   (또는  /quit)'
    Write-Host '     /clear     대화를 새로 시작  (기억은 유지)'
    Write-Host '     /login     로그인         /logout   로그아웃'
    Write-Host '     /status    지금 상태 보기'
    Write-Host '     /usage     사용량·요금 확인'
    Write-Host ''
    Write-Host '   평소에는 명령 없이 그냥 한국어로 시키면 됩니다.' -ForegroundColor Green
    Write-Host '     예시)  이 폴더 정리해줘'
    Wait-Key
}

# ============================================================
#  [5] 업데이트
# ============================================================
function Invoke-Update {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     업데이트' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    if (-not (Has-Claude)) {
        Show-Line '   아직 설치가 안 돼 있어요. 메뉴 [1] 부터 해주세요.' 'Yellow'
        Wait-Key; return
    }
    Write-Host '   최신 버전으로 업데이트합니다...' -ForegroundColor Yellow
    claude update
    Write-Host ''
    Show-Line '   완료. (네이티브 설치본은 평소에도 자동 최신화됩니다)' 'Green'
    Wait-Key
}

# ============================================================
#  [6] 진단·문제 해결
# ============================================================
function Invoke-Diagnose {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     진단 / 문제 해결' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    if (-not (Has-Claude)) {
        Show-Line '   아직 설치가 안 돼 있어요. 메뉴 [1] 설치하기 로 설치하세요.' 'Yellow'
        Wait-Key; return
    }
    Write-Host '   설치 상태를 점검합니다 (claude doctor)' -ForegroundColor DarkGray
    claude doctor
    Write-Host ''
    Write-Host '   자주 묻는 문제와 해결'
    Write-Host '     - claude 를 못 찾음   →  이 창을 닫고 키트를 다시 실행'
    Write-Host '     - 로그인 실패         →  유료 플랜/계정과 인터넷 확인'
    Write-Host '     - 글자가 깨져 보임     →  글꼴을 맑은 고딕 또는 D2Coding 으로'
    Wait-Key
}

# ============================================================
#  [7] 버전 확인
# ============================================================
function Show-Version {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     버전 확인' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host ''
    if (-not (Has-Claude)) {
        Show-Line '   아직 설치가 안 돼 있어요. 메뉴 [1] 부터 해주세요.' 'Yellow'
        Wait-Key; return
    }
    claude --version
    Wait-Key
}

# ============================================================
#  [8] 제거  (비가역 단계는 한 번 더 확인)
# ============================================================
function Invoke-Uninstall {
    Clear-Host
    Show-Line '  ============================================' 'Cyan'
    Show-Line '     제거' 'Cyan'
    Show-Line '  ============================================' 'Cyan'
    Write-Host '     [1] 프로그램만 지우기   (설정·기록은 남김)'
    Write-Host '     [2] 전부 지우기         (설정·로그인·기록까지 / 되돌릴 수 없음)'
    Write-Host '     [3] 취소'
    Write-Host ''
    $u = (Read-Host '   선택 (1-3)').Trim()
    if ($u -eq '3' -or $u -eq '') { return }

    Write-Host ''
    Write-Host '   프로그램을 제거하는 중...' -ForegroundColor Yellow
    $exe = Join-Path $nativeBin 'claude.exe'
    if (Test-Path $exe) { Remove-Item $exe -Force -ErrorAction SilentlyContinue }
    $share = Join-Path $env:USERPROFILE '.local\share\claude'
    if (Test-Path $share) { Remove-Item $share -Recurse -Force -ErrorAction SilentlyContinue }
    cmd /c "npm uninstall -g @anthropic-ai/claude-code >nul 2>&1"
    Show-Line '   프로그램 제거 완료.' 'Green'

    if ($u -eq '1') { Wait-Key; return }

    Write-Host ''
    Show-Line '   [경고] 설정·로그인·대화기록을 모두 삭제합니다. 정말 진행할까요?' 'Red'
    $yn = (Read-Host '   삭제하려면 Y, 남기려면 N').Trim().ToUpper()
    if ($yn -ne 'Y') { Write-Host '   설정과 기록은 남겨두었습니다.'; Wait-Key; return }
    $cfgDir = Join-Path $env:USERPROFILE '.claude'
    $cfgJson = Join-Path $env:USERPROFILE '.claude.json'
    if (Test-Path $cfgDir) { Remove-Item $cfgDir -Recurse -Force -ErrorAction SilentlyContinue }
    if (Test-Path $cfgJson) { Remove-Item $cfgJson -Force -ErrorAction SilentlyContinue }
    Show-Line '   전부 제거 완료.' 'Green'
    Wait-Key
}

# ============================================================
#  메인 메뉴
# ============================================================
# --- 메뉴 데이터 (item = 선택지, header/blank = 꾸밈) ---
$Menu = @(
    @{ t='header'; text='── 처음이라면 (딱 한 번만) ───────────────' }
    @{ t='item'; key='1'; label='설치하기';        desc='Claude Code 깔기';        color='Green' }
    @{ t='item'; key='2'; label='로그인·계정 안내';  desc='어떤 계정이 필요한가요';    color='Gray' }
    @{ t='blank' }
    @{ t='header'; text='── 사용하기 (매번) ──────────────────────' }
    @{ t='item'; key='3'; label='시작하기';        desc='바로 Claude 실행';        color='Green' }
    @{ t='item'; key='4'; label='도움말·명령어';    desc='Claude 안에서 쓰는 명령';  color='Gray' }
    @{ t='blank' }
    @{ t='header'; text='── 관리 / 문제 해결 ─────────────────────' }
    @{ t='item'; key='5'; label='업데이트';        desc='최신 버전으로';           color='Gray' }
    @{ t='item'; key='6'; label='진단·문제 해결';   desc='안 될 때 자동 점검';       color='Gray' }
    @{ t='item'; key='7'; label='버전 확인';       desc='';                       color='Gray' }
    @{ t='item'; key='8'; label='제거';           desc='깔끔하게 지우기';          color='DarkYellow' }
    @{ t='blank' }
    @{ t='item'; key='Q'; label='종료';           desc='';                       color='Gray' }
)

# 한글(전각)은 폭 2로 계산해 칸 맞춤
function Pad-Display($s, $width) {
    $w = 0
    foreach ($ch in $s.ToCharArray()) { if ([int]$ch -ge 0x1100) { $w += 2 } else { $w += 1 } }
    if ($w -lt $width) { return $s + (' ' * ($width - $w)) }
    return $s
}

function Write-MenuItem($e, $on) {
    $body = "[{0}]  {1}{2}" -f $e.key, (Pad-Display $e.label 18), $e.desc
    if ($on) { Write-Host ('   ▶ ' + $body) -ForegroundColor Black -BackgroundColor Gray }
    else     { Write-Host ('     ' + $body) -ForegroundColor $e.color }
}

function Render-Menu($hi) {
    Clear-Host
    $state = if (Has-Claude) { '설치됨' } else { '아직 설치 안 됨' }
    Write-Host ''
    Show-Line '  ══════════ Claude Code  원클릭 키트 ══════════' 'White'
    Write-Host  "     상태  $state        사용자  $env:USERNAME"
    Write-Host ''
    foreach ($e in $Menu) {
        switch ($e.t) {
            'header' { Show-Line ('   ' + $e.text) 'DarkCyan' }
            'blank'  { Write-Host '' }
            'item'   { Write-MenuItem $e ($hi -eq $e.key) }
        }
    }
    Show-Line '  ════════════════════════════════════════════' 'White'
}

# 대화형: 화살표로 고르고 Enter, 또는 번호/Q 즉시 선택
function Read-Choice-Interactive {
    $items = @($Menu | Where-Object { $_.t -eq 'item' })
    $idx = 0
    while ($true) {
        Render-Menu $items[$idx].key
        Write-Host '    ↑↓ 로 고르고 Enter,  또는 번호키.  종료는 Q.' -ForegroundColor Yellow
        $k = [Console]::ReadKey($true)
        if     ($k.Key -eq 'UpArrow')   { $idx = ($idx - 1 + $items.Count) % $items.Count }
        elseif ($k.Key -eq 'DownArrow') { $idx = ($idx + 1) % $items.Count }
        elseif ($k.Key -eq 'Enter')     { return $items[$idx].key }
        elseif ($k.Key -eq 'Escape')    { return 'Q' }
        else {
            $ch = ([string]$k.KeyChar).ToUpper()
            if ($items.key -contains $ch) { return $ch }
        }
    }
}

# 폴백(입력 리다이렉트/테스트): 정적 메뉴 + 번호 입력
function Read-Choice-Fallback {
    Render-Menu $null
    Write-Host '    번호를 누르고 Enter.  (종료는 Q)' -ForegroundColor Yellow
    $s = Read-Host '   번호 선택'
    if ($null -eq $s) { return $null }
    return ([string]$s).Trim().ToUpper()
}

$emptyCount = 0
while ($true) {
    if ([Console]::IsInputRedirected) {
        $c = Read-Choice-Fallback
        if ($null -eq $c) { break }
        if ($c -eq '') { $emptyCount++; if ($emptyCount -ge 5) { break }; continue }
    } else {
        $c = Read-Choice-Interactive
    }
    $emptyCount = 0
    switch ($c) {
        '1' { Invoke-Install }
        '2' { Show-LoginGuide }
        '3' { Invoke-Start }
        '4' { Show-Help }
        '5' { Invoke-Update }
        '6' { Invoke-Diagnose }
        '7' { Show-Version }
        '8' { Invoke-Uninstall }
        'Q' { Clear-Host; Write-Host ''; Write-Host '    안녕히 가세요.'; Write-Host ''; return }
        default {
            if ($c -ne '') {
                Write-Host '    그 번호는 없어요. 다시 골라주세요.' -ForegroundColor Red
                Start-Sleep -Milliseconds 800
            }
        }
    }
}
