@echo off
title Mireb Commercial - Déploiement Complet
color 0A

echo.
echo ============================================
echo  🏗️  DÉPLOIEMENT COMPLET - MIREB COMMERCIAL
echo ============================================
echo  📧 Account: mirebcommercial@gmail.com
echo  🔑 Author: Fiacre-19
echo  🌍 Location: Kinshasa, Congo (DRC)
echo ============================================
echo.

echo 🎯 DÉPLOIEMENT COMPLET SÉLECTIONNÉ
echo.
echo Ce processus va créer une application complète avec:
echo ✅ Base de données partagée MongoDB Atlas
echo ✅ Images stockées sur Cloudinary 
echo ✅ Backend déployé sur Railway
echo ✅ Frontend déployé sur Netlify
echo ✅ Toutes les données synchronisées entre utilisateurs
echo.

echo 📋 SERVICES À CONFIGURER (tous gratuits):
echo.
echo 1. 🗄️  MongoDB Atlas - Base de données
echo 2. 🖼️  Cloudinary - Stockage images
echo 3. 🚂 Railway - Serveur backend
echo 4. 🌐 Netlify - Interface frontend
echo.

set /p confirm="Continuer avec le déploiement complet? (o/n): "
if /i "%confirm%" neq "o" goto :end

echo.
echo 🌐 Ouverture des services de déploiement...
echo.

echo 1/4 - Ouverture MongoDB Atlas...
start https://www.mongodb.com/atlas
timeout /t 2 /nobreak >nul

echo 2/4 - Ouverture Cloudinary...
start https://cloudinary.com/
timeout /t 2 /nobreak >nul

echo 3/4 - Ouverture Railway...
start https://railway.app/
timeout /t 2 /nobreak >nul

echo 4/4 - Ouverture Netlify...
start https://netlify.com/
timeout /t 2 /nobreak >nul

echo.
echo ✅ Tous les services sont ouverts dans votre navigateur!
echo.
echo 📋 INSTRUCTIONS DÉTAILLÉES:
echo.
echo 1. Créez des comptes sur tous les services avec: mirebcommercial@gmail.com
echo 2. Suivez le guide: DEPLOY-COMPLET.md
echo 3. Configurez MongoDB Atlas et copiez l'URI
echo 4. Configurez Cloudinary et copiez les credentials
echo 5. Déployez le backend sur Railway
echo 6. Déployez le frontend sur Netlify
echo.

echo 🎯 ORDRE RECOMMANDÉ:
echo Step 1: MongoDB Atlas (base de données)
echo Step 2: Cloudinary (images)
echo Step 3: Railway (backend)
echo Step 4: Netlify (frontend)
echo.

echo 📚 DOCUMENTATION:
echo • Guide complet: DEPLOY-COMPLET.md
echo • Configuration: .env (mis à jour)
echo • Package.json: prêt pour production
echo.

set /p openGuide="Ouvrir le guide détaillé maintenant? (o/n): "
if /i "%openGuide%"=="o" start DEPLOY-COMPLET.md

echo.
echo 🎉 DÉPLOIEMENT PRÊT À COMMENCER!
echo.
echo URLs finales après déploiement:
echo 🌐 Application: https://mireb-commercial.netlify.app
echo 🔧 API Backend: https://mireb-commercial-backend.railway.app
echo.
echo 💡 Astuce: Gardez ce terminal ouvert pour référence
echo.

:end
pause
