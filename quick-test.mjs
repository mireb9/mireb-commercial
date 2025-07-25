// Test simple Node.js - Mireb Commercial
console.log('🎉 ===== MIREB COMMERCIAL TEST =====');
console.log('📧 Account: mirebcommercial@gmail.com');
console.log('🔑 Author: Fiacre-19');
console.log('🌍 Location: Kinshasa, Congo (DRC)');
console.log('✅ Node.js Version:', process.version);
console.log('🖥️  Platform:', process.platform);
console.log('📅 Date:', new Date().toLocaleString('fr-FR'));
console.log('=====================================');
console.log('🚀 Ready to launch Mireb Commercial!');

// Test simple serveur HTTP
import { createServer } from 'node:http';

const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
  res.end(`
    <h1>🏪 Mireb Commercial - Test Réussi!</h1>
    <p><strong>📧 Compte:</strong> mirebcommercial@gmail.com</p>
    <p><strong>🔑 Auteur:</strong> Fiacre-19</p>
    <p><strong>🌍 Localisation:</strong> Kinshasa, Congo (RDC)</p>
    <p><strong>✅ Node.js:</strong> ${process.version}</p>
    <p><strong>📅 Date:</strong> ${new Date().toLocaleString('fr-FR')}</p>
    <hr>
    <p style="color: green;"><strong>🎉 Installation réussie ! Votre serveur fonctionne parfaitement.</strong></p>
  `);
});

server.listen(3000, '127.0.0.1', () => {
  console.log('🌐 Serveur démarré sur: http://127.0.0.1:3000');
  console.log('💡 Appuyez sur Ctrl+C pour arrêter');
});
