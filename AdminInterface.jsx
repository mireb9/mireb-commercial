import React, { useState } from 'react';
import { CATEGORIES } from '../data/products';

function AdminInterface({ produits, setProduits, onLogout }) {
  const [nom, setNom] = useState("");
  const [prix, setPrix] = useState("");
  const [stock, setStock] = useState("");
  const [categorie, setCategorie] = useState(CATEGORIES[0]);
  const [images, setImages] = useState("");
  const [description, setDescription] = useState("");

  const handleAdd = () => {
    const newP = {
      id: Date.now(),
      nom,
      prix: Number(prix),
      stock: Number(stock),
      categorie,
      images: images.split(",").map(i => i.trim()).filter(i => i) || ["https://via.placeholder.com/600x400?text=No+Image"],
      description
    };
    setProduits([...produits, newP]);
    /* reset */
    setNom(""); setPrix(""); setStock(""); setImages(""); setDescription("");
  };

  const handleDelete = id => setProduits(produits.filter(p => p.id !== id));

  return (
    <div className="min-h-screen bg-gray-100">
      <header className="bg-red-600 text-white p-4 flex justify-between items-center">
        <h1 className="text-xl font-bold">Admin Mireb</h1>
        <button onClick={onLogout} className="bg-white text-red-600 px-3 py-1 rounded">Déconnexion</button>
      </header>

      <div className="p-4 grid gap-6">
        {/* Ajouter produit */}
        <div className="bg-white p-4 rounded shadow">
          <h2 className="text-lg font-bold mb-3">Ajouter / Modifier produit</h2>
          <div className="grid md:grid-cols-2 gap-3 text-sm">
            <input placeholder="Nom du produit" value={nom} onChange={e => setNom(e.target.value)} className="border px-2 py-1 rounded"/>
            <input type="number" placeholder="Prix" value={prix} onChange={e => setPrix(e.target.value)} className="border px-2 py-1 rounded"/>
            <input type="number" placeholder="Stock" value={stock} onChange={e => setStock(e.target.value)} className="border px-2 py-1 rounded"/>
            <select value={categorie} onChange={e => setCategorie(e.target.value)} className="border px-2 py-1 rounded">
              {CATEGORIES.map(c => <option key={c}>{c}</option>)}
            </select>
            <textarea placeholder="URLs images (séparées par virgule)" value={images} onChange={e => setImages(e.target.value)} className="border px-2 py-1 rounded md:col-span-2" rows="2"/>
            <textarea placeholder="Description (HTML autorisé)" value={description} onChange={e => setDescription(e.target.value)} className="border px-2 py-1 rounded md:col-span-2" rows="3"/>
          </div>
          <button onClick={handleAdd} className="mt-3 bg-orange-600 text-white px-4 py-1 rounded">Ajouter</button>
        </div>

        {/* Liste */}
        <div className="bg-white p-4 rounded shadow">
          <h2 className="text-lg font-bold mb-3">Produits existants</h2>
          <div className="overflow-auto">
            <table className="w-full text-sm">
              <thead><tr className="border-b"><th>Nom</th><th>Prix</th><th>Stock</th><th></th></tr></thead>
              <tbody>
                {produits.map(p => (
                  <tr key={p.id} className="border-b">
                    <td className="p-1">{p.nom}</td>
                    <td className="p-1">{p.prix}</td>
                    <td className="p-1">{p.stock}</td>
                    <td className="p-1">
                      <button onClick={() => handleDelete(p.id)} className="bg-red-500 text-white px-2 py-0.5 rounded">Suppr</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

export default AdminInterface;