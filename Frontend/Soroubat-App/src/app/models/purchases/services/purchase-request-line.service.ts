// src/app/modules/purchases/services/purchase-request-line.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, map, timeout } from 'rxjs/operators';
import { 
  PurchaseRequestLine, 
  CreatePurchaseRequestLine, 
  UpdatePurchaseRequestLine 
} from '../models/purchase-request-line.model';

@Injectable({
  providedIn: 'root'
})
export class PurchaseRequestLineService {
  private readonly API_URL = 'http://localhost:5227/api/PurchaseRequest/lines';
  private readonly TIMEOUT_MS = 30000;

  constructor(private http: HttpClient) {}

  /**
   * Décode les chaînes encodées par OData
   */
  private decodeODataString(str: string | undefined): string {
    if (!str) return '';
    return str
      .replace(/_x0020_/g, ' ')
      .replace(/_x0028_/g, '(')
      .replace(/_x0029_/g, ')')
      .replace(/_x002F_/g, '/')
      .replace(/_x0026_/g, '&')
      .replace(/_x003C_/g, '<')
      .replace(/_x003E_/g, '>')
      .replace(/_x0022_/g, '"')
      .replace(/_x0027_/g, "'")
      .replace(/_x005F_/g, '_');
  }

  /**
   * Décode une ligne - ALIGNÉ AVEC PurchaseRequestLineReadDto
   */
  private decodeLine(line: any): PurchaseRequestLine {
    if (!line) return line;
    return {
      id: line.id,
      documentNo: line.documentNo,
      lineNo: line.lineNo,
      type: this.decodeODataString(line.type),
      no: line.no,
      description: this.decodeODataString(line.description),
      observation: this.decodeODataString(line.observation),
      quantity: line.quantity || 0,
      unitOfMeasureCode: line.unitOfMeasureCode,
      locationCode: line.locationCode,
      jobNo: line.jobNo,
      jobTaskNo: line.jobTaskNo
    };
  }

  /**
   * Décode une liste de lignes
   */
  private decodeLines(lines: any[]): PurchaseRequestLine[] {
    if (!lines || !Array.isArray(lines)) return [];
    return lines.map(line => this.decodeLine(line));
  }

  /**
   * Récupère les lignes par numéro de document
   */
  getByDocumentNo(documentNo: string): Observable<PurchaseRequestLine[]> {
    const params = new HttpParams().set('documentNo', documentNo);
    console.log('📡 Appel API GET lignes:', this.API_URL, { documentNo });
    
    return this.http.get<any[]>(this.API_URL, { params }).pipe(
      timeout(this.TIMEOUT_MS),
      map(lines => this.decodeLines(lines)),
      catchError(error => { 
        console.error('❌ Erreur getByDocumentNo:', error); 
        throw error; 
      })
    );
  }

  /**
   * Créer une nouvelle ligne - ALIGNÉ AVEC PurchaseRequestLineCreateDto
   */
  create(line: CreatePurchaseRequestLine): Observable<PurchaseRequestLine> {
    // ✅ UNIQUEMENT les champs attendus par le backend
    const cleanedLine = {
      documentNo: line.documentNo,
      jobNo: line.jobNo,
      jobTaskNo: line.jobTaskNo || '0',
      type: line.type,
      no: line.no,
      quantity: line.quantity,
      locationCode: line.locationCode || '',
      observation: line.observation || ''
    };
    
    console.log('📡 Appel API POST ligne:', this.API_URL, cleanedLine);
    
    return this.http.post<any[]>(this.API_URL, [cleanedLine]).pipe(
      timeout(this.TIMEOUT_MS),
      map(createdLines => this.decodeLine(createdLines[0])),
      catchError(error => {
        console.error('❌ Erreur création ligne:', error);
        if (error.error?.errors) {
          console.error('❌ Erreurs de validation:', JSON.stringify(error.error.errors, null, 2));
        }
        throw error;
      })
    );
  }

  /**
   * Créer plusieurs lignes en batch - ALIGNÉ AVEC PurchaseRequestLineCreateDto
   */
  createBatch(lines: CreatePurchaseRequestLine[]): Observable<{ message: string }> {
    // ✅ UNIQUEMENT les champs attendus par le backend
    const cleanedLines = lines.map(line => ({
      documentNo: line.documentNo,
      jobNo: line.jobNo,
      jobTaskNo: line.jobTaskNo || '0',
      type: line.type,
      no: line.no,
      quantity: line.quantity,
      locationCode: line.locationCode || '',
      observation: line.observation || ''
    }));
    
    console.log(`📡 Appel API POST batch (${cleanedLines.length} lignes):`, this.API_URL);
    console.log('📡 Données:', JSON.stringify(cleanedLines, null, 2));
    
    return this.http.post<{ message: string }>(this.API_URL, cleanedLines).pipe(
      timeout(this.TIMEOUT_MS),
      catchError(error => {
        console.error('❌ Erreur création batch:', error);
        throw error;
      })
    );
  }

  /**
   * Mettre à jour une ligne (PATCH) - ALIGNÉ AVEC PurchaseRequestLinePatchDto
   */
  update(id: string, updates: UpdatePurchaseRequestLine): Observable<void> {
    if (!id) {
      return throwError(() => new Error('ID requis pour mettre à jour une ligne'));
    }
    
    // ✅ UNIQUEMENT les champs modifiables
    const cleanedUpdates: any = {};
    
    if (updates.type !== undefined) cleanedUpdates.type = updates.type;
    if (updates.no !== undefined) cleanedUpdates.no = updates.no;
    if (updates.description !== undefined) cleanedUpdates.description = updates.description;
    if (updates.observation !== undefined) cleanedUpdates.observation = updates.observation;
    if (updates.quantity !== undefined) cleanedUpdates.quantity = updates.quantity;
    if (updates.locationCode !== undefined) cleanedUpdates.locationCode = updates.locationCode;
    if (updates.jobTaskNo !== undefined) cleanedUpdates.jobTaskNo = updates.jobTaskNo;
    
    console.log('📡 Appel API PATCH ligne:', `${this.API_URL}/${id}`, cleanedUpdates);
    
    return this.http.patch<void>(`${this.API_URL}/${id}`, cleanedUpdates).pipe(
      timeout(this.TIMEOUT_MS),
      catchError(error => { 
        console.error('❌ Erreur mise à jour ligne:', error); 
        throw error; 
      })
    );
  }

  /**
   * Supprime une ligne
   */
  delete(id: string): Observable<void> {
    if (!id) {
      return throwError(() => new Error('ID requis pour supprimer une ligne'));
    }
    
    console.log('📡 Appel API DELETE ligne:', `${this.API_URL}/${id}`);
    
    return this.http.delete<void>(`${this.API_URL}/${id}`).pipe(
      timeout(this.TIMEOUT_MS),
      catchError(error => { 
        console.error('❌ Erreur suppression ligne:', error); 
        throw error; 
      })
    );
  }

  /**
   * Met à jour la quantité d'une ligne
   */
  updateQuantity(id: string, quantity: number): Observable<void> {
    return this.update(id, { quantity });
  }
}