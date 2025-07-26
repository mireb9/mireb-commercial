# Configuration automatique des services - Mireb Commercial
# Compte: mirebcommercial@gmail.com / Fiacre-19

Write-Host "=== CONFIGURATION SERVICES MIREB COMMERCIAL ===" -ForegroundColor Cyan
Write-Host "Compte: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host ""

# Fonction pour configurer MongoDB Atlas
function Configure-MongoDB {
    Write-Host "🗄️  CONFIGURATION MONGODB ATLAS" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Créez votre compte MongoDB Atlas GRATUIT:" -ForegroundColor White
    Write-Host "   📧 Email: mirebcommercial@gmail.com" -ForegroundColor Gray
    Write-Host "   🔑 Mot de passe: [Choisissez un mot de passe sécurisé]" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Créez un cluster gratuit (M0):" -ForegroundColor White
    Write-Host "   🌍 Région recommandée: Europe (Frankfurt)" -ForegroundColor Gray
    Write-Host "   📁 Nom de base: mireb-commercial" -ForegroundColor Gray
    Write-Host ""
    Write-Host "3. Configurez l'accès:" -ForegroundColor White
    Write-Host "   👤 Créez un utilisateur de base de données" -ForegroundColor Gray
    Write-Host "   🌐 Autorisez l'accès depuis n'importe quelle IP (0.0.0.0/0)" -ForegroundColor Gray
    Write-Host ""
    
    $response = Read-Host "Voulez-vous ouvrir MongoDB Atlas? (o/n)"
    if ($response -eq 'o' -or $response -eq 'O') {
        Start-Process "https://www.mongodb.com/atlas"
        Write-Host "✅ MongoDB Atlas ouvert dans votre navigateur" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "Une fois votre cluster créé, copiez l'URI de connexion dans .env" -ForegroundColor Yellow
    $mongoUri = Read-Host "Collez votre URI MongoDB (optionnel, peut être fait plus tard)"
    
    if ($mongoUri -and $mongoUri.Length -gt 10) {
        # Mettre à jour le fichier .env
        $envContent = Get-Content ".env" -Raw
        $envContent = $envContent -replace "MONGODB_URI=mongodb\+srv://mirebcommercial:<password>@cluster0\.xxxxx\.mongodb\.net/mireb-commercial\?retryWrites=true&w=majority", "MONGODB_URI=$mongoUri"
        $envContent | Out-File -FilePath ".env" -Encoding UTF8
        Write-Host "✅ URI MongoDB configuré dans .env" -ForegroundColor Green
    }
}

# Fonction pour configurer Cloudinary
function Configure-Cloudinary {
    Write-Host ""
    Write-Host "🖼️  CONFIGURATION CLOUDINARY" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Créez votre compte Cloudinary GRATUIT:" -ForegroundColor White
    Write-Host "   📧 Email: mirebcommercial@gmail.com" -ForegroundColor Gray
    Write-Host "   🔑 Mot de passe: [Choisissez un mot de passe sécurisé]" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Dans le dashboard Cloudinary:" -ForegroundColor White
    Write-Host "   📁 Cloud Name: mireb-commercial (ou celui généré)" -ForegroundColor Gray
    Write-Host "   🔑 API Key: [Copiez depuis le dashboard]" -ForegroundColor Gray
    Write-Host "   🔐 API Secret: [Copiez depuis le dashboard]" -ForegroundColor Gray
    Write-Host ""
    
    $response = Read-Host "Voulez-vous ouvrir Cloudinary? (o/n)"
    if ($response -eq 'o' -or $response -eq 'O') {
        Start-Process "https://cloudinary.com/"
        Write-Host "✅ Cloudinary ouvert dans votre navigateur" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "Configurez vos credentials Cloudinary:" -ForegroundColor Yellow
    $cloudName = Read-Host "Cloud Name (optionnel)"
    $apiKey = Read-Host "API Key (optionnel)"
    $apiSecret = Read-Host "API Secret (optionnel)"
    
    if ($cloudName -or $apiKey -or $apiSecret) {
        $envContent = Get-Content ".env" -Raw
        
        if ($cloudName) {
            $envContent = $envContent -replace "CLOUDINARY_CLOUD_NAME=mireb-commercial", "CLOUDINARY_CLOUD_NAME=$cloudName"
        }
        if ($apiKey) {
            $envContent = $envContent -replace "CLOUDINARY_API_KEY=your_api_key", "CLOUDINARY_API_KEY=$apiKey"
        }
        if ($apiSecret) {
            $envContent = $envContent -replace "CLOUDINARY_API_SECRET=your_api_secret", "CLOUDINARY_API_SECRET=$apiSecret"
        }
        
        $envContent | Out-File -FilePath ".env" -Encoding UTF8
        Write-Host "✅ Credentials Cloudinary configurés dans .env" -ForegroundColor Green
    }
}

# Fonction pour tester la configuration
function Test-Configuration {
    Write-Host ""
    Write-Host "🧪 TEST DE CONFIGURATION" -ForegroundColor Yellow
    Write-Host ""
    
    $envContent = Get-Content ".env" -Raw
    
    # Vérifier MongoDB
    if ($envContent -match "MONGODB_URI=mongodb\+srv://.*@.*\.mongodb\.net/") {
        Write-Host "✅ MongoDB URI configuré" -ForegroundColor Green
    } else {
        Write-Host "⚠️  MongoDB URI à configurer" -ForegroundColor Yellow
    }
    
    # Vérifier Cloudinary
    $cloudinaryConfigured = $true
    if ($envContent -match "CLOUDINARY_CLOUD_NAME=your_cloud_name" -or $envContent -match "CLOUDINARY_CLOUD_NAME=mireb-commercial") {
        $cloudinaryConfigured = $false
    }
    if ($envContent -match "CLOUDINARY_API_KEY=your_api_key") {
        $cloudinaryConfigured = $false
    }
    if ($envContent -match "CLOUDINARY_API_SECRET=your_api_secret") {
        $cloudinaryConfigured = $false
    }
    
    if ($cloudinaryConfigured) {
        Write-Host "✅ Cloudinary configuré" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Cloudinary à configurer" -ForegroundColor Yellow
    }
    
    # Vérifier OpenAI
    if ($envContent -match "OPENAI_API_KEY=sk-proj-") {
        Write-Host "✅ OpenAI configuré" -ForegroundColor Green
    } else {
        Write-Host "❌ OpenAI non configuré" -ForegroundColor Red
    }
}

# Exécution principale
Configure-MongoDB
Configure-Cloudinary
Test-Configuration

Write-Host ""
Write-Host "=== RÉSUMÉ DE CONFIGURATION ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "📧 Compte principal: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "🔑 Auteur: Fiacre-19" -ForegroundColor Green
Write-Host "🎯 Application: Mireb Commercial E-commerce" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Services à configurer:" -ForegroundColor Yellow
Write-Host "  • MongoDB Atlas (Base de données) - GRATUIT" -ForegroundColor White
Write-Host "  • Cloudinary (Images) - GRATUIT" -ForegroundColor White
Write-Host "  • OpenAI (IA) - DÉJÀ CONFIGURÉ ✅" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Pour démarrer l'application:" -ForegroundColor Yellow
Write-Host "  npm start" -ForegroundColor White
Write-Host ""
Write-Host "📱 Accès application: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""

$response = Read-Host "Voulez-vous démarrer l'application maintenant? (o/n)"
if ($response -eq 'o' -or $response -eq 'O') {
    Write-Host ""
    Write-Host "🚀 Démarrage de Mireb Commercial..." -ForegroundColor Green
    npm start
}
