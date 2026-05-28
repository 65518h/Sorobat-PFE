// src/app/modules/inventory/services/stock.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { map, catchError, tap, switchMap } from 'rxjs/operators';
import { StockItem, StockFilter, StockStats } from '../models/stock.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Injectable({
  providedIn: 'root'
})
export class StockService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:5227/api/Stock/my-stock';

  constructor(
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

  /**
   * Récupère tous les stocks avec cache offline
   * @param forceRefresh - Si true, ignore le cache et force un appel API
   */
  getAllStock(forceRefresh: boolean = false): Observable<StockItem[]> {
    // Si forceRefresh est true, ignorer complètement le cache
    if (forceRefresh) {
      console.log(' Force refresh du stock - Ignorant le cache');
      return this.fetchFromApi().pipe(
        tap(items => {
          this.cacheService.saveToCache('stock-all', items);
          console.log(` Cache mis à jour avec ${items.length} articles`);
        })
      );
    }
    
    // Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return this.getFromCacheOffline();
    }
    
    // Vérifier le cache d'abord
    return from(this.cacheService.getFromCache('stock-all')).pipe(
      switchMap(cached => {
        if (cached && cached.length > 0) {
          console.log(` Utilisation du cache - ${cached.length} articles`);
          return of(cached);
        }
        // Pas de cache, appeler l'API
        console.log(' Pas de cache - Appel API GET /api/Stock/my-stock');
        return this.fetchFromApi().pipe(
          tap(items => {
            this.cacheService.saveToCache('stock-all', items);
          })
        );
      })
    );
  }

  /**
   * Appel API pour récupérer le stock
   */
  private fetchFromApi(): Observable<StockItem[]> {
    console.log(' Appel API GET /api/Stock/my-stock');
    return this.http.get<StockItem[]>(this.apiUrl).pipe(
      map(items => {
        if (!items) return [];
        return items.sort((a, b) => a.itemNo.localeCompare(b.itemNo));
      }),
      tap(items => {
        console.log(` ${items.length} articles de stock récupérés depuis l'API`);
      }),
      catchError(error => {
        console.error(' Erreur getAllStock:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère les stocks depuis le cache (mode offline)
   */
  private getFromCacheOffline(): Observable<StockItem[]> {
    return from(this.cacheService.getFromCache('stock-all')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(` Mode offline - ${cached.length} article(s) de stock depuis IndexedDB`);
          return cached;
        }
        console.log(' Mode offline - Aucune donnée de stock en cache');
        return [];
      })
    );
  }

  /**
   * Récupère le stock avec filtres
   */
  getFilteredStock(filters?: StockFilter): Observable<StockItem[]> {
    // Si mode offline, filtrer depuis le cache
    if (!this.offlineSync.isOnline) {
      return this.getFromCacheOffline().pipe(
        map(items => this.applyFiltersToItems(items, filters))
      );
    }
    
    let params = new HttpParams();
    
    if (filters) {
      if (filters.searchTerm) params = params.set('searchTerm', filters.searchTerm);
      if (filters.locationCode) params = params.set('locationCode', filters.locationCode);
      if (filters.jobNo) params = params.set('jobNo', filters.jobNo);
      if (filters.minQuantity !== undefined) params = params.set('minQuantity', filters.minQuantity.toString());
      if (filters.maxQuantity !== undefined) params = params.set('maxQuantity', filters.maxQuantity.toString());
    }
    
    console.log(' Appel API GET /api/Stock/my-stock avec filtres:', params.toString());
    
    return this.http.get<StockItem[]>(this.apiUrl, { params }).pipe(
      map(items => items || []),
      catchError(error => {
        console.error(' Erreur getFilteredStock:', error);
        return this.getFromCacheOffline().pipe(
          map(items => this.applyFiltersToItems(items, filters))
        );
      })
    );
  }

  /**
   * Applique les filtres aux données en cache (mode offline)
   */
  private applyFiltersToItems(items: StockItem[], filters?: StockFilter): StockItem[] {
    if (!filters) return items;
    
    let filtered = [...items];
    
    if (filters.searchTerm && filters.searchTerm.trim()) {
      const term = filters.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(item => 
        item.itemNo?.toLowerCase().includes(term) || 
        item.itemDescription?.toLowerCase().includes(term)
      );
    }
    
    if (filters.locationCode && filters.locationCode !== 'all') {
      filtered = filtered.filter(item => item.locationCode === filters.locationCode);
    }
    
    if (filters.jobNo) {
      filtered = filtered.filter(item => item.jobNo === filters.jobNo);
    }
    
    if (filters.minQuantity !== undefined) {
      filtered = filtered.filter(item => item.quantity >= filters.minQuantity!);
    }
    
    if (filters.maxQuantity !== undefined) {
      filtered = filtered.filter(item => item.quantity <= filters.maxQuantity!);
    }
    
    return filtered;
  }

  /**
   * Récupère le stock par magasin
   */
  getStockByLocation(locationCode: string): Observable<StockItem[]> {
    return this.getFilteredStock({ locationCode });
  }

  /**
   * Récupère le stock par chantier/projet
   */
  getStockByJob(jobNo: string): Observable<StockItem[]> {
    return this.getFilteredStock({ jobNo });
  }

  /**
   * Récupère le stock par article
   */
  getStockByItem(itemNo: string): Observable<StockItem[]> {
    return this.getFilteredStock({ searchTerm: itemNo });
  }

  /**
   * Récupère les articles en stock faible
   */
  getLowStock(threshold: number = 10): Observable<StockItem[]> {
    return this.getAllStock().pipe(
      map(items => items.filter(item => item.quantity > 0 && item.quantity <= threshold))
    );
  }

  /**
   * Récupère les articles en rupture de stock
   */
  getOutOfStock(): Observable<StockItem[]> {
    return this.getAllStock().pipe(
      map(items => items.filter(item => item.quantity <= 0))
    );
  }

  /**
   * Récupère les statistiques du stock
   */
  getStockStats(): Observable<StockStats> {
    return this.getAllStock().pipe(
      map(items => {
        const uniqueLocations = new Set(items.map(i => i.locationCode));
        const uniqueJobs = new Set(items.map(i => i.jobNo)) ;
        const totalQuantity = items.reduce((sum, i) => sum + (i.quantity || 0), 0);
        const lowStockCount = items.filter(i => i.quantity > 0 && i.quantity <= 10).length;
        const outOfStockCount = items.filter(i => i.quantity <= 0).length;
        
        return {
          totalItems: items.length,
          totalQuantity: totalQuantity,
          uniqueLocations: uniqueLocations.size,
          uniqueJobs: uniqueJobs.size,
          lowStockCount: lowStockCount,
          outOfStockCount: outOfStockCount
        };
      })
    );
  }

  /**
   * Vide le cache
   */
  clearCache(): void {
    console.log(' Cache stock vidé');
    this.cacheService.invalidateCache('stock-all');
  }
}