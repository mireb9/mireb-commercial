import React, { useState } from 'react';

function LoginPage({ onLogin, onClose }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white p-5 rounded w-80">
        <h2 className="text-lg font-bold mb-3">Connexion</h2>
        <input
          type="email"
          placeholder="Email"
          className="w-full mb-2 border px-2 py-1.5 rounded"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />
        <input
          type="password"
          placeholder="Mot de passe"
          className="w-full mb-3 border px-2 py-1.5 rounded"
          value={password}
          onChange={e => setPassword(e.target.value)}
        />
        <button
          onClick={() => onLogin(email, password)}
          className="w-full bg-orange-600 text-white py-2 rounded mb-2"
        >
          Se connecter
        </button>
        <button onClick={onClose} className="text-sm text-gray-500">Annuler</button>
      </div>
    </div>
  );
}

export default LoginPage;