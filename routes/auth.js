const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Route de test pour l'authentification
router.get('/test', (req, res) => {
  res.json({ 
    message: 'Route auth fonctionnelle',
    service: 'Mireb Commercial Auth',
    timestamp: new Date().toISOString()
  });
});

// Route de connexion (placeholder)
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Pour le moment, retourner un token factice
    const token = jwt.sign(
      { id: 'user_demo', email },
      process.env.JWT_SECRET || 'default_secret',
      { expiresIn: '24h' }
    );
    
    res.json({
      success: true,
      message: 'Connexion réussie (mode démo)',
      token,
      user: { id: 'user_demo', email }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Route d'inscription (placeholder)
router.post('/register', async (req, res) => {
  try {
    const { email, password, name } = req.body;
    
    res.json({
      success: true,
      message: 'Inscription réussie (mode démo)',
      user: { email, name }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
