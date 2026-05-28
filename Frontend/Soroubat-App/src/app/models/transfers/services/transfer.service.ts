// src/app/models/transfers/services/transfer.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { catchError, map, tap, switchMap } from 'rxjs/operators';
import { TransferHeader, TransferLine } from '../models/transfer.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

export interface TransferHeaderPatchDto {
  receiptDate?: string | null;
}

export interface TransferLinePatchDto {
  qtyToReceive?: number;
  numVehicule?: string;
}

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

  getAll(): Observable<TransferHeader[]> {
    if (!this.offlineSync.isOnline) {
      return this.getFromCacheOffline();
    }
    
    console.log('📡 Appel API GET transfers:', this.API_URL);
    return this.http.get<TransferHeader[]>(this.API_URL).pipe(
      tap(transfers => {
        this.cacheService.saveToCache('transfers-headers', transfers);
        console.log(` ${transfers?.length || 0} transferts sauvegardés`);
      }),
      catchError(error => {
        console.error(' Erreur getTransfers:', error);
        return this.getFromCacheOffline();
      })
    );
  }

  private getFromCacheOffline(): Observable<TransferHeader[]> {
    return from(this.cacheService.getFromCache('transfers-headers')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(` Mode offline - ${cached.length} transfert(s) depuis IndexedDB`);
          return cached;
        }
        return [];
      })
    );
  }

  getById(id: string): Observable<TransferHeader> {
    const url = `${this.API_URL}/${id}`;
    console.log(' Appel API GET transfer:', url);
    
    return this.http.get<TransferHeader>(url).pipe(
      catchError(error => {
        console.error(' Erreur getById:', error);
        throw error;
      })
    );
  }

  create(transfer: Partial<TransferHeader>): Observable<TransferHeader> {
    console.log(' Appel API POST transfer:', this.API_URL, transfer);
    this.clearCache();
    return this.http.post<TransferHeader>(this.API_URL, transfer).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur createTransfer:', error);
        throw error;
      })
    );
  }

  update(id: string, transfer: Partial<TransferHeader>): Observable<void> {
    const url = `${this.API_URL}/${id}`;
    console.log(' Appel API PUT transfer:', url, transfer);
    this.clearCache();
    return this.http.put<void>(url, transfer).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur updateTransfer:', error);
        throw error;
      })
    );
  }

  delete(id: string): Observable<void> {
    const url = `${this.API_URL}/${id}`;
    console.log(' Appel API DELETE transfer:', url);
    this.clearCache();
    return this.http.delete<void>(url).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur deleteTransfer:', error);
        throw error;
      })
    );
  }

  updateLineQuantity(id: string, quantityReceived: number, receptionDate: string): Observable<void> {
    const url = `${this.API_URL}/lines/${id}`;
    console.log(' Appel API PATCH transfer line:', url, { quantityReceived });
    this.clearCache();
    return this.http.patch<void>(url, { quantityReceived }).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur updateLineQuantity:', error);
        throw error;
      })
    );
  }

  receiveTransfer(id: string, receptionDate: string): Observable<void> {
    const url = `${this.API_URL}/${id}/receive`;
    console.log(' Appel API POST receive transfer:', url);
    this.clearCache();
    return this.http.post<void>(url, {}).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur receiveTransfer:', error);
        throw error;
      })
    );
  }

  releaseTransfer(id: string): Observable<void> {
    const url = `${this.API_URL}/${id}/release`;
    console.log(' Appel API POST release transfer:', url);
    this.clearCache();
    return this.http.post<void>(url, {}).pipe(
      tap(() => this.clearCache()),
      catchError(error => {
        console.error(' Erreur releaseTransfer:', error);
        throw error;
      })
    );
  }

  clearCache(): void {
    console.log(' Cache transfers vidé');
    this.cacheService.invalidateCache('transfers-headers');
  }

  updateLineQtyToReceive(id: string, qtyToReceive: number): Observable<void> {
    const url = `${this.API_URL}/lines/${id}`;
    const patchDto: TransferLinePatchDto = { qtyToReceive };
    console.log(' Appel API PATCH transfer line:', url, patchDto);
    this.clearCache();
    return this.http.patch<void>(url, patchDto).pipe(
      tap(() => {
        this.clearCache();
        console.log(` Quantité à recevoir ${qtyToReceive} enregistrée`);
      }),
      catchError(error => {
        console.error(' Erreur updateLineQtyToReceive:', error);
        throw error;
      })
    );
  }

  /**
   * Met à jour la date de réception d'un transfert
   * @param transferId - ID du transfert
   * @param receiptDate - Date de réception
   */
  updateReceiptDate(transferId: string, receiptDate: Date): Observable<void> {
    const url = `${this.API_URL}/${transferId}`;
    
    // Formater la date au format YYYY-MM-DD (attendu par Business Central)
    const formattedDate = this.formatDateForBC(receiptDate);
    
    const patchDto: TransferHeaderPatchDto = {
      receiptDate: formattedDate
    };
    
    console.log(' Appel API PATCH transfer (receiptDate):', url);
    console.log(' Body:', patchDto);
    
    this.clearCache();
    return this.http.patch<void>(url, patchDto).pipe(
      tap(() => {
        this.clearCache();
        console.log(` Date de réception mise à jour: ${formattedDate}`);
      }),
      catchError(error => {
        console.error(' Erreur updateReceiptDate:', error);
        if (error.error) {
          console.error(' Détail erreur backend:', error.error);
        }
        throw error;
      })
    );
  }

  /**
   * Formate une date pour Business Central
   * Format attendu: YYYY-MM-DD
   */
  private formatDateForBC(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
}