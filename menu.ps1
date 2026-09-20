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
# ============================================================
#  [3] 시작하기 - 먼저 "어느 폴더에서 열지" 고르기
#  (Claude Code 는 세션을 연 폴더 밖으로는 cd 이동이 안 되므로,
#   아예 원하는 폴더에서 켜주는 것이 가장 확실합니다.)
# ============================================================
#  --- 정규식 폴백이 망가진(대소문자 중복 키) JSON 에서도, "projects" 객체
#      바로 밑(중첩 깊이 1)에 있는 키만 뽑는다.
#  예전엔 파일 전체를 정규식으로 훑어서, mcpServers 설정 값 안에 윈도우 경로처럼
#  생긴 문자열이 있으면(예: cwd 값) 그걸 진짜 프로젝트로 잘못 주워올 수 있었다.
#  중괄호 깊이를 직접 세어가며 "projects 바로 안"일 때만 키를 받는다.
function Get-TopLevelProjectKeys($raw) {
    $keys = @()
    $m = [regex]::Match($raw, '"projects"\s*:\s*\{')
    if (-not $m.Success) { return $keys }

    $i = $m.Index + $m.Length   #  projects 객체 내부 시작 (여기부터 깊이 1)
    $n = $raw.Length
    $depth = 1
    $inStr = $false
    $esc = $false
    $keyStart = -1

    while ($i -lt $n -and $depth -gt 0) {
        $c = $raw[$i]
        if ($inStr) {
            if ($esc) { $esc = $false }
            elseif ($c -eq [char]92) { $esc = $true }
            elseif ($c -eq '"') {
                $inStr = $false
                if ($depth -eq 1) {
                    #  문자열이 막 끝났다 - 뒤에 : { 가 오면(깊이1의 진짜 키) 채택한다.
                    $rest = $raw.Substring($i + 1)
                    $chk = [regex]::Match($rest, '^\s*:\s*\{')
                    if ($chk.Success) {
                        $keys += $raw.Substring($keyStart, $i - $keyStart)
                    }
                }
            }
        }
        else {
            if     ($c -eq '"') { $inStr = $true; $keyStart = $i + 1 }
            elseif ($c -eq '{') { $depth++ }
            elseif ($c -eq '}') { $depth-- }
        }
        $i++
    }
    return $keys
}

function Get-ProjectFolders {
    #  .claude.json 에서 "예전에 작업했던 폴더" 목록을 뽑는다.
    #  주의: ConvertFrom-Json 은 대소문자만 다른 중복 키가 있으면 통째로 실패한다
    #        (실측: 'C:/WINDOWS/System32' 와 'C:/WINDOWS/system32' 가 같이 있으면 터짐).
    #        그래서 정상 파싱을 먼저 시도하고, 실패하면 경로 키만 정규식으로 뽑는다.
    $cands = @(
        (Join-Path $env:APPDATA 'claude-code\.claude.json'),
        (Join-Path $env:USERPROFILE '.claude.json')
    )
    $keys = @()
    foreach ($c in $cands) {
        if (-not (Test-Path -LiteralPath $c)) { continue }
        try { $raw = Get-Content -LiteralPath $c -Raw -Encoding UTF8 } catch { continue }
        if ([string]::IsNullOrWhiteSpace($raw)) { continue }

        $ok = $false
        try {
            $j = $raw | ConvertFrom-Json
            if ($j.projects) {
                $keys += @($j.projects.PSObject.Properties.Name)
                $ok = $true
            }
        } catch { $ok = $false }

        if (-not $ok) {
            $keys += @(Get-TopLevelProjectKeys $raw)
        }
    }

    #  --- 채팅 중 cd 로 이동해 작업한 폴더도 목록에 뜨게 한다 (.claude.json 은 안 건드림) ---
    #  .claude.json 은 이 PC에서 이미 알려진 결함(중복 키로 파싱 실패)이 있어 직접 쓰지 않고,
    #  별도의 평문 목록 파일을 추가로 읽어서 합친다. 한 줄에 폴더 경로 하나.
    $extraFile = Join-Path $env:APPDATA 'claude-code\menu-extra-folders.txt'
    if (Test-Path -LiteralPath $extraFile) {
        try {
            $extraLines = @(Get-Content -LiteralPath $extraFile -Encoding UTF8 -ErrorAction Stop |
                Where-Object { $_ -and $_.Trim() -ne '' })
            $keys += $extraLines
        } catch {}
    }

    $found = @()
    $seen  = @()
    $win   = $env:WINDIR
    foreach ($n in $keys) {
        $p = ([string]$n -replace '/', '\').TrimEnd('\')
        if ($p.Length -lt 3) { continue }
        if ($p -eq $env:USERPROFILE) { continue }
        if ($win -and $p.ToLower().StartsWith($win.ToLower())) { continue }
        if ($seen -contains $p.ToLower()) { continue }
        $seen += $p.ToLower()
        if (-not (Test-Path -LiteralPath $p -PathType Container)) { continue }
        $item = Get-Item -LiteralPath $p
        $found += [PSCustomObject]@{
            Path    = $p
            Name    = Split-Path $p -Leaf
            Last    = $item.LastWriteTime
            Created = $item.CreationTime
        }
    }
    return @($found | Sort-Object Last -Descending)
}
#  --- 이 폴더를 Claude 가 이미 "믿는다"고 기록했는지 본다 (읽기만 한다) -----
#  기록이 없으면 Claude 를 켤 때 "이 폴더를 믿나요?" 창이 한 번 뜬다.
#  그 창은 기본 선택이 [No, exit] 라서, 모르고 Enter 를 누르면 그냥 꺼진다.
#  그래서 미리 안내해 주려고 상태만 확인한다.
#  (대소문자만 다른 중복 키 때문에 ConvertFrom-Json 이 통째로 실패할 수 있어 글자로 찾는다)
function Test-FolderTrusted($path) {
    $key = ([string]$path).Replace([char]92, [char]47).TrimEnd([char]47)
    $cands = @(
        (Join-Path $env:APPDATA 'claude-code\.claude.json'),
        (Join-Path $env:USERPROFILE '.claude.json')
    )
    foreach ($c in $cands) {
        if (-not (Test-Path -LiteralPath $c)) { continue }
        try { $raw = Get-Content -LiteralPath $c -Raw -Encoding UTF8 } catch { continue }
        if ([string]::IsNullOrWhiteSpace($raw)) { continue }
        $i = $raw.IndexOf('"' + $key + '"')
        if ($i -lt 0) { continue }
        #  반드시 '이 폴더 블록 안'에서만 봐야 한다.
        #  뒤쪽을 넉넉히 잘라서 보면, 바로 다음 폴더의 값을 자기 것으로 착각한다.
        $seg = $raw.Substring($i)
        $nx  = [regex]::Match($seg.Substring(1), '"[A-Za-z]:/')
        if ($nx.Success) { $seg = $seg.Substring(0, $nx.Index + 1) }
        $m = [regex]::Match($seg, '"hasTrustDialogAccepted"\s*:\s*(true|false)')
        if ($m.Success) { return ($m.Groups[1].Value -eq 'true') }
        return $false
    }
    return $false
}

#  --- 창 높이에 맞춰 "몇 줄을, 몇 번째부터" 보여줄지 계산 ----------------
#  $height  : 콘솔 창 높이(줄). 8 은 목록 바깥 줄 수
#             (제목 1 + 빈줄 1 + ▲ 1 + ▼ 1 + 빈줄 1 + 고른 곳 1 + 안내 1 + 커서 여유 1).
#  고른 줄($idx)이 항상 보이는 칸 안에 들어오도록 시작 위치($top)를 민다.
function Get-PickerWindow($count, $idx, $top, $height) {
    $room = $height - 8
    if ($room -lt 5) { $room = 5 }
    if ($room -gt $count) { $room = $count }
    if ($idx -lt $top) { $top = $idx }
    if ($idx -ge ($top + $room)) { $top = $idx - $room + 1 }
    if ($top -gt ($count - $room)) { $top = $count - $room }
    if ($top -lt 0) { $top = 0 }
    return @{ Top = $top; Room = $room }
}

#  --- 폴더 고르기 화면 그리기 (화살표로 오르내리는 목록) -----------------
#  목록이 창보다 길 수 있으므로 "보이는 칸"만 그리고,
#  고른 줄이 항상 화면 안에 있도록 시작 위치($top)가 따라 움직인다.
function Render-FolderPicker($entries, $idx, $top, $room, $hidden, $noneFound, $sortName) {
    Clear-Host
    Show-Line '  ══════ 어느 폴더에서 시작할까요? ══════' 'Cyan'
    Write-Host ''
    if ($noneFound) {
        Show-Line '   최근 작업한 기록을 못 찾았어요. [D] 로 직접 넣으시면 됩니다.' 'Yellow'
    }
    if ($top -gt 0) { Show-Line '        ▲ 위에 더 있어요' 'DarkGray' } else { Write-Host '' }

    $last = [Math]::Min($top + $room, $entries.Count) - 1
    for ($k = $top; $k -le $last; $k++) {
        $e = $entries[$k]
        $body = '[' + (Pad-Display $e.Key 2) + ']  ' + (Pad-Display $e.Label 38) + $e.Note
        if ($k -eq $idx) { Write-Host ('   ▶ ' + $body) -ForegroundColor Black -BackgroundColor Gray }
        else             { Write-Host ('     ' + $body) -ForegroundColor $e.Color }
    }

    if ($last -lt ($entries.Count - 1)) { Show-Line '        ▼ 아래에 더 있어요' 'DarkGray' } else { Write-Host '' }
    if ($hidden -gt 0) {
        Show-Line ('   ... 이 밖에 ' + $hidden + '개 더 있어요. [D] 로 직접 입력하세요.') 'DarkGray'
    }
    Write-Host ''
    Show-Line ('   고른 곳 :  ' + $entries[$idx].Detail) 'Cyan'
    $hint = '   ↑↓ 로 고르고 Enter.   숫자·D 키는 그 줄로 이동.   S: 정렬 전환.   취소는 Esc.'
    if ($sortName) { $hint += ('   [정렬: ' + $sortName + ']') }
    Show-Line $hint 'Yellow'
}

#  --- 폴백: 입력이 리다이렉트된 곳(자동 테스트 등)에서는 화살표를 읽을 수
#      없으므로, 예전처럼 번호를 적어서 고른다. --------------------------
function Select-StartFolder-Typed($entries, $hidden) {
    while ($true) {
        Clear-Host
        Write-Host ''
        Show-Line '  ══════ 어느 폴더에서 시작할까요? ══════' 'Cyan'
        Write-Host ''
        foreach ($e in $entries) {
            Write-Host ('   [' + (Pad-Display $e.Key 2) + ']  ' + $e.Label) -ForegroundColor $e.Color
            Show-Line ('        ' + $e.Detail) 'DarkGray'
        }
        if ($hidden -gt 0) {
            Show-Line ('   ... 이 밖에 ' + $hidden + '개 더 있어요. [D] 로 직접 입력하세요.') 'DarkGray'
        }
        Write-Host ''
        $ans = Read-Host '   번호 입력 (그냥 Enter = 0번 홈 폴더)'
        if ($null -eq $ans) { return $env:USERPROFILE }
        $ans = ([string]$ans).Trim().ToUpper()
        if ($ans -eq '') { return $env:USERPROFILE }

        $sel = @($entries | Where-Object { $_.Key -eq $ans })[0]
        if ($null -eq $sel) {
            Show-Line '   그 번호는 없어요. 다시 골라주세요.' 'Red'
            Start-Sleep -Milliseconds 1200
            continue
        }
        if ($sel.Kind -ne 'manual') { return $sel.Path }

        $manual = Read-Host '   폴더 경로를 붙여넣으세요'
        if ($null -eq $manual) { return $env:USERPROFILE }
        $manual = $manual.Trim().Trim('"').Trim("'")
        if ($manual -eq '') { continue }
        if (Test-Path -LiteralPath $manual -PathType Container) { return $manual }
        Show-Line '   그런 폴더가 없어요. 경로를 다시 확인해 주세요.' 'Red'
        Start-Sleep -Milliseconds 1500
    }
}

function Build-FolderEntries($all, $sortModes, $sortIdx) {
    $mode   = $sortModes[$sortIdx]
    $sorted = @($all | Sort-Object $mode.Prop -Descending:$mode.Desc)
    $entries = @()
    #  [D] 경로 직접 입력은 맨 위에 둔다. 새 프로젝트는 홈 폴더에서 cd 로 옮길 수 없어서 결국 여기로 들어와야 하기 때문.
    $entries += [PSCustomObject]@{
        Key = 'D'; Kind = 'manual'; Color = 'Gray'
        Label = '경로 직접 입력'; Note = '목록에 없는 폴더'
        Detail = '고르면 폴더 경로를 붙여넣는 칸이 나와요'; Path = $null
    }
    $entries += [PSCustomObject]@{
        Key = '0'; Kind = 'home'; Color = 'Green'
        Label = '홈 폴더'; Note = '지금까지 방식'
        Detail = $env:USERPROFILE; Path = $env:USERPROFILE
    }
    $i = 1
    foreach ($p in $sorted) {
        $entries += [PSCustomObject]@{
            Key = [string]$i; Kind = 'folder'; Color = 'Gray'
            Label = $p.Name; Note = ''
            Detail = $p.Path; Path = $p.Path
        }
        $i++
    }
    return $entries
}

function Select-StartFolder {
    $all  = @(Get-ProjectFolders)
    #  예전엔 15개만 보여주고 나머지는 [D] 로 직접 쳐야만 갈 수 있었다.
    #  이제는 전부 목록에 넣고, 화면에 안 들어가는 만큼만 아래로 스크롤한다.
    $hidden = 0

    #  --- 정렬 옵션(2026-09-19 추가): S 키로 순환. 기본값은 기존과 동일(수정 최신순) ---
    $sortModes = @(
        @{ Name = '수정 최신순';   Prop = 'Last';    Desc = $true  }
        @{ Name = '수정 오래된순'; Prop = 'Last';    Desc = $false }
        @{ Name = '생성 최신순';   Prop = 'Created'; Desc = $true  }
        @{ Name = '생성 오래된순'; Prop = 'Created'; Desc = $false }
        @{ Name = '이름순';       Prop = 'Name';    Desc = $false }
        @{ Name = '이름역순';     Prop = 'Name';    Desc = $true  }
    )
    $sortIdx = 0

    #  화살표로 오르내릴 "한 줄짜리" 목록을 만든다 (직접 입력 → 홈 → 최근 폴더).
    #  전체 경로는 줄마다 찍지 않고, 지금 고른 줄만 아래에 크게 보여준다.
    $entries = Build-FolderEntries $all $sortModes $sortIdx

    if ([Console]::IsInputRedirected) { return (Select-StartFolder-Typed $entries $hidden) }

    #  (창을 코드로 강제로 키우는 기능은 빼다 - 실제 콘솔에서 목록이 두 번 격쳐 보이는 화면 손상이 실측되어 제거함.
    #   창을 더 크게 보고 싶으면 사용자가 직접 창 높이를 늘리면 된다 - 아래 계산은 그때마다 자동으로 맞춰진다.)
    $idx = 0
    $top = 0
    while ($true) {
        $h = 30
        try { $h = [Console]::WindowHeight } catch {}
        $win  = Get-PickerWindow $entries.Count $idx $top $h
        $top  = $win.Top
        $room = $win.Room

        Render-FolderPicker $entries $idx $top $room $hidden ($all.Count -eq 0) $sortModes[$sortIdx].Name

        $k = [Console]::ReadKey($true)
        if     ($k.Key -eq 'UpArrow')   { $idx = ($idx - 1 + $entries.Count) % $entries.Count }
        elseif ($k.Key -eq 'DownArrow') { $idx = ($idx + 1) % $entries.Count }
        elseif ($k.Key -eq 'Home')      { $idx = 0 }
        elseif ($k.Key -eq 'End')       { $idx = $entries.Count - 1 }
        elseif ($k.Key -eq 'PageUp')    { $idx = [Math]::Max(0, $idx - $room) }
        elseif ($k.Key -eq 'PageDown')  { $idx = [Math]::Min($entries.Count - 1, $idx + $room) }
        elseif ($k.Key -eq 'Escape')    { return $null }
        elseif ($k.Key -eq 'Enter') {
            $sel = $entries[$idx]
            if ($sel.Kind -ne 'manual') { return $sel.Path }
            Write-Host ''
            $manual = Read-Host '   폴더 경로를 붙여넣으세요 (그냥 Enter 면 취소)'
            if ($null -eq $manual) { continue }
            $manual = $manual.Trim().Trim('"').Trim("'")
            if ($manual -eq '') { continue }
            if (Test-Path -LiteralPath $manual -PathType Container) { return $manual }
            Show-Line '   그런 폴더가 없어요. 경로를 다시 확인해 주세요.' 'Red'
            Start-Sleep -Milliseconds 1500
        }
        elseif ($k.KeyChar -eq 's' -or $k.KeyChar -eq 'S') {
            #  정렬 방식 순환 전환. 지금 고른 폴더는 경로로 다시 찾아서 유지 시도.
            $curPath = $entries[$idx].Path
            $sortIdx = ($sortIdx + 1) % $sortModes.Count
            $entries = Build-FolderEntries $all $sortModes $sortIdx
            $again = $null
            if ($curPath) { $again = @($entries | Where-Object { $_.Path -eq $curPath })[0] }
            if ($again) { $idx = [array]::IndexOf($entries, $again) }
            elseif ($null -eq $curPath) { $idx = 0 }   # [D] 줄은 항상 맨 위 고정이라 그대로 유지
            else { $idx = 0 }
            $top = 0
        }
        else {
            #  숫자·D 키는 "그 줄로 이동"만 한다.
            #  (10~15번처럼 두 자리 번호가 있어서, 바로 실행하면 1을 누른 순간
            #   12번 대신 1번이 켜지는 사고가 난다. 이동만 시키고 Enter로 확정.)
            $ch = ([string]$k.KeyChar).ToUpper()
            for ($j = 0; $j -lt $entries.Count; $j++) {
                if ($entries[$j].Key -eq $ch) { $idx = $j; break }
            }
        }
    }
}

# ============================================================
function Invoke-Start {
    if (-not (Has-Claude)) {
        Clear-Host
        Show-Line '   아직 설치가 안 돼 있어요.' 'Yellow'
        Write-Host '   메뉴 [1] 설치하기 를 먼저 해주세요.'
        Wait-Key; return
    }
    # --- 고정디스크를 --add-dir 로 허용해 둔다 ---------------------------
    #  주의: 이건 '파일 읽기·쓰기 허용'일 뿐, cd 로 작업폴더를 옆기는 것은
    #  Claude Code 구조상 불가능하다(단독 cd 는 다음 명령에서 되돌려짐).
    #  그래서 시작 폴더는 위에서 골라서 정하고, 이건 보조수단으로만 쓴다.
    #  (경로는 D:/ 처럼 / 로 끝낸다 — 끝에 역슬래시가 오면 인자가 깨질 수 있음)
    $allowDirs = @()
    try {
        $vols = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' -ErrorAction Stop
        foreach ($v in $vols) {
            $r = $v.DeviceID + '/'
            if (Test-Path -LiteralPath $r) { $allowDirs += $r }
        }
    } catch {
        foreach ($d in (Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue)) {
            $r = $d.Name + ':/'
            if (Test-Path -LiteralPath $r) { $allowDirs += $r }
        }
    }

    $startDir = Select-StartFolder
    if ($null -eq $startDir) { return }   # Esc = 취소 (메뉴로 돌아감)
    #  목록을 만든 뒤에 폴더가 지워졌거나 이름이 바뀌었을 수 있다.
    #  실패를 그냥 넘기면 "고른 폴더"라고 써놓고 엉뚱한 곳에서 켜지므로 여기서 멈춘다.
    try {
        Set-Location -LiteralPath $startDir -ErrorAction Stop
    } catch {
        Clear-Host
        Show-Line '   그 폴더로 들어갈 수 없어요.' 'Red'
        Write-Host ('   ' + $startDir)
        Write-Host '   폴더가 지워졌거나 이름이 바뀌었을 수 있어요. 메뉴에서 다시 골라주세요.'
        Wait-Key
        return
    }
    Clear-Host
    Show-Line "   실행 위치 : $startDir" 'DarkGray'
    if ($allowDirs.Count -gt 0) {
        Show-Line ("   파일 접근 허용 : " + ($allowDirs -join '   ')) 'DarkGray'
    }
    if (-not (Test-FolderTrusted $startDir)) {
        Write-Host ''
        Show-Line '   [이 폴더는 Claude 로 처음 여는 곳이에요]' 'Yellow'
        Write-Host '   잠시 뒤  이 폴더를 믿나요?  라고 한 번 물어봅니다.'
        Write-Host '   기본 선택이  No, exit  라서 그냥 Enter 를 누르면 그대로 꺼져요.' -ForegroundColor Yellow
        Write-Host '   아래 화살표(↓)로  Yes, I trust this folder  를 고르고 Enter 하세요.'
        Write-Host '   한 번만 해두면 이 폴더는 다음부터 안 물어봅니다.'
        Write-Host ''
    }
    Write-Host '   Claude Code 를 켭니다.'
    Write-Host '   처음이면 브라우저 로그인 화면이 먼저 나와요.'
    Write-Host '   끝낼 때는 Claude 안에서  /exit  입력.'
    Write-Host ''
    if ($allowDirs.Count -gt 0) { claude --add-dir $allowDirs } else { claude }
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
    #  1·2 말고는 아무것도 지우지 않는다 (예전엔 9·n·q 같은 잘못된 입력도 프로그램 삭제로 넘어갔음)
    if ($u -ne '1' -and $u -ne '2') {
        Show-Line '   그 번호는 없어요. 아무것도 지우지 않았습니다.' 'Yellow'
        Wait-Key; return
    }

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
