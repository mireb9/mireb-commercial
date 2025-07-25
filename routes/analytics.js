const express = require("express");
const router = express.Router();

router.get("/test", (req, res) => {
  res.json({ message: "Route analytics fonctionnelle", timestamp: new Date() });
});

router.get("/", (req, res) => {
  res.json({ analytics: { views: 100, orders: 10, revenue: 1500 }, message: "Analytics (démo)" });
});

module.exports = router;
