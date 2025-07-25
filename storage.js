export const storageKey = "mirebProduits";

export function loadProduits() {
  return JSON.parse(localStorage.getItem(storageKey)) || [];
}

export function saveProduits(list) {
  localStorage.setItem(storageKey, JSON.stringify(list));
}