// src/app/models/purchases/services/purchase-request-line.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
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

  constructor(private http: HttpClient) {}

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

  private decodeLine(line: PurchaseRequestLine): PurchaseRequestLine {
    if (!line) return line;
    return {
      ...line,
      description: this.decodeODataString(line.description),
      description2: this.decodeODataString(line.description2),
      type: this.decodeODataString(line.type),
      no: this.decodeODataString(line.no)
    };
  }

  private decodeLines(lines: PurchaseRequestLine[]): PurchaseRequestLine[] {
    if (!lines || !Array.isArray(lines)) return [];
    return lines.map(line => this.decodeLine(line));
  }

  getByDocumentNo(documentNo: string): Observable<PurchaseRequestLine[]> {
    const params = new HttpParams().set('documentNo', documentNo);
    console.log('📡 Appel API GET lignes:', this.API_URL, { documentNo });
    return this.http.get<PurchaseRequestLine[]>(this.API_URL, { params }).pipe(
      map(lines => this.decodeLines(lines)),
      catchError(error => { 
        console.error('❌ Erreur getByDocumentNo:', error); 
        throw error; 
      })
    );
  }

  /**
   * Créer une nouvelle ligne
   * UNIQUEMENT les champs acceptés par le backend
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
      transferer: line.transferer || false
    };
    
    console.log('📡 Appel API POST ligne (format tableau):', this.API_URL, [cleanedLine]);
    
    return this.http.post<PurchaseRequestLine[]>(this.API_URL, [cleanedLine]).pipe(
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
   * Créer plusieurs lignes en batch
   * UNIQUEMENT les champs acceptés par le backend
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
      transferer: line.transferer || false
    }));
    
    console.log(`📡 Appel API POST batch (${cleanedLines.length} lignes):`, this.API_URL);
    console.log('📡 Données:', JSON.stringify(cleanedLines, null, 2));
    
    return this.http.post<{ message: string }>(this.API_URL, cleanedLines).pipe(
      catchError(error => {
        console.error('❌ Erreur création batch:', error);
        throw error;
      })
    );
  }

  /**
 * Mettre à jour une ligne (PATCH)
 */
update(id: string, updates: UpdatePurchaseRequestLine): Observable<void> {
  // ✅ Nettoyer les données de mise à jour
  const cleanedUpdates: any = {};
  
  // ✅ Ajouter tous les champs possibles
  if (updates.no !== undefined) cleanedUpdates.no = updates.no;
  if (updates.transferer !== undefined) cleanedUpdates.transferer = updates.transferer;
  if (updates.quantity !== undefined) cleanedUpdates.quantity = updates.quantity;
  if (updates.locationCode !== undefined) cleanedUpdates.locationCode = updates.locationCode;
  if (updates.jobTaskNo !== undefined) cleanedUpdates.jobTaskNo = updates.jobTaskNo;
  if (updates.engin !== undefined) cleanedUpdates.engin = updates.engin;
  if (updates.type !== undefined) cleanedUpdates.type = updates.type;
  if (updates.description !== undefined) cleanedUpdates.description = updates.description;
  if (updates.description2 !== undefined) cleanedUpdates.description2 = updates.description2;
  if (updates.unitOfMeasureCode !== undefined) cleanedUpdates.unitOfMeasureCode = updates.unitOfMeasureCode;
  if (updates.variantCode !== undefined) cleanedUpdates.variantCode = updates.variantCode;
  
  console.log('📡 Appel API PATCH ligne:', `${this.API_URL}/${id}`, cleanedUpdates);
  
  return this.http.patch<void>(`${this.API_URL}/${id}`, cleanedUpdates).pipe(
    catchError(error => { 
      console.error('❌ Erreur mise à jour ligne:', error); 
      throw error; 
    })
  );
}

  delete(id: string): Observable<void> {
    console.log('📡 Appel API DELETE ligne:', `${this.API_URL}/${id}`);
    return this.http.delete<void>(`${this.API_URL}/${id}`).pipe(
      catchError(error => { 
        console.error('❌ Erreur suppression ligne:', error); 
        throw error; 
      })
    );
  }

  updateQuantity(id: string, quantity: number): Observable<void> {
    return this.update(id, { quantity });
  }

  toggleTransferer(id: string): Observable<void> {
    return this.update(id, { transferer: true });
  }
}