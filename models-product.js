const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  nom: {
    type: String,
    required: true,
    trim: true
  },
  prix: {
    type: Number,
    required: true,
    min: 0
  },
  stock: {
    type: Number,
    required: true,
    min: 0,
    default: 0
  },
  categorie: {
    type: String,
    required: true,
    enum: [
      "Électronique", "Mode", "Maison & Jardin", "Automobile",
      "Santé & Beauté", "Sports & Loisirs", "Industrie & BTP"
    ]
  },
  images: [{
    url: String,
    publicId: String, // Pour Cloudinary
    alt: String,
    isPrimary: { type: Boolean, default: false }
  }],
  description: {
    type: String,
    default: ""
  },
  aiGenerated: {
    type: Boolean,
    default: false
  },
  metadata: {
    views: { type: Number, default: 0 },
    likes: { type: Number, default: 0 },
    sales: { type: Number, default: 0 }
  },
  seo: {
    title: String,
    metaDescription: String,
    keywords: [String]
  },
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  isActive: {
    type: Boolean,
    default: true
  }
}, {
  timestamps: true
});

// Index pour recherche
productSchema.index({ nom: 'text', description: 'text' });
productSchema.index({ categorie: 1 });
productSchema.index({ prix: 1 });
productSchema.index({ createdAt: -1 });

// Middleware pour panorama automatique
productSchema.pre('save', function(next) {
  if (this.images && this.images.length > 0) {
    // Assurer qu'une seule image est marquée comme principale
    let primaryFound = false;
    this.images.forEach(img => {
      if (img.isPrimary && !primaryFound) {
        primaryFound = true;
      } else {
        img.isPrimary = false;
      }
    });
    
    // Si aucune image principale, la première devient principale
    if (!primaryFound && this.images.length > 0) {
      this.images[0].isPrimary = true;
    }
  }
  next();
});

// Méthodes virtuelles
productSchema.virtual('primaryImage').get(function() {
  const primary = this.images.find(img => img.isPrimary);
  return primary || (this.images.length > 0 ? this.images[0] : null);
});

productSchema.virtual('secondaryImages').get(function() {
  return this.images.filter(img => !img.isPrimary);
});

productSchema.virtual('isInStock').get(function() {
  return this.stock > 0;
});

module.exports = mongoose.model('Product', productSchema);
