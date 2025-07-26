<<<<<<< HEAD
// server.mjs - Serveur simple Mireb Commercial
// Account: mirebcommercial@gmail.com - Fiacre-19
// Run with: node server.mjs

import { createServer } from 'node:http';
import { readFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Configuration
const PORT = process.env.PORT || 3000;
const HOST = process.env.SERVER_HOST || '127.0.0.1';

// Fonction pour servir les fichiers statiques
function serveFile(filePath, contentType) {
    try {
        const content = readFileSync(join(__dirname, filePath), 'utf8');
        return { content, contentType };
    } catch (error) {
        return null;
    }
}

// Créer le serveur HTTP
const server = createServer((req, res) => {
    const url = req.url;
    
    console.log(`${new Date().toISOString()} - ${req.method} ${url}`);
    
    // Configuration CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    // Gérer les requêtes OPTIONS (preflight)
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }
    
    // Router simple
    if (url === '/' || url === '/index.html') {
        // Servir la page principale
        const file = serveFile('index.html', 'text/html');
        if (file) {
            res.writeHead(200, { 'Content-Type': file.contentType });
            res.end(file.content);
        } else {
            res.writeHead(404, { 'Content-Type': 'text/html' });
            res.end('<h1>404 - Page non trouvée</h1><p>Fichier index.html manquant</p>');
        }
    }
    else if (url === '/api/health') {
        // Point de santé API
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            status: 'OK',
            message: 'Mireb Commercial Server is running',
            timestamp: new Date().toISOString(),
            account: 'mirebcommercial@gmail.com',
            author: 'Fiacre-19',
            version: '1.0.0'
        }));
    }
    else if (url === '/api/info') {
        // Informations du serveur
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            app: 'Mireb Commercial',
            version: '1.0.0',
            author: 'Fiacre-19',
            email: 'mirebcommercial@gmail.com',
            location: 'Kinshasa, Congo (DRC)',
            features: [
                'E-commerce Platform',
                'AI Product Descriptions',
                'Real-time Analytics',
                'Multi-image Gallery',
                'Visitor Tracking'
            ],
            endpoints: {
                health: '/api/health',
                info: '/api/info',
                home: '/'
            }
        }));
    }
    else if (url.startsWith('/api/')) {
        // Autres endpoints API (placeholder)
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            message: 'API Endpoint',
            url: url,
            note: 'Full API implementation in server.js'
        }));
    }
    else {
        // 404 pour autres routes
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            error: 'Not Found',
            message: `Route ${url} not found`,
            suggestion: 'Try / for home page or /api/health for API status'
        }));
    }
});

// Démarrer le serveur
server.listen(PORT, HOST, () => {
    console.log('🚀 ===== MIREB COMMERCIAL SERVER =====');
    console.log(`📧 Account: mirebcommercial@gmail.com`);
    console.log(`🔑 Author: Fiacre-19`);
    console.log(`🌍 Location: Kinshasa, Congo (DRC)`);
    console.log(`🌐 Server running on: http://${HOST}:${PORT}`);
    console.log(`📱 Application: http://${HOST}:${PORT}/`);
    console.log(`🔧 API Health: http://${HOST}:${PORT}/api/health`);
    console.log(`📊 API Info: http://${HOST}:${PORT}/api/info`);
    console.log('=====================================');
    console.log('💡 Press Ctrl+C to stop the server');
    console.log('');
});

// Gestion des erreurs
server.on('error', (error) => {
    console.error('❌ Server Error:', error.message);
    
    if (error.code === 'EADDRINUSE') {
        console.log(`⚠️  Port ${PORT} is already in use`);
        console.log('💡 Try a different port or stop the existing server');
    }
});

