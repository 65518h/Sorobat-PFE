// src/app/models/transfers/services/transfer.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { catchError, map, tap, switchMap } from 'rxjs/operators';
import { TransferHeader, TransferLine } from '../models/transfer.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Injectable({
  providedIn: 'root'
})
export class TransferService {
  private readonly API_URL = 'http://localhost:5227/api/Transfer';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

  /**
   * Récupère tous les ordres de transfert avec cache offline
   */
  getAll(): Observable<TransferHeader[]> {
    // ✅ Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return this.getFromCacheOffline();
    }
    
    console.log('📡 Appel API GET transfers:', this.API_URL);
    return this.http.get<TransferHeader[]>(this.API_URL).pipe(
      tap(transfers => {
        // Sauvegarder dans le cache
        this.cacheService.saveToCache('transfers-headers', transfers);
        console.log(`💾 ${transfers?.length || 0} transferts sauvegardés dans IndexedDB`);
        
        // Précharger les détails
        if (transfers && transfers.length > 0) {
          setTimeout(() => this.preloadAllDetails(transfers), 1500);
        }
      }),
      catchError(error => {
        console.error('❌ Erreur getTransfers:', error);
        return this.getFromCacheOffline();
      })
    );
  }

  /**
   * Récupère les transferts depuis le cache (mode offline)
   */
  private getFromCacheOffline(): Observable<TransferHeader[]> {
    return from(this.cacheService.getFromCache('transfers-headers')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(`📦 Mode offline - ${cached.length} transfert(s) depuis IndexedDB`);
          return cached;
        }
        console.log('📦 Mode offline - Aucun transfert en cache');
        return [];
      })
    );
  }

  /**
   * Précharge tous les détails des transferts
   */
  preloadAllDetails(transfers: TransferHeader[]): void {
    const idsToLoad = transfers.filter(t => t.id).map(t => t.id as string);
    
    if (idsToLoad.length === 0) return;
    
    console.log(`🔄 Préchargement des détails pour ${idsToLoad.length} transferts...`);
    
    idsToLoad.forEach(id => {
      this.getById(id).subscribe({
        next: () => console.log(`✅ Détail transfert ${id} préchargé`),
        error: (err) => console.warn(`⚠️ Échec préchargement ${id}:`, err)
      });
    });
  }

  /**
   * Récupère un ordre de transfert par son ID avec cache
   */
  getById(id: string): Observable<TransferHeader> {
    // ✅ Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return from(this.cacheService.getFromCache(`transfer-${id}`)).pipe(
        map(cached => {
          if (cached) {
            console.log(`📦 Mode offline - Détail transfert ${id} depuis IndexedDB`);
            return cached;
          }
          throw new Error('Transfert non trouvé en cache');
        })
      );
    }
    
    const url = `${this.API_URL}/${id}`;
    console.log('📡 Appel API GET transfer:', url);
    
    return this.http.get<TransferHeader>(url).pipe(
      tap(transfer => {
        // Sauvegarder dans le cache
        this.cacheService.saveToCache(`transfer-${id}`, transfer);
        console.log(`💾 Transfert ${id} sauvegardé dans IndexedDB`);
      }),
      catchError(error => {
        console.error('❌ Erreur getTransferById:', error);
        // En cas d'erreur, essayer le cache
        return from(this.cacheService.getFromCache(`transfer-${id}`)).pipe(
          map(cached => {
            if (cached) {
              console.log(`⚠️ Utilisation cache pour ${id}`);
              return cached;
            }
            throw error;
          })
        );
      })
    );
  }

  /**
   * Crée un nouvel ordre de transfert
   */
  create(transfer: Partial<TransferHeader>): Observable<TransferHeader> {
    console.log('📡 Appel API POST transfer:', this.API_URL, transfer);
    this.clearCache();
    return this.http.post<TransferHeader>(this.API_URL, transfer).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur createTransfer:', error);
        throw error;
      })
    );
  }

  /**
   * Met à jour un ordre de transfert
   */
  update(id: string, transfer: Partial<TransferHeader>): Observable<void> {
    const url = `${this.API_URL}/${id}`;
    console.log('📡 Appel API PUT transfer:', url, transfer);
    this.clearCache();
    return this.http.put<void>(url, transfer).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur updateTransfer:', error);
        throw error;
      })
    );
  }

  /**
   * Supprime un ordre de transfert
   */
  delete(id: string): Observable<void> {
    const url = `${this.API_URL}/${id}`;
    console.log('📡 Appel API DELETE transfer:', url);
    this.clearCache();
    return this.http.delete<void>(url).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur deleteTransfer:', error);
        throw error;
      })
    );
  }

  /**
   * Met à jour la quantité reçue d'une ligne de transfert
   */
  updateLineQuantity(id: string, quantityReceived: number): Observable<void> {
    const url = `${this.API_URL}/lines/${id}`;
    console.log('📡 Appel API PATCH transfer line:', url, { quantityReceived });
    this.clearCache();
    return this.http.patch<void>(url, { quantityReceived }).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur updateLineQuantity:', error);
        throw error;
      })
    );
  }

  /**
   * Valide la réception complète d'un ordre de transfert
   */
  receiveTransfer(id: string): Observable<void> {
    const url = `${this.API_URL}/${id}/receive`;
    console.log('📡 Appel API POST receive transfer:', url);
    this.clearCache();
    return this.http.post<void>(url, {}).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur receiveTransfer:', error);
        throw error;
      })
    );
  }

  /**
   * Expédie un ordre de transfert (change status de Open à Released)
   */
  releaseTransfer(id: string): Observable<void> {
    const url = `${this.API_URL}/${id}/release`;
    console.log('📡 Appel API POST release transfer:', url);
    this.clearCache();
    return this.http.post<void>(url, {}).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error('❌ Erreur releaseTransfer:', error);
        throw error;
      })
    );
  }

  /**
   * Vide tous les caches
   */
  clearCache(): void {
    console.log('🗑️ Cache transfers vidé');
    this.cacheService.invalidateCache('transfers-headers');
  }
}