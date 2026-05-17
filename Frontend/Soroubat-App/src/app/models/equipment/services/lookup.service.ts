// src/app/core/services/lookup.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, map, of, forkJoin, from } from 'rxjs';
import { catchError, switchMap, timeout } from 'rxjs/operators';

// ==================== MODÈLES ====================

export interface Project {
  code: string;
  description: string;
  status?: string;
}

export interface Vehicule {
  code: string;
  designation: string;
  type?: string;
  status?: string;
  lastPointageDate?: string;
  totalHours?: number;
}

export interface Location {
  code: string;
  name: string;
  address?: string;
}

export interface ProjectTask {
  taskNo: string;
  description: string;
  projectNo?: string;
}

export interface Item {
  number: string;
  displayName: string;
  baseUnitOfMeasure: string;
  description?: string;
  unitPrice?: number;
}

export interface Demandeur {
  code: string;
  name: string;
  email?: string;
  department?: string;
}

export interface ChefChantier {
  id: string;
  nomEtPrenom: string;
  email: string;
  actif: boolean;
  numProjet: string;
}

export interface Site {
  id: string;
  no: string;
  description: string;
  status: string;
  personResponsible: string;
  projectManager: string;
  affectationMagasin: string;
}

// ==================== RÉPONSES API ====================

export interface ODataResponse<T> {
  '@odata.context': string;
  value: T[];
}

@Injectable({
  providedIn: 'root'
})
export class LookupService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:5227/api';

  // ==================== PROJETS ====================

  /**
   * Récupère tous les projets
   */
  getProjects(): Observable<Project[]> {
    return this.http.get<Project[]>(`${this.apiUrl}/Project`).pipe(
      map(projects => projects || [])
    );
  }

  /**
   * Récupère un projet par son code
   */
  getProjectByCode(code: string): Observable<Project | null> {
    return this.getProjects().pipe(
      map(projects => projects.find(p => p.code === code) || null)
    );
  }

  // ==================== VÉHICULES / ENGINS ====================

  /**
   * ✅ Récupère tous les véhicules/engins depuis l'API VehiculePointage
   * GET /api/VehiculePointage puis pour chaque pointage, récupère les détails
   */
  getVehicules(): Observable<Vehicule[]> {
    const url = `${this.apiUrl}/VehiculePointage`;
    console.log('📡 Appel API GET engins depuis /api/VehiculePointage:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      switchMap(pointages => {
        if (!Array.isArray(pointages) || pointages.length === 0) {
          console.log('⚠️ Aucun pointage trouvé');
          return of([]);
        }
        
        console.log(`📦 ${pointages.length} pointages trouvés, récupération des détails...`);
        
        // Pour chaque pointage, récupérer les détails complets (avec lignes)
        const detailRequests = pointages.map(pointage => 
          this.http.get<any>(`${this.apiUrl}/VehiculePointage/${pointage.id}`).pipe(
            timeout(10000),
            catchError(error => {
              console.error(`❌ Erreur récupération pointage ${pointage.id}:`, error);
              return of(null);
            })
          )
        );
        
        return forkJoin(detailRequests).pipe(
          map(details => {
            const uniqueVehicules = new Map<string, Vehicule>();
            
            details.forEach(detail => {
              if (detail && detail.vehiculePointageLines) {
                const lines = detail.vehiculePointageLines;
                
                lines.forEach((line: any) => {
                  const code = line.vehiculeNo;
                  const designation = line.description || line.vehiculeNo;
                  
                  if (code && code.trim() !== '') {
                    if (!uniqueVehicules.has(code)) {
                      uniqueVehicules.set(code, {
                        code: code,
                        designation: designation,
                        status: line.status || '',
                        lastPointageDate: detail.date,
                        totalHours: line.hoursWorked || 0
                      });
                    }
                  }
                });
              }
            });
            
            const vehicules = Array.from(uniqueVehicules.values());
            console.log(`✅ ${vehicules.length} engins uniques récupérés depuis /api/VehiculePointage`);
            if (vehicules.length > 0) {
              console.log('🚗 Exemples d\'engins:', vehicules.slice(0, 5).map(v => `${v.code} - ${v.designation}`));
            }
            
            return vehicules;
          })
        );
      }),
      catchError(error => {
        console.error('❌ Erreur getVehicules depuis VehiculePointage:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère un véhicule par son code
   */
  getVehiculeByCode(code: string): Observable<Vehicule | null> {
    return this.getVehicules().pipe(
      map(vehicules => vehicules.find(v => v.code === code) || null)
    );
  }

  /**
   * Récupère les véhicules par statut
   */
  getVehiculesByStatus(status: string): Observable<Vehicule[]> {
    return this.getVehicules().pipe(
      map(vehicules => vehicules.filter(v => v.status === status))
    );
  }

  /**
   * Récupère les véhicules disponibles (Fonctionnel ou Disponible)
   */
  getAvailableVehicules(): Observable<Vehicule[]> {
    return this.getVehicules().pipe(
      map(vehicules => vehicules.filter(v => 
        v.status === 'Fonctionnel' || v.status === 'Disponible'
      ))
    );
  }

  // ==================== MAGASINS ====================

  /**
   * ✅ Récupère tous les magasins depuis l'API Stock
   * GET /api/Stock (extraction des locationCode uniques)
   */
  getLocations(): Observable<Location[]> {
    const url = `${this.apiUrl}/Stock`;
    console.log('📡 Appel API GET locations depuis /api/Stock:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        // Extraire les magasins uniques depuis les données de stock
        const uniqueLocations = new Map<string, Location>();
        
        response.forEach((item: any) => {
          const locationCode = item.locationCode;
          if (locationCode && locationCode.trim() !== '') {
            if (!uniqueLocations.has(locationCode)) {
              uniqueLocations.set(locationCode, {
                code: locationCode,
                name: locationCode
              });
            }
          }
        });
        
        const locations = Array.from(uniqueLocations.values());
        console.log(`✅ ${locations.length} magasins uniques récupérés depuis /api/Stock`);
        return locations;
      }),
      catchError(error => {
        console.error('❌ Erreur getLocations depuis Stock:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère un magasin par son code
   */
  getLocationByCode(code: string): Observable<Location | null> {
    return this.getLocations().pipe(
      map(locations => locations.find(l => l.code === code) || null)
    );
  }

  // ==================== TÂCHES PROJET ====================

  /**
   * ✅ Récupère les tâches depuis l'API SiteManagement
   * GET /api/SiteManagement/my-tasks
   */
  getProjectTasks(projectNo: string): Observable<ProjectTask[]> {
    if (!projectNo) {
      return of([]);
    }
    
    const url = `${this.apiUrl}/SiteManagement/my-tasks`;
    console.log('📡 Appel API GET tasks depuis /api/SiteManagement/my-tasks');
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        // Filtrer les tâches par projet
        const filteredTasks = response.filter(task => task.jobNo === projectNo);
        
        return filteredTasks.map((item: any) => ({
          taskNo: item.taskNo || '',
          description: item.description || '',
          projectNo: item.jobNo || ''
        }));
      }),
      catchError(error => {
        console.error('❌ Erreur getProjectTasks:', error);
        return of([]);
      })
    );
  }

  // ==================== ARTICLES ====================

  /**
   * ✅ Récupère tous les articles depuis l'API Stock
   * GET /api/Stock
   */
  getItems(): Observable<Item[]> {
    const url = `${this.apiUrl}/Stock`;
    console.log('📡 Appel API GET items depuis /api/Stock:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        const items: Item[] = response.map((item: any) => ({
          number: item.itemNo || '',
          displayName: item.itemDescription || item.itemNo || 'Sans description',
          baseUnitOfMeasure: 'PIECE',
          description: item.itemDescription || '',
          unitPrice: 0
        }));
        
        // Supprimer les doublons par number
        const uniqueItems = items.filter((item, index, self) => 
          index === self.findIndex(i => i.number === item.number)
        );
        
        console.log(`✅ ${uniqueItems.length} articles uniques récupérés depuis /api/Stock`);
        return uniqueItems;
      }),
      catchError(error => {
        console.error('❌ Erreur getItems depuis Stock:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère un article par son numéro
   */
  getItemByNumber(number: string): Observable<Item | null> {
    return this.getItems().pipe(
      map(items => items.find(i => i.number === number) || null)
    );
  }

  /**
   * Recherche des articles par terme
   */
  searchItems(searchTerm: string): Observable<Item[]> {
    return this.getItems().pipe(
      map(items => items.filter(item => 
        item.number.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.displayName.toLowerCase().includes(searchTerm.toLowerCase())
      ))
    );
  }

  // ==================== DEMANDEURS ====================

  /**
   * Récupère tous les demandeurs
   */
  getDemandeurs(): Observable<Demandeur[]> {
    return this.http.get<Demandeur[]>(`${this.apiUrl}/Demandeur`).pipe(
      map(demandeurs => demandeurs || [])
    );
  }

  /**
   * Récupère un demandeur par son code
   */
  getDemandeurByCode(code: string): Observable<Demandeur | null> {
    return this.getDemandeurs().pipe(
      map(demandeurs => demandeurs.find(d => d.code === code) || null)
    );
  }

  // ==================== CHEFS CHANTIER ====================

  /**
   * Récupère tous les chefs de chantier
   */
  getChefChantiers(): Observable<ChefChantier[]> {
    return this.http.get<ChefChantier[]>(`${this.apiUrl}/Lookup/chefsChantier`).pipe(
      map(chefs => chefs || [])
    );
  }

  /**
   * Récupère un chef de chantier par email
   */
  getChefChantierByEmail(email: string): Observable<ChefChantier | null> {
    const url = `${this.apiUrl}/Lookup/chefsChantier?filter=email eq '${email}'`;
    return this.http.get<{ value: ChefChantier[] }>(url).pipe(
      map(response => response.value?.[0] || null),
      catchError(() => of(null))
    );
  }

  /**
   * Récupère le projet d'un chef de chantier par email
   */
  getProjetByEmail(email: string): Observable<string | null> {
    return this.getChefChantierByEmail(email).pipe(
      map(chef => chef?.numProjet || null)
    );
  }

  // ==================== SITES ====================

  /**
   * Récupère tous les sites
   */
  getSites(): Observable<Site[]> {
    return this.http.get<Site[]>(`${this.apiUrl}/Project`).pipe(
      map(sites => sites || [])
    );
  }

  /**
   * Récupère un site par son numéro
   */
  getSiteByNo(no: string): Observable<Site | null> {
    return this.getSites().pipe(
      map(sites => sites.find(s => s.no === no) || null)
    );
  }

  /**
   * Récupère le magasin associé à un site
   */
  getMagasinBySiteNo(siteNo: string): Observable<string | null> {
    return this.getSiteByNo(siteNo).pipe(
      map(site => site?.affectationMagasin || null)
    );
  }

  // ==================== MÉTHODES GÉNÉRIQUES ====================

  /**
   * Récupère toutes les entités d'un type donné
   */
  getLookup(entityName: string, filter?: string): Observable<any[]> {
    let url = `${this.apiUrl}/Lookup/${entityName}`;
    if (filter) {
      url += `?filter=${encodeURIComponent(filter)}`;
    }
    return this.http.get<any[]>(url).pipe(
      map(data => data || [])
    );
  }

  /**
   * Recherche dans toutes les entités
   */
  search(entityName: string, searchTerm: string, fields: string[]): Observable<any[]> {
    return this.getLookup(entityName).pipe(
      map(items => items.filter(item => 
        fields.some(field => 
          item[field]?.toLowerCase().includes(searchTerm.toLowerCase())
        )
      ))
    );
  }
}