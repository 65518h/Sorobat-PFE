// src/app/modules/gasoil/services/gasoil.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from, BehaviorSubject } from 'rxjs';
import { catchError, tap, finalize, map } from 'rxjs/operators';
import { GasoilHeader, GasoilLine, GasoilStats } from '../models/gasoil.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Injectable({
  providedIn: 'root'
})
export class GasoilService {
  private http = inject(HttpClient);
  
  // ✅ CORRECTION: Utiliser la nouvelle route du backend
  private readonly API_BASE = 'http://localhost:5227/api/Gasoil';
  
  // Routes spécifiques
  private readonly HEADERS_URL = `${this.API_BASE}/headers`;
  private readonly LINES_URL = `${this.API_BASE}/lines`;  // Nouvelle route pour les lignes
  
  private headersCache = new Map<string, GasoilHeader>();
  private headersList: GasoilHeader[] = [];
  private isLoadingList = false;
  private isLoadingDetails = false;
  private preloadStarted = false;
  private headersSubject = new BehaviorSubject<GasoilHeader[]>([]);
  public headers$ = this.headersSubject.asObservable();

  constructor(
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

  /**
   * Récupère toutes les fiches gasoil avec cache IndexedDB
   */
  getAll(forceRefresh: boolean = false): Observable<GasoilHeader[]> {
    if (!this.offlineSync.isOnline && !forceRefresh) {
      return this.getFromIndexedDB();
    }
    
    if (this.headersList.length > 0 && !forceRefresh) {
      return of([...this.headersList]);
    }
    
    if (this.isLoadingList) return this.headers$;
    
    console.log('📡 Appel API GET gasoil headers:', this.HEADERS_URL);
    this.isLoadingList = true;
    
    return this.http.get<GasoilHeader[]>(this.HEADERS_URL).pipe(
      tap(headers => {
        this.headersList = [];
        this.headersCache.clear();
        
        headers?.forEach(header => {
          if (header.id) {
            this.headersCache.set(header.id, { ...header, gasoilLines: [] });
            this.headersList.push({ ...header, gasoilLines: [] });
          }
        });
        
        this.headersSubject.next([...this.headersList]);
        
        this.cacheService.saveToCache('gasoil-headers', this.headersList);
        console.log(`💾 ${this.headersList.length} fiches gasoil sauvegardées dans IndexedDB`);
        
        if (!this.preloadStarted && this.headersList.length > 0) {
          this.preloadStarted = true;
          setTimeout(() => this.preloadAllDetails(), 1500);
        }
      }),
      finalize(() => { this.isLoadingList = false; }),
      catchError(error => {
        console.error('❌ Erreur getAll:', error);
        this.isLoadingList = false;
        return this.getFromIndexedDB();
      })
    );
  }

  /**
   * Récupère les fiches depuis IndexedDB (mode offline)
   */
  private getFromIndexedDB(): Observable<GasoilHeader[]> {
    return from(this.cacheService.getFromCache('gasoil-headers')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(`📦 Mode offline - ${cached.length} fiche(s) gasoil depuis IndexedDB`);
          this.headersList = cached;
          this.headersSubject.next([...this.headersList]);
          return cached;
        }
        console.log('📦 Mode offline - Aucune fiche gasoil en cache');
        return [];
      })
    );
  }

  /**
   * Précharge tous les détails avec sauvegarde IndexedDB
   */
  preloadAllDetails(): void {
    if (this.isLoadingDetails || !this.preloadStarted) return;
    
    const idsToLoad = this.headersList
      .filter(h => h.id && !this.headersCache.get(h.id)?.gasoilLines?.length)
      .map(h => h.id)
      .filter((id): id is string => id !== undefined);
    
    if (idsToLoad.length === 0) return;
    
    console.log(`🔄 Préchargement des détails pour ${idsToLoad.length} fiches...`);
    this.isLoadingDetails = true;
    
    let loadedCount = 0;
    idsToLoad.forEach(id => {
      // ✅ CORRECTION: Utiliser la nouvelle route
      this.http.get<GasoilHeader>(`${this.HEADERS_URL}/${id}?$expand=gasoilLines`).pipe(
        tap(detailed => {
          if (detailed.id) {
            this.headersCache.set(detailed.id, detailed);
            const index = this.headersList.findIndex(h => h.id === detailed.id);
            if (index !== -1) {
              this.headersList[index] = detailed;
            }
            loadedCount++;
            
            this.cacheService.saveToCache(`gasoil-${detailed.id}`, detailed);
          }
        }),
        finalize(() => {
          if (loadedCount === idsToLoad.length) {
            this.isLoadingDetails = false;
            this.headersSubject.next([...this.headersList]);
            console.log(`✅ Préchargement terminé: ${loadedCount} fiches`);
            this.cacheService.saveToCache('gasoil-headers', this.headersList);
          }
        })
      ).subscribe();
    });
  }

  /**
   * Récupère une fiche par son ID avec cache IndexedDB
   */
  getById(id: string): Observable<GasoilHeader> {
    const cached = this.headersCache.get(id);
    if (cached?.gasoilLines?.length) {
      return of(cached);
    }
    
    if (!this.offlineSync.isOnline) {
      return from(this.cacheService.getFromCache(`gasoil-${id}`)).pipe(
        map(cachedData => {
          if (cachedData) {
            console.log(`📦 Mode offline - Détail fiche ${id} depuis IndexedDB`);
            this.headersCache.set(id, cachedData);
            return cachedData;
          }
          throw new Error('Fiche non trouvée en cache');
        })
      );
    }
    
    console.log(`📡 Appel API GET gasoil/${id}`);
    
    // ✅ CORRECTION: Utiliser la nouvelle route
    return this.http.get<GasoilHeader>(`${this.HEADERS_URL}/${id}?$expand=gasoilLines`).pipe(
      tap(header => {
        if (header.id) {
          this.headersCache.set(header.id, header);
          const index = this.headersList.findIndex(h => h.id === header.id);
          if (index !== -1) {
            this.headersList[index] = header;
          } else {
            this.headersList.push(header);
          }
          this.headersSubject.next([...this.headersList]);
          
          this.cacheService.saveToCache(`gasoil-${header.id}`, header);
          this.cacheService.saveToCache('gasoil-headers', this.headersList);
        }
      }),
      catchError(error => {
        console.error('❌ Erreur getById:', error);
        return from(this.cacheService.getFromCache(`gasoil-${id}`)).pipe(
          map(cachedData => {
            if (cachedData) {
              console.log(`⚠️ Utilisation cache IndexedDB pour ${id}`);
              return cachedData;
            }
            throw error;
          })
        );
      })
    );
  }

  /**
   * Crée une nouvelle fiche - CORRIGÉ
   */
  create(header: Partial<GasoilHeader>): Observable<GasoilHeader> {
    console.log('📡 Appel API POST gasoil headers:', this.HEADERS_URL);
    this.clearCache();
    return this.http.post<GasoilHeader>(this.HEADERS_URL, header).pipe(
      tap(response => {
        console.log('✅ Fiche créée:', response.documentNo);
        this.clearCache();
      }),
      catchError(error => { 
        console.error('❌ Erreur création fiche:', error);
        throw error; 
      })
    );
  }

  /**
   * Met à jour une fiche - CORRIGÉ
   */
  update(id: string, header: Partial<GasoilHeader>): Observable<GasoilHeader> {
    console.log(`📡 Appel API PATCH ${this.HEADERS_URL}/${id}`);
    this.clearCache();
    return this.http.patch<GasoilHeader>(`${this.HEADERS_URL}/${id}`, header).pipe(
      tap(() => {
        console.log('✅ Fiche mise à jour');
        this.clearCache();
      }),
      catchError(error => { 
        console.error('❌ Erreur mise à jour fiche:', error);
        throw error; 
      })
    );
  }

  /**
   * Supprime une fiche - CORRIGÉ
   */
  delete(id: string): Observable<void> {
    console.log(`📡 Appel API DELETE ${this.HEADERS_URL}/${id}`);
    this.clearCache();
    return this.http.delete<void>(`${this.HEADERS_URL}/${id}`).pipe(
      tap(() => {
        console.log('✅ Fiche supprimée');
        this.clearCache();
      }),
      catchError(error => { 
        console.error('❌ Erreur suppression fiche:', error);
        throw error; 
      })
    );
  }

  /**
   * Valide une fiche - CORRIGÉ
   */
  validate(id: string): Observable<void> {
    console.log(`📡 Appel API POST ${this.HEADERS_URL}/${id}/valider`);
    this.clearCache();
    return this.http.post<void>(`${this.HEADERS_URL}/${id}/valider`, {}).pipe(
      tap(() => {
        console.log('✅ Fiche validée');
        this.clearCache();
      }),
      catchError(error => { 
        console.error('❌ Erreur validation fiche:', error);
        throw error; 
      })
    );
  }

  /**
   * Ajoute une ligne - CORRIGÉ
   */
  addLine(line: Partial<GasoilLine>): Observable<GasoilLine> {
    console.log('📡 Appel API POST gasoil lines:', this.LINES_URL);
    this.clearCache();
    return this.http.post<GasoilLine>(this.LINES_URL, line).pipe(
      tap(() => console.log('✅ Ligne créée')),
      catchError(error => { 
        console.error('❌ Erreur création ligne:', error);
        throw error; 
      })
    );
  }

  /**
   * Met à jour une ligne - CORRIGÉ
   */
  updateLine(id: string, line: Partial<GasoilLine>): Observable<GasoilLine> {
    console.log(`📡 Appel API PATCH ${this.LINES_URL}/${id}`);
    this.clearCache();
    return this.http.patch<GasoilLine>(`${this.LINES_URL}/${id}`, line).pipe(
      tap(() => console.log('✅ Ligne mise à jour')),
      catchError(error => { 
        console.error('❌ Erreur mise à jour ligne:', error);
        throw error; 
      })
    );
  }

  /**
   * Supprime une ligne - CORRIGÉ
   */
  deleteLine(id: string): Observable<void> {
    console.log(`📡 Appel API DELETE ${this.LINES_URL}/${id}`);
    this.clearCache();
    return this.http.delete<void>(`${this.LINES_URL}/${id}`).pipe(
      tap(() => console.log('✅ Ligne supprimée')),
      catchError(error => { 
        console.error('❌ Erreur suppression ligne:', error);
        throw error; 
      })
    );
  }

  /**
   * Vide tous les caches
   */
  clearCache(): void {
    console.log('🗑️ Cache vidé');
    this.headersCache.clear();
    this.headersList = [];
    this.isLoadingList = false;
    this.isLoadingDetails = false;
    this.preloadStarted = false;
    this.headersSubject.next([]);
    this.cacheService.invalidateCache('gasoil-headers');
  }

  /**
   * Vérifie si une fiche est en cache avec ses lignes
   */
  isInCacheWithLines(id: string): boolean {
    return !!this.headersCache.get(id)?.gasoilLines?.length;
  }

  /**
   * Calcule les statistiques
   */
  getStats(headers: GasoilHeader[]): GasoilStats {
    return {
      totalDocuments: headers.length,
      totalQuantity: headers.reduce((sum, h) => sum + (h.gasoilLines?.reduce((s, l) => s + (l.quantity || 0), 0) || 0), 0),
      pendingCount: headers.filter(h => h.status === 'En cours').length,
      validatedCount: headers.filter(h => h.status === 'Valider').length
    };
  }
}