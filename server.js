const express = require('express');
const cors = require('cors');
const app = express();

// Middleware de base
app.use(cors());
app.use(express.json());

// Route principale
app.get('/', (req, res) => {
  res.json({ 
    message: 'Mireb Commercial API - Serveur fonctionnel',
    status: 'success',
    timestamp: new Date().toISOString()
  });
});

// Route de santé
app.get('/health', (req, res) => {
  res.json({ status: 'OK', service: 'Mireb Commercial' });
});

// Routes API de base
app.get('/api/products', (req, res) => {
  res.json({ products: [], message: 'API produits fonctionnelle' });
});

// Gestion des erreurs
app.use((err, req, res, next) => {
  console.error('Erreur:', err);
  res.status(500).json({ error: 'Erreur serveur', message: err.message });
});

// Route 404
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route non trouvée' });
});

const PORT = process.env.PORT || 3000;

// Export pour Vercel
module.exports = app;
