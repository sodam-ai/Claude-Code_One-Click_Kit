#!/usr/bin/env node
'use strict';
// cd-folder-register 훅 설치기.
//  1) 훅 파일을 <설정폴더>/hooks 로 복사
//  2) settings.json 의 hooks.PreToolUse 에 Bash/PowerShell 항목을 "덧붙이기만" 함 (기존 항목·설정은 그대로)
//  3) 임시 폴더로 자체 테스트
// 안전장치: 수정 전 백업 → 수정 후 재검증 → 실패 시 자동 복구. 여러 번 실행해도 결과 동일.
// 사용법: node install-cd-hook.cjs [--dry-run]   (--dry-run: 아무것도 쓰지 않고 무엇을 할지만 보여줌)
// 설정 폴더: 환경변수 CLAUDE_CONFIG_DIR, 없으면 ~/.claude

const fs = require('fs');
const os = require('os');
const path = require('path');

const DRY = process.argv.includes('--dry-run');
// 모르는 옵션(예: --dryrun 오타)이면 실제 설치로 넘어가지 않고 멈춘다
const UNKNOWN_ARGS = process.argv.slice(2).filter((a) => a !== '--dry-run');
if (UNKNOWN_ARGS.length) {
  console.error('[중단] 알 수 없는 옵션: ' + UNKNOWN_ARGS.join(' ') + '\n사용법: node install-cd-hook.cjs [--dry-run]\n아무것도 바꾸지 않았습니다.');
  process.exit(2);
}
const HOOK_NAME = 'cd-folder-register.cjs';
const MATCHERS = ['Bash', 'PowerShell'];

function say(s) { console.log(s); }
function fail(msg) { console.error('\n[중단] ' + msg + '\n아무것도 바꾸지 않았거나, 바꾼 것은 원래대로 되돌렸습니다.'); process.exit(1); }

const cfgDir = process.env.CLAUDE_CONFIG_DIR && process.env.CLAUDE_CONFIG_DIR.trim()
  ? process.env.CLAUDE_CONFIG_DIR.trim()
  : path.join(os.homedir(), '.claude');
const hooksDir = path.join(cfgDir, 'hooks');
const dstHook = path.join(hooksDir, HOOK_NAME);
const srcHook = path.join(__dirname, HOOK_NAME);
const settingsPath = path.join(cfgDir, 'settings.json');

say('설정 폴더: ' + cfgDir + (DRY ? '   (시험 모드: 아무것도 쓰지 않습니다)' : ''));

if (!fs.existsSync(srcHook)) fail('이 설치기와 같은 폴더에 ' + HOOK_NAME + ' 파일이 없습니다. 폴더째 복사했는지 확인하세요.');
if (!fs.existsSync(cfgDir)) fail('설정 폴더가 없습니다: ' + cfgDir + '\nClaude Code를 한 번 실행한 뒤 다시 시도하거나, CLAUDE_CONFIG_DIR 환경변수를 확인하세요.');

// 훅 파일 문법 검사 (깨진 파일을 설치하지 않기 위해)
try {
  const vm = require('vm');
  new vm.Script(fs.readFileSync(srcHook, 'utf8').replace(/^﻿/, '').replace(/^#!.*/, ''), { filename: HOOK_NAME });
} catch (e) {
  fail('훅 파일 문법 검사 실패(' + (e && e.name) + '). 파일이 손상됐을 수 있습니다.');
}

// settings.json 읽기
let original = null; // 원문 문자열 (없으면 null)
let cfg = {};
if (fs.existsSync(settingsPath)) {
  original = fs.readFileSync(settingsPath, 'utf8');
  try { cfg = JSON.parse(original.replace(/^﻿/, '')); }
  catch (e) { fail('settings.json 을 읽을 수 없습니다(JSON 형식 오류). 이 파일을 먼저 고친 뒤 다시 실행하세요. 설치기는 손대지 않았습니다.'); }
  if (cfg === null || typeof cfg !== 'object' || Array.isArray(cfg)) fail('settings.json 의 최상위 형식이 예상과 다릅니다.');
}
if (cfg.disableAllHooks === true) say('주의: settings.json 에 disableAllHooks=true 가 있어 훅이 꺼져 있습니다. 설치는 되지만 동작하려면 이 값을 끄세요.');

const command = 'node "' + dstHook.replace(/\\/g, '/') + '"';
const before = JSON.stringify(cfg);

if (cfg.hooks === undefined) cfg.hooks = {};
if (cfg.hooks === null || typeof cfg.hooks !== 'object' || Array.isArray(cfg.hooks)) fail('settings.json 의 "hooks" 형식이 예상과 다릅니다.');
if (cfg.hooks.PreToolUse === undefined) cfg.hooks.PreToolUse = [];
if (!Array.isArray(cfg.hooks.PreToolUse)) fail('settings.json 의 hooks.PreToolUse 형식이 예상과 다릅니다(배열이어야 함).');

const added = [];
for (const m of MATCHERS) {
  const entries = cfg.hooks.PreToolUse.filter((x) => x && x.matcher === m && Array.isArray(x.hooks));
  const already = entries.some((x) => x.hooks.some((h) => h && typeof h.command === 'string' && h.command.includes(HOOK_NAME)));
  if (already) continue; // 이 matcher 에는 이미 등록됨
  if (entries.length) entries[0].hooks.push({ type: 'command', command }); // 기존 묶음 뒤에 덧붙이기
  else cfg.hooks.PreToolUse.push({ matcher: m, hooks: [{ type: 'command', command }] });
  added.push(m);
}

const needCopy = path.resolve(srcHook).toLowerCase() !== path.resolve(dstHook).toLowerCase();
const needSettings = added.length > 0;

say('훅 파일 복사: ' + (needCopy ? '필요' : '같은 위치라 생략'));
say('settings.json 등록: ' + (needSettings ? added.join(', ') + ' 에 추가 예정' : '이미 등록되어 있음'));

if (DRY) { say('\n시험 모드 종료. 실제 변경은 없습니다.'); process.exit(0); }

let backupPath = null;
function restore() {
  try {
    if (backupPath) fs.copyFileSync(backupPath, settingsPath);
    else if (original === null && fs.existsSync(settingsPath)) fs.unlinkSync(settingsPath);
  } catch (e) { /* 복구 실패는 아래 안내로 */ }
}

try {
  if (needCopy) {
    fs.mkdirSync(hooksDir, { recursive: true });
    fs.copyFileSync(srcHook, dstHook);
  }
  if (needSettings) {
    if (original !== null) {
      const ts = new Date().toISOString().replace(/[-:T]/g, '').slice(0, 14);
      backupPath = settingsPath + '.bak-cd-hook-' + ts;
      fs.copyFileSync(settingsPath, backupPath);
    }
    const tmp = settingsPath + '.tmp-cd-hook';
    fs.writeFileSync(tmp, JSON.stringify(cfg, null, 2) + '\n', 'utf8'); // BOM 없이 저장
    // 재검증: 읽히는지, 두 항목이 있는지, 기존 내용이 그대로인지
    const re = JSON.parse(fs.readFileSync(tmp, 'utf8'));
    const ok = MATCHERS.every((m) => re.hooks.PreToolUse.some((x) => x && x.matcher === m && x.hooks.some((h) => h.command === command || String(h.command).includes(HOOK_NAME))));
    if (!ok) { fs.unlinkSync(tmp); throw new Error('재검증 실패'); }
    // PreToolUse 를 뺀 나머지가 원본과 완전히 같아야 함
    const rest = (o) => { const c = JSON.parse(JSON.stringify(o)); if (c.hooks) { delete c.hooks.PreToolUse; if (!Object.keys(c.hooks).length) delete c.hooks; } return JSON.stringify(c); };
    if (rest(JSON.parse(before)) !== rest(re)) { fs.unlinkSync(tmp); throw new Error('기존 설정이 달라짐'); }
    // PreToolUse 안의 기존 항목도 하나도 사라지면 안 됨
    const oldPre = (JSON.parse(before).hooks || {}).PreToolUse || [];
    const newHas = JSON.stringify(re.hooks.PreToolUse);
    for (const x of oldPre) for (const h of (x && x.hooks) || []) if (h && h.command && !newHas.includes(JSON.stringify(h.command).slice(1, -1))) { fs.unlinkSync(tmp); throw new Error('기존 훅 항목이 사라짐'); }
    fs.renameSync(tmp, settingsPath);
  }
} catch (e) {
  restore();
  fail('설치 중 오류(' + (e && e.message) + '). 백업으로 복구했습니다.' + (backupPath ? ' 백업: ' + backupPath : ''));
}

// 자체 테스트: 임시 폴더에서 훅이 실제로 폴더를 등록하는지 (실제 등록 파일은 건드리지 않음)
let selfTest = '생략';
try {
  const { execFileSync } = require('child_process');
  const root = fs.mkdtempSync(path.join(os.tmpdir(), 'cdhook-selftest-'));
  const fakeApp = path.join(root, 'appdata');
  const proj = path.join(root, 'proj');
  fs.mkdirSync(proj);
  const input = JSON.stringify({ tool_input: { command: 'cd ' + proj.replace(/\\/g, '/') } });
  execFileSync('node', [dstHook], { input, env: Object.assign({}, process.env, { APPDATA: fakeApp }), stdio: ['pipe', 'pipe', 'pipe'] });
  const reg = path.join(fakeApp, 'claude-code', 'menu-extra-folders.txt');
  const okTest = fs.existsSync(reg) && fs.readFileSync(reg, 'utf8').split(/\r?\n/).includes(proj);
  selfTest = okTest ? '통과' : '실패(훅이 폴더를 등록하지 않음)';
  try { fs.unlinkSync(reg); fs.rmdirSync(path.dirname(reg)); fs.rmdirSync(fakeApp); fs.rmdirSync(proj); fs.rmdirSync(root); } catch (e) { /* 임시 폴더 정리 실패는 무시 */ }
} catch (e) {
  selfTest = '실패(' + (e && e.message ? String(e.message).split('\n')[0] : 'error') + ')';
}

say('\n[완료]');
say(' - 훅 파일: ' + dstHook);
say(' - settings.json: ' + (needSettings ? '등록 완료' + (backupPath ? ' (백업: ' + backupPath + ')' : ' (새로 만듦)') : '변경 없음(이미 설치됨)'));
say(' - 자체 테스트: ' + selfTest);
say('\n새 Claude Code 세션을 열어 폴더로 cd 한 뒤, ' + path.join('%APPDATA%', 'claude-code', 'menu-extra-folders.txt') + ' 에 들어갔는지 확인하세요.');
if (selfTest.startsWith('실패')) process.exit(2);
