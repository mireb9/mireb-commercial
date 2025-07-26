# Script de Déploiement Automatique - Mireb Commercial
# Account: mirebcommercial@gmail.com - Fiacre-19

Write-Host "=== DÉPLOIEMENT MIREB COMMERCIAL ===" -ForegroundColor Cyan
Write-Host "📧 Account: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "🔑 Author: Fiacre-19" -ForegroundColor Green
Write-Host "🌍 Location: Kinshasa, Congo (DRC)" -ForegroundColor Green
Write-Host ""

# Menu de choix
Write-Host "🚀 CHOISISSEZ VOTRE OPTION DE DÉPLOIEMENT:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 🌐 DÉPLOIEMENT SIMPLE (5 minutes)" -ForegroundColor White
Write-Host "   • Version actuelle avec localStorage" -ForegroundColor Gray
Write-Host "   • Interface complète fonctionnelle" -ForegroundColor Gray
Write-Host "   • Netlify ou Vercel gratuit" -ForegroundColor Gray
Write-Host ""
Write-Host "2. 🏗️  DÉPLOIEMENT COMPLET (30 minutes)" -ForegroundColor White
Write-Host "   • Base de données MongoDB partagée" -ForegroundColor Gray
Write-Host "   • Images Cloudinary partagées" -ForegroundColor Gray
Write-Host "   • Backend + Frontend séparés" -ForegroundColor Gray
Write-Host ""
Write-Host "3. 📋 VOIR LES INSTRUCTIONS DÉTAILLÉES" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Votre choix (1, 2, ou 3)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "🌐 DÉPLOIEMENT SIMPLE SÉLECTIONNÉ" -ForegroundColor Green
        Write-Host ""
        Write-Host "📋 ÉTAPES À SUIVRE:" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "1. Allez sur: https://app.netlify.com/drop" -ForegroundColor White
        Write-Host "2. Créez un compte avec: mirebcommercial@gmail.com" -ForegroundColor White
        Write-Host "3. Glissez votre fichier index.html dans la zone" -ForegroundColor White
        Write-Host "4. Votre app sera accessible immédiatement !" -ForegroundColor White
        Write-Host ""
        Write-Host "🎯 ALTERNATIVE VERCEL:" -ForegroundColor Yellow
        Write-Host "1. Allez sur: https://vercel.com/new" -ForegroundColor White
        Write-Host "2. Upload votre fichier index.html" -ForegroundColor White
        Write-Host ""
        
        $openSites = Read-Host "Ouvrir Netlify et Vercel maintenant? (o/n)"
        if ($openSites -eq 'o' -or $openSites -eq 'O') {
            Start-Process "https://app.netlify.com/drop"
            Start-Sleep 2
            Start-Process "https://vercel.com/new"
            Write-Host "✅ Sites ouverts dans votre navigateur" -ForegroundColor Green
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "🏗️  DÉPLOIEMENT COMPLET SÉLECTIONNÉ" -ForegroundColor Green
        Write-Host ""
        Write-Host "📋 SERVICES À CONFIGURER:" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "1. 🗄️  MongoDB Atlas (Base de données gratuite)" -ForegroundColor White
        Write-Host "   • https://www.mongodb.com/atlas" -ForegroundColor Gray
        Write-Host "   • Compte: mirebcommercial@gmail.com" -ForegroundColor Gray
        Write-Host ""
        Write-Host "2. 🖼️  Cloudinary (Images gratuites)" -ForegroundColor White
        Write-Host "   • https://cloudinary.com/" -ForegroundColor Gray
        Write-Host "   • Compte: mirebcommercial@gmail.com" -ForegroundColor Gray
        Write-Host ""
        Write-Host "3. 🚂 Railway (Backend gratuit)" -ForegroundColor White
        Write-Host "   • https://railway.app/" -ForegroundColor Gray
        Write-Host "   • Déploiement serveur Node.js" -ForegroundColor Gray
        Write-Host ""
        Write-Host "4. 🌐 Netlify (Frontend gratuit)" -ForegroundColor White
        Write-Host "   • https://netlify.com/" -ForegroundColor Gray
        Write-Host "   • Interface utilisateur" -ForegroundColor Gray
        Write-Host ""
        
        $openAll = Read-Host "Ouvrir tous les services maintenant? (o/n)"
        if ($openAll -eq 'o' -or $openAll -eq 'O') {
            Write-Host "🌐 Ouverture des services..." -ForegroundColor Green
            Start-Process "https://www.mongodb.com/atlas"
            Start-Sleep 2
            Start-Process "https://cloudinary.com/"
            Start-Sleep 2
            Start-Process "https://railway.app/"
            Start-Sleep 2
            Start-Process "https://netlify.com/"
            Write-Host "✅ Tous les services ouverts" -ForegroundColor Green
            Write-Host ""
            Write-Host "📋 Ordre recommandé:" -ForegroundColor Yellow
            Write-Host "1. Créez d'abord les comptes sur tous les services" -ForegroundColor White
            Write-Host "2. Configurez MongoDB Atlas et obtenez l'URI" -ForegroundColor White
            Write-Host "3. Configurez Cloudinary et obtenez les credentials" -ForegroundColor White
            Write-Host "4. Déployez le backend sur Railway" -ForegroundColor White
            Write-Host "5. Déployez le frontend sur Netlify" -ForegroundColor White
        }
    }
    
    "3" {
        Write-Host ""
        Write-Host "📋 OUVERTURE DE LA DOCUMENTATION" -ForegroundColor Green
        Start-Process "DEPLOYMENT.md"
        Write-Host "✅ Guide détaillé ouvert" -ForegroundColor Green
    }
    
    default {
        Write-Host ""
        Write-Host "❌ Choix invalide" -ForegroundColor Red
        Write-Host "Relancez le script et choisissez 1, 2 ou 3" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "🎯 SUPPORT:" -ForegroundColor Cyan
Write-Host "• Documentation complète: DEPLOYMENT.md" -ForegroundColor White
Write-Host "• Guide d'accès: ACCESS-GUIDE.md" -ForegroundColor White
Write-Host "• Status du projet: SUCCESS.md" -ForegroundColor White
Write-Host ""
Write-Host "📧 Configuration pour: mirebcommercial@gmail.com" -ForegroundColor Green
Write-Host "🔑 Auteur: Fiacre-19" -ForegroundColor Green
Write-Host "🌍 Localisation: Kinshasa, Congo (DRC)" -ForegroundColor Green
Write-Host ""
Write-Host "🎉 Bonne chance avec votre déploiement !" -ForegroundColor Cyan
