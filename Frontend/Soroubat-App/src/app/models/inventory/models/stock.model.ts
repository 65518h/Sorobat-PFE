// src/app/models/inventory/models/stock.model.ts

export interface StockItem {
  lastPostingDate: null;
  itemNo: string;
  itemDescription: string;
  locationCode: string;
  quantity: number;
  jobNo: string;
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
  totalValue?: number;
}

export interface StockMovement {
  id: string;
  itemNo: string;
  itemDescription: string;
  fromLocation: string;
  toLocation: string;
  quantity: number;
  movementDate: Date;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'COMPLETED';
  requestedBy: string;
  approvedBy?: string;
}