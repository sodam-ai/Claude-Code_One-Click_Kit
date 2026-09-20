@echo off
chcp 65001 >nul
where node >nul 2>&1
if errorlevel 1 echo Node.js is required. Install it from https://nodejs.org and run this file again.
if errorlevel 1 goto end
node "%~dp0install-cd-hook.cjs" %*
:end
echo.
pause
