@echo off
title Claude Code Universal
color 0A

REM === PC NAME AUTO DETECT ===
set "MY_USER=%USERNAME%"
set "MY_HOME=%USERPROFILE%"
set "MY_DESKTOP=%USERPROFILE%\Desktop"
set "MY_DOCS=%USERPROFILE%\Documents"
set "MY_DOWN=%USERPROFILE%\Downloads"

REM === NPM GLOBAL PATH AUTO ADD ===
set "NPM_GLOBAL=%APPDATA%\npm"
set "PATH=%NPM_GLOBAL%;%PATH%"

REM === CHECK CLAUDE CODE ===
where claude >nul 2>&1
if errorlevel 1 (
    echo.
    echo Claude Code not found! Installing...
    echo.
    call npm install -g @anthropic-ai/claude-code
    echo.
    echo Installation complete! Restarting...
    timeout /t 3 >nul
)

:MENU
cls
echo.
echo ============================================
echo         CLAUDE CODE - UNIVERSAL
echo ============================================
echo.
echo   PC User: %MY_USER%
echo   Home: %MY_HOME%
echo.
echo ============================================
echo.
echo   [0] = AUTO START (BEST!)
echo.
echo   [1] = HERE
echo   [2] = DESKTOP
echo   [3] = DOCUMENTS  
echo   [4] = DOWNLOADS
echo.
echo   [5] = NEW PROJECT
echo   [6] = SELECT FOLDER
echo.
echo   [Q] = EXIT
echo.
echo ============================================
echo.
echo   TIP: JUST PRESS 0
echo.
set /p choice="SELECT: "

if "%choice%"=="0" goto AUTO
if "%choice%"=="1" goto HERE
if "%choice%"=="2" goto DESKTOP
if "%choice%"=="3" goto DOCUMENTS
if "%choice%"=="4" goto DOWNLOADS
if "%choice%"=="5" goto NEW
if "%choice%"=="6" goto SELECT
if /i "%choice%"=="Q" exit

echo Try again!
timeout /t 2 >nul
goto MENU

:AUTO
cls
echo ============================================
echo              AUTO MODE
echo ============================================
echo.
echo Checking: %CD%
echo.

REM Check if project folder
if exist "*.html" goto RUN
if exist "*.py" goto RUN
if exist "*.js" goto RUN
if exist "*.txt" goto RUN
if exist "*.md" goto RUN
if exist "*.json" goto RUN
if exist "*.xml" goto RUN

echo No project files found
echo.
echo [1] Start here anyway
echo [2] Go to Desktop
echo [3] Create new project
echo.
set /p auto="Choose (1-3): "

if "%auto%"=="1" goto RUN
if "%auto%"=="2" goto DESKTOP
if "%auto%"=="3" goto NEW
goto RUN

:RUN
echo.
echo --------------------------------------------
echo Starting Claude Code...
echo Path: %CD%
echo --------------------------------------------
echo.
claude
if errorlevel 1 (
    echo.
    echo ERROR: Claude Code not installed!
    echo.
    echo Please run:
    echo npm install -g @anthropic-ai/claude-code
    echo.
)
pause
goto MENU

:HERE
cls
echo ============================================
echo           CURRENT FOLDER
echo ============================================
echo.
echo Path: %CD%
echo.
claude
pause
goto MENU

:DESKTOP
cls
if not exist "%MY_DESKTOP%" (
    echo Creating Desktop folder...
    mkdir "%MY_DESKTOP%" 2>nul
)
cd /d "%MY_DESKTOP%"
echo ============================================
echo              DESKTOP
echo ============================================
echo.
echo Path: %MY_DESKTOP%
echo.
claude
pause
goto MENU

:DOCUMENTS
cls
if not exist "%MY_DOCS%" (
    echo Creating Documents folder...
    mkdir "%MY_DOCS%" 2>nul
)
cd /d "%MY_DOCS%"
echo ============================================
echo            DOCUMENTS
echo ============================================
echo.
echo Path: %MY_DOCS%
echo.
claude
pause
goto MENU

:DOWNLOADS
cls
if not exist "%MY_DOWN%" (
    echo Creating Downloads folder...
    mkdir "%MY_DOWN%" 2>nul
)
cd /d "%MY_DOWN%"
echo ============================================
echo            DOWNLOADS
echo ============================================
echo.
echo Path: %MY_DOWN%
echo.
claude
pause
goto MENU

:NEW
cls
echo ============================================
echo          NEW PROJECT
echo ============================================
echo.
echo Where to create?
echo.
echo [1] Desktop
echo [2] Documents
echo [3] Current folder
echo [4] Custom path
echo.
set /p where="Select (1-4): "

if "%where%"=="1" (
    set "create_path=%MY_DESKTOP%"
    set "create_name=Desktop"
)
if "%where%"=="2" (
    set "create_path=%MY_DOCS%"
    set "create_name=Documents"
)
if "%where%"=="3" (
    set "create_path=%CD%"
    set "create_name=Current"
)
if "%where%"=="4" (
    echo.
    set /p create_path="Enter full path: "
    set "create_name=Custom"
)

echo.
set /p project="Project name: "
if "%project%"=="" goto MENU

cd /d "%create_path%" 2>nul
if errorlevel 1 (
    echo ERROR: Invalid path
    pause
    goto MENU
)

mkdir "%project%" 2>nul
cd "%project%"
echo.
echo SUCCESS!
echo Created: %create_path%\%project%
echo.
claude
pause
goto MENU

:SELECT
cls
echo ============================================
echo          SELECT FOLDER
echo ============================================
echo.
echo Quick paths:
echo [1] %MY_DESKTOP%
echo [2] %MY_DOCS%
echo [3] %MY_DOWN%
echo [4] %MY_HOME%
echo [5] C:\
echo [6] Type custom path
echo.
set /p sel="Select (1-6): "

if "%sel%"=="1" cd /d "%MY_DESKTOP%"
if "%sel%"=="2" cd /d "%MY_DOCS%"
if "%sel%"=="3" cd /d "%MY_DOWN%"
if "%sel%"=="4" cd /d "%MY_HOME%"
if "%sel%"=="5" cd /d "C:\"
if "%sel%"=="6" (
    echo.
    set /p custom="Enter path: "
    cd /d "%custom%" 2>nul
    if errorlevel 1 (
        echo ERROR: Path not found
        pause
        goto MENU
    )
)

echo.
echo Moved to: %CD%
echo.
claude
pause
goto MENU