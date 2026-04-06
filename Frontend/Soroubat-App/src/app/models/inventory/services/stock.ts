// src/app/inventory/services/stock.service.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface StockAvailability {
  itemNo: string;
  locationCode: string;
  stockAvailable: number;
  stockInProgress: number;
  quantityOrderedNotDelivered: number;
  isSufficient: boolean;
}

@Injectable({ providedIn: 'root' })
export class StockService {
  constructor(private http: HttpClient) {}
  
  checkAvailability(itemNo: string, locationCode: string): Observable<StockAvailability> {
    return this.http.get<StockAvailability>(`/api/stock/check?itemNo=${itemNo}&locationCode=${locationCode}`);
  }
}