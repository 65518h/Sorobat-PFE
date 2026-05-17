// src/app/core/services/site-management.service.ts

import { Injectable, Inject, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { map, catchError, tap, switchMap } from 'rxjs/operators';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

export interface Site {
  id: string;
  no: string;
  description: string;
  status: string;
  personResponsible: string;
  projectManager: string;
  affectationMagasin: string;
  startingDate?: string;
  endingDate?: string;
}

@Injectable({
  providedIn: 'root'
})
export class SiteManagementService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:5227/api/SiteManagement';

  constructor(
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

  /**
   * Récupère le projet de l'utilisateur connecté avec cache offline
   * GET /api/SiteManagement/my-project
   */
  getMyProject(): Observable<Site | null> {
    // ✅ Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return this.getProjectFromCache();
    }
    
    console.log('📡 Appel API GET /my-project');
    return this.http.get<Site>(`${this.apiUrl}/my-project`).pipe(
      tap(project => {
        console.log('📦 Projet reçu:', project);
        // ✅ Sauvegarder dans le cache
        if (project) {
          this.cacheService.saveToCache('my-project', project);
          console.log('💾 Projet sauvegardé dans IndexedDB');
        }
      }),
      catchError(error => {
        console.error('❌ Erreur getMyProject:', error);
        // En cas d'erreur, essayer le cache
        return this.getProjectFromCache();
      })
    );
  }

  /**
   * Récupère le projet depuis le cache (mode offline)
   */
  private getProjectFromCache(): Observable<Site | null> {
    return from(this.cacheService.getFromCache('my-project')).pipe(
      map(cached => {
        if (cached) {
          console.log('📦 Mode offline - Projet depuis IndexedDB:', cached);
          return cached;
        }
        console.log('📦 Mode offline - Aucun projet en cache');
        return null;
      })
    );
  }

  /**
   * Récupère le magasin associé au projet de l'utilisateur avec cache
   */
  getCurrentUserMagasin(): Observable<string | null> {
    // ✅ Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return this.getMagasinFromCache();
    }
    
    console.log('🔍 Récupération du magasin associé au projet');
    
    return this.getMyProject().pipe(
      map(project => {
        if (project && project.affectationMagasin) {
          console.log(`✅ Magasin trouvé: ${project.affectationMagasin}`);
          // ✅ Sauvegarder le magasin dans le cache séparément
          this.cacheService.saveToCache('current-magasin', project.affectationMagasin);
          return project.affectationMagasin;
        }
        console.warn('⚠️ Aucun magasin associé au projet');
        return null;
      })
    );
  }

  /**
   * Récupère le magasin depuis le cache (mode offline)
   */
  private getMagasinFromCache(): Observable<string | null> {
    return from(this.cacheService.getFromCache('current-magasin')).pipe(
      map(cached => {
        if (cached) {
          console.log('📦 Mode offline - Magasin depuis IndexedDB:', cached);
          return cached;
        }
        console.log('📦 Mode offline - Aucun magasin en cache');
        return null;
      })
    );
  }

  /**
   * Récupère le projet avec toutes ses informations (avec cache)
   */
  getProjectWithDetails(): Observable<Site | null> {
    return this.getMyProject();
  }

  /**
   * Force le rafraîchissement du cache
   */
  refreshCache(): void {
    console.log('🔄 Rafraîchissement du cache projet');
    this.cacheService.invalidateCache('my-project');
    this.cacheService.invalidateCache('current-magasin');
    
    // Recharger en ligne
    if (this.offlineSync.isOnline) {
      this.getMyProject().subscribe();
    }
  }

  /**
   * @deprecated Utilisez getMyProject() à la place
   */
  getAllSites(): Observable<Site[]> {
    console.warn('⚠️ getAllSites est déprécié - Utilisez getMyProject()');
    return this.getMyProject().pipe(
      map(project => project ? [project] : [])
    );
  }

  /**
   * @deprecated Utilisez getCurrentUserMagasin() à la place
   */
  getMagasinByProjectNo(projectNo: string): Observable<string | null> {
    console.warn('⚠️ getMagasinByProjectNo est déprécié');
    return this.getMyProject().pipe(
      map(project => {
        if (project && project.no === projectNo) {
          return project.affectationMagasin || null;
        }
        return null;
      })
    );
  }
}