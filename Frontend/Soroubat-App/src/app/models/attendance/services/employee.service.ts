// src/app/modules/attendance/services/employee.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, from } from 'rxjs';
import { map, catchError, tap, switchMap } from 'rxjs/operators';
import { CacheService } from '../../../core/services/cache.service';
import { AppModeService } from '../../../core/services/app-mode.service';

export interface Employee {
  matricule: string;
  id: string;
  firstName: string;
  lastName: string;
  fonction: string;
  chantier: string;
  employeeName?: string;
  employeeNo?: string;
}

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {
  private apiUrl = 'http://localhost:5227/api/Lookup';
  
  private readonly CACHE_KEY_EMPLOYEES = 'all-employees';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private appMode: AppModeService
  ) {}

  /**
   * Récupère tous les employés avec cache offline
   */
  getAllEmployees(): Observable<Employee[]> {
    console.log(' Appel API GET /api/Lookup/employees');
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_EMPLOYEES)).pipe(
      switchMap(cachedEmployees => {
        if (cachedEmployees && isOffline) {
          console.log(` Mode offline - ${cachedEmployees.length} employés chargés depuis le cache`);
          return of(cachedEmployees);
        }
        
        return this.http.get<{ value: Employee[] }>(`${this.apiUrl}/employees`).pipe(
          map(response => {
            const employees = response.value || [];
            console.log(` ${employees.length} employés reçus de l'API`);
            
            return employees.map(emp => ({
              ...emp,
              employeeName: `${emp.lastName} ${emp.firstName}`.trim(),
              employeeNo: emp.matricule
            }));
          }),
          tap(employees => {
            this.cacheService.saveToCache(this.CACHE_KEY_EMPLOYEES, employees);
            console.log(` ${employees.length} employés sauvegardés en cache`);
          }),
          catchError(error => {
            console.error(' Erreur getAllEmployees:', error);
            if (cachedEmployees) {
             
              return of(cachedEmployees);
            }
            return of([]);
          })
        );
      })
    );
  }

  async preloadForOffline(): Promise<boolean> {
    console.log(' Préchargement de la liste des employés...');
    
    try {
      const employees = await this.getAllEmployees().toPromise();
      if (employees && employees.length > 0) {
        console.log(` ${employees.length} employés préchargés pour offline`);
        return true;
      }
      return false;
    } catch (error) {
      console.error(' Erreur préchargement employés:', error);
      return false;
    }
  }

  /**
   * Récupère les employés avec filtre - CORRIGÉ
   */
  getEmployees(filter?: string): Observable<{ value: Employee[] }> {
    //  CORRECTION: Utiliser 'employees' au lieu de 'employe'
    let url = `${this.apiUrl}/employees`;
    if (filter) {
      url += `?$filter=${encodeURIComponent(filter)}`;
    }
    console.log(' URL getEmployees:', url);
    return this.http.get<{ value: Employee[] }>(url);
  }

  /**
   * Recherche des employés par terme
   */
  searchEmployees(searchTerm: string): Observable<{ value: Employee[] }> {
    if (!searchTerm || searchTerm.trim() === '') {
      return this.getEmployees();
    }
    const filter = `contains(firstName, '${searchTerm}') or contains(lastName, '${searchTerm}') or contains(matricule, '${searchTerm}')`;
    return this.getEmployees(filter);
  }

  /**
   * Récupère les employés avec pagination - CORRIGÉ
   */
  getEmployeesPaginated(page: number = 1, pageSize: number = 20, searchTerm: string = ''): Observable<any> {
    //  CORRECTION: URL de base correcte
    let url = `${this.apiUrl}/employees`;
    const params: string[] = [];
    
    params.push(`$skip=${(page - 1) * pageSize}`);
    params.push(`$top=${pageSize}`);
    
    if (searchTerm && searchTerm.trim() !== '') {
      const term = searchTerm.trim();
      params.push(`$filter=contains(firstName, '${term}') or contains(lastName, '${term}') or contains(matricule, '${term}')`);
    }
    
    if (params.length > 0) {
      url += `?${params.join('&')}`;
    }
    
    console.log(' URL getEmployeesPaginated:', url);
    return this.http.get<{ value: Employee[] }>(url);
  }

  searchEmployeesPaginated(page: number = 1, pageSize: number = 20, searchTerm: string = ''): Observable<any> {
    return this.getEmployeesPaginated(page, pageSize, searchTerm);
  }

  /**
   * Vérifie si un matricule existe - CORRIGÉ
   */
  checkMatriculeExists(matricule: string): Observable<boolean> {
    const filter = `matricule eq '${matricule}'`;
    return this.getEmployees(filter).pipe(
      map(response => response.value && response.value.length > 0)
    );
  }

  /**
   * Récupère un employé par son matricule - CORRIGÉ
   */
  getEmployeeByMatricule(matricule: string): Observable<Employee | null> {
    //  CORRECTION: Utiliser 'employees' au lieu de 'employe'
    const filter = `matricule eq '${matricule}'`;
    const url = `${this.apiUrl}/employees?$filter=${encodeURIComponent(filter)}`;
    
    console.log(' URL de recherche employé (CORRIGÉE):', url);
    
    return this.http.get<{ value: Employee[] }>(url).pipe(
      map(response => {
        console.log(' Réponse API:', response);
        const employees = response.value || [];
        const exactMatch = employees.find(emp => emp.matricule === matricule);
        
        if (exactMatch) {
          console.log(' Employé trouvé:', exactMatch);
          return {
            ...exactMatch,
            employeeName: `${exactMatch.lastName} ${exactMatch.firstName}`.trim(),
            employeeNo: exactMatch.matricule
          };
        }
        console.log(' Aucun employé trouvé avec matricule:', matricule);
        return null;
      }),
      catchError(error => {
        console.error(' Erreur getEmployeeByMatricule:', error);
        return of(null);
      })
    );
  }
}