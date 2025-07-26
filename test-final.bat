@echo off
title Mireb Commercial - Test Final Node.js
color 0A

echo.
echo ========================================
echo  🏪 MIREB COMMERCIAL - TEST FINAL
echo ========================================
echo  📧 Account: mirebcommercial@gmail.com
echo  🔑 Author: Fiacre-19
echo  🌍 Location: Kinshasa, Congo (DRC)
echo ========================================
echo.

echo ✅ Testing Node.js installation...
"C:\Program Files\nodejs\node.exe" --version
if %errorlevel% neq 0 (
    echo ❌ Node.js test failed
    pause
    exit /b 1
)

echo ✅ Testing npm...
"C:\Program Files\nodejs\npm.cmd" --version
if %errorlevel% neq 0 (
    echo ❌ npm test failed
    pause
    exit /b 1
)

echo.
echo ✅ Node.js and npm are working perfectly!
echo.
echo 🚀 NEXT STEPS:
echo 1. Install dependencies: npm install
echo 2. Start test server: node quick-test.mjs
echo 3. Open: http://127.0.0.1:3000
echo.

echo 🎯 Starting quick test server...
echo 🌐 URL: http://127.0.0.1:3000
echo 💡 Press Ctrl+C to stop
echo.

"C:\Program Files\nodejs\node.exe" quick-test.mjs

echo.
echo Server stopped.
pause
