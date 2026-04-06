// src/app/equipment/services/equipment.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class EquipmentService {
  constructor(private http: HttpClient) {}
  
  getAll(): Observable<any[]> {
    return this.http.get<any[]>('/api/equipment');
  }
}