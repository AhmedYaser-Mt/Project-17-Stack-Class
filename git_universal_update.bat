@echo off
setlocal EnableDelayedExpansion
title Git Universal Update V2

echo ========================================
echo   Git Universal Update (Stable V2)
echo ========================================
echo.

:: -------------------------------------------------
:: 1) Initialize repo if not exists
:: -------------------------------------------------
if not exist ".git" (
    echo 🚀 Initializing new Git repository...
    git init
    echo.
)

:: -------------------------------------------------
:: 2) Detect current branch
:: -------------------------------------------------
for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set currentBranch=%%i

if not defined currentBranch (
    set currentBranch=main
)

echo 🌿 Current branch: %currentBranch%
echo.

:: -------------------------------------------------
:: 3) Ask for branch (default current)
:: -------------------------------------------------
set "branchName="
set /p "branchName=Enter branch name (default: %currentBranch%): "

if not defined branchName (
    set branchName=%currentBranch%
)

echo.
echo 📂 Files status:
git status
echo.

:: -------------------------------------------------
:: 4) Check if there is anything to commit
:: -------------------------------------------------
git diff --cached --quiet
git diff --quiet
if %errorlevel%==0 (
    echo ⚠ Nothing to commit. Working tree clean.
) else (
    :: Ask for commit message
    set "commitMsg="
    set /p "commitMsg=Enter commit message: "

    if not defined commitMsg (
        echo ❌ Commit message cannot be empty.
        pause
        exit /b
    )

    echo.
    echo ➕ Adding files...
    git add .

    echo.
    echo 💾 Committing...
    git commit -m "!commitMsg!"
)

:: -------------------------------------------------
:: 5) Check if remote exists
:: -------------------------------------------------
git remote | findstr origin >nul
if errorlevel 1 (
    echo.
    echo 🔗 No remote repository found.

    set "repoURL="
    set /p "repoURL=Enter GitHub repository URL: "

    if not defined repoURL (
        echo ❌ Repository URL cannot be empty.
        pause
        exit /b
    )

    git remote add origin "!repoURL!"
)

:: -------------------------------------------------
:: 6) Check internet connection
:: -------------------------------------------------
echo.
echo 🌍 Checking internet connection...
ping github.com -n 1 >nul
if errorlevel 1 (
    echo ❌ No internet connection. Cannot push.
    pause
    exit /b
)

:: -------------------------------------------------
:: 7) Push safely
:: -------------------------------------------------
echo.
echo 🚀 Pushing to %branchName% ...
git push -u origin %branchName%

if errorlevel 1 (
    echo ❌ Push failed. Check credentials or branch name.
    pause
    exit /b
)

echo.
echo ✅ Done Successfully!
pause
exit /b
