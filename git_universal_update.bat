@echo off
setlocal EnableDelayedExpansion
title Git Universal Update V4 - Elite

:: Enable Colors
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

set "GREEN=%ESC%[92m"
set "RED=%ESC%[91m"
set "YELLOW=%ESC%[93m"
set "CYAN=%ESC%[96m"
set "RESET=%ESC%[0m"

echo %CYAN%========================================%RESET%
echo %CYAN%   Git Universal Update (Elite V4)%RESET%
echo %CYAN%========================================%RESET%
echo.

:: -------------------------------------------------
:: 1) Init if needed
:: -------------------------------------------------
if not exist ".git" (
    echo %YELLOW%Initializing new repository...%RESET%
    git init
    echo.
)

:: -------------------------------------------------
:: 2) Detect Branch
:: -------------------------------------------------
for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set currentBranch=%%i
if not defined currentBranch set currentBranch=main

echo %GREEN%Current branch:%RESET% %currentBranch%
echo.

:: -------------------------------------------------
:: 3) Ask branch
:: -------------------------------------------------
set "branchName="
set /p "branchName=Enter branch name (default: %currentBranch%): "
if not defined branchName set branchName=%currentBranch%

echo.
git status
echo.

:: -------------------------------------------------
:: 4) Commit if needed
:: -------------------------------------------------
git diff --quiet
if not %errorlevel%==0 (
    set "commitMsg="
    set /p "commitMsg=Enter commit message: "
    if not defined commitMsg (
        echo %RED%Commit message cannot be empty.%RESET%
        pause
        exit /b
    )

    git add .
    git commit -m "!commitMsg!"
) else (
    echo %YELLOW%Nothing to commit.%RESET%
)

:: -------------------------------------------------
:: 5) Remote Check
:: -------------------------------------------------
git remote | findstr origin >nul
if errorlevel 1 (
    echo.
    echo %YELLOW%No remote found.%RESET%
    set "repoURL="
    set /p "repoURL=Enter GitHub repository URL: "
    if not defined repoURL (
        echo %RED%Repository URL cannot be empty.%RESET%
        pause
        exit /b
    )
    git remote add origin "!repoURL!"
)

:: -------------------------------------------------
:: 6) Internet Check
:: -------------------------------------------------
ping github.com -n 1 >nul
if errorlevel 1 (
    echo %RED%No internet connection.%RESET%
    pause
    exit /b
)

:: -------------------------------------------------
:: 7) Smart Push
:: -------------------------------------------------
echo.
echo %CYAN%Pushing...%RESET%
git push -u origin %branchName%

if errorlevel 1 (
    echo.
    echo %YELLOW%Remote has changes. Attempting safe merge...%RESET%

    git pull origin %branchName% --allow-unrelated-histories --no-edit

    if errorlevel 1 (
        echo.
        echo %RED%Merge conflict detected!%RESET%
        echo Please resolve conflicts manually.
        pause
        exit /b
    )

    echo.
    echo %CYAN%Retrying push...%RESET%
    git push -u origin %branchName%

    if errorlevel 1 (
        echo %RED%Push failed again.%RESET%
        pause
        exit /b
    )
)

echo.
echo %GREEN%All Done Successfully!%RESET%
pause
exit /b
