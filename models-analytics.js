const mongoose = require('mongoose');

const visitorSchema = new mongoose.Schema({
  sessionId: {
    type: String,
    required: true,
    index: true
  },
  ipAddress: String,
  userAgent: String,
  location: {
    country: String,
    city: String,
    coordinates: {
      lat: Number,
      lng: Number
    },
    accuracy: Number
  },
  pages: [{
    path: String,
    title: String,
    visitedAt: { type: Date, default: Date.now },
    timeSpent: Number // en secondes
  }],
  referrer: String,
  device: {
    type: { type: String }, // mobile, desktop, tablet
    browser: String,
    os: String,
    screen: {
      width: Number,
      height: Number
    }
  },
  isReturning: {
    type: Boolean,
    default: false
  },
  totalPageViews: {
    type: Number,
    default: 1
  },
  sessionDuration: Number, // en secondes
  lastSeenAt: {
    type: Date,
    default: Date.now
  }
}, {
  timestamps: true
});

// Index pour analytics
visitorSchema.index({ createdAt: -1 });
visitorSchema.index({ 'location.country': 1 });
visitorSchema.index({ 'location.city': 1 });
visitorSchema.index({ sessionId: 1, createdAt: -1 });

const leadSchema = new mongoose.Schema({
  nom: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    type: String,
    required: true,
    lowercase: true
  },
  telephone: String,
  message: String,
  product: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product'
  },
  source: {
    type: String,
    enum: ['contact_form', 'product_inquiry', 'newsletter', 'chat'],
    default: 'contact_form'
  },
  status: {
    type: String,
    enum: ['new', 'contacted', 'qualified', 'converted', 'lost'],
    default: 'new'
  },
  priority: {
    type: String,
    enum: ['low', 'medium', 'high', 'urgent'],
    default: 'medium'
  },
  assignedTo: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  notes: [String],
  tags: [String],
  followUpDate: Date,
  convertedAt: Date,
  conversionValue: Number
}, {
  timestamps: true
});

// Index pour CRM
leadSchema.index({ status: 1 });
leadSchema.index({ createdAt: -1 });
leadSchema.index({ email: 1 });
leadSchema.index({ assignedTo: 1 });

const Visitor = mongoose.model('Visitor', visitorSchema);
const Lead = mongoose.model('Lead', leadSchema);

module.exports = { Visitor, Lead };
