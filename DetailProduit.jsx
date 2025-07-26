import React, { useState } from 'react';

function DetailProduit({ produit, onBack }) {
  const [currentImg, setCurrentImg] = useState(0);
  const [form, setForm] = useState({ nom: "", tel: "", message: "" });
  const [sent, setSent] = useState(false);

  const handleSubmit = e => {
    e.preventDefault();
    console.log("NOUVEAU LEAD :", { produit: produit.nom, ...form });
    setSent(true);
    setTimeout(() => setSent(false), 3000);
  };

  return (
    <div className="min-h-screen bg-white">
      <header className="bg-orange-600 text-white p-3 flex items-center">
        <button onClick={onBack} className="mr-3">
          <i className="fas fa-arrow-left text-xl"></i>
        </button>
        <h1 className="text-lg font-bold truncate">{produit.nom}</h1>
      </header>

      <div className="relative">
        <img src={produit.images[currentImg]} alt={produit.nom} className="w-full h-64 object-cover"/>
        {produit.images.length > 1 && (
          <div className="absolute bottom-2 left-0 right-0 flex justify-center space-x-2">
            {produit.images.map((_, idx) => (
              <button
                key={idx}
                className={`w-2.5 h-2.5 rounded-full ${idx === currentImg ? 'bg-white' : 'bg-white bg-opacity-50'}`}
                onClick={() => setCurrentImg(idx)}
              />
            ))}
          </div>
        )}
      </div>

      <div className="p-4">
        <h2 className="text-2xl font-bold text-orange-600">${produit.prix}</h2>
        <p className="text-sm text-gray-500 mb-2">Stock : {produit.stock}</p>
        <div className="mb-4 prose prose-sm" dangerouslySetInnerHTML={{ __html: produit.description }}/>

        <h3 className="font-bold mb-2">Intéressé ? Contactez-nous</h3>
        {sent && <p className="text-green-600 mb-2">Demande envoyée !</p>}
        <form onSubmit={handleSubmit} className="space-y-3">
          <input type="text" placeholder="Votre nom"
            required className="w-full border rounded px-3 py-2"
            value={form.nom} onChange={e => setForm({...form, nom: e.target.value})} />
          <input type="tel" placeholder="Numéro WhatsApp"
            required className="w-full border rounded px-3 py-2"
            value={form.tel} onChange={e => setForm({...form, tel: e.target.value})} />
          <textarea placeholder="Mon message..."
            rows="3" className="w-full border rounded px-3 py-2"
            value={form.message} onChange={e => setForm({...form, message: e.target.value})} />
          <button type="submit" className="w-full bg-orange-600 text-white py-2 rounded">
            Envoyer
          </button>
        </form>
      </div>
    </div>
  );
}

export default DetailProduit;