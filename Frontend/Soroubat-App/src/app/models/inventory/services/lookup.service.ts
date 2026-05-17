// src/app/models/inventory/services/lookup.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of, forkJoin } from 'rxjs';
import { catchError, map, timeout, switchMap } from 'rxjs/operators';

export interface ChefChantier {
  id: string;
  nomEtPrenom: string;
  email: string;
  actif: boolean;
  numProjet: string;
  idApprobateur: string;
}

export interface Project {
  id: string;
  code: string;
  description: string;
  status: string;
}

export interface Vehicule {
  code: string;
  designation: string;
}

export interface Location {
  code: string;
  name: string;
}

export interface Item {
  number: string;
  displayName: string;
  baseUnitOfMeasure: string;
}

export interface Article {
  number: string;
  description: string;
  baseUnitOfMeasure: string;
  unitPrice?: number;
}

export interface Immobilisation {
  number: string;
  displayName: string;
  faClassCode?: string;
  faSubclassCode?: string;
}

export interface ProjectTask {
  projectNo: string;
  taskNo: string;
  description: string;
  type: string;
}

@Injectable({
  providedIn: 'root'
})
export class LookupService {
  private readonly BASE_URL = 'http://localhost:5227/api';

  constructor(private http: HttpClient) {}

  // ==================== CHEFS CHANTIER (LOOKUP) ====================

  /**
   * Récupère les informations du chef de chantier par email
   * GET /api/Lookup/chantier?filter=email eq 'xxx'
   */
  getChefChantierByEmail(email: string): Observable<ChefChantier | null> {
    if (!email) {
      return of(null);
    }
    
    const filter = `email eq '${email}'`;
    const url = `${this.BASE_URL}/Lookup/chefsChantier?filter=${encodeURIComponent(filter)}`;
    console.log('📡 Appel API GET chef chantier par email:', url);
    
    return this.http.get<any>(url).pipe(
      timeout(10000),
      map(response => {
        if (response && response.value && Array.isArray(response.value) && response.value.length > 0) {
          const chef = response.value[0];
          return {
            id: chef.id || '',
            nomEtPrenom: chef.nomEtPrenom || '',
            email: chef.email || '',
            actif: chef.actif || false,
            numProjet: chef.numProjet || '',
            idApprobateur: chef.idApprobateur || ''
          };
        }
        return null;
      }),
      catchError(error => {
        console.error('❌ Erreur getChefChantierByEmail:', error);
        return of(null);
      })
    );
  }

  /**
   * Récupère les informations du chef de chantier par projet
   * GET /api/Lookup/chantier?filter=numProjet eq 'xxx'
   */
  getChefChantierByProjet(projetNo: string): Observable<ChefChantier | null> {
    if (!projetNo) {
      return of(null);
    }
    
    const filter = `numProjet eq '${projetNo}'`;
    const url = `${this.BASE_URL}/Lookup/chefsChantier?filter=${encodeURIComponent(filter)}`;
    console.log('📡 Appel API GET chef chantier par projet:', url);
    
    return this.http.get<any>(url).pipe(
      timeout(10000),
      map(response => {
        if (response && response.value && Array.isArray(response.value) && response.value.length > 0) {
          const chef = response.value[0];
          return {
            id: chef.id || '',
            nomEtPrenom: chef.nomEtPrenom || '',
            email: chef.email || '',
            actif: chef.actif || false,
            numProjet: chef.numProjet || '',
            idApprobateur: chef.idApprobateur || ''
          };
        }
        return null;
      }),
      catchError(error => {
        console.error('❌ Erreur getChefChantierByProjet:', error);
        return of(null);
      })
    );
  }