// Gestion de l'arrêt propre
process.on('SIGTERM', () => {
    console.log('\n🛑 Received SIGTERM, shutting down gracefully...');
    server.close(() => {
        console.log('✅ Server closed successfully');
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('\n🛑 Received SIGINT (Ctrl+C), shutting down gracefully...');
    server.close(() => {
        console.log('✅ Server closed successfully');
        process.exit(0);
    });
});

export default server;
=======
// server.mjs - Serveur simple Mireb Commercial
// Account: mirebcommercial@gmail.com - Fiacre-19
// Run with: node server.mjs

import { createServer } from 'node:http';
import { readFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Configuration
const PORT = process.env.PORT || 3000;
const HOST = process.env.SERVER_HOST || '127.0.0.1';

// Fonction pour servir les fichiers statiques
function serveFile(filePath, contentType) {
    try {
        const content = readFileSync(join(__dirname, filePath), 'utf8');
        return { content, contentType };
    } catch (error) {
        return null;
    }
}

// Créer le serveur HTTP
const server = createServer((req, res) => {
    const url = req.url;
    
    console.log(`${new Date().toISOString()} - ${req.method} ${url}`);
    
    // Configuration CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    // Gérer les requêtes OPTIONS (preflight)
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }
    
    // Router simple
    if (url === '/' || url === '/index.html') {
        // Servir la page principale
        const file = serveFile('index.html', 'text/html');
        if (file) {
            res.writeHead(200, { 'Content-Type': file.contentType });
            res.end(file.content);
        } else {
            res.writeHead(404, { 'Content-Type': 'text/html' });
            res.end('<h1>404 - Page non trouvée</h1><p>Fichier index.html manquant</p>');
        }
    }
    else if (url === '/api/health') {
        // Point de santé API
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            status: 'OK',
            message: 'Mireb Commercial Server is running',
            timestamp: new Date().toISOString(),
            account: 'mirebcommercial@gmail.com',
            author: 'Fiacre-19',
            version: '1.0.0'
        }));
    }
    else if (url === '/api/info') {
        // Informations du serveur
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            app: 'Mireb Commercial',
            version: '1.0.0',
            author: 'Fiacre-19',
            email: 'mirebcommercial@gmail.com',
            location: 'Kinshasa, Congo (DRC)',
            features: [
                'E-commerce Platform',
                'AI Product Descriptions',
                'Real-time Analytics',
                'Multi-image Gallery',
                'Visitor Tracking'
            ],
            endpoints: {
                health: '/api/health',
                info: '/api/info',
                home: '/'
            }
        }));
    }
    else if (url.startsWith('/api/')) {
        // Autres endpoints API (placeholder)
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            message: 'API Endpoint',
            url: url,
            note: 'Full API implementation in server.js'
        }));
    }
    else {
        // 404 pour autres routes
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
            error: 'Not Found',
            message: `Route ${url} not found`,
            suggestion: 'Try / for home page or /api/health for API status'
        }));
    }
});

// Démarrer le serveur
server.listen(PORT, HOST, () => {
    console.log('🚀 ===== MIREB COMMERCIAL SERVER =====');
    console.log(`📧 Account: mirebcommercial@gmail.com`);
    console.log(`🔑 Author: Fiacre-19`);
    console.log(`🌍 Location: Kinshasa, Congo (DRC)`);
    console.log(`🌐 Server running on: http://${HOST}:${PORT}`);
    console.log(`📱 Application: http://${HOST}:${PORT}/`);
    console.log(`🔧 API Health: http://${HOST}:${PORT}/api/health`);
    console.log(`📊 API Info: http://${HOST}:${PORT}/api/info`);
    console.log('=====================================');
    console.log('💡 Press Ctrl+C to stop the server');
    console.log('');
});

// Gestion des erreurs
server.on('error', (error) => {
    console.error('❌ Server Error:', error.message);
    
    if (error.code === 'EADDRINUSE') {
        console.log(`⚠️  Port ${PORT} is already in use`);
        console.log('💡 Try a different port or stop the existing server');
    }
});

// Gestion de l'arrêt propre
process.on('SIGTERM', () => {
    console.log('\n🛑 Received SIGTERM, shutting down gracefully...');
    server.close(() => {
        console.log('✅ Server closed successfully');
        process.exit(0);
    });
});

process.on('SIGINT', () => {
    console.log('\n🛑 Received SIGINT (Ctrl+C), shutting down gracefully...');
    server.close(() => {
        console.log('✅ Server closed successfully');
        process.exit(0);
    });
});

export default server;
>>>>>>> a7ebd8c2b3beafbb2fa4c8505a08f5b5880fc7a2
