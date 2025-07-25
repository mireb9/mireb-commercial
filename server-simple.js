require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();

// Middleware de base
app.use(cors());
app.use(express.json());

// Route de test
app.get("/", (req, res) => {
  res.json({ 
    message: "🎉 Mireb Commercial API fonctionne !",
    status: "success",
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || "development"
  });
});

// Routes de test
app.get("/api/test", (req, res) => {
  res.json({ message: "API Test réussie", service: "Mireb Commercial" });
});

app.get("/api/health", (req, res) => {
  res.json({ status: "healthy", uptime: process.uptime() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Serveur Mireb Commercial démarré sur le port ${PORT}`);
  console.log(`🌐 URL: http://localhost:${PORT}`);
  console.log(`📧 Contact: mirebcommercial@gmail.com`);
});
