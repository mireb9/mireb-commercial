<<<<<<< HEAD
# Installation Simple - Mireb Commercial
# Account: mirebcommercial@gmail.com / Fiacre-19

Write-Host "=== MIREB COMMERCIAL INSTALLATION ===" -ForegroundColor Cyan
Write-Host "Account: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "Author: Fiacre-19" -ForegroundColor Green
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "WARNING: Not running as administrator" -ForegroundColor Yellow
    Write-Host "Some operations may require admin privileges" -ForegroundColor Yellow
    Write-Host ""
}

# Check Node.js
Write-Host "Checking Node.js..." -ForegroundColor Green
try {
    $nodeVersion = node --version 2>$null
    $npmVersion = npm --version 2>$null
    if ($nodeVersion -and $npmVersion) {
        Write-Host "✅ Node.js $nodeVersion found" -ForegroundColor Green
        Write-Host "✅ npm $npmVersion found" -ForegroundColor Green
        $nodeInstalled = $true
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "❌ Node.js not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "SOLUTION:" -ForegroundColor Yellow
    Write-Host "1. Download Node.js from: https://nodejs.org/" -ForegroundColor White
    Write-Host "2. Install the LTS version" -ForegroundColor White
    Write-Host "3. Restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    
    $openSite = Read-Host "Open nodejs.org now? (y/n)"
    if ($openSite -eq 'y' -or $openSite -eq 'Y') {
        Start-Process "https://nodejs.org/"
    }
    exit 1
}

# Install dependencies
Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Green
npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dependencies installed successfully" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
    exit 1
}

# Update .env file
Write-Host ""
Write-Host "Configuring environment..." -ForegroundColor Green

$envContent = @"
# MongoDB Atlas Configuration
MONGODB_URI=mongodb+srv://mirebcommercial:YOUR_PASSWORD@cluster0.xxxxx.mongodb.net/mireb-commercial?retryWrites=true&w=majority

# Cloudinary Configuration  
CLOUDINARY_CLOUD_NAME=mireb-commercial
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# OpenAI Configuration (CONFIGURED)
OPENAI_API_KEY=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

# JWT Configuration
JWT_SECRET=mireb_commercial_jwt_secret_fiacre19_2025

# Server Configuration
PORT=3000
NODE_ENV=development
FRONTEND_URL=http://localhost:3001

# App Information
APP_NAME=Mireb Commercial
APP_EMAIL=mirebcommercial@gmail.com
APP_AUTHOR=Fiacre-19
APP_VERSION=1.0.0

# Kinshasa Configuration
DEFAULT_CITY=Kinshasa
DEFAULT_COUNTRY=Congo (DRC)
DEFAULT_TIMEZONE=Africa/Kinshasa
"@

$envContent | Out-File -FilePath ".env" -Encoding UTF8
Write-Host "✅ Environment file created" -ForegroundColor Green

# Success message
Write-Host ""
Write-Host "=== INSTALLATION COMPLETE ===" -ForegroundColor Green
Write-Host ""
Write-Host "📧 Account: mirebcommercial@gmail.com" -ForegroundColor Cyan
Write-Host "🔑 Author: Fiacre-19" -ForegroundColor Cyan
Write-Host "🌍 Location: Kinshasa, Congo (DRC)" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. MONGODB ATLAS (FREE):" -ForegroundColor White
Write-Host "   • Go to: https://www.mongodb.com/atlas" -ForegroundColor Gray
Write-Host "   • Create account with: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Create free cluster" -ForegroundColor Gray
Write-Host "   • Update MONGODB_URI in .env file" -ForegroundColor Gray
Write-Host ""
Write-Host "2. CLOUDINARY (FREE):" -ForegroundColor White
Write-Host "   • Go to: https://cloudinary.com/" -ForegroundColor Gray
Write-Host "   • Create account with: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Copy credentials to .env file" -ForegroundColor Gray
Write-Host ""
Write-Host "3. START APPLICATION:" -ForegroundColor White
Write-Host "   • Run: npm start" -ForegroundColor Gray
Write-Host "   • Or double-click: start-mireb.bat" -ForegroundColor Gray
Write-Host ""
Write-Host "🌐 Application URL: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""

# Offer to open configuration sites
$openConfig = Read-Host "Open MongoDB Atlas and Cloudinary now? (y/n)"
if ($openConfig -eq 'y' -or $openConfig -eq 'Y') {
    Start-Process "https://www.mongodb.com/atlas"
    Start-Sleep 2
    Start-Process "https://cloudinary.com/"
    Write-Host "✅ Configuration sites opened" -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Mireb Commercial is ready!" -ForegroundColor Green
Write-Host "🎉 Happy coding, Fiacre-19!" -ForegroundColor Cyan
=======
# Installation Simple - Mireb Commercial
# Account: mirebcommercial@gmail.com / Fiacre-19

Write-Host "=== MIREB COMMERCIAL INSTALLATION ===" -ForegroundColor Cyan
Write-Host "Account: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "Author: Fiacre-19" -ForegroundColor Green
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "WARNING: Not running as administrator" -ForegroundColor Yellow
    Write-Host "Some operations may require admin privileges" -ForegroundColor Yellow
    Write-Host ""
}

# Check Node.js
Write-Host "Checking Node.js..." -ForegroundColor Green
try {
    $nodeVersion = node --version 2>$null
    $npmVersion = npm --version 2>$null
    if ($nodeVersion -and $npmVersion) {
        Write-Host "✅ Node.js $nodeVersion found" -ForegroundColor Green
        Write-Host "✅ npm $npmVersion found" -ForegroundColor Green
        $nodeInstalled = $true
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "❌ Node.js not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "SOLUTION:" -ForegroundColor Yellow
    Write-Host "1. Download Node.js from: https://nodejs.org/" -ForegroundColor White
    Write-Host "2. Install the LTS version" -ForegroundColor White
    Write-Host "3. Restart PowerShell and run this script again" -ForegroundColor White
    Write-Host ""
    
    $openSite = Read-Host "Open nodejs.org now? (y/n)"
    if ($openSite -eq 'y' -or $openSite -eq 'Y') {
        Start-Process "https://nodejs.org/"
    }
    exit 1
}

# Install dependencies
Write-Host ""
Write-Host "Installing dependencies..." -ForegroundColor Green
npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dependencies installed successfully" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
    exit 1
}

# Update .env file
Write-Host ""
Write-Host "Configuring environment..." -ForegroundColor Green

$envContent = @"
# MongoDB Atlas Configuration
MONGODB_URI=mongodb+srv://mirebcommercial:YOUR_PASSWORD@cluster0.xxxxx.mongodb.net/mireb-commercial?retryWrites=true&w=majority

# Cloudinary Configuration  
CLOUDINARY_CLOUD_NAME=mireb-commercial
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# OpenAI Configuration (CONFIGURED)
OPENAI_API_KEY=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

# JWT Configuration
JWT_SECRET=mireb_commercial_jwt_secret_fiacre19_2025

# Server Configuration
PORT=3000
NODE_ENV=development
FRONTEND_URL=http://localhost:3001

# App Information
APP_NAME=Mireb Commercial
APP_EMAIL=mirebcommercial@gmail.com
APP_AUTHOR=Fiacre-19
APP_VERSION=1.0.0

# Kinshasa Configuration
DEFAULT_CITY=Kinshasa
DEFAULT_COUNTRY=Congo (DRC)
DEFAULT_TIMEZONE=Africa/Kinshasa
"@

$envContent | Out-File -FilePath ".env" -Encoding UTF8
Write-Host "✅ Environment file created" -ForegroundColor Green

# Success message
Write-Host ""
Write-Host "=== INSTALLATION COMPLETE ===" -ForegroundColor Green
Write-Host ""
Write-Host "📧 Account: mirebcommercial@gmail.com" -ForegroundColor Cyan
Write-Host "🔑 Author: Fiacre-19" -ForegroundColor Cyan
Write-Host "🌍 Location: Kinshasa, Congo (DRC)" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. MONGODB ATLAS (FREE):" -ForegroundColor White
Write-Host "   • Go to: https://www.mongodb.com/atlas" -ForegroundColor Gray
Write-Host "   • Create account with: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Create free cluster" -ForegroundColor Gray
Write-Host "   • Update MONGODB_URI in .env file" -ForegroundColor Gray
Write-Host ""
Write-Host "2. CLOUDINARY (FREE):" -ForegroundColor White
Write-Host "   • Go to: https://cloudinary.com/" -ForegroundColor Gray
Write-Host "   • Create account with: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Copy credentials to .env file" -ForegroundColor Gray
Write-Host ""
Write-Host "3. START APPLICATION:" -ForegroundColor White
Write-Host "   • Run: npm start" -ForegroundColor Gray
Write-Host "   • Or double-click: start-mireb.bat" -ForegroundColor Gray
Write-Host ""
Write-Host "🌐 Application URL: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""

# Offer to open configuration sites
$openConfig = Read-Host "Open MongoDB Atlas and Cloudinary now? (y/n)"
if ($openConfig -eq 'y' -or $openConfig -eq 'Y') {
    Start-Process "https://www.mongodb.com/atlas"
    Start-Sleep 2
    Start-Process "https://cloudinary.com/"
    Write-Host "✅ Configuration sites opened" -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Mireb Commercial is ready!" -ForegroundColor Green
Write-Host "🎉 Happy coding, Fiacre-19!" -ForegroundColor Cyan
>>>>>>> a7ebd8c2b3beafbb2fa4c8505a08f5b5880fc7a2