  /**
   * Récupère tous les chefs de chantier
   * GET /api/Lookup/chantier
   */
  getAllChefChantier(): Observable<ChefChantier[]> {
    const url = `${this.BASE_URL}/Lookup/chantier`;
    console.log('📡 Appel API GET tous les chefs chantier:', url);
    
    return this.http.get<any>(url).pipe(
      timeout(10000),
      map(response => {
        if (response && response.value && Array.isArray(response.value)) {
          return response.value.map((chef: any) => ({
            id: chef.id || '',
            nomEtPrenom: chef.nomEtPrenom || '',
            email: chef.email || '',
            actif: chef.actif || false,
            numProjet: chef.numProjet || '',
            idApprobateur: chef.idApprobateur || ''
          }));
        }
        return [];
      }),
      catchError(error => {
        console.error('❌ Erreur getAllChefChantier:', error);
        return of([]);
      })
    );
  }

  // ==================== PROJETS ====================

  /**
   * Récupère tous les projets
   * GET /api/Project
   */
  getProjects(): Observable<Project[]> {
    const url = `${this.BASE_URL}/Project`;
    console.log('📡 Appel API GET projects:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        return response.map((item: any) => ({
          id: item.id || '',
          code: item.no || item.code || '',
          description: item.description || '',
          status: item.status || 'Open'
        }));
      }),
      catchError(error => {
        console.error('❌ Erreur getProjects:', error);
        return of([]);
      })
    );
  }

  // ==================== VÉHICULES / ENGINS ====================

  /**
   * Récupère les engins depuis l'API VehiculePointage
   * GET /api/VehiculePointage/my-pointages
   * Puis pour chaque pointage, GET /api/VehiculePointage/header/{id}
   */
  getVehicules(): Observable<Vehicule[]> {
    const url = `${this.BASE_URL}/VehiculePointage/my-pointages`;
    console.log('📡 Appel API GET engins depuis:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      switchMap(pointages => {
        if (!Array.isArray(pointages) || pointages.length === 0) {
          console.log('⚠️ Aucun pointage trouvé');
          return of([]);
        }
        
        console.log(`📦 ${pointages.length} pointages trouvés, récupération des détails...`);
        
        const detailRequests = pointages.map(pointage => 
          this.http.get<any>(`${this.BASE_URL}/VehiculePointage/header/${pointage.id}`).pipe(
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
                console.log(`📦 Pointage ${detail.documentNo}: ${lines.length} lignes`);
                
                lines.forEach((line: any) => {
                  const code = line.vehiculeNo;
                  const designation = line.description || line.vehiculeNo;
                  
                  if (code && code.trim() !== '') {
                    if (!uniqueVehicules.has(code)) {
                      uniqueVehicules.set(code, {
                        code: code,
                        designation: designation
                      });
                    }
                  }
                });
              }
            });
            
            const vehicules = Array.from(uniqueVehicules.values());
            console.log(`✅ ${vehicules.length} engins uniques récupérés`);
            return vehicules;
          })
        );
      }),
      catchError(error => {
        console.error('❌ Erreur getVehicules:', error);
        return of([]);
      })
    );
  }

  // ==================== MAGASINS ====================

  /**
   * Récupère les magasins depuis l'API Stock
   * GET /api/Stock/my-stock
   */
  getLocations(): Observable<Location[]> {
    const url = `${this.BASE_URL}/Stock/my-stock`;
    console.log('📡 Appel API GET locations depuis:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        const uniqueLocations = new Map<string, Location>();
        
        response.forEach((item: any) => {
          const locationCode = item.locationCode || item.code;
          if (locationCode && locationCode.trim() !== '') {
            if (!uniqueLocations.has(locationCode)) {
              uniqueLocations.set(locationCode, {
                code: locationCode,
                name: item.locationName || item.name || locationCode
              });
            }
          }
        });
        
        const locations = Array.from(uniqueLocations.values());
        console.log(`✅ ${locations.length} magasins uniques récupérés`);
        return locations;
      }),
      catchError(error => {
        console.error('❌ Erreur getLocations:', error);
        return of([]);
      })
    );
  }

  // ==================== ARTICLES ====================

  /**
   * Récupère tous les articles depuis l'API Stock
   * GET /api/Stock/my-stock
   */
  getItems(filter?: string): Observable<Item[]> {
    const url = `${this.BASE_URL}/Stock/my-stock`;
    console.log('📡 Appel API GET items depuis:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        const items: Item[] = response.map((item: any) => ({
          number: item.itemNo || item.number || '',
          displayName: item.itemDescription || item.description || item.displayName || 'Sans description',
          baseUnitOfMeasure: item.baseUnitOfMeasure || item.unitOfMeasure || 'PIECE'
        }));
        
        const uniqueItems = items.filter((item, index, self) => 
          index === self.findIndex(i => i.number === item.number && i.number !== '')
        );
        
        console.log(`✅ ${uniqueItems.length} articles uniques récupérés`);
        return uniqueItems;
      }),
      catchError(error => {
        console.error('❌ Erreur getItems:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère les articles (alias pour getItems)
   */
  getArticles(filter?: string): Observable<Article[]> {
    return this.getItems(filter).pipe(
      map(items => items.map(item => ({
        number: item.number,
        description: item.displayName,
        baseUnitOfMeasure: item.baseUnitOfMeasure,
        unitPrice: 0
      })))
    );
  }

  // ==================== IMMOBILISATIONS ====================

  /**
   * Récupère toutes les immobilisations
   * GET /api/Immobilisation
   */
  getImmobilisations(filter?: string): Observable<Immobilisation[]> {
    let url = `${this.BASE_URL}/Immobilisation`;
    if (filter) {
      url += `?filter=${encodeURIComponent(filter)}`;
    }
    console.log('📡 Appel API GET immobilisations:', url);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        return response
          .filter((item: any) => item.number && item.number !== '')
          .map((item: any) => ({
            number: item.number || '',
            displayName: item.displayName || item.description || '',
            faClassCode: item.faClassCode || '',
            faSubclassCode: item.faSubclassCode || ''
          }));
      }),
      catchError(error => {
        console.error('❌ Erreur getImmobilisations:', error);
        return of([]);
      })
    );
  }

  /**
   * Récupère une immobilisation par son numéro
   */
  getImmobilisationByNumber(immobilisationNo: string): Observable<Immobilisation | null> {
    if (!immobilisationNo) {
      return of(null);
    }
    return this.getImmobilisations().pipe(
      map(immobilisations => immobilisations.find(i => i.number === immobilisationNo) || null)
    );
  }

  // ==================== TÂCHES ====================

  /**
   * Récupère les tâches depuis l'API SiteManagement
   * GET /api/SiteManagement/my-tasks
   */
  getProjectTasks(projectNo: string): Observable<ProjectTask[]> {
    if (!projectNo) {
      return of([]);
    }
    
    const url = `${this.BASE_URL}/SiteManagement/my-tasks`;
    console.log('📡 Appel API GET tasks depuis:', url, 'pour projet:', projectNo);
    
    return this.http.get<any[]>(url).pipe(
      timeout(10000),
      map(response => {
        if (!Array.isArray(response)) return [];
        
        const filteredTasks = response.filter(task => task.jobNo === projectNo);
        
        console.log(`✅ ${filteredTasks.length} tâches pour le projet ${projectNo}`);
        
        return filteredTasks.map((item: any) => ({
          projectNo: item.jobNo || '',
          taskNo: item.taskNo || '',
          description: item.description || '',
          type: item.type || ''
        }));
      }),
      catchError(error => {
        console.error('❌ Erreur getProjectTasks:', error);
        return of([]);
      })
    );
  }

  // ==================== MÉTHODES UTILITAIRES ====================

  /**
   * Récupère tous les articles et immobilisations (pour recherche globale)
   */
  getAllItems(): Observable<{ articles: Item[], immobilisations: Immobilisation[] }> {
    return forkJoin({
      articles: this.getItems(),
      immobilisations: this.getImmobilisations()
    });
  }

  /**
   * Récupère un article par son numéro
   */
  getArticleByNumber(articleNo: string): Observable<Article | null> {
    if (!articleNo) {
      return of(null);
    }
    return this.getArticles().pipe(
      map(articles => articles.find(a => a.number === articleNo) || null)
    );
  }
}