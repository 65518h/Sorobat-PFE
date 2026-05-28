// src/app/models/gasoil/services/vehicule.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map, of, forkJoin, timeout, catchError, switchMap } from 'rxjs';

export interface Vehicule {
  code: string;
  designation: string;
  statut: string;
  lastPointageDate?: string;
  totalHours?: number;
}

@Injectable({ providedIn: 'root' })
export class VehiculeService {
  private apiUrl = 'http://localhost:5227/api';
  
  // Statuts acceptés pour la consommation de gasoil
  private readonly VALID_STATUSES = ['Fonctionnel', 'Disponible', 'En service', '', null];
  
  constructor(private http: HttpClient) {}
  
  // src/app/modules/gasoil/services/vehicule.service.ts

//  CORRECTION: Utiliser les bonnes URLs
getVehicules(): Observable<Vehicule[]> {
  // D'abord récupérer tous les pointages
  const myPointagesUrl = `${this.apiUrl}/VehiculePointage`;
  console.log(' Appel API GET /my-pointages:', myPointagesUrl);
  
  return this.http.get<any[]>(myPointagesUrl).pipe(
    timeout(10000),
    switchMap(pointages => {
      if (!Array.isArray(pointages) || pointages.length === 0) {
        console.log(' Aucun pointage trouvé');
        return of([]);
      }
      
      console.log(` ${pointages.length} pointages trouvés, récupération des détails...`);
      
      // Pour chaque pointage, récupérer les détails complets (avec lignes)
      const detailRequests = pointages.map(pointage => 
        this.http.get<any>(`${this.apiUrl}/VehiculePointage/${pointage.id}`).pipe(
          timeout(10000),
          catchError(error => {
            console.error(` Erreur récupération pointage ${pointage.id}:`, error);
            return of(null);
          })
        )
      );
      
      return forkJoin(detailRequests).pipe(
        map(details => {
          const uniqueVehicules = new Map<string, Vehicule>();
          
          details.forEach(detail => {
            if (detail && detail.vehiculePointageLines) {
              detail.vehiculePointageLines.forEach((line: any) => {
                const code = line.vehiculeNo;
                const designation = line.description || line.vehiculeNo;
                const statut = line.status || '';
                
                if (code && code.trim() !== '') {
                  if (!uniqueVehicules.has(code)) {
                    uniqueVehicules.set(code, {
                      code: code,
                      designation: designation,
                      statut: statut,
                      lastPointageDate: detail.date,
                      totalHours: line.hoursWorked || 0
                    });
                  }
                }
              });
            }
          });
          
          const vehicules = Array.from(uniqueVehicules.values());
          console.log(` ${vehicules.length} véhicules uniques récupérés`);
          return vehicules;
        })
      );
    }),
    catchError(error => {
      console.error(' Erreur getVehicules:', error);
      return of([]);
    })
  );
}
  
  /**
   *  Récupère uniquement les véhicules éligibles pour la consommation de gasoil
   */
  getVehiculesForGasoil(): Observable<Vehicule[]> {
    return this.getVehicules().pipe(
      map(vehicules => vehicules.filter(v => this.isEligibleForGasoil(v.statut)))
    );
  }
  
  /**
   * Vérifie si un véhicule est éligible pour la consommation de gasoil
   */
  isEligibleForGasoil(statut: string): boolean {
    if (!statut || statut.trim() === '') {
      return true; // Statut vide = considéré comme fonctionnel par défaut
    }
    return this.VALID_STATUSES.includes(statut.trim());
  }
  
  /**
   * Vérifie si un véhicule est réformé ou en panne
   */
  isVehiculeDisabled(statut: string): boolean {
    const disabledStatuses = ['Réformé', 'Panne'];
    return disabledStatuses.includes(statut?.trim());
  }
  
  /**
   * Récupère le statut d'un véhicule avec une classe CSS correspondante
   */
  getVehiculeStatusClass(statut: string): string {
    const statusMap: Record<string, string> = {
      'Fonctionnel': 'status-functional',
      'Disponible': 'status-available',
      'En service': 'status-active',
      'Réformé': 'status-scrapped',
      'Panne': 'status-broken'
    };
    return statusMap[statut?.trim()] || 'status-unknown';
  }
}