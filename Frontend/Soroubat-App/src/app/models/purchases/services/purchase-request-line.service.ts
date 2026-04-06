// src/app/models/purchases/services/purchase-request-line.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { 
  PurchaseRequestLine, 
  CreatePurchaseRequestLine, 
  UpdatePurchaseRequestLine 
} from '../models/purchase-request-line.model';

@Injectable({
  providedIn: 'root'
})
export class PurchaseRequestLineService {
  // ✅ URL complète avec majuscules
  private readonly API_URL = 'http://localhost:5227/api/PurchaseRequest/lines';

  constructor(private http: HttpClient) {}

  /**
   * Récupérer toutes les lignes d'une demande
   * @param documentNo Numéro du document parent
   */
  getByDocumentNo(documentNo: string): Observable<PurchaseRequestLine[]> {
    let params = new HttpParams().set('documentNo', documentNo);
    console.log('📡 Appel API lignes:', `${this.API_URL}`, { documentNo });
    
    return this.http.get<PurchaseRequestLine[]>(this.API_URL, { params }).pipe(
      catchError(error => {
        console.error('❌ Erreur getByDocumentNo:', error);
        throw error;
      })
    );
  }

  /**
   * Créer une nouvelle ligne
   * @param line Données de la ligne
   */
  create(line: CreatePurchaseRequestLine): Observable<PurchaseRequestLine> {
    console.log('📡 Création ligne:', line);
    
    return this.http.post<PurchaseRequestLine>(this.API_URL, line).pipe(
      catchError(error => {
        console.error('❌ Erreur création ligne:', error);
        throw error;
      })
    );
  }

  /**
   * Mettre à jour une ligne (PATCH)
   * @param id SystemId de la ligne
   * @param updates Champs à modifier
   */
  update(id: string, updates: UpdatePurchaseRequestLine): Observable<void> {
    console.log('📡 Mise à jour ligne:', id, updates);
    
    return this.http.patch<void>(`${this.API_URL}/${id}`, updates).pipe(
      catchError(error => {
        console.error('❌ Erreur mise à jour ligne:', error);
        throw error;
      })
    );
  }

  /**
   * Supprimer une ligne
   * @param id SystemId de la ligne
   */
  delete(id: string): Observable<void> {
    console.log('📡 Suppression ligne:', id);
    
    return this.http.delete<void>(`${this.API_URL}/${id}`).pipe(
      catchError(error => {
        console.error('❌ Erreur suppression ligne:', error);
        throw error;
      })
    );
  }

  /**
   * Mettre à jour le flag transferer pour plusieurs lignes
   * @param lineIds IDs des lignes
   * @param transferer Valeur à appliquer
   */
  batchUpdateTransferer(lineIds: string[], transferer: boolean): Observable<void> {
    console.log('📡 Mise à jour batch transferer:', { lineIds, transferer });
    
    return this.http.patch<void>(`${this.API_URL}/batchTransferer`, { lineIds, transferer }).pipe(
      catchError(error => {
        console.error('❌ Erreur batchUpdateTransferer:', error);
        throw error;
      })
    );
  }
}