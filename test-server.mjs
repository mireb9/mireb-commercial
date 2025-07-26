// test-server.mjs - Test simple du serveur
// Account: mirebcommercial@gmail.com - Fiacre-19

import { createServer } from 'node:http';

console.log('🧪 Test Server - Mireb Commercial');
console.log('📧 Account: mirebcommercial@gmail.com');
console.log('🔑 Author: Fiacre-19');
console.log('');

// Serveur de test minimal
const testServer = createServer((req, res) => {
    const timestamp = new Date().toISOString();
    
    // Log de la requête
    console.log(`${timestamp} - ${req.method} ${req.url}`);
    
    // Réponse selon l'URL
    if (req.url === '/') {
        res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end(`
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mireb Commercial - Test</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            max-width: 800px; 
            margin: 50px auto; 
            padding: 20px;
            background: #f5f5f5;
        }
        .header { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color: white; 
            padding: 20px; 
            border-radius: 10px; 
            text-align: center;
            margin-bottom: 20px;
        }
        .info { 
            background: white; 
            padding: 20px; 
            border-radius: 10px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .status { color: #28a745; font-weight: bold; }
        .endpoint { 
            background: #e9ecef; 
            padding: 10px; 
            border-radius: 5px; 
            margin: 5px 0;
            font-family: monospace;
        }
        .next-steps {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            padding: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏪 Mireb Commercial</h1>
        <p>Plateforme E-commerce Intelligente</p>
        <p><strong>mirebcommercial@gmail.com</strong> - Fiacre-19</p>
    </div>
    
    <div class="info">
        <h2>✅ Serveur de Test Fonctionnel</h2>
        <p class="status">Le serveur Node.js fonctionne correctement !</p>
        <p><strong>Timestamp:</strong> ${timestamp}</p>
        <p><strong>Localisation:</strong> Kinshasa, Congo (RDC)</p>
    </div>
    
    <div class="info">
        <h3>🔗 Endpoints de Test</h3>
        <div class="endpoint">GET / - Page d'accueil</div>
        <div class="endpoint">GET /api/test - Test API JSON</div>
        <div class="endpoint">GET /api/status - Statut du serveur</div>
    </div>
    
    <div class="next-steps">
        <h3>🚀 Prochaines Étapes</h3>
        <ol>
            <li>✅ Node.js fonctionne</li>
            <li>📦 Installer les dépendances: <code>npm install</code></li>
            <li>🗄️ Configurer MongoDB Atlas</li>
            <li>🖼️ Configurer Cloudinary</li>
            <li>🏃‍♂️ Lancer le serveur complet: <code>npm start</code></li>
        </ol>
    </div>
</body>
</html>
        `);
    }
    else if (req.url === '/api/test') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            status: 'success',
            message: 'API Test endpoint working!',
            server: 'Mireb Commercial Test Server',
            account: 'mirebcommercial@gmail.com',
            author: 'Fiacre-19',
            location: 'Kinshasa, Congo (DRC)',
            timestamp: timestamp,
            nodeVersion: process.version,
            platform: process.platform
        }, null, 2));
    }
    else if (req.url === '/api/status') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            server: 'Online',
            uptime: process.uptime(),
            memory: process.memoryUsage(),
            environment: {
                nodeVersion: process.version,
                platform: process.platform,
                arch: process.arch
            },
            project: {
                name: 'Mireb Commercial',
                version: '1.0.0',
                author: 'Fiacre-19',
                email: 'mirebcommercial@gmail.com'
            }
        }, null, 2));
    }
    else {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            error: 'Not Found',
            message: `Endpoint ${req.url} not found`,
            availableEndpoints: [
                '/',
                '/api/test', 
                '/api/status'
            ]
        }, null, 2));
    }
});

// Démarrer le serveur de test
const PORT = 3000;
const HOST = '127.0.0.1';

testServer.listen(PORT, HOST, () => {
    console.log('✅ Test server started successfully!');
    console.log(`🌐 Open: http://${HOST}:${PORT}`);
    console.log(`🔧 API Test: http://${HOST}:${PORT}/api/test`);
    console.log(`📊 Status: http://${HOST}:${PORT}/api/status`);
    console.log('');
    console.log('💡 Press Ctrl+C to stop');
});

testServer.on('error', (error) => {
    if (error.code === 'EADDRINUSE') {
        console.log(`❌ Port ${PORT} already in use`);
        console.log('💡 Stop other servers or use different port');
    } else {
        console.error('❌ Server error:', error.message);
    }
});

process.on('SIGINT', () => {
    console.log('\n🛑 Stopping test server...');
    testServer.close(() => {
        console.log('✅ Test server stopped');
        process.exit(0);
    });
});
