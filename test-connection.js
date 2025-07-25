const http = require("http");

console.log("🔍 Test de connectivité au serveur...");

const options = {
  hostname: "localhost",
  port: 3000,
  path: "/",
  method: "GET"
};

const req = http.request(options, (res) => {
  console.log(`✅ Statut: ${res.statusCode}`);
  
  let data = "";
  res.on("data", (chunk) => {
    data += chunk;
  });
  
  res.on("end", () => {
    console.log("📝 Réponse:", JSON.parse(data));
    console.log("🎉 Serveur Mireb Commercial fonctionne correctement !");
  });
});

req.on("error", (err) => {
  console.log("❌ Erreur:", err.message);
  console.log("💡 Le serveur nest pas encore démarré ou il y a un problème.");
});

req.end();
