// src/app/models/purchases/services/purchase-request.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError, delay } from 'rxjs/operators';
import { 
  PurchaseRequest, 
  CreatePurchaseRequest, 
  UpdatePurchaseRequest,
  PurchaseRequestStatus 
} from '../models/purchase-request.model';

@Injectable({
  providedIn: 'root'
})
export class PurchaseRequestService {
  // ✅ URL complète
  private readonly API_URL = 'http://localhost:5227/api/PurchaseRequest';

  constructor(private http: HttpClient) {}

  getAll(params?: {
    jobNo?: string;
    status?: PurchaseRequestStatus;
    requesterId?: string;
  }): Observable<PurchaseRequest[]> {
    let httpParams = new HttpParams();
    
    if (params?.jobNo) httpParams = httpParams.set('jobNo', params.jobNo);
    if (params?.status) httpParams = httpParams.set('status', params.status);
    if (params?.requesterId) httpParams = httpParams.set('requesterId', params.requesterId);
    
    console.log('📡 Appel API PurchaseRequest:', this.API_URL, params);
    
    return this.http.get<PurchaseRequest[]>(this.API_URL, { params: httpParams }).pipe(
      catchError(error => {
        console.error('❌ Erreur getAll:', error);
        return of([]); // Retourner tableau vide en cas d'erreur
      })
    );
  }

  getById(id: string): Observable<PurchaseRequest> {
    return this.http.get<PurchaseRequest>(`${this.API_URL}/${id}`).pipe(
      catchError(error => {
        console.error('❌ Erreur getById:', error);
        throw error;
      })
    );
  }

  create(request: CreatePurchaseRequest): Observable<PurchaseRequest> {
    return this.http.post<PurchaseRequest>(this.API_URL, request).pipe(
      catchError(error => {
        console.error('❌ Erreur création:', error);
        throw error;
      })
    );
  }

  update(id: string, updates: UpdatePurchaseRequest): Observable<void> {
    return this.http.patch<void>(`${this.API_URL}/${id}`, updates).pipe(
      catchError(error => {
        console.error('❌ Erreur mise à jour:', error);
        throw error;
      })
    );
  }

  delete(id: string): Observable<void> {
    return this.http.delete<void>(`${this.API_URL}/${id}`).pipe(
      catchError(error => {
        console.error('❌ Erreur suppression:', error);
        throw error;
      })
    );
  }
}