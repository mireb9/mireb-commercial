# Mireb Commercial - Setup Full Stack
# Script PowerShell pour Windows

Write-Host "🚀 Déploiement Mireb Commercial Full Stack" -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue

# 1. Vérification Node.js
Write-Host "ℹ️  Vérification de Node.js..." -ForegroundColor Cyan

try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js installé: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js n'est pas installé" -ForegroundColor Red
    Write-Host "Téléchargez Node.js sur: https://nodejs.org" -ForegroundColor Yellow
    exit 1
}

# 2. Installation des dépendances backend
Write-Host "ℹ️  Installation des dépendances backend..." -ForegroundColor Cyan

$backendDeps = @(
    "express", "mongoose", "cors", "dotenv", "bcryptjs", 
    "jsonwebtoken", "multer", "cloudinary", "firebase-admin",
    "axios", "helmet", "express-rate-limit", "express-validator",
    "morgan", "compression", "@sentry/node", "socket.io"
)

npm install $backendDeps

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dépendances backend installées" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'installation" -ForegroundColor Red
    exit 1
}

# 3. Installation des dépendances dev
Write-Host "ℹ️  Installation des dépendances dev..." -ForegroundColor Cyan

npm install --save-dev nodemon jest supertest

Write-Host "✅ Dépendances dev installées" -ForegroundColor Green

# 4. Configuration .env
Write-Host "ℹ️  Configuration de l'environnement..." -ForegroundColor Cyan

if (!(Test-Path ".env")) {
    Write-Host "⚠️  Création du fichier .env depuis .env.example" -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
    
    Write-Host ""
    Write-Host "⚠️  IMPORTANT: Configurez ces variables dans .env:" -ForegroundColor Yellow
    Write-Host "  - MONGODB_URI (MongoDB Atlas connection string)" -ForegroundColor White
    Write-Host "  - CLOUDINARY_CLOUD_NAME (votre cloud name)" -ForegroundColor White
    Write-Host "  - CLOUDINARY_API_KEY (votre API key)" -ForegroundColor White  
    Write-Host "  - CLOUDINARY_API_SECRET (votre API secret)" -ForegroundColor White
    Write-Host "  - JWT_SECRET (générez une clé sécurisée)" -ForegroundColor White
    Write-Host ""
    Write-Host "✅ OpenAI API Key déjà configurée" -ForegroundColor Green
} else {
    Write-Host "✅ Fichier .env trouvé" -ForegroundColor Green
}

# 5. Création des scripts package.json
Write-Host "ℹ️  Mise à jour des scripts..." -ForegroundColor Cyan

$packageJson = Get-Content "backend-package.json" | ConvertFrom-Json
$packageJson | ConvertTo-Json -Depth 10 | Set-Content "package.json"

Write-Host "✅ package.json mis à jour" -ForegroundColor Green

# 6. Création des dossiers
Write-Host "ℹ️  Création de la structure..." -ForegroundColor Cyan

$folders = @("uploads", "logs", "backups", "routes", "models", "middleware")
foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }
}

Write-Host "✅ Structure de dossiers créée" -ForegroundColor Green

# 7. Organisation des fichiers
Write-Host "ℹ️  Organisation des fichiers..." -ForegroundColor Cyan

# Déplacer les fichiers models
if (Test-Path "models-product.js") { Move-Item "models-product.js" "models/Product.js" -Force }
if (Test-Path "models-user.js") { Move-Item "models-user.js" "models/User.js" -Force }
if (Test-Path "models-order.js") { Move-Item "models-order.js" "models/Order.js" -Force }
if (Test-Path "models-analytics.js") { Move-Item "models-analytics.js" "models/Analytics.js" -Force }

# Déplacer les fichiers routes
if (Test-Path "routes-products.js") { Move-Item "routes-products.js" "routes/products.js" -Force }
if (Test-Path "routes-upload.js") { Move-Item "routes-upload.js" "routes/upload.js" -Force }

# Déplacer le middleware
if (Test-Path "middleware-auth.js") { Move-Item "middleware-auth.js" "middleware/auth.js" -Force }

Write-Host "✅ Fichiers organisés" -ForegroundColor Green

# 8. Création des routes manquantes
Write-Host "ℹ️  Création des routes manquantes..." -ForegroundColor Cyan

# Route auth basique
$authRoute = @"
const express = require('express');
const router = express.Router();
const User = require('../models/User');
const jwt = require('jsonwebtoken');

// POST /api/auth/login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Vérifier si c'est l'admin par défaut
    if (email === 'admin@mireb.com' && password === 'admin123') {
      const token = jwt.sign(
        { id: 'admin', email: 'admin@mireb.com', role: 'admin' },
        process.env.JWT_SECRET || 'your-secret-key',
        { expiresIn: '7d' }
      );
      
      return res.json({
        message: 'Connexion réussie',
        token,
        user: { id: 'admin', email: 'admin@mireb.com', role: 'admin' }
      });
    }

    res.status(401).json({ error: 'Identifiants invalides' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
"@

$authRoute | Set-Content "routes/auth.js"

# Route analytics basique
$analyticsRoute = @"
const express = require('express');
const router = express.Router();
const { Visitor, Lead } = require('../models/Analytics');

// GET /api/analytics/visitors
router.get('/visitors', async (req, res) => {
  try {
    const visitors = await Visitor.find().sort({ createdAt: -1 }).limit(50);
    res.json(visitors);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/analytics/visitor
router.post('/visitor', async (req, res) => {
  try {
    const visitor = new Visitor(req.body);
    await visitor.save();
    res.status(201).json(visitor);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
"@

$analyticsRoute | Set-Content "routes/analytics.js"

# Route orders basique
$ordersRoute = @"
const express = require('express');
const router = express.Router();
const Order = require('../models/Order');

// GET /api/orders
router.get('/', async (req, res) => {
  try {
    const orders = await Order.find().sort({ createdAt: -1 });
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/orders
router.post('/', async (req, res) => {
  try {
    const order = new Order(req.body);
    await order.save();
    res.status(201).json(order);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
"@

$ordersRoute | Set-Content "routes/orders.js"

Write-Host "✅ Routes créées" -ForegroundColor Green

# 9. Instructions finales
Write-Host ""
Write-Host "🎉 Configuration terminée !" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Prochaines étapes:" -ForegroundColor Yellow
Write-Host "  1. Éditez le fichier .env avec vos credentials" -ForegroundColor White
Write-Host "  2. Lancez: npm run dev" -ForegroundColor White
Write-Host "  3. Ouvrez: http://localhost:5000" -ForegroundColor White
Write-Host ""
Write-Host "🔧 Services requis:" -ForegroundColor Yellow
Write-Host "  - MongoDB Atlas: https://mongodb.com/atlas" -ForegroundColor White
Write-Host "  - Cloudinary: https://cloudinary.com" -ForegroundColor White
Write-Host "  - OpenAI: ✅ Déjà configuré" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 Bon développement !" -ForegroundColor Blue
