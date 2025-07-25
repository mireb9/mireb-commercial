const express = require("express");
const router = express.Router();

router.get("/test", (req, res) => {
  res.json({ message: "Route orders fonctionnelle", timestamp: new Date() });
});

router.get("/", (req, res) => {
  res.json({ orders: [], message: "Liste des commandes (démo)" });
});

router.post("/", (req, res) => {
  res.json({ success: true, message: "Commande créée (démo)", orderId: "demo_order_" + Date.now() });
});

module.exports = router;
