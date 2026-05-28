// src/app/models/inventory/models/stock.model.ts

export interface StockItem {
  itemNo: string;           // Code article
  itemDescription: string;  // Description
  locationCode: string;     // Code magasin
  locationName?: string;    // Nom magasin (optionnel)
  quantity: number;         // Quantité
  jobNo: string;            // Numéro de projet/chantier
  lastPostingDate?: string | null;  // Date dernier mouvement (ISO)
}

export interface StockFilter {
  searchTerm?: string;
  locationCode?: string;
  jobNo?: string;
  minQuantity?: number;
  maxQuantity?: number;
}

export interface StockStats {
  totalItems: number;
  totalQuantity: number;
  uniqueLocations: number;
  uniqueJobs: number;
  lowStockCount: number;
  outOfStockCount: number;
}