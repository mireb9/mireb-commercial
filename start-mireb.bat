<<<<<<< HEAD
@echo off
title Mireb Commercial - mirebcommercial@gmail.com
color 0A
echo.
echo  ███╗   ███╗██╗██████╗ ███████╗██████╗ 
echo  ████╗ ████║██║██╔══██╗██╔════╝██╔══██╗
echo  ██╔████╔██║██║██████╔╝█████╗  ██████╔╝
echo  ██║╚██╔╝██║██║██╔══██╗██╔══╝  ██╔══██╗
echo  ██║ ╚═╝ ██║██║██║  ██║███████╗██████╔╝
echo  ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ 
echo.
echo  COMMERCIAL E-COMMERCE PLATFORM
echo  Account: mirebcommercial@gmail.com
echo  Author: Fiacre-19
echo.
echo ==========================================
echo  Checking Node.js installation...
echo ==========================================
echo.

node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ❌ Node.js not found!
    echo  Please install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ❌ npm not found!
    echo  Please install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo  ✅ Node.js found: 
node --version
echo  ✅ npm found: 
npm --version
echo.
echo ==========================================
echo  Starting Mireb Commercial Server...
echo ==========================================
echo.
echo  🌐 Application will be available at:
echo  📱 http://localhost:3000
echo.
echo  💡 To stop the server, press Ctrl+C
echo.

npm start

echo.
echo ==========================================
echo  Server stopped.
echo ==========================================
pause
=======
@echo off
title Mireb Commercial - mirebcommercial@gmail.com
color 0A
echo.
echo  ███╗   ███╗██╗██████╗ ███████╗██████╗ 
echo  ████╗ ████║██║██╔══██╗██╔════╝██╔══██╗
echo  ██╔████╔██║██║██████╔╝█████╗  ██████╔╝
echo  ██║╚██╔╝██║██║██╔══██╗██╔══╝  ██╔══██╗
echo  ██║ ╚═╝ ██║██║██║  ██║███████╗██████╔╝
echo  ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚══════╝╚═════╝ 
echo.
echo  COMMERCIAL E-COMMERCE PLATFORM
echo  Account: mirebcommercial@gmail.com
echo  Author: Fiacre-19
echo.
echo ==========================================
echo  Checking Node.js installation...
echo ==========================================
echo.

node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ❌ Node.js not found!
    echo  Please install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ❌ npm not found!
    echo  Please install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo  ✅ Node.js found: 
node --version
echo  ✅ npm found: 
npm --version
echo.
echo ==========================================
echo  Starting Mireb Commercial Server...
echo ==========================================
echo.
echo  🌐 Application will be available at:
echo  📱 http://localhost:3000
echo.
echo  💡 To stop the server, press Ctrl+C
echo.

npm start

echo.
echo ==========================================
echo  Server stopped.
echo ==========================================
pause
>>>>>>> a7ebd8c2b3beafbb2fa4c8505a08f5b5880fc7a2
