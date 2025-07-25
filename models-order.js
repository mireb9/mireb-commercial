const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  orderNumber: {
    type: String,
    unique: true,
    required: true
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  guestInfo: {
    nom: String,
    email: String,
    telephone: String,
    adresse: String
  },
  items: [{
    product: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Product',
      required: true
    },
    nom: String, // Snapshot du nom
    prix: Number, // Snapshot du prix
    quantite: {
      type: Number,
      required: true,
      min: 1
    },
    image: String // Snapshot de l'image principale
  }],
  shipping: {
    adresse: {
      type: String,
      required: true
    },
    ville: String,
    pays: { type: String, default: 'RDC' },
    codePostal: String,
    method: {
      type: String,
      enum: ['standard', 'express', 'pickup'],
      default: 'standard'
    },
    cost: { type: Number, default: 0 }
  },
  payment: {
    method: {
      type: String,
      enum: ['cash', 'mobile_money', 'bank_transfer', 'card'],
      required: true
    },
    status: {
      type: String,
      enum: ['pending', 'paid', 'failed', 'refunded'],
      default: 'pending'
    },
    transactionId: String,
    paidAt: Date
  },
  totals: {
    subtotal: { type: Number, required: true },
    shipping: { type: Number, default: 0 },
    tax: { type: Number, default: 0 },
    total: { type: Number, required: true }
  },
  status: {
    type: String,
    enum: ['pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled'],
    default: 'pending'
  },
  tracking: {
    number: String,
    carrier: String,
    url: String
  },
  notes: String,
  adminNotes: String
}, {
  timestamps: true
});

// Générer numéro de commande avant sauvegarde
orderSchema.pre('save', function(next) {
  if (!this.orderNumber) {
    const timestamp = Date.now().toString(36);
    const random = Math.random().toString(36).substr(2, 5);
    this.orderNumber = `MRB-${timestamp}-${random}`.toUpperCase();
  }
  next();
});

// Index pour recherche et performance
orderSchema.index({ orderNumber: 1 });
orderSchema.index({ user: 1 });
orderSchema.index({ status: 1 });
orderSchema.index({ createdAt: -1 });
orderSchema.index({ 'payment.status': 1 });

module.exports = mongoose.model('Order', orderSchema);
