import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

interface ApiStatus {
  message: string;
  status: string;
  timestamp: string;
}

function App() {
  const [apiStatus, setApiStatus] = useState<ApiStatus | null>(null);
  const [products, setProducts] = useState<any[]>([]);

  useEffect(() => {
    // Vérifier le statut de l'API
    fetchApiStatus();
    fetchProducts();
  }, []);

  const fetchApiStatus = async () => {
    try {
      const response = await axios.get('/');
      setApiStatus(response.data);
    } catch (error) {
      console.error('Erreur API:', error);
    }
  };

  const fetchProducts = async () => {
    try {
      const response = await axios.get('/api/products');
      setProducts(response.data.products || []);
    } catch (error) {
      console.error('Erreur produits:', error);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <h1 className="text-2xl font-bold text-gray-900">
              🛒 Mireb Commercial
            </h1>
            <nav className="space-x-4">
              <a href="#" className="text-gray-600 hover:text-gray-900">Accueil</a>
              <a href="#" className="text-gray-600 hover:text-gray-900">Produits</a>
              <a href="#" className="text-gray-600 hover:text-gray-900">Panier</a>
            </nav>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-8 px-4">
        {/* Status API */}
        <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6">
          <div className="flex items-center">
            <span className="text-green-500 mr-2">✅</span>
            <div>
              <strong>Application e-commerce fonctionnelle !</strong>
              {apiStatus && (
                <p className="text-sm">
                  API Status: {apiStatus.status} - {new Date(apiStatus.timestamp).toLocaleString()}
                </p>
              )}
            </div>
          </div>
        </div>

        {/* Hero Section */}
        <div className="text-center py-12">
          <h2 className="text-4xl font-bold text-gray-900 mb-4">
            Bienvenue sur Mireb Commercial
          </h2>
          <p className="text-xl text-gray-600 mb-8">
            Votre marketplace e-commerce moderne avec React + Node.js
          </p>
          <div className="space-x-4">
            <button className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
              Voir les produits
            </button>
            <button className="bg-gray-200 text-gray-800 px-6 py-3 rounded-lg hover:bg-gray-300">
              En savoir plus
            </button>
          </div>
        </div>

        {/* Features */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-12">
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-blue-600 text-2xl mb-3">⚛️</div>
            <h3 className="text-lg font-semibold mb-2">Frontend React</h3>
            <p className="text-gray-600">Interface utilisateur moderne avec TypeScript</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-green-600 text-2xl mb-3">🔧</div>
            <h3 className="text-lg font-semibold mb-2">Backend Node.js</h3>
            <p className="text-gray-600">API RESTful avec Express et MongoDB</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md">
            <div className="text-purple-600 text-2xl mb-3">🚀</div>
            <h3 className="text-lg font-semibold mb-2">Déployé sur Vercel</h3>
            <p className="text-gray-600">Application en ligne et accessible</p>
          </div>
        </div>

        {/* Products Section */}
        <div className="mt-12">
          <h3 className="text-2xl font-bold text-gray-900 mb-6">Produits disponibles</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {products.length > 0 ? (
              products.map((product, index) => (
                <div key={index} className="bg-white p-6 rounded-lg shadow-md">
                  <h4 className="font-semibold text-lg">{product.name || 'Produit'}</h4>
                  <p className="text-gray-600">{product.description || 'Description du produit'}</p>
                  <p className="text-blue-600 font-bold mt-2">{product.price || 'Prix à définir'}</p>
                </div>
              ))
            ) : (
              <div className="col-span-full bg-white p-8 rounded-lg shadow-md text-center">
                <p className="text-gray-600">Catalogue de produits en cours de configuration...</p>
                <p className="text-sm text-gray-500 mt-2">L'API produits est prête à recevoir votre catalogue !</p>
              </div>
            )}
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="bg-gray-800 text-white py-8 mt-12">
        <div className="max-w-7xl mx-auto px-4 text-center">
          <p>&copy; 2025 Mireb Commercial. Application e-commerce développée avec React + Node.js</p>
        </div>
      </footer>
    </div>
  );
}

export default App;
