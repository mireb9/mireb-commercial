# ✅ Checklist Déploiement Complet - Mireb Commercial

## 📧 Account: mirebcommercial@gmail.com - Fiacre-19

---

## 🎯 PHASE 1: SERVICES GRATUITS (10 minutes)

### ☐ 1. MongoDB Atlas (Base de données)
- [ ] Aller sur: https://www.mongodb.com/atlas
- [ ] Créer compte avec: mirebcommercial@gmail.com
- [ ] Créer cluster gratuit M0 (512MB)
- [ ] Nom cluster: `mireb-commercial`
- [ ] Région: Frankfurt (Europe)
- [ ] Utilisateur DB: `mirebcommercial` / Password: `Fiacre2025!`
- [ ] Network Access: 0.0.0.0/0 (Allow all IPs)
- [ ] Copier Connection String dans .env

### ☐ 2. Cloudinary (Images)
- [ ] Aller sur: https://cloudinary.com/
- [ ] Créer compte avec: mirebcommercial@gmail.com
- [ ] Plan gratuit (25GB)
- [ ] Cloud Name: `mireb-commercial`
- [ ] Copier API Key et API Secret dans .env

---

## 🎯 PHASE 2: PRÉPARATION CODE (5 minutes)

### ☐ 3. Configuration locale
- [ ] Fichier .env mis à jour ✅
- [ ] Dépendances installées: `npm install`
- [ ] Test local: `node server.js`
- [ ] Vérifier que l'API fonctionne sur http://localhost:3000

---

## 🎯 PHASE 3: DÉPLOIEMENT BACKEND (10 minutes)

### ☐ 4. Railway (Serveur)
- [ ] Aller sur: https://railway.app/
- [ ] Créer compte (GitHub ou mirebcommercial@gmail.com)
- [ ] New Project → Deploy from GitHub ou Upload
- [ ] Nom projet: `mireb-commercial-backend`
- [ ] Ajouter variables d'environnement:
  - [ ] MONGODB_URI
  - [ ] CLOUDINARY_CLOUD_NAME
  - [ ] CLOUDINARY_API_KEY  
  - [ ] CLOUDINARY_API_SECRET
  - [ ] OPENAI_API_KEY
  - [ ] JWT_SECRET
  - [ ] NODE_ENV=production
- [ ] Vérifier déploiement: https://[projet].railway.app/api/health

---

## 🎯 PHASE 4: DÉPLOIEMENT FRONTEND (5 minutes)

### ☐ 5. Modification index.html
- [ ] Remplacer `http://localhost:3000/api` par `https://[projet].railway.app/api`
- [ ] Tester en local avec la nouvelle URL

### ☐ 6. Netlify (Interface)
- [ ] Aller sur: https://netlify.com/
- [ ] Créer compte avec: mirebcommercial@gmail.com
- [ ] Sites → Drag & Drop fichier index.html modifié
- [ ] Site name: `mireb-commercial`
- [ ] Vérifier: https://mireb-commercial.netlify.app

---

## 🎯 PHASE 5: TESTS FINAUX (5 minutes)

### ☐ 7. Vérifications
- [ ] Backend API: https://[projet].railway.app/api/health
- [ ] Frontend: https://mireb-commercial.netlify.app
- [ ] Ajouter un produit test
- [ ] Upload image test
- [ ] Générer description IA test
- [ ] Vérifier analytics visiteurs
- [ ] Test responsive mobile

---

## 🌐 URLS FINALES

Une fois terminé:
- **🏠 Application**: https://mireb-commercial.netlify.app
- **🔧 API**: https://mireb-commercial-backend.railway.app
- **📊 Health**: https://mireb-commercial-backend.railway.app/api/health

---

## 🛠️ DÉPANNAGE

### Erreurs communes:
- **CORS Error**: Vérifier allowedOrigins dans server.js
- **DB Connection**: MONGODB_URI incorrect
- **Images**: Cloudinary credentials incorrects

### Solutions:
- Railway Logs: Dashboard → View Logs
- Browser Console: F12 → Network tab
- Test API individuellement

---

## ✅ SUCCÈS !

Quand tout fonctionne:
- ✅ Application accessible mondialement
- ✅ Données partagées entre utilisateurs  
- ✅ Images stockées sur cloud
- ✅ IA descriptions fonctionnelles
- ✅ Analytics temps réel
- ✅ Mobile responsive

**🎉 Votre plateforme e-commerce Mireb Commercial est en ligne !**

---

*Checklist pour: mirebcommercial@gmail.com - Fiacre-19*  
*Kinshasa, Congo (DRC) - 24 juillet 2025*
