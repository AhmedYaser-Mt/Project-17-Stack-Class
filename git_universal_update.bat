@echo off
title Git Universal Update

echo ========================================
echo   Git Universal Update
echo ========================================
echo.

:: Check if .git exists
if not exist ".git" (
    echo 🚀 Initializing new Git repository...
    git init
    echo.
)

:: Show current branch
for /f "delims=" %%i in ('git branch --show-current') do set currentBranch=%%i

if "%currentBranch%"=="" (
    set currentBranch=main
)

echo 🌿 Current branch: %currentBranch%
echo.

:: Ask for branch (default current)
set /p branchName=Enter branch name (default: %currentBranch%): 
if "%branchName%"=="" set branchName=%currentBranch%

echo.
echo 📂 Files to be committed:
git status
echo.

:: Ask for commit message (MANDATORY)
set /p commitMsg=Enter commit message: 
if "%commitMsg%"=="" (
    echo ❌ Commit message cannot be empty.
    pause
    exit /b
)

echo.
echo ➕ Adding files...
git add .

echo.
echo 💾 Committing...
git commit -m "%commitMsg%"

:: Check if remote exists
git remote | findstr origin >nul
if errorlevel 1 (
    echo.
    echo 🔗 No remote repository found.
    set /p repoURL=Enter GitHub repository URL: 

    if "%repoURL%"=="" (
        echo ❌ Repository URL cannot be empty.
        pause
        exit /b
    )

    git remote add origin %repoURL%
)

:: Check internet connection
echo.
echo 🌍 Checking internet connection...
ping github.com -n 1 >nul
if errorlevel 1 (
    echo ❌ No internet connection. Cannot push.
    pause
    exit /b
)

echo.
echo 🚀 Pushing to %branchName% ...
git push -u origin %branchName%

if errorlevel 1 (
    echo ❌ Push failed. Check branch or credentials.
    pause
    exit /b
)

echo.
echo ✅ Done Successfully!
pause
