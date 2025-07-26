# Test Node.js - Mireb Commercial
# Account: mirebcommercial@gmail.com / Fiacre-19

Write-Host "=== TEST NODE.JS - MIREB COMMERCIAL ===" -ForegroundColor Cyan
Write-Host "Account: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "Author: Fiacre-19" -ForegroundColor Green
Write-Host ""

# Test 1: Vérifier Node.js
Write-Host "1. Testing Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✅ Node.js found: $nodeVersion" -ForegroundColor Green
        $nodeOK = $true
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "❌ Node.js not installed" -ForegroundColor Red
    Write-Host "Download from: https://nodejs.org/" -ForegroundColor Yellow
    $nodeOK = $false
}

# Test 2: Vérifier npm
Write-Host "2. Testing npm..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Host "✅ npm found: $npmVersion" -ForegroundColor Green
        $npmOK = $true
    } else {
        throw "npm not found"
    }
} catch {
    Write-Host "❌ npm not found" -ForegroundColor Red
    $npmOK = $false
}

# Test 3: Test serveur simple si Node.js fonctionne
if ($nodeOK -and $npmOK) {
    Write-Host ""
    Write-Host "3. Testing simple server..." -ForegroundColor Yellow
    
    # Créer un test rapide
    Write-Host "Starting test server..." -ForegroundColor Gray
    
    $testChoice = Read-Host "Start test server? (y/n)"
    if ($testChoice -eq 'y' -or $testChoice -eq 'Y') {
        Write-Host ""
        Write-Host "🚀 Starting Mireb Commercial Test Server..." -ForegroundColor Green
        Write-Host "📱 URL: http://127.0.0.1:3000" -ForegroundColor Cyan
        Write-Host "🔧 API Test: http://127.0.0.1:3000/api/test" -ForegroundColor Cyan
        Write-Host "💡 Press Ctrl+C to stop" -ForegroundColor Yellow
        Write-Host ""
        
        # Démarrer le serveur de test
        node test-server.mjs
    }
} else {
    Write-Host ""
    Write-Host "❌ Cannot test server - Node.js/npm not available" -ForegroundColor Red
    Write-Host ""
    Write-Host "SOLUTION:" -ForegroundColor Yellow
    Write-Host "1. Install Node.js from https://nodejs.org/" -ForegroundColor White
    Write-Host "2. Restart PowerShell" -ForegroundColor White
    Write-Host "3. Run this test again" -ForegroundColor White
    
    $openSite = Read-Host "Open Node.js download page? (y/n)"
    if ($openSite -eq 'y' -or $openSite -eq 'Y') {
        Start-Process "https://nodejs.org/"
    }
}

Write-Host ""
Write-Host "=== TEST SUMMARY ===" -ForegroundColor Cyan
if ($nodeOK -and $npmOK) {
    Write-Host "✅ Ready for Mireb Commercial installation!" -ForegroundColor Green
    Write-Host "Next step: powershell -ExecutionPolicy Bypass -File install-simple.ps1" -ForegroundColor Yellow
} else {
    Write-Host "⚠️  Install Node.js first, then retry" -ForegroundColor Yellow
}
