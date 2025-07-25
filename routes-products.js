const express = require('express');
const router = express.Router();
const Product = require('../models-product');
const { authenticateToken } = require('../middleware-auth');
const { body, validationResult } = require('express-validator');
const axios = require('axios');

// OpenAI pour descriptions IA
const generateAIDescription = async (productName) => {
  try {
    const response = await axios.post('https://api.openai.com/v1/chat/completions', {
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: "Tu es un expert en rédaction de descriptions produits e-commerce. Crée des descriptions attractives, détaillées et persuasives en HTML avec des balises <p>, <ul>, <li>, <b>. Utilise des émojis pour rendre plus attractif. La description doit être en français et faire environ 100-150 mots."
        },
        {
          role: "user",
          content: `Créé une description e-commerce professionnelle et attractive pour le produit suivant : "${productName}". Inclus les caractéristiques techniques probables, les avantages, et pourquoi l'acheter. Utilise du HTML avec des balises <p>, <ul>, <li>, <b> et des émojis.`
        }
      ],
      max_tokens: 500,
      temperature: 0.7
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`
      }
    });

    return response.data.choices[0].message.content;
  } catch (error) {
    console.error('Erreur OpenAI:', error.response?.data || error.message);
    throw new Error('Erreur lors de la génération de description IA');
  }
};

// GET /api/products - Récupérer tous les produits avec filtres
router.get('/', async (req, res) => {
  try {
    const {
      page = 1,
      limit = 20,
      categorie,
      search,
      sortBy = 'createdAt',
      order = 'desc',
      inStock
    } = req.query;

    const query = { isActive: true };
    
    // Filtres
    if (categorie && categorie !== 'Toutes') query.categorie = categorie;
    if (search) {
      query.$text = { $search: search };
    }
    if (inStock === 'true') query.stock = { $gt: 0 };

    const sortOrder = order === 'desc' ? -1 : 1;
    const sortOptions = { [sortBy]: sortOrder };

    const products = await Product.find(query)
      .sort(sortOptions)
      .limit(limit * 1)
      .skip((page - 1) * limit)
      .populate('createdBy', 'nom email');

    const total = await Product.countDocuments(query);

    res.json({
      products,
      totalPages: Math.ceil(total / limit),
      currentPage: page,
      total
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /api/products/:id - Récupérer un produit spécifique
router.get('/:id', async (req, res) => {
  try {
    const product = await Product.findById(req.params.id)
      .populate('createdBy', 'nom email');
    
    if (!product) {
      return res.status(404).json({ error: 'Produit non trouvé' });
    }

    // Incrémenter les vues
    product.metadata.views += 1;
    await product.save();

    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/products - Créer un nouveau produit (Admin requis)
router.post('/', 
  authenticateToken,
  [
    body('nom').trim().isLength({ min: 1 }).withMessage('Le nom est requis'),
    body('prix').isNumeric().withMessage('Le prix doit être numérique'),
    body('stock').isInt({ min: 0 }).withMessage('Le stock doit être un entier positif'),
    body('categorie').isIn([
      "Électronique", "Mode", "Maison & Jardin", "Automobile",
      "Santé & Beauté", "Sports & Loisirs", "Industrie & BTP"
    ]).withMessage('Catégorie invalide')
  ],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { nom, prix, stock, categorie, images, description, generateAI } = req.body;

      let finalDescription = description;
      
      // Générer description IA si demandé
      if (generateAI && !description) {
        try {
          finalDescription = await generateAIDescription(nom);
        } catch (aiError) {
          console.error('Erreur IA:', aiError);
          // Continuer sans IA
        }
      }

      const product = new Product({
        nom,
        prix,
        stock,
        categorie,
        images: images || [],
        description: finalDescription || '',
        aiGenerated: !!generateAI,
        createdBy: req.user.id
      });

      await product.save();
      
      res.status(201).json({
        message: 'Produit créé avec succès',
        product
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

// PUT /api/products/:id - Mettre à jour un produit (Admin requis)
router.put('/:id',
  authenticateToken,
  [
    body('nom').optional().trim().isLength({ min: 1 }),
    body('prix').optional().isNumeric(),
    body('stock').optional().isInt({ min: 0 })
  ],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const product = await Product.findByIdAndUpdate(
        req.params.id,
        { ...req.body, updatedAt: new Date() },
        { new: true, runValidators: true }
      );

      if (!product) {
        return res.status(404).json({ error: 'Produit non trouvé' });
      }

      res.json({
        message: 'Produit mis à jour avec succès',
        product
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

// DELETE /api/products/:id - Supprimer un produit (Admin requis)
router.delete('/:id', authenticateToken, async (req, res) => {
  try {
    const product = await Product.findByIdAndUpdate(
      req.params.id,
      { isActive: false },
      { new: true }
    );

    if (!product) {
      return res.status(404).json({ error: 'Produit non trouvé' });
    }

    res.json({ message: 'Produit supprimé avec succès' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /api/products/import - Importer des produits depuis URL/JSON
router.post('/import', authenticateToken, async (req, res) => {
  try {
    const { url, jsonData } = req.body;
    let data;

    if (url) {
      const response = await axios.get(url);
      data = response.data;
    } else if (jsonData) {
      data = JSON.parse(jsonData);
    } else {
      return res.status(400).json({ error: 'URL ou données JSON requises' });
    }

    const productsArray = Array.isArray(data) ? data : [data];
    const importedProducts = [];

    for (const item of productsArray) {
      const product = new Product({
        nom: item.title || item.name || item.nom || "Produit importé",
        prix: Number(item.price || item.prix || 0),
        stock: Number(item.stock || item.inventory || item.quantity || 20),
        categorie: item.category || item.categorie || "Électronique",
        images: Array.isArray(item.images) 
          ? item.images.map(img => ({ url: img, isPrimary: false }))
          : item.image 
          ? [{ url: item.image, isPrimary: true }]
          : [],
        description: item.description || item.desc || item.body || "",
        createdBy: req.user.id
      });

      // Marquer la première image comme principale
      if (product.images.length > 0) {
        product.images[0].isPrimary = true;
      }

      await product.save();
      importedProducts.push(product);
    }

    res.json({
      message: `${importedProducts.length} produit(s) importé(s) avec succès`,
      products: importedProducts
    });
  } catch (error) {
    console.error('Erreur import:', error);
    res.status(500).json({ error: error.message });
  }
});

// POST /api/products/:id/generate-description - Générer description IA
router.post('/:id/generate-description', authenticateToken, async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ error: 'Produit non trouvé' });
    }

    const aiDescription = await generateAIDescription(product.nom);
    
    product.description = aiDescription;
    product.aiGenerated = true;
    await product.save();

    res.json({
      message: 'Description générée avec succès',
      description: aiDescription
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
