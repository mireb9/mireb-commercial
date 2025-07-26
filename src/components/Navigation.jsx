import React from 'react';
import { useHistory } from 'react-router-dom';

const Navigation = () => {
  const history = useHistory();

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 flex justify-around py-1.5">
      <button onClick={() => history.push('/')} className="flex flex-col items-center text-orange-600">
        <i className="fas fa-home text-xl"></i>
        <span className="text-xs">Accueil</span>
      </button>
      <button onClick={() => history.push('/categories')} className="flex flex-col items-center text-gray-400">
        <i className="fas fa-th-large text-xl"></i>
        <span className="text-xs">Catégories</span>
      </button>
      <button onClick={() => history.push('/panier')} className="flex flex-col items-center text-gray-400">
        <i className="fas fa-shopping-cart text-xl"></i>
        <span className="text-xs">Panier</span>
      </button>
      <button onClick={() => history.push('/compte')} className="flex flex-col items-center text-gray-400">
        <i className="fas fa-user text-xl"></i>
        <span className="text-xs">Compte</span>
      </button>
    </nav>
  );
};

export default Navigation;