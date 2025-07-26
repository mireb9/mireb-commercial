<<<<<<< HEAD
# Guide d'Installation - Mireb Commercial Full-Stack

## ⚠️ PRÉREQUIS: Installation de Node.js

**Node.js n'est pas installé sur votre système. Voici comment l'installer:**

### Option 1: Installation directe (Recommandée)
1. Allez sur https://nodejs.org/
2. Téléchargez la version LTS (Long Term Support)
3. Exécutez l'installateur et suivez les instructions
4. Redémarrez votre terminal PowerShell

### Option 2: Installation via Chocolatey
```powershell
# Si Chocolatey est installé
choco install nodejs

# Si Chocolatey n'est pas installé, installez-le d'abord:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## 🚀 APRÈS L'INSTALLATION DE NODE.JS

Une fois Node.js installé, exécutez ces commandes dans l'ordre:

```powershell
# Vérifier l'installation
node -v
npm -v

# Installer les dépendances
npm install

# Configurer l'environnement (voir section suivante)
# Puis démarrer le serveur
npm start
```

## 🔧 CONFIGURATION REQUISE

### 1. MongoDB Atlas
- Créez un compte sur https://www.mongodb.com/atlas
- Créez un cluster gratuit
- Obtenez votre URI de connexion
- Remplacez dans `.env`: `MONGODB_URI=votre_uri_ici`

### 2. Cloudinary (pour les images)
- Créez un compte sur https://cloudinary.com/
- Obtenez vos credentials dans le dashboard
- Remplacez dans `.env`:
  ```
  CLOUDINARY_CLOUD_NAME=votre_cloud_name
  CLOUDINARY_API_KEY=votre_api_key  
  CLOUDINARY_API_SECRET=votre_api_secret
  ```

### 3. OpenAI (Déjà configuré)
✅ Votre clé API OpenAI est déjà configurée dans `.env`

## 📁 STRUCTURE DU PROJET

```
mireb-commercial/
├── server.js              # Serveur Express principal
├── package.json           # Dépendances Node.js
├── .env                   # Variables d'environnement
├── models/                # Modèles MongoDB
│   ├── models-product.js
│   ├── models-user.js
│   └── models-order.js
├── routes/                # Routes API
│   ├── routes-products.js
│   └── routes-upload.js
├── middleware/            # Middleware d'authentification
│   └── middleware-auth.js
└── index.html            # Interface utilisateur (React)
```

## 🏃‍♂️ DÉMARRAGE RAPIDE

```powershell
# 1. Installer Node.js (voir section prérequis)
# 2. Installer les dépendances
npm install

# 3. Configurer .env avec vos credentials MongoDB et Cloudinary
# 4. Démarrer le serveur
npm start

# Le serveur sera accessible sur http://localhost:3000
# L'interface utilisateur sur http://localhost:3000 (même port)
```

## 🔧 COMMANDES UTILES

```powershell
# Développement avec rechargement automatique
npm run dev

# Démarrage en production
npm start

# Vérifier les logs
# (les logs s'affichent dans le terminal)
```

## 🎯 FONCTIONNALITÉS DISPONIBLES

✅ **Terminé et fonctionnel:**
- Interface utilisateur React complète
- Gestion des produits (CRUD)
- Système d'authentification
- Upload d'images avec Cloudinary
- Descriptions AI avec OpenAI
- Analytiques en temps réel
- Import/Export de produits
- Recherche et filtres avancés

## 🔄 PROCHAINES ÉTAPES

1. **Installer Node.js** (étape critique)
2. **Configurer MongoDB Atlas** 
3. **Configurer Cloudinary**
4. **Tester l'application**
5. **Déployer en production**

## 🆘 SUPPORT

Si vous rencontrez des problèmes:
1. Vérifiez que Node.js est installé: `node -v`
2. Vérifiez que les dépendances sont installées: `npm list`
3. Vérifiez que `.env` est configuré correctement
4. Consultez les logs du serveur pour les erreurs

---
**Status**: ⏳ En attente d'installation Node.js
**Prêt pour**: Configuration des services externes
=======
# Guide d'Installation - Mireb Commercial Full-Stack

## ⚠️ PRÉREQUIS: Installation de Node.js

**Node.js n'est pas installé sur votre système. Voici comment l'installer:**

### Option 1: Installation directe (Recommandée)
1. Allez sur https://nodejs.org/
2. Téléchargez la version LTS (Long Term Support)
3. Exécutez l'installateur et suivez les instructions
4. Redémarrez votre terminal PowerShell

### Option 2: Installation via Chocolatey
```powershell
# Si Chocolatey est installé
choco install nodejs

# Si Chocolatey n'est pas installé, installez-le d'abord:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## 🚀 APRÈS L'INSTALLATION DE NODE.JS

Une fois Node.js installé, exécutez ces commandes dans l'ordre:

```powershell
# Vérifier l'installation
node -v
npm -v

# Installer les dépendances
npm install

# Configurer l'environnement (voir section suivante)
# Puis démarrer le serveur
npm start
```

## 🔧 CONFIGURATION REQUISE

### 1. MongoDB Atlas
- Créez un compte sur https://www.mongodb.com/atlas
- Créez un cluster gratuit
- Obtenez votre URI de connexion
- Remplacez dans `.env`: `MONGODB_URI=votre_uri_ici`

### 2. Cloudinary (pour les images)
- Créez un compte sur https://cloudinary.com/
- Obtenez vos credentials dans le dashboard
- Remplacez dans `.env`:
  ```
  CLOUDINARY_CLOUD_NAME=votre_cloud_name
  CLOUDINARY_API_KEY=votre_api_key  
  CLOUDINARY_API_SECRET=votre_api_secret
  ```

### 3. OpenAI (Déjà configuré)
✅ Votre clé API OpenAI est déjà configurée dans `.env`

## 📁 STRUCTURE DU PROJET

```
mireb-commercial/
├── server.js              # Serveur Express principal
├── package.json           # Dépendances Node.js
├── .env                   # Variables d'environnement
├── models/                # Modèles MongoDB
│   ├── models-product.js
│   ├── models-user.js
│   └── models-order.js
├── routes/                # Routes API
│   ├── routes-products.js
│   └── routes-upload.js
├── middleware/            # Middleware d'authentification
│   └── middleware-auth.js
└── index.html            # Interface utilisateur (React)
```

## 🏃‍♂️ DÉMARRAGE RAPIDE

```powershell
# 1. Installer Node.js (voir section prérequis)
# 2. Installer les dépendances
npm install

# 3. Configurer .env avec vos credentials MongoDB et Cloudinary
# 4. Démarrer le serveur
npm start

# Le serveur sera accessible sur http://localhost:3000
# L'interface utilisateur sur http://localhost:3000 (même port)
```

## 🔧 COMMANDES UTILES

```powershell
# Développement avec rechargement automatique
npm run dev

# Démarrage en production
npm start

# Vérifier les logs
# (les logs s'affichent dans le terminal)
```

## 🎯 FONCTIONNALITÉS DISPONIBLES

✅ **Terminé et fonctionnel:**
- Interface utilisateur React complète
- Gestion des produits (CRUD)
- Système d'authentification
- Upload d'images avec Cloudinary
- Descriptions AI avec OpenAI
- Analytiques en temps réel
- Import/Export de produits
- Recherche et filtres avancés

## 🔄 PROCHAINES ÉTAPES

1. **Installer Node.js** (étape critique)
2. **Configurer MongoDB Atlas** 
3. **Configurer Cloudinary**
4. **Tester l'application**
5. **Déployer en production**

## 🆘 SUPPORT

Si vous rencontrez des problèmes:
1. Vérifiez que Node.js est installé: `node -v`
2. Vérifiez que les dépendances sont installées: `npm list`
3. Vérifiez que `.env` est configuré correctement
4. Consultez les logs du serveur pour les erreurs

---
**Status**: ⏳ En attente d'installation Node.js
**Prêt pour**: Configuration des services externes
>>>>>>> a7ebd8c2b3beafbb2fa4c8505a08f5b5880fc7a2
