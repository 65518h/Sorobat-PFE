// src/app/core/services/cache.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, from, of } from 'rxjs';
import { map, catchError, switchMap } from 'rxjs/operators';
import { db, CacheItem } from '../database/offline-db';

@Injectable({ providedIn: 'root' })
export class CacheService {
  private cacheDuration = 86400000; // 24 heures
  
  constructor(private http: HttpClient) {}
  
  /**
   * Récupère ou charge des données avec cache
   */
  getOrFetch<T>(key: string, apiUrl: string, forceRefresh = false): Observable<T> {
    return from(this.getFromCache(key)).pipe(
      switchMap(cached => {
        if (cached && !forceRefresh) {
          console.log(` Cache hit pour ${key}`);
          return of(cached);
        }
        
        console.log(` Fetch API pour ${key}`);
        return this.http.get<T>(apiUrl).pipe(
          map(data => {
            this.saveToCache(key, data);
            return data;
          }),
          catchError(error => {
            console.error(` Erreur chargement ${key}:`, error);
            // En cas d'erreur, essayer de retourner le cache même expiré
            if (cached) {
              console.log(` Utilisation cache expiré pour ${key}`);
              return of(cached);
            }
            throw error;
          })
        );
      })
    );
  }
  
  /**
   * Sauvegarde des données en cache
   */
  async saveToCache(key: string, data: any): Promise<void> {
    try {
      await db.cache.put({
        key,
        data,
        timestamp: Date.now(),
        expiresIn: this.cacheDuration
      });

    } catch (error) {
      console.error(` Erreur sauvegarde cache ${key}:`, error);
    }
  }
  
  /**
   * Récupère des données du cache
   */
  async getFromCache(key: string): Promise<any> {
    try {
      const cached = await db.cache.where('key').equals(key).first();
      if (cached && Date.now() - cached.timestamp < cached.expiresIn) {
        console.log(` Cache lu: ${key}`);
        return cached.data;
      }
      return null;
    } catch (error) {
      console.error(` Erreur lecture cache ${key}:`, error);
      return null;
    }
  }
  
  /**
   * Récupère des données du cache sans vérification d'expiration (fallback)
   */
  async getFromCacheExpired(key: string): Promise<any> {
    try {
      const cached = await db.cache.where('key').equals(key).first();
      if (cached) {
        console.log(` Cache (expiré) lu: ${key}`);
        return cached.data;
      }
      return null;
    } catch (error) {
      console.error(` Erreur lecture cache ${key}:`, error);
      return null;
    }
  }
  
  /**
   * Vide tout le cache
   */
  async clearCache(): Promise<void> {
    try {
      await db.cache.clear();
      console.log(' Cache vidé');
    } catch (error) {
      console.error(' Erreur vidage cache:', error);
    }
  }
  
  /**
   * Supprime une entrée spécifique du cache
   */
  async invalidateCache(key: string): Promise<void> {
    try {
      await db.cache.where('key').equals(key).delete();
      console.log(` Cache invalidé: ${key}`);
    } catch (error) {
      console.error(` Erreur invalidation cache ${key}:`, error);
    }
  }
  
  /**
   * Sauvegarde une liste de demandes d'achat en cache
   */
  async savePurchaseRequests(requests: any[]): Promise<void> {
    await this.saveToCache('purchase-requests', requests);
  }
  
  /**
   * Récupère les demandes d'achat du cache
   */
  async getPurchaseRequests(): Promise<any[] | null> {
    return await this.getFromCache('purchase-requests');
  }
  
  /**
   * Sauvegarde une demande d'achat individuelle en cache
   */
  async savePurchaseRequest(id: string, request: any): Promise<void> {
    await this.saveToCache(`purchase-request-${id}`, request);
  }
  
  /**
   * Récupère une demande d'achat individuelle du cache
   */
  async getPurchaseRequest(id: string): Promise<any | null> {
    return await this.getFromCache(`purchase-request-${id}`);
  }
  
  /**
   * Invalide le cache des demandes d'achat
   */
  async invalidatePurchaseRequests(): Promise<void> {
    await this.invalidateCache('purchase-requests');
  }
}