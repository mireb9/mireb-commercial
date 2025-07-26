# Script d'installation simple pour Mireb Commercial
# Exécution: powershell -ExecutionPolicy Bypass -File setup-simple.ps1

Write-Host "=== Installation de Mireb Commercial ===" -ForegroundColor Cyan

# Vérifier si Node.js est installé
Write-Host "Vérification de Node.js..." -ForegroundColor Green
try {
    $nodeVersion = node --version
    Write-Host "Node.js trouvé: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "ERREUR: Node.js n'est pas installé. Veuillez l'installer depuis https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Installation des dépendances
Write-Host "Installation des dépendances npm..." -ForegroundColor Green
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERREUR: L'installation des dépendances a échoué" -ForegroundColor Red
    exit 1
}

# Configuration de l'environnement
Write-Host "Configuration de l'environnement..." -ForegroundColor Green

# Créer le fichier .env s'il n'existe pas
if (-not (Test-Path ".env")) {
    $envContent = @"
# Configuration MongoDB Atlas
MONGODB_URI=mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/mireb-commercial?retryWrites=true&w=majority

# Configuration Cloudinary
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# Configuration OpenAI
OPENAI_API_KEY=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

# Configuration JWT
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production

# Configuration du serveur
PORT=3000
NODE_ENV=development

# Configuration CORS
FRONTEND_URL=http://localhost:3001
"@
    
    $envContent | Out-File -FilePath ".env" -Encoding UTF8
    Write-Host "Fichier .env créé" -ForegroundColor Green
} else {
    Write-Host "Fichier .env existe déjà" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Installation terminée! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Étapes suivantes:" -ForegroundColor Yellow
Write-Host "1. Configurez MongoDB Atlas dans le fichier .env" -ForegroundColor White
Write-Host "2. Configurez Cloudinary dans le fichier .env" -ForegroundColor White
Write-Host "3. Démarrez le serveur avec: npm start" -ForegroundColor White
Write-Host ""
Write-Host "Documentation complète dans README-FULLSTACK.md" -ForegroundColor Cyan
