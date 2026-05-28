// src/app/core/database/offline-db.ts

import Dexie, { Table } from 'dexie';

// Types pour les documents offline
export interface OfflinePointage {
  id?: string;
  type: 'pointage';
  data: any;
  syncStatus: 'pending' | 'syncing' | 'synced' | 'error';
  createdAt: Date;
  errorMessage?: string;
  documentNo?: string;
  updatedAt?: Date;
}

export interface OfflineGasoil {
  id?: string;
  type: 'gasoil';
  data: any;
  syncStatus: 'pending' | 'syncing' | 'synced' | 'error';
  createdAt: Date;
  errorMessage?: string;
  documentNo?: string;
  updatedAt?: Date;
}

export interface OfflinePurchaseRequest {
  id?: string;
  type: 'purchase';
  data: any;
  syncStatus: 'pending' | 'syncing' | 'synced' | 'error';
  createdAt: Date;
  errorMessage?: string;
  documentNo?: string;
  updatedAt?: Date;
}

export interface OfflineAttendance {
  id?: string;
  type: 'attendance';
  data: any;
  syncStatus: 'pending' | 'syncing' | 'synced' | 'error';
  createdAt: Date;
  errorMessage?: string;
  documentNo?: string;
  updatedAt?: Date;
}

// Interface pour le cache
export interface CacheItem {
  key: string;
  data: any;
  timestamp: number;
  expiresIn: number;
}

// Base de données
export class OfflineDatabase extends Dexie {
  pointages!: Table<OfflinePointage>;
  gasoil!: Table<OfflineGasoil>;
  purchases!: Table<OfflinePurchaseRequest>;
  attendances!: Table<OfflineAttendance>;
  cache!: Table<CacheItem>;  

  constructor() {
    super('SoroubatOfflineDB');
    
    // Version 2 avec table cache
    this.version(2).stores({
      pointages: '++id, syncStatus, createdAt',
      gasoil: '++id, syncStatus, createdAt',
      purchases: '++id, syncStatus, createdAt',
      attendances: '++id, syncStatus, createdAt',
      cache: 'key, timestamp'  
    });
  }
}

export const db = new OfflineDatabase();