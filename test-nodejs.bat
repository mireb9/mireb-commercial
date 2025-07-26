@echo off
title Test Node.js - Mireb Commercial
color 0B

echo.
echo ===== MIREB COMMERCIAL - NODE.JS TEST =====
echo Account: mirebcommercial@gmail.com
echo Author: Fiacre-19
echo Location: Kinshasa, Congo (DRC)
echo ===========================================
echo.

echo Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js not found
    echo.
    echo SOLUTION:
    echo 1. Download Node.js from: https://nodejs.org/
    echo 2. Install LTS version
    echo 3. Restart this script
    echo.
    echo Opening Node.js website...
    start https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js found:
node --version

echo ✅ npm version:
npm --version

echo.
echo Testing simple server...
echo 🌐 Server will start on: http://127.0.0.1:3000
echo 💡 Press Ctrl+C to stop the server
echo.

echo Starting test server...
node test-server.mjs

echo.
echo Server stopped.
pause
