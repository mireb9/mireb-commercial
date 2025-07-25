@echo off
title Mireb Commercial - Accès Direct
color 0B

echo.
echo ==========================================
echo  🌐 ACCÈS DIRECT - MIREB COMMERCIAL
echo ==========================================
echo  📧 Account: mirebcommercial@gmail.com
echo  🔑 Author: Fiacre-19
echo  🌍 Location: Kinshasa, Congo (DRC)
echo ==========================================
echo.

echo 🚀 Démarrage du serveur...
echo.

start "Mireb Commercial Server" "C:\Program Files\nodejs\node.exe" quick-test.mjs

echo ⏳ Attente du démarrage du serveur (3 secondes)...
timeout /t 3 /nobreak >nul

echo.
echo 🌐 Ouverture de votre application...
echo 📱 URL: http://127.0.0.1:3000
echo.

start http://127.0.0.1:3000

echo ✅ Application lancée !
echo.
echo 💡 INSTRUCTIONS:
echo - Votre app s'ouvre dans le navigateur
echo - Le serveur tourne en arrière-plan
echo - Pour arrêter: fermez la fenêtre du serveur
echo.

echo 🎯 PROCHAINES ÉTAPES:
echo 1. Testez l'interface web
echo 2. Installez les dépendances: npm install
echo 3. Configurez MongoDB et Cloudinary
echo.

pause
