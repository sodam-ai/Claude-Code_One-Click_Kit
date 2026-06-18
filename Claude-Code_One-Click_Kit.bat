@echo off
REM ============================================================
REM  Claude Code One-Click Kit - launcher (ASCII only)
REM  The Korean menu is in menu.ps1. PowerShell renders Korean
REM  safely regardless of the console code page, which avoids
REM  the cmd UTF-8 batch-parser bug. Do not put Korean here.
REM ============================================================
title Claude Code One-Click Kit
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0menu.ps1"
if errorlevel 1 (
    echo.
    echo  Could not start the menu. Right-click menu.ps1 was blocked?
    echo  Try: keep this .bat and menu.ps1 together in the same folder.
    echo.
    pause
)
