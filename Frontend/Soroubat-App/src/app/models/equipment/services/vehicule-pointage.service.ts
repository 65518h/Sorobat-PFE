// src/app/modules/equipment/services/vehicule-pointage.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, forkJoin, from, BehaviorSubject } from 'rxjs';
import { map, catchError, switchMap, tap, finalize } from 'rxjs/operators';
import { VehiculePointageHeader, VehiculePointageLine } from '../models/vehicule-pointage.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Injectable({
  providedIn: 'root'
})
export class VehiculePointageService {
  
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:5227/api/VehiculePointage';

  // Caches mémoire
  private pointagesCache: VehiculePointageHeader[] = [];
  private pointagesSubject = new BehaviorSubject<VehiculePointageHeader[]>([]);
  public pointages$ = this.pointagesSubject.asObservable();
  private isLoading = false;
  
  // Cache pour les lignes
  private linesCache = new Map<string, VehiculePointageLine>();
  
  // ✅ Pour les pointages avec lignes
  private pointagesWithLinesSubject = new BehaviorSubject<VehiculePointageHeader[]>([]);
  public pointagesWithLines$ = this.pointagesWithLinesSubject.asObservable();
  private isLoadingPointagesWithLines = false;
  private pointagesWithLinesLoaded = false;

  constructor(
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

  // ==================== EN-TÊTES (HEADERS) ====================

  /**
   * Récupère tous les pointages
   * GET /api/VehiculePointage
   */
  getAllPointages(forceRefresh: boolean = false): Observable<VehiculePointageHeader[]> {
    if (!this.offlineSync.isOnline && !forceRefresh) {
      return this.getPointagesFromCache();
    }
    
    if (this.pointagesCache.length > 0 && !forceRefresh) {
      return of([...this.pointagesCache]);
    }
    
    if (this.isLoading) {
      return this.pointages$;
    }
    
    console.log('📡 Appel API GET /api/VehiculePointage');
    this.isLoading = true;
    
    return this.http.get<VehiculePointageHeader[]>(`${this.apiUrl}`).pipe(
      map(pointages => {
        if (!pointages) return [];
        
        return pointages.map(p => ({
          ...p,
          no: p.documentNo,
          lines: p.vehiculePointageLines || [],
          totalVehicules: p.vehiculePointageLines?.length || 0,
          totalHours: p.vehiculePointageLines?.reduce((sum, l) => sum + (l.hoursWorked || 0), 0) || 0,
          totalDistance: p.vehiculePointageLines?.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0) || 0,
          totalFuel: p.vehiculePointageLines?.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0) || 0
        }));
      }),
      tap(pointages => {
        this.pointagesCache = pointages;
        this.pointagesSubject.next([...pointages]);
        
        this.cacheService.saveToCache('vehicule-pointages', pointages);
        console.log(`💾 ${pointages.length} pointages véhicules sauvegardés dans IndexedDB`);
      }),
      finalize(() => { this.isLoading = false; }),
      catchError(error => {
        console.error('❌ Erreur getAllPointages:', error);
        this.isLoading = false;
        return this.getPointagesFromCache();
      })
    );
  }

  /**
   * Alias pour getAllPointages (compatibilité)
   */
  getMyPointages(forceRefresh: boolean = false): Observable<VehiculePointageHeader[]> {
    return this.getAllPointages(forceRefresh);
  }

  /**
   * Récupère les pointages depuis le cache (mode offline)
   */
  private getPointagesFromCache(): Observable<VehiculePointageHeader[]> {
    return from(this.cacheService.getFromCache('vehicule-pointages')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(`📦 Mode offline - ${cached.length} pointage(s) véhicules depuis IndexedDB`);
          this.pointagesCache = cached;
          this.pointagesSubject.next([...cached]);
          return cached;
        }
        console.log('📦 Mode offline - Aucun pointage véhicule en cache');
        return [];
      })
    );
  }

  /**
   * Récupère tous les pointages avec les compteurs détaillés
   */
  getMyPointagesWithCounts(): Observable<VehiculePointageHeader[]> {
  // ✅ En mode offline, essayer d'abord le cache des pointages enrichis
  if (!this.offlineSync.isOnline) {
    return from(this.cacheService.getFromCache('vehicule-pointages-enriched')).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(`📦 Mode offline - ${cached.length} pointages enrichis depuis cache`);
          return cached;
        }
        // Fallback vers le cache simple
        return this.calculateCounts(this.pointagesCache);
      })
    );
  }
  
  return this.getAllPointages().pipe(
    switchMap(pointages => {
      if (!pointages || pointages.length === 0) {
        return of([]);
      }
      
      const requests = pointages.map(pointage =>
        this.getHeaderById(pointage.id!).pipe(
          map(detail => this.enrichPointageWithCounts(pointage, detail)),
          catchError(() => of(pointage))
        )
      );
      
      return forkJoin(requests);
    }),
    tap(enrichedPointages => {
      //  Sauvegarder les pointages enrichis pour le mode offline
      this.cacheService.saveToCache('vehicule-pointages-enriched', enrichedPointages);
      console.log(` ${enrichedPointages.length} pointages enrichis sauvegardés pour offline`);
    })
  );
}


  /**
   * Enrichit un pointage avec ses compteurs
   */
  private enrichPointageWithCounts(pointage: VehiculePointageHeader, detail: VehiculePointageHeader): VehiculePointageHeader {
    const lines = detail.vehiculePointageLines || [];
    const totalVehicules = lines.length;
    const totalHours = lines.reduce((sum, l) => sum + (l.hoursWorked || 0), 0);
    const totalDistance = lines.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0);
    const totalFuel = lines.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0);
    const totalEstimatedCost = Math.round((totalFuel * 850) + (totalHours * 5000));
    
    return {
      ...pointage,
      no: pointage.documentNo,
      lines: lines,
      vehiculePointageLines: lines,
      totalVehicules: totalVehicules,
      totalHours: totalHours,
      totalDistance: totalDistance,
      totalFuel: totalFuel,
      totalEstimatedCost: totalEstimatedCost
    };
  }

  /**
   * Calcule les compteurs pour une liste de pointages
   */
  private calculateCounts(pointages: VehiculePointageHeader[]): VehiculePointageHeader[] {
    return pointages.map(p => ({
      ...p,
      no: p.documentNo,
      totalVehicules: p.lines?.length || p.vehiculePointageLines?.length || 0,
      totalHours: p.lines?.reduce((sum, l) => sum + (l.hoursWorked || 0), 0) || 
                  p.vehiculePointageLines?.reduce((sum, l) => sum + (l.hoursWorked || 0), 0) || 0,
      totalDistance: p.lines?.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0) ||
                     p.vehiculePointageLines?.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0) || 0,
      totalFuel: p.lines?.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0) ||
                 p.vehiculePointageLines?.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0) || 0
    }));
  }

  /**
   * Récupère un en-tête de pointage par son ID avec cache
   * GET /api/VehiculePointage/{id}
   */
  getHeaderById(id: string): Observable<VehiculePointageHeader> {
    if (!this.offlineSync.isOnline) {
      return from(this.cacheService.getFromCache(`vehicule-pointage-${id}`)).pipe(
        map(cached => {
          if (cached) {
            console.log(`📦 Mode offline - Détail pointage ${id} depuis IndexedDB`);
            return cached;
          }
          throw new Error('Pointage non trouvé en cache');
        })
      );
    }
    
    console.log(`📡 Appel API GET /api/VehiculePointage/${id}`);
    
    return this.http.get<VehiculePointageHeader>(`${this.apiUrl}/${id}`).pipe(
      map(header => ({
        ...header,
        no: header.documentNo,
        lines: header.vehiculePointageLines,
        totalVehicules: header.vehiculePointageLines?.length || 0,
        totalHours: header.vehiculePointageLines?.reduce((sum, l) => sum + (l.hoursWorked || 0), 0) || 0,
        totalDistance: header.vehiculePointageLines?.reduce((sum, l) => sum + Math.max(0, (l.endIndex || 0) - (l.startIndex || 0)), 0) || 0,
        totalFuel: header.vehiculePointageLines?.reduce((sum, l) => sum + (l.fuelConsumed || 0), 0) || 0
      })),
      tap(header => {
        this.cacheService.saveToCache(`vehicule-pointage-${id}`, header);
        
        const index = this.pointagesCache.findIndex(p => p.id === id);
        if (index !== -1) {
          this.pointagesCache[index] = header;
          this.pointagesSubject.next([...this.pointagesCache]);
        }
      }),
      catchError(error => {
        console.error(`❌ Erreur getHeaderById ${id}:`, error);
        
        if (error.status === 404) {
          console.log(`🗑️ ID ${id} non trouvé - Nettoyage du cache`);
          this.cacheService.invalidateCache(`vehicule-pointage-${id}`);
          this.pointagesCache = this.pointagesCache.filter(p => p.id !== id);
          this.pointagesSubject.next([...this.pointagesCache]);
          this.cacheService.saveToCache('vehicule-pointages', this.pointagesCache);
        }
        
        return from(this.cacheService.getFromCache(`vehicule-pointage-${id}`)).pipe(
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
   * Crée un nouvel en-tête de pointage
   * POST /api/VehiculePointage
   * Body: { "date": "2026-05-13" }
   */
  createHeader(data: string | { date: string }): Observable<VehiculePointageHeader> {
    const dateToSend = typeof data === 'string' ? data : data.date;
    
    console.log(`📡 Appel API POST /api/VehiculePointage avec date: ${dateToSend}`);
    this.clearCache();
    this.resetPointagesWithLinesCache();
    
    return this.http.post<VehiculePointageHeader>(`${this.apiUrl}`, { date: dateToSend }).pipe(
      tap(response => {
        console.log('✅ En-tête créé:', response.documentNo);
        this.clearCache();
        this.resetPointagesWithLinesCache();
      }),
      catchError(error => {
        console.error('❌ Erreur createHeader:', error);
        throw error;
      })
    );
  }

  /**
   * Met à jour un en-tête de pointage
   * PATCH /api/VehiculePointage/{id}
   */
  updateHeader(id: string, header: Partial<VehiculePointageHeader>): Observable<VehiculePointageHeader> {
    console.log(`📡 Appel API PATCH /api/VehiculePointage/${id}`, header);
    this.clearCache();
    this.resetPointagesWithLinesCache();
    
    return this.http.patch<VehiculePointageHeader>(`${this.apiUrl}/${id}`, header).pipe(
      tap(response => {
        console.log('✅ En-tête mis à jour:', response.documentNo);
        this.clearCache();
        this.resetPointagesWithLinesCache();
      }),
      catchError(error => {
        console.error('❌ Erreur updateHeader:', error);
        throw error;
      })
    );
  }

  /**
   * Supprime un en-tête de pointage
   * DELETE /api/VehiculePointage/{id}
   */
  deleteHeader(id: string): Observable<void> {
    console.log(`📡 Appel API DELETE /api/VehiculePointage/${id}`);
    this.clearCache();
    this.resetPointagesWithLinesCache();
    
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      tap(() => {
        console.log('✅ En-tête supprimé');
        this.clearCache();
        this.resetPointagesWithLinesCache();
      }),
      catchError(error => {
        console.error('❌ Erreur deleteHeader:', error);
        throw error;
      })
    );
  }

  /**
   * Valide un pointage (Ouvert → Validé)
   * POST /api/VehiculePointage/{id}/valider
   */
  validatePointage(id: string): Observable<VehiculePointageHeader> {
    console.log(`📡 Appel API POST /api/VehiculePointage/${id}/valider`);
    this.clearCache();
    this.resetPointagesWithLinesCache();
    
    return this.http.post<VehiculePointageHeader>(`${this.apiUrl}/${id}/valider`, {}).pipe(
      tap(response => {
        console.log('✅ Pointage validé:', response.documentNo);
        this.clearCache();
        this.resetPointagesWithLinesCache();
      }),
      catchError(error => {
        console.error('❌ Erreur validatePointage:', error);
        throw error;
      })
    );
  }

  // ==================== LIGNES (LINES) ====================

  /**
   * Récupère une ligne de pointage par son ID avec cache
   * GET /api/VehiculePointage/lines/{id}
   */
  getLineById(id: string): Observable<VehiculePointageLine> {
    if (this.linesCache.has(id)) {
      console.log(`📦 Cache mémoire - Ligne ${id} trouvée`);
      return of(this.linesCache.get(id)!);
    }
    
    if (!this.offlineSync.isOnline) {
      return from(this.cacheService.getFromCache(`vehicule-pointage-line-${id}`)).pipe(
        map(cached => {
          if (cached) {
            console.log(`📦 Mode offline - Ligne ${id} depuis IndexedDB`);
            this.linesCache.set(id, cached);
            return cached;
          }
          throw new Error('Ligne non trouvée en cache');
        })
      );
    }
    
    console.log(`📡 Appel API GET /api/VehiculePointage/lines/${id}`);
    
    return this.http.get<VehiculePointageLine>(`${this.apiUrl}/lines/${id}`).pipe(
      tap(line => {
        this.linesCache.set(id, line);
        this.cacheService.saveToCache(`vehicule-pointage-line-${id}`, line);
        console.log('✅ Ligne reçue pour véhicule:', line.vehiculeNo);
      }),
      catchError(error => {
        console.error(`❌ Erreur getLineById ${id}:`, error);
        
        if (error.status === 404) {
          console.log(`🗑️ Ligne ${id} non trouvée - Nettoyage du cache`);
          this.linesCache.delete(id);
          this.cacheService.invalidateCache(`vehicule-pointage-line-${id}`);
        }
        
        return from(this.cacheService.getFromCache(`vehicule-pointage-line-${id}`)).pipe(
          map(cached => {
            if (cached) {
              console.log(`⚠️ Utilisation cache pour ligne ${id}`);
              this.linesCache.set(id, cached);
              return cached;
            }
            throw error;
          })
        );
      })
    );
  }

  /**
   * Met à jour une ligne de pointage avec cache
   * PATCH /api/VehiculePointage/lines/{id}
   */
  updateLine(id: string, line: Partial<VehiculePointageLine>): Observable<VehiculePointageLine> {
    console.log(`📡 Appel API PATCH /api/VehiculePointage/lines/${id}`, line);
    this.resetPointagesWithLinesCache();
    
    return this.http.patch<VehiculePointageLine>(`${this.apiUrl}/lines/${id}`, line).pipe(
      tap(response => {
        console.log('✅ Ligne mise à jour:', response);
        this.linesCache.set(id, response);
        this.cacheService.saveToCache(`vehicule-pointage-line-${id}`, response);
        this.clearCache();
        this.resetPointagesWithLinesCache();
      }),
      catchError(error => {
        console.error('❌ Erreur updateLine:', error);
        throw error;
      })
    );
  }

  // ==================== POINTAGES AVEC LIGNES (POUR DASHBOARD) ====================

  /**
   * Récupère tous les pointages avec leurs lignes (une fois)
   * Utilisé par le dashboard
   */
  getAllPointagesWithLines(forceRefresh: boolean = false): Observable<VehiculePointageHeader[]> {
    const cacheKey = 'vehicule-pointages-with-lines';
    
    if (!this.offlineSync.isOnline && !forceRefresh) {
      return from(this.cacheService.getFromCache(cacheKey)).pipe(
        map(cached => cached || [])
      );
    }
    
    return this.getAllPointages(forceRefresh).pipe(
      switchMap(pointages => {
        if (!pointages || pointages.length === 0) {
          return of([]);
        }
        
        const requests = pointages.map(p => 
          this.getHeaderById(p.id!).pipe(
            catchError(() => of(p))
          )
        );
        
        return forkJoin(requests);
      }),
      tap(data => {
        this.cacheService.saveToCache(cacheKey, data);
        console.log(`💾 ${data.length} pointages avec lignes sauvegardés`);
      }),
      catchError(error => {
        console.error('❌ Erreur getAllPointagesWithLines:', error);
        return from(this.cacheService.getFromCache(cacheKey)).pipe(
          map(cached => cached || [])
        );
      })
    );
  }

  /**
   * Charge tous les pointages avec leurs lignes et émet les mises à jour
   * (Version optimisée avec flag pour éviter les appels multiples)
   */
  loadPointagesWithLines(forceRefresh: boolean = false): void {
    // ✅ Éviter les appels multiples simultanés
    if (this.isLoadingPointagesWithLines) {
      console.log('⏳ Chargement des pointages déjà en cours, ignoré');
      return;
    }
    
    // ✅ Ne pas recharger si déjà chargé et pas de force refresh
    if (this.pointagesWithLinesLoaded && !forceRefresh && this.offlineSync.isOnline) {
      console.log('📦 Pointages déjà chargés, utilisation du cache');
      return;
    }
    
    const cacheKey = 'vehicule-pointages-with-lines';
    
    // Vérifier le cache
    this.cacheService.getFromCache(cacheKey).then(cached => {
      if (cached && cached.length > 0 && !forceRefresh && !this.offlineSync.isOnline) {
        console.log('📦 Pointages avec lignes depuis le cache IndexedDB');
        this.pointagesWithLinesSubject.next(cached);
        this.pointagesWithLinesLoaded = true;
        return;
      }
      
      if (!this.offlineSync.isOnline && !forceRefresh) {
        return;
      }
      
      console.log('📡 Chargement des pointages avec lignes depuis l\'API...');
      this.isLoadingPointagesWithLines = true;
      
      this.getAllPointages(forceRefresh).pipe(
        switchMap(pointages => {
          if (!pointages || pointages.length === 0) {
            return of([]);
          }
          
          console.log(`📦 ${pointages.length} pointages trouvés, chargement des détails...`);
          
          const requests = pointages.map(p => 
            this.getHeaderById(p.id!).pipe(
              catchError((error) => {
                console.warn(`⚠️ Erreur chargement pointage ${p.documentNo}:`, error);
                return of(p);
              })
            )
          );
          
          return forkJoin(requests);
        }),
        tap(data => {
          console.log(`✅ ${data.length} pointages avec lignes chargés`);
          this.cacheService.saveToCache(cacheKey, data);
          this.pointagesWithLinesSubject.next(data);
          this.pointagesWithLinesLoaded = true;
          this.isLoadingPointagesWithLines = false;
        }),
        catchError(error => {
          console.error('❌ Erreur chargement pointages avec lignes:', error);
          this.isLoadingPointagesWithLines = false;
          return of([]);
        })
      ).subscribe();
    });
  }

  /**
   * Réinitialiser le cache des pointages avec lignes
   */
  resetPointagesWithLinesCache(): void {
    this.pointagesWithLinesLoaded = false;
    this.isLoadingPointagesWithLines = false;
    this.cacheService.invalidateCache('vehicule-pointages-with-lines');
  }

  // ==================== MÉTHODES UTILITAIRES ====================

  /**
   * Vide tous les caches
   */
  clearCache(): void {
    console.log('🗑️ Cache pointages véhicules vidé');
    this.pointagesCache = [];
    this.linesCache.clear();
    this.pointagesSubject.next([]);
    this.cacheService.invalidateCache('vehicule-pointages');
  }

  /**
   * Clôture un pointage
   */
  closePointage(id: string): Observable<VehiculePointageHeader> {
    console.log(`📡 Clôture du pointage ${id}`);
    return this.updateHeader(id, { status: 'Clôturé' });
  }

  /**
   * Annule un pointage
   */
  cancelPointage(id: string): Observable<VehiculePointageHeader> {
    console.log(`📡 Annulation du pointage ${id}`);
    return this.updateHeader(id, { status: 'Annulé' });
  }

  /**
   * Rafraîchit les données
   */
  refresh(): void {
    this.clearCache();
    this.resetPointagesWithLinesCache();
    this.getAllPointages(true).subscribe();
  }

  /**
   * Précharge les données pour le mode offline
   */
  async preloadForOffline(): Promise<boolean> {
    console.log('📦 Préchargement des pointages véhicules...');
    
    try {
      const pointages = await this.getAllPointages().toPromise();
      if (pointages && pointages.length > 0) {
        for (const pointage of pointages) {
          if (pointage.id) {
            await this.getHeaderById(pointage.id).toPromise();
          }
        }
        console.log(`✅ ${pointages.length} pointages véhicules préchargés`);
        return true;
      }
      return false;
    } catch (error) {
      console.error('❌ Erreur préchargement pointages:', error);
      return false;
    }
  }
}