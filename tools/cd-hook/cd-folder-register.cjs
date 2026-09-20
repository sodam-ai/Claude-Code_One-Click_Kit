#!/usr/bin/env node
'use strict';
// PreToolUse(Bash/PowerShell) 훅 — 명령어 안의 cd/Set-Location 대상 폴더를
// 원클릭 키트의 menu-extra-folders.txt 에 자동 등록한다.
// 절대 명령 실행을 막거나 바꾸지 않는다 (관찰만 하고 항상 exit 0).

const fs = require('fs');
const path = require('path');
const os = require('os');

let raw = '';
process.stdin.on('data', (d) => { raw += d; });
process.stdin.on('end', () => {
  try {
    run();
  } catch (e) {
    // 어떤 오류가 나도 원래 명령을 막지 않는다. 다만 조용히 실패하면 원인을 알 수 없으므로
    // 오류 "종류"만 로그에 남긴다(메시지에는 명령어 조각이 섞일 수 있어 기록하지 않음).
    logError(e);
  }
  process.exit(0);
});

function logError(e) {
  try {
    const appData = process.env.APPDATA;
    if (!appData) return;
    const logFile = path.join(appData, 'claude-code', 'cd-hook-errors.log');
    let size = 0;
    try { size = fs.statSync(logFile).size; } catch (_) { /* 아직 없음 */ }
    if (size > 50 * 1024) return; // 무한 증가 방지
    const kind = (e && (e.code || e.name)) || 'Error';
    fs.mkdirSync(path.dirname(logFile), { recursive: true });
    fs.appendFileSync(logFile, new Date().toISOString() + ' ' + String(kind).slice(0, 60) + '\n', 'utf8');
  } catch (_) { /* 로그 실패도 무시 */ }
}

function run() {
  const input = JSON.parse(raw || '{}');
  const command = (input.tool_input && input.tool_input.command) || '';
  if (!command) return;

  // 오탐 방지(2026-09-19 실측 발견): echo/printf/Write-Host/cat/type 등으로 시작하는
  // 명령은 "텍스트를 출력/전달"하는 것뿐이라, 그 안의 cd 같은 문자열은 진짜 이동이
  // 아니라 그냥 데이터일 수 있다(실측: 이 훅 자체를 echo로 테스트하다가 오탐 확인됨).
  // 진짜 cd/Set-Location 명령은 이렇게 시작하지 않으므로 안전하게 건너뛴다.
  if (/^\s*(echo|printf|Write-Host|Write-Output|cat|type)\b/i.test(command)) return;

  // cd 또는 Set-Location(별칭 sl) 뒤에 오는 마지막 경로만 뽑는다.
  // 체인 명령(cd A && cmd, cd A; cmd)에서도 cd 대상만 골라낸다.
  const re = /(?:^|[;&|]\s*)(?:cd|Set-Location|sl)\s+["']?([A-Za-z]:[\\/][^"'&;|\r\n]*)/gi;
  let m;
  let target = null;
  while ((m = re.exec(command))) { target = m[1]; }
  if (!target) return;

  target = target.trim().replace(/[\\/]+$/, '');
  if (target.length < 3) return;
  const winPath = target.replace(/\//g, '\\');

  let stat;
  try { stat = fs.statSync(winPath); } catch (e) { return; }
  if (!stat.isDirectory()) return;

  const home = os.homedir();
  const winDir = process.env.WINDIR || 'C:\\Windows';
  const lower = winPath.toLowerCase();
  if (lower === home.toLowerCase()) return;
  if (lower.startsWith(winDir.toLowerCase())) return;

  // 작업 폴더가 아닌 곳(패키지 내부, Claude 설정 폴더)은 목록을 어지럽히므로 제외
  if (/[\\/]node_modules([\\/]|$)/i.test(winPath)) return;
  if (/[\\/]Temp[\\/]claude([\\/]|$)/i.test(winPath)) return;

  const appData = process.env.APPDATA;
  if (!appData) return;
  if (lower.startsWith(path.join(appData, 'claude-code').toLowerCase())) return;
  const extraFile = path.join(appData, 'claude-code', 'menu-extra-folders.txt');
  fs.mkdirSync(path.dirname(extraFile), { recursive: true });

  let existing = [];
  try {
    existing = fs.readFileSync(extraFile, 'utf8').split(/\r?\n/);
  } catch (e) { /* 파일 없으면 새로 시작 */ }

  const already = existing.some((l) => l.trim().toLowerCase() === winPath.toLowerCase());
  if (!already) {
    fs.appendFileSync(extraFile, winPath + '\n', 'utf8');
  }
}
