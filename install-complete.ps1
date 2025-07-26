# Script d'installation automatique complète - Mireb Commercial
# Exécution: powershell -ExecutionPolicy Bypass -File install-complete.ps1

param(
    [switch]$Force
)

Write-Host "=== INSTALLATION AUTOMATIQUE MIREB COMMERCIAL ===" -ForegroundColor Cyan
Write-Host "Compte: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host ""

# Fonction pour vérifier les privilèges administrateur
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Fonction pour installer Chocolatey
function Install-Chocolatey {
    Write-Host "Installation de Chocolatey (gestionnaire de paquets)..." -ForegroundColor Yellow
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Recharger l'environnement
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        Write-Host "✅ Chocolatey installé avec succès" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ Erreur lors de l'installation de Chocolatey: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Fonction pour installer Node.js
function Install-NodeJS {
    Write-Host "Installation de Node.js..." -ForegroundColor Yellow
    try {
        # Essayer avec Chocolatey d'abord
        if (Get-Command choco -ErrorAction SilentlyContinue) {
            choco install nodejs -y
        } else {
            # Installer Chocolatey puis Node.js
            if (Install-Chocolatey) {
                refreshenv
                choco install nodejs -y
            } else {
                throw "Impossible d'installer Chocolatey"
            }
        }
        
        # Recharger l'environnement
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        
        # Vérifier l'installation
        $nodeVersion = & node --version 2>$null
        $npmVersion = & npm --version 2>$null
        
        if ($nodeVersion -and $npmVersion) {
            Write-Host "✅ Node.js $nodeVersion installé avec succès" -ForegroundColor Green
            Write-Host "✅ npm $npmVersion disponible" -ForegroundColor Green
            return $true
        } else {
            throw "Node.js n'est pas accessible après installation"
        }
    } catch {
        Write-Host "❌ Erreur lors de l'installation de Node.js: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "💡 Solution alternative: Téléchargez Node.js depuis https://nodejs.org/" -ForegroundColor Yellow
        return $false
    }
}

# Vérifier si Node.js est déjà installé
Write-Host "Vérification de Node.js..." -ForegroundColor Green
$nodeInstalled = $false
try {
    $nodeVersion = & node --version 2>$null
    $npmVersion = & npm --version 2>$null
    if ($nodeVersion -and $npmVersion) {
        Write-Host "✅ Node.js $nodeVersion déjà installé" -ForegroundColor Green
        Write-Host "✅ npm $npmVersion disponible" -ForegroundColor Green
        $nodeInstalled = $true
    }
} catch {
    Write-Host "❌ Node.js non trouvé" -ForegroundColor Red
}

# Installer Node.js si nécessaire
if (-not $nodeInstalled) {
    if (-not (Test-Admin)) {
        Write-Host "⚠️  Privilèges administrateur requis pour installer Node.js" -ForegroundColor Yellow
        Write-Host "Relancez PowerShell en tant qu'administrateur ou installez Node.js manuellement depuis https://nodejs.org/" -ForegroundColor Yellow
        
        # Proposer d'ouvrir le site
        $response = Read-Host "Voulez-vous ouvrir nodejs.org dans votre navigateur? (o/n)"
        if ($response -eq 'o' -or $response -eq 'O') {
            Start-Process "https://nodejs.org/"
        }
        exit 1
    }
    
    if (-not (Install-NodeJS)) {
        Write-Host "❌ Installation automatique échouée. Installez Node.js manuellement depuis https://nodejs.org/" -ForegroundColor Red
        Start-Process "https://nodejs.org/"
        exit 1
    }
}

# Configurer le projet
Write-Host ""
Write-Host "=== CONFIGURATION DU PROJET ===" -ForegroundColor Cyan

# Mettre à jour package.json pour le backend
Write-Host "Configuration du package.json backend..." -ForegroundColor Green
$backendPackage = @{
    name = "mireb-commercial"
    version = "1.0.0"
    description = "E-commerce platform with AI descriptions and real-time analytics - mirebcommercial@gmail.com"
    main = "server.js"
    scripts = @{
        start = "node server.js"
        dev = "nodemon server.js"
        test = "echo `"Error: no test specified`" && exit 1"
    }
    keywords = @("ecommerce", "nodejs", "express", "mongodb", "ai", "mireb")
    author = "Mireb Commercial <mirebcommercial@gmail.com>"
    license = "MIT"
    dependencies = @{
        express = "^4.18.2"
        mongoose = "^8.0.3"
        cors = "^2.8.5"
        dotenv = "^16.3.1"
        bcryptjs = "^2.4.3"
        jsonwebtoken = "^9.0.2"
        multer = "^1.4.5-lts.1"
        cloudinary = "^1.41.3"
        "socket.io" = "^4.7.4"
        axios = "^1.6.2"
        helmet = "^7.1.0"
        "express-rate-limit" = "^7.1.5"
        compression = "^1.7.4"
        morgan = "^1.10.0"
    }
    devDependencies = @{
        nodemon = "^3.0.2"
    }
    engines = @{
        node = ">=16.0.0"
    }
    repository = @{
        type = "git"
        url = "https://github.com/mirebcommercial/mireb-commercial.git"
    }
    bugs = @{
        url = "https://github.com/mirebcommercial/mireb-commercial/issues"
    }
    homepage = "https://mireb-commercial.netlify.app"
}

$backendPackage | ConvertTo-Json -Depth 10 | Out-File -FilePath "package.json" -Encoding UTF8

# Installation des dépendances
Write-Host "Installation des dépendances npm..." -ForegroundColor Green
try {
    npm install
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Dépendances installées avec succès" -ForegroundColor Green
    } else {
        throw "npm install a échoué"
    }
} catch {
    Write-Host "❌ Erreur lors de l'installation des dépendances: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Essayez manuellement: npm install" -ForegroundColor Yellow
}

# Configuration automatique des services
Write-Host ""
Write-Host "=== CONFIGURATION DES SERVICES ===" -ForegroundColor Cyan

# Mettre à jour le fichier .env avec des configurations plus spécifiques
$envContent = @"
# Configuration MongoDB Atlas (À CONFIGURER)
MONGODB_URI=mongodb+srv://mirebcommercial:<password>@cluster0.xxxxx.mongodb.net/mireb-commercial?retryWrites=true&w=majority

# Configuration Cloudinary (À CONFIGURER)
CLOUDINARY_CLOUD_NAME=mireb-commercial
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# Configuration OpenAI (CONFIGURÉ)
OPENAI_API_KEY=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

# Configuration JWT
JWT_SECRET=mireb_commercial_super_secret_jwt_key_2025_fiacre19

# Configuration du serveur
PORT=3000
NODE_ENV=development

# Configuration CORS
FRONTEND_URL=http://localhost:3001

# Configuration de l'application
APP_NAME=Mireb Commercial
APP_EMAIL=mirebcommercial@gmail.com
APP_VERSION=1.0.0
APP_AUTHOR=Fiacre-19

# Configuration géolocalisation (Kinshasa)
DEFAULT_CITY=Kinshasa
DEFAULT_COUNTRY=Congo (DRC)
DEFAULT_TIMEZONE=Africa/Kinshasa
"@

$envContent | Out-File -FilePath ".env" -Encoding UTF8
Write-Host "✅ Fichier .env configuré" -ForegroundColor Green

# Créer un script de démarrage rapide
$startScript = @"
@echo off
echo === Démarrage Mireb Commercial ===
echo Compte: mirebcommercial@gmail.com
echo.
echo Vérification de Node.js...
node --version
npm --version
echo.
echo Démarrage du serveur...
npm start
pause
"@

$startScript | Out-File -FilePath "start-mireb.bat" -Encoding ASCII
Write-Host "✅ Script de démarrage créé: start-mireb.bat" -ForegroundColor Green

# Afficher les instructions finales
Write-Host ""
Write-Host "=== INSTALLATION TERMINÉE ===" -ForegroundColor Green
Write-Host ""
Write-Host "📧 Compte configuré: mirebcommercial@gmail.com" -ForegroundColor Cyan
Write-Host "🔑 Auteur: Fiacre-19" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 PROCHAINES ÉTAPES:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 🗄️  MONGODB ATLAS (GRATUIT):" -ForegroundColor White
Write-Host "   • Allez sur: https://www.mongodb.com/atlas" -ForegroundColor Gray
Write-Host "   • Créez un compte avec: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Créez un cluster gratuit" -ForegroundColor Gray
Write-Host "   • Remplacez <password> dans .env par votre mot de passe" -ForegroundColor Gray
Write-Host ""
Write-Host "2. 🖼️  CLOUDINARY (GRATUIT):" -ForegroundColor White
Write-Host "   • Allez sur: https://cloudinary.com/" -ForegroundColor Gray
Write-Host "   • Créez un compte avec: mirebcommercial@gmail.com" -ForegroundColor Gray
Write-Host "   • Copiez vos credentials dans .env" -ForegroundColor Gray
Write-Host ""
Write-Host "3. 🚀 DÉMARRER L'APPLICATION:" -ForegroundColor White
Write-Host "   • Double-cliquez sur: start-mireb.bat" -ForegroundColor Gray
Write-Host "   • Ou tapez: npm start" -ForegroundColor Gray
Write-Host ""
Write-Host "📱 Application accessible sur: http://localhost:3000" -ForegroundColor Cyan
Write-Host "📚 Documentation: README-FULLSTACK.md" -ForegroundColor Cyan
Write-Host ""

# Proposer d'ouvrir les sites de configuration
$response = Read-Host "Voulez-vous ouvrir MongoDB Atlas et Cloudinary maintenant? (o/n)"
if ($response -eq 'o' -or $response -eq 'O') {
    Start-Process "https://www.mongodb.com/atlas"
    Start-Sleep 2
    Start-Process "https://cloudinary.com/"
}

Write-Host ""
Write-Host "✅ Installation automatique terminée!" -ForegroundColor Green
Write-Host "🎉 Votre application Mireb Commercial est prête!" -ForegroundColor Cyan
