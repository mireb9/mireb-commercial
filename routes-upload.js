const express = require('express');
const router = express.Router();
const multer = require('multer');
const cloudinary = require('cloudinary').v2;
const { authenticateToken } = require('../middleware-auth');

// Configuration Cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});

// Configuration Multer pour upload en mémoire
const storage = multer.memoryStorage();
const upload = multer({ 
  storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB max
  },
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Seules les images sont autorisées'), false);
    }
  }
});

// Fonction pour uploader vers Cloudinary
const uploadToCloudinary = (buffer, folder = 'mireb-products') => {
  return new Promise((resolve, reject) => {
    cloudinary.uploader.upload_stream(
      {
        resource_type: 'image',
        folder: folder,
        transformation: [
          { width: 800, height: 600, crop: 'limit', quality: 'auto' },
          { format: 'webp' }
        ]
      },
      (error, result) => {
        if (error) reject(error);
        else resolve(result);
      }
    ).end(buffer);
  });
};

// POST /api/upload/single - Upload d'une seule image
router.post('/single', authenticateToken, upload.single('image'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'Aucun fichier fourni' });
    }

    const result = await uploadToCloudinary(req.file.buffer);
    
    res.json({
      message: 'Image uploadée avec succès',
      image: {
        url: result.secure_url,
        publicId: result.public_id,
        width: result.width,
        height: result.height,
        format: result.format,
        size: result.bytes
      }
    });
  } catch (error) {
    console.error('Erreur upload:', error);
    res.status(500).json({ error: 'Erreur lors de l\'upload' });
  }
});

// POST /api/upload/multiple - Upload de plusieurs images avec panorama automatique
router.post('/multiple', authenticateToken, upload.array('images', 10), async (req, res) => {
  try {
    if (!req.files || req.files.length === 0) {
      return res.status(400).json({ error: 'Aucun fichier fourni' });
    }

    const uploadPromises = req.files.map((file, index) => 
      uploadToCloudinary(file.buffer, 'mireb-products')
    );

    const results = await Promise.all(uploadPromises);
    
    // Organiser pour panorama automatique
    const images = results.map((result, index) => ({
      url: result.secure_url,
      publicId: result.public_id,
      isPrimary: index === 0, // Première image = principale
      alt: `Image ${index + 1}`,
      width: result.width,
      height: result.height,
      format: result.format,
      size: result.bytes
    }));

    res.json({
      message: `${images.length} images uploadées avec succès`,
      images: {
        primary: images[0],
        secondary: images.slice(1),
        all: images
      }
    });
  } catch (error) {
    console.error('Erreur upload multiple:', error);
    res.status(500).json({ error: 'Erreur lors de l\'upload multiple' });
  }
});

// DELETE /api/upload/:publicId - Supprimer une image de Cloudinary
router.delete('/:publicId', authenticateToken, async (req, res) => {
  try {
    const result = await cloudinary.uploader.destroy(req.params.publicId);
    
    if (result.result === 'ok') {
      res.json({ message: 'Image supprimée avec succès' });
    } else {
      res.status(404).json({ error: 'Image non trouvée' });
    }
  } catch (error) {
    console.error('Erreur suppression:', error);
    res.status(500).json({ error: 'Erreur lors de la suppression' });
  }
});

// POST /api/upload/optimize - Optimiser et créer des variantes d'images
router.post('/optimize/:publicId', authenticateToken, async (req, res) => {
  try {
    const { publicId } = req.params;
    const { transformations } = req.body;

    // Générer différentes tailles automatiquement
    const variants = {
      thumbnail: `${publicId}_thumb`,
      medium: `${publicId}_med`,
      large: `${publicId}_large`
    };

    const optimizationPromises = [
      // Thumbnail 150x150
      cloudinary.uploader.explicit(publicId, {
        type: 'upload',
        public_id: variants.thumbnail,
        transformation: { width: 150, height: 150, crop: 'fill', quality: 'auto', format: 'webp' }
      }),
      // Medium 400x300
      cloudinary.uploader.explicit(publicId, {
        type: 'upload',
        public_id: variants.medium,
        transformation: { width: 400, height: 300, crop: 'limit', quality: 'auto', format: 'webp' }
      }),
      // Large 800x600
      cloudinary.uploader.explicit(publicId, {
        type: 'upload',
        public_id: variants.large,
        transformation: { width: 800, height: 600, crop: 'limit', quality: 'auto', format: 'webp' }
      })
    ];

    const results = await Promise.all(optimizationPromises);
    
    const optimizedUrls = {
      thumbnail: results[0].secure_url,
      medium: results[1].secure_url,
      large: results[2].secure_url,
      original: cloudinary.url(publicId)
    };

    res.json({
      message: 'Images optimisées avec succès',
      variants: optimizedUrls
    });
  } catch (error) {
    console.error('Erreur optimisation:', error);
    res.status(500).json({ error: 'Erreur lors de l\'optimisation' });
  }
});

// Middleware de gestion d'erreurs pour Multer
router.use((error, req, res, next) => {
  if (error instanceof multer.MulterError) {
    if (error.code === 'LIMIT_FILE_SIZE') {
      return res.status(400).json({ error: 'Fichier trop volumineux (max 5MB)' });
    }
    if (error.code === 'LIMIT_FILE_COUNT') {
      return res.status(400).json({ error: 'Trop de fichiers (max 10)' });
    }
  }
  
  if (error.message === 'Seules les images sont autorisées') {
    return res.status(400).json({ error: error.message });
  }
  
  next(error);
});

module.exports = router;
