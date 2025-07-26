# 🚀 Mireb Commercial - E-commerce Full Stack

Application e-commerce complète avec React + Node.js + MongoDB + IA

## 📋 Architecture

```
Frontend (React + Vite + Tailwind)
    ↓ API REST
Backend (Node.js + Express + MongoDB)
    ↓ Cloud Storage
Cloudinary (Images optimisées)
    ↓ AI Services  
OpenAI (Descriptions produits)
```

## 🛠️ Technologies

### Frontend
- ⚛️ **React 18** + Vite
- 🎨 **Tailwind CSS** + Headless UI
- 🔄 **React Query** pour API calls
- 🗂️ **Zustand** pour state management
- 🌐 **Socket.io** pour temps réel
- 📱 **Responsive design** mobile-first

### Backend
- 🚀 **Node.js** + Express
- 🍃 **MongoDB** + Mongoose
- 🔐 **JWT** + bcrypt pour auth
- ☁️ **Cloudinary** pour images
- 🤖 **OpenAI** pour IA
- 📊 **Socket.io** pour temps réel
- 🛡️ **Helmet** + Rate limiting

## 🚀 Installation

### 1. Backend
```bash
# Installer les dépendances
npm install express mongoose cors dotenv bcryptjs jsonwebtoken multer cloudinary firebase-admin axios helmet express-rate-limit express-validator morgan compression @sentry/node socket.io

# Créer .env depuis .env.example
cp .env.example .env

# Configurer les variables d'environnement
nano .env

# Démarrer le serveur
npm run dev
```

### 2. Frontend
```bash
# Installer les dépendances
npm install react react-dom react-router-dom axios socket.io-client @headlessui/react @heroicons/react framer-motion react-hot-toast react-hook-form react-query zustand clsx date-fns

# Démarrer le frontend
npm run dev
```

## 🔧 Configuration

### MongoDB Atlas
1. Créer un cluster sur [MongoDB Atlas](https://mongodb.com/atlas)
2. Obtenir la connection string
3. Ajouter dans `.env`: `MONGODB_URI=mongodb+srv://...`

### Cloudinary
1. Créer un compte sur [Cloudinary](https://cloudinary.com)
2. Obtenir les credentials
3. Ajouter dans `.env`:
   ```
   CLOUDINARY_CLOUD_NAME=your-cloud-name
   CLOUDINARY_API_KEY=your-api-key  
   CLOUDINARY_API_SECRET=your-api-secret
   ```

### OpenAI (Déjà configuré)
```
OPENAI_API_KEY=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
```

## 📊 Fonctionnalités

### ✅ E-commerce complet
- 🛒 Catalogue produits avec filtres
- 🛍️ Panier d'achats persistant
- 📦 Système de commandes
- 💳 Intégration paiements (Stripe/PayPal)

### ✅ Admin avancé
- 👨‍💼 Interface admin complète
- 📈 Dashboard analytics en temps réel
- 🎨 Upload d'images avec panorama automatique
- 🤖 Génération descriptions IA
- 📊 CRM intégré avec leads

### ✅ Images optimisées
- ☁️ **Stockage Cloudinary** (partagé entre utilisateurs)
- 🖼️ **Panorama automatique** (image principale + miniatures)
- ⚡ **Optimisation automatique** (WebP, compression)
- 📱 **Responsive images** selon l'écran

### ✅ IA intégrée
- 🤖 **OpenAI GPT-3.5** pour descriptions personnalisées
- 📝 **Génération automatique** selon le nom du produit
- 🎯 **Prompts optimisés** pour e-commerce

### ✅ Analytics & Monitoring
- 📍 **Géolocalisation réelle** des visiteurs
- 📊 **Statistiques temps réel** avec Socket.io
- 🎯 **Tracking complet** (pages, durée, conversions)
- 🔍 **Monitoring** avec Sentry

## 🔄 API Endpoints

### Produits
```
GET    /api/products          # Liste avec filtres
GET    /api/products/:id      # Détail produit
POST   /api/products          # Créer (Admin)
PUT    /api/products/:id      # Modifier (Admin)
DELETE /api/products/:id      # Supprimer (Admin)
POST   /api/products/import   # Import URL/JSON
POST   /api/products/:id/generate-description # IA
```

### Upload
```
POST   /api/upload/single     # Upload 1 image
POST   /api/upload/multiple   # Upload multiple + panorama
DELETE /api/upload/:publicId  # Supprimer image
POST   /api/upload/optimize/:id # Optimiser image
```

### Auth & Users
```
POST   /api/auth/register     # Inscription
POST   /api/auth/login        # Connexion
GET    /api/auth/profile      # Profil utilisateur
PUT    /api/auth/profile      # Modifier profil
```

## 🚀 Déploiement

### Backend (Railway/Heroku)
```bash
# Build pour production
npm run build

# Variables d'environnement requises
NODE_ENV=production
MONGODB_URI=mongodb+srv://...
JWT_SECRET=your-secret
OPENAI_API_KEY=sk-proj-...
CLOUDINARY_CLOUD_NAME=...
```

### Frontend (Vercel/Netlify)
```bash
# Build pour production
npm run build

# Configuration Vercel
{
  "version": 2,
  "builds": [{ "src": "package.json", "use": "@vercel/static-build" }],
  "routes": [{ "src": "/(.*)", "dest": "/index.html" }]
}
```

## 🎯 Avantages vs Version Statique

| Fonctionnalité | Statique | Full Stack |
|----------------|----------|------------|
| **Images partagées** | ❌ localStorage | ✅ Cloudinary |
| **Données persistantes** | ❌ Local | ✅ MongoDB |
| **Multi-utilisateurs** | ❌ | ✅ |
| **Authentification** | ❌ | ✅ Firebase/JWT |
| **API temps réel** | ❌ | ✅ Socket.io |
| **Monitoring** | ❌ | ✅ Sentry |
| **Panorama auto** | ❌ | ✅ |
| **Optimisation images** | ❌ | ✅ |

## 🔒 Sécurité

- 🛡️ **Helmet** pour headers sécurisés
- 🚦 **Rate limiting** anti-spam
- 🔐 **JWT** tokens sécurisés
- ✅ **Validation** des données
- 🔒 **CORS** configuré
- 🧹 **Sanitization** des inputs

## 📈 Performance

- ⚡ **CDN** Cloudinary mondial
- 🗜️ **Compression** automatique
- 📦 **Bundle splitting** Vite
- 💾 **Cache** intelligent
- 🖼️ **Lazy loading** images
- 📱 **PWA ready**

## 🤝 Support

- 📧 Email: support@mireb-commercial.com
- 📱 WhatsApp: +243 XXX XXX XXX
- 🌐 Site: https://mireb-commercial.com

---

**🎉 Votre e-commerce moderne est prêt !**
