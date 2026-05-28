// src/app/core/services/lookup.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface LookupItem {
  id: string;
  code: string;
  name: string;
  city?: string;
  countryRegionCode?: string;
}

@Injectable({
  providedIn: 'root'
})
export class LookupService {
  private http = inject(HttpClient);
  private readonly API_URL = 'http://localhost:5227/api/Lookup';

  /**
   * Récupère la liste des chauffeurs (shippingAgents)
   */
  getDrivers(): Observable<{ value: LookupItem[] }> {
    return this.http.get<{ value: LookupItem[] }>(`${this.API_URL}/shippingAgents`);
  }

  /**
   * Récupère la liste des destinations (postCodes)
   */
  getDestinations(): Observable<{ value: LookupItem[] }> {
    return this.http.get<{ value: LookupItem[] }>(`${this.API_URL}/postCodes`);
  }
}