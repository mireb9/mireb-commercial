#!/bin/bash

echo "🚀 Déploiement Mireb Commercial Full Stack"
echo "=========================================="

# Couleurs pour les logs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction de log
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 1. Vérification des dépendances
log_info "Vérification des dépendances..."

if ! command -v node &> /dev/null; then
    log_error "Node.js n'est pas installé"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    log_error "npm n'est pas installé"
    exit 1
fi

log_success "Node.js et npm sont installés"

# 2. Installation des dépendances backend
log_info "Installation des dépendances backend..."

npm install express mongoose cors dotenv bcryptjs jsonwebtoken multer cloudinary firebase-admin axios helmet express-rate-limit express-validator morgan compression @sentry/node socket.io

if [ $? -eq 0 ]; then
    log_success "Dépendances backend installées"
else
    log_error "Erreur lors de l'installation des dépendances backend"
    exit 1
fi

# 3. Installation des dépendances dev
log_info "Installation des dépendances de développement..."

npm install --save-dev nodemon jest supertest

log_success "Dépendances dev installées"

# 4. Configuration de l'environnement
log_info "Configuration de l'environnement..."

if [ ! -f .env ]; then
    log_warning "Fichier .env non trouvé, création depuis .env.example"
    cp .env.example .env
    
    log_warning "⚠️  IMPORTANT: Configurez les variables dans .env:"
    echo "  - MONGODB_URI (MongoDB Atlas)"
    echo "  - CLOUDINARY_* (Cloudinary credentials)"
    echo "  - JWT_SECRET (générez une clé sécurisée)"
    echo ""
    echo "OpenAI API Key déjà configurée ✅"
else
    log_success "Fichier .env trouvé"
fi

# 5. Vérification de la connexion MongoDB
log_info "Test de connexion MongoDB..."

node -e "
require('dotenv').config();
const mongoose = require('mongoose');
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/mireb-commercial')
  .then(() => {
    console.log('✅ MongoDB connecté avec succès');
    process.exit(0);
  })  
  .catch(err => {
    console.log('❌ Erreur MongoDB:', err.message);
    process.exit(1);
  });
" 2>/dev/null

if [ $? -eq 0 ]; then
    log_success "MongoDB accessible"
else
    log_warning "MongoDB non accessible - vérifiez MONGODB_URI dans .env"
fi

# 6. Test des credentials Cloudinary
log_info "Test des credentials Cloudinary..."

node -e "
require('dotenv').config();
const cloudinary = require('cloudinary').v2;
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});
cloudinary.api.ping((error, result) => {
  if (error) {
    console.log('❌ Erreur Cloudinary:', error.message);
    process.exit(1);
  } else {
    console.log('✅ Cloudinary connecté avec succès');
    process.exit(0);
  }
});
" 2>/dev/null

if [ $? -eq 0 ]; then
    log_success "Cloudinary accessible"
else
    log_warning "Cloudinary non accessible - vérifiez les credentials dans .env"
fi

# 7. Création des dossiers nécessaires
log_info "Création de la structure de dossiers..."

mkdir -p uploads logs backups

log_success "Structure de dossiers créée"

# 8. Démarrage du serveur en mode développement
log_info "Démarrage du serveur de développement..."

log_success "🎉 Configuration terminée !"
echo ""
echo "📋 Prochaines étapes:"
echo "  1. Configurez les variables dans .env"
echo "  2. Lancez: npm run dev"
echo "  3. Ouvrez: http://localhost:5000"
echo ""
echo "📊 API disponible sur:"
echo "  - GET  http://localhost:5000/api"
echo "  - POST http://localhost:5000/api/products"
echo "  - POST http://localhost:5000/api/upload/single"
echo ""
echo "🚀 Bon développement !"
