#!/usr/bin/env node
'use strict';
// cd-folder-register 훅 상태 점검 (읽기 전용 — settings.json·등록 파일을 절대 수정하지 않음).
// 사용법: node check-cd-hook.cjs
// 설정 폴더: 환경변수 CLAUDE_CONFIG_DIR, 없으면 ~/.claude

const fs = require('fs');
const os = require('os');
const path = require('path');
const crypto = require('crypto');

const HOOK_NAME = 'cd-folder-register.cjs';
const cfgDir = process.env.CLAUDE_CONFIG_DIR && process.env.CLAUDE_CONFIG_DIR.trim()
  ? process.env.CLAUDE_CONFIG_DIR.trim() : path.join(os.homedir(), '.claude');
const hookFile = path.join(cfgDir, 'hooks', HOOK_NAME);
const settingsFile = path.join(cfgDir, 'settings.json');
const appData = process.env.APPDATA || '';
const extraFile = path.join(appData, 'claude-code', 'menu-extra-folders.txt');
const errLog = path.join(appData, 'claude-code', 'cd-hook-errors.log');

let bad = 0, warn = 0;
const ok = (m) => console.log('  [정상] ' + m);
const ng = (m) => { bad++; console.log('  [문제] ' + m); };
const wn = (m) => { warn++; console.log('  [주의] ' + m); };
const sha = (buf) => crypto.createHash('sha256').update(buf).digest('hex').slice(0, 12);

console.log('cd 훅 상태 점검 (읽기 전용)');
console.log('설정 폴더: ' + cfgDir + '\n');

// 1. 훅 파일
console.log('1) 훅 파일');
let hookBuf = null;
try {
  hookBuf = fs.readFileSync(hookFile);
  ok('있음: ' + hookFile);
  try {
    new (require('vm').Script)(hookBuf.toString('utf8').replace(/^﻿/, '').replace(/^#!.*/, ''), { filename: HOOK_NAME });
    ok('문법 이상 없음');
  } catch (e) { ng('문법 오류(' + (e && e.name) + ') — 파일이 손상됐을 수 있음'); }
} catch (e) { ng('없음: ' + hookFile + ' → install-cd-hook.cmd 를 실행하세요'); }

// 2. settings.json 등록
console.log('\n2) settings.json 등록');
let settingsBuf = null;
try {
  settingsBuf = fs.readFileSync(settingsFile);
  const j = JSON.parse(settingsBuf.toString('utf8').replace(/^﻿/, ''));
  ok('JSON 정상으로 읽힘');
  const pre = (j.hooks && Array.isArray(j.hooks.PreToolUse)) ? j.hooks.PreToolUse : [];
  for (const m of ['Bash', 'PowerShell']) {
    const hit = pre.some((x) => x && x.matcher === m && Array.isArray(x.hooks) && x.hooks.some((h) => h && String(h.command).includes(HOOK_NAME)));
    hit ? ok(m + ' 에 등록됨') : ng(m + ' 에 등록 안 됨 → install-cd-hook.cmd 를 실행하세요');
  }
  if (j.disableAllHooks === true) ng('disableAllHooks=true — 모든 훅이 꺼져 있음');
} catch (e) {
  if (e && e.code === 'ENOENT') ng('settings.json 없음: ' + settingsFile);
  else ng('settings.json 을 읽을 수 없음(JSON 형식 오류 가능)');
}

// 3. 오류 로그
console.log('\n3) 오류 로그');
try {
  const st = fs.statSync(errLog);
  const lines = fs.readFileSync(errLog, 'utf8').split(/\r?\n/).filter(Boolean);
  wn('오류 기록 ' + lines.length + '건 (' + st.size + ' bytes). 최근 3건:');
  lines.slice(-3).forEach((l) => console.log('         ' + l));
} catch (e) { ok('오류 기록 없음'); }

// 4. 등록된 폴더
console.log('\n4) 등록된 폴더 (menu-extra-folders.txt)');
let extraCount = 0;
try {
  const lines = fs.readFileSync(extraFile, 'utf8').split(/\r?\n/).map((s) => s.trim()).filter(Boolean);
  extraCount = lines.length;
  ok(lines.length + '개 등록');
  for (const l of lines) {
    let isDir = false; try { isDir = fs.statSync(l).isDirectory(); } catch (e) { /* 없음 */ }
    console.log('         ' + (isDir ? '(있음) ' : '(없는 폴더) ') + l);
    if (!isDir) warn++;
  }
} catch (e) { wn('등록 파일이 아직 없음 — 아직 어떤 폴더로도 cd 하지 않았거나, 훅이 동작하지 않음'); }

// 5. 훅 실제 동작 (임시 폴더, 실제 등록 파일은 건드리지 않음)
console.log('\n5) 훅 동작 자체 테스트');
if (hookBuf) {
  let root = null;
  try {
    const { execFileSync } = require('child_process');
    root = fs.mkdtempSync(path.join(os.tmpdir(), 'cdhook-check-'));
    const fakeApp = path.join(root, 'appdata'); const proj = path.join(root, 'proj');
    fs.mkdirSync(proj);
    const input = JSON.stringify({ tool_input: { command: 'cd ' + proj.replace(/\\/g, '/') } });
    execFileSync('node', [hookFile], { input, env: Object.assign({}, process.env, { APPDATA: fakeApp }), stdio: ['pipe', 'pipe', 'pipe'] });
    const reg = path.join(fakeApp, 'claude-code', 'menu-extra-folders.txt');
    const good = fs.existsSync(reg) && fs.readFileSync(reg, 'utf8').split(/\r?\n/).includes(proj);
    good ? ok('임시 폴더 cd 를 정상 등록함') : ng('훅이 폴더를 등록하지 않음');
    try { fs.unlinkSync(reg); fs.rmdirSync(path.dirname(reg)); fs.rmdirSync(fakeApp); fs.rmdirSync(proj); fs.rmdirSync(root); } catch (e) { /* 정리 실패 무시 */ }
  } catch (e) { ng('훅 실행 실패: ' + String(e && e.message).split('\n')[0]); }
} else { wn('훅 파일이 없어 건너뜀'); }

// 기준값
console.log('\n[기준값 — 나중에 무언가 바뀌었는지 비교용]');
console.log('  Node ' + process.version + ' / ' + os.platform());
console.log('  훅 파일 sha256(앞 12자): ' + (hookBuf ? sha(hookBuf) : '-'));
console.log('  settings.json sha256(앞 12자): ' + (settingsBuf ? sha(settingsBuf) : '-'));
console.log('  등록된 폴더 수: ' + extraCount);

console.log('\n결과: ' + (bad ? '문제 ' + bad + '건' : '문제 없음') + (warn ? ', 주의 ' + warn + '건' : ''));
process.exit(bad ? 1 : 0);
