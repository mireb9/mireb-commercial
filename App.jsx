import React, { useState, useEffect } from 'react';
import { loadProduits, saveProduits } from './utils/storage';
import AdminInterface from './components/AdminInterface';
import DetailProduit from './components/DetailProduit';
import LoginPage from './components/LoginPage';
import Navigation from './components/Navigation';

const CATEGORIES = [
  "Électronique", "Mode", "Maison & Jardin", "Automobile",
  "Santé & Beauté", "Sports & Loisirs", "Industrie & BTP"
];

function App() {
  const [user, setUser] = useState(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [showLogin, setShowLogin] = useState(false);
  const [screen, setScreen] = useState("home");
  const [produitActif, setProduitActif] = useState(null);
  const [produits, setProduits] = useState(loadProduits());

  const handleLogin = (email, password) => {
    if (email === "mirebshop@gmail.com" && password === "Fiacre-19") {
      setUser({ email, name: "Admin" });
      setIsAdmin(true);
      setShowLogin(false);
      setScreen("admin");
    } else if (email && password) {
      setUser({ email, name: email.split("@")[0] });
      setIsAdmin(false);
      setShowLogin(false);
    }
  };

  const handleLogout = () => {
    setUser(null);
    setIsAdmin(false);
    setScreen("home");
  };

  useEffect(() => saveProduits(produits), [produits]);

  if (showLogin) {
    return <LoginPage onLogin={handleLogin} onClose={() => setShowLogin(false)} />;
  }

  if (screen === "admin") {
    return <AdminInterface produits={produits} setProduits={setProduits} onLogout={handleLogout} />;
  }

  if (screen === "detail" && produitActif) {
    return <DetailProduit produit={produitActif} onBack={() => setScreen("home")} />;
  }

  return (
    <div className="min-h-screen pb-16">
      <Navigation setShowLogin={setShowLogin} setScreen={setScreen} />
      <div className="pt-16">
        {/* Render products here */}
      </div>
    </div>
  );
}

export default App;