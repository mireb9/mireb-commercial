const express = require('express');
const cors = require('cors');

const app = express();
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

// Route produits
app.get('/api/products', (req, res) => {
  res.json({ products: [], message: 'API produits fonctionnelle' });
});

module.exports = app;
