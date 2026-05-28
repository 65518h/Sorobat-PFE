// src/app/modules/purchases/services/purchase-request.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of, throwError, from } from 'rxjs';
import { catchError, timeout, retry, map, tap, switchMap } from 'rxjs/operators';
import { 
  PurchaseRequest, 
  CreatePurchaseRequest, 
  UpdatePurchaseRequest
} from '../models/purchase-request.model';
import { CacheService } from '../../../core/services/cache.service';
import { OfflineSyncService } from '../../../core/services/offline-sync.service';

@Injectable({
  providedIn: 'root'
})
export class PurchaseRequestService {
  private readonly API_URL = 'http://localhost:5227/api/PurchaseRequest';
  private readonly TIMEOUT_MS = 30000;

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private offlineSync: OfflineSyncService
  ) {}

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
   * Normalise le statut
   */
  private normalizeStatus(status: string | undefined): string {
    if (!status) return 'Ouvert';
    
    let cleanStatus = status.replace(/_x0020_/g, ' ');
    
    const statusMap: Record<string, string> = {
      'Open': 'Ouvert',
      'To Approve': 'Released',
      'Released': 'Released',
      'Pending Approval': 'En cours',
      'In Progress': 'En cours',
      'Completed': 'Totallement Pris En Charge',
      'Rejected': 'Rejeté',
      'Draft': 'Brouillon'
    };
    
    const frenchStatuses = ['Ouvert', 'Released', 'En cours', 'Partiellement Pris En Charge', 'Totallement Pris En Charge', 'Archiver'];
    if (frenchStatuses.includes(cleanStatus)) {
      return cleanStatus;
    }
    
    const mappedStatus = statusMap[cleanStatus];
    if (mappedStatus) {
      return mappedStatus;
    }
    
    return cleanStatus;
  }

  /**
   * Décode une demande d'achat - ALIGNÉ AVEC PurchaseRequestReadDto
   */
  private decodePurchaseRequest(request: any): PurchaseRequest {
    if (!request) return request;
    
    return {
      id: request.id,
      no: request.no,
      jobNo: request.jobNo,
      jobDescription: this.decodeODataString(request.jobDescription),
      requestType: this.decodeODataString(request.requestType),
      engin: request.engin,
      descriptionEngin: this.decodeODataString(request.descriptionEngin),
      locationCode: request.locationCode,
      dateSaisie: request.dateSaisie,
      statut: this.normalizeStatus(request.statut),
      observation: this.decodeODataString(request.observation),
      purchaseRequestLines: request.purchaseRequestLines?.map((line: any) => this.decodePurchaseRequestLine(line)) || []
    };
  }

  /**
   * Décode une ligne de demande - ALIGNÉ AVEC PurchaseRequestLineReadDto
   */
  private decodePurchaseRequestLine(line: any): any {
    if (!line) return line;
    return {
      id: line.id,
      documentNo: line.documentNo,
      lineNo: line.lineNo,
      type: this.decodeODataString(line.type),
      no: line.no,
      description: this.decodeODataString(line.description),
      observation: this.decodeODataString(line.observation),
      quantity: line.quantity,
      unitOfMeasureCode: line.unitOfMeasureCode,
      locationCode: line.locationCode,
      jobNo: line.jobNo,
      jobTaskNo: line.jobTaskNo
    };
  }

  /**
   * Récupère toutes les demandes avec cache offline
   */
  getAll(params?: {
    jobNo?: string;
  }): Observable<PurchaseRequest[]> {
    let httpParams = new HttpParams();
    
    if (params?.jobNo) httpParams = httpParams.set('jobNo', params.jobNo);
    
    //  Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return this.getFromCacheOffline();
    }
    
    //  Mode en ligne - appel API
    console.log(' Appel API GET all:', this.API_URL, { params });
    
    return this.http.get<any[]>(this.API_URL, { params: httpParams }).pipe(
      timeout(this.TIMEOUT_MS),
      retry(1),
      map(requests => this.decodePurchaseRequests(requests)),
      tap(requests => {
        // Mettre en cache les résultats
        this.cacheService.savePurchaseRequests(requests);
      }),
      catchError(error => {
        console.error(' Erreur getAll:', error);
        // En cas d'erreur API, essayer le cache
        return this.getFromCacheOffline();
      })
    );
  }

  /**
   * Récupère les demandes depuis le cache (mode offline)
   */
  private getFromCacheOffline(): Observable<PurchaseRequest[]> {
    return from(this.cacheService.getPurchaseRequests()).pipe(
      map(cached => {
        if (cached && cached.length > 0) {
          console.log(` Mode offline - ${cached.length} demande(s) d'achat depuis cache`);
          return this.decodePurchaseRequests(cached);
        }
        console.log(' Mode offline - Aucune demande d\'achat en cache');
        return [];
      })
    );
  }

  /**
   * Récupère une demande par son ID avec cache offline
   */
  getById(id: string): Observable<PurchaseRequest> {
    if (!id) {
      return throwError(() => new Error('ID requis pour récupérer une demande'));
    }
    
    //  Si mode offline, essayer le cache
    if (!this.offlineSync.isOnline) {
      return from(this.cacheService.getPurchaseRequest(id)).pipe(
        switchMap(cached => {
          if (cached) {
            console.log(` Mode offline - Détail demande ${id} depuis cache`);
            return of(this.decodePurchaseRequest(cached));
          }
          return throwError(() => new Error('Demande non trouvée en cache'));
        })
      );
    }
    
    //  Mode en ligne - appel API
    console.log(' Appel API GET by id:', `${this.API_URL}/${id}`);
    
    return this.http.get<any>(`${this.API_URL}/${id}`).pipe(
      timeout(this.TIMEOUT_MS),
      retry(1),
      map(request => this.decodePurchaseRequest(request)),
      tap(request => {
        // Mettre en cache
        this.cacheService.savePurchaseRequest(id, request);
      }),
      catchError(error => {
        console.error(' Erreur getById:', error);
        // En cas d'erreur, essayer le cache
        return from(this.cacheService.getPurchaseRequest(id)).pipe(
          switchMap(cached => {
            if (cached) {
              console.log(` Utilisation cache pour ${id}`);
              return of(this.decodePurchaseRequest(cached));
            }
            return throwError(() => error);
          })
        );
      })
    );
  }

  /**
   * Décode une liste de demandes
   */
  private decodePurchaseRequests(requests: any[]): PurchaseRequest[] {
    if (!requests || !Array.isArray(requests)) return [];
    return requests.map(req => this.decodePurchaseRequest(req));
  }

  /**
   * Crée une nouvelle demande d'achat - ALIGNÉ AVEC PurchaseRequestCreateDto
   */
  create(request: CreatePurchaseRequest): Observable<PurchaseRequest> {
    //  UNIQUEMENT les champs acceptés par le backend
    const cleanedRequest = {
      jobNo: request.jobNo,
      requestType: request.requestType,
      engin: request.engin || '',
      locationCode: request.locationCode || '',
      observation: request.observation || ''
    };
    
    console.log(' Appel API POST header:', this.API_URL, cleanedRequest);
    
    return this.http.post<any>(this.API_URL, cleanedRequest).pipe(
      timeout(this.TIMEOUT_MS),
      map(request => this.decodePurchaseRequest(request)),
      tap(request => {
        // Invalider le cache après création
        this.cacheService.invalidatePurchaseRequests();
        if (request.id) {
          this.cacheService.savePurchaseRequest(request.id, request);
        }
      }),
      catchError(error => {
        console.error(' Erreur création header:', error);
        return throwError(() => error);
      })
    );
  }

  /**
   * Met à jour une demande d'achat - ALIGNÉ AVEC PurchaseRequestPatchDto
   */
  update(id: string, updates: UpdatePurchaseRequest): Observable<void> {
    if (!id) {
      return throwError(() => new Error('ID requis pour mettre à jour une demande'));
    }
    
    //  UNIQUEMENT les champs modifiables
    const cleanedUpdates: any = {};
    if (updates.requestType !== undefined) cleanedUpdates.requestType = updates.requestType;
    if (updates.engin !== undefined) cleanedUpdates.engin = updates.engin;
    if (updates.locationCode !== undefined) cleanedUpdates.locationCode = updates.locationCode;
    if (updates.observation !== undefined) cleanedUpdates.observation = updates.observation;
    
    console.log('📡 Appel API PATCH:', `${this.API_URL}/${id}`, cleanedUpdates);
    
    return this.http.patch<void>(`${this.API_URL}/${id}`, cleanedUpdates).pipe(
      timeout(this.TIMEOUT_MS),
      tap(() => {
        // Invalider le cache après mise à jour
        this.cacheService.invalidatePurchaseRequests();
        this.cacheService.invalidateCache(`purchase-request-${id}`);
      }),
      catchError(error => {
        console.error(' Erreur mise à jour:', error);
        return throwError(() => error);
      })
    );
  }

  /**
   * Supprime une demande d'achat
   */
  delete(id: string): Observable<void> {
    if (!id) {
      return throwError(() => new Error('ID requis pour supprimer une demande'));
    }
    
    console.log(' Appel API DELETE:', `${this.API_URL}/${id}`);
    
    return this.http.delete<void>(`${this.API_URL}/${id}`).pipe(
      timeout(this.TIMEOUT_MS),
      tap(() => {
        // Invalider le cache après suppression
        this.cacheService.invalidatePurchaseRequests();
        this.cacheService.invalidateCache(`purchase-request-${id}`);
      }),
      catchError(error => {
        console.error(' Erreur suppression:', error);
        return throwError(() => error);
      })
    );
  }

  /**
   * Met à jour uniquement le statut d'une demande
   */
  updateStatus(id: string, status: string): Observable<void> {
    let apiStatus = status;
    if (status === 'To Approve') {
      apiStatus = 'Released';
    } else if (status === 'Open') {
      apiStatus = 'Ouvert';
    }
    
    console.log(` Mise à jour statut: ${id} → ${apiStatus}`);
    return this.update(id, { status: apiStatus } as any);
  }

  // src/app/modules/purchases/services/purchase-request.service.ts

/**
 * Soumet une demande à l'approbation - POST /api/PurchaseRequest/{id}/submit
 */
submitToApprove(id: string): Observable<PurchaseRequest> {
  if (!id) {
    return throwError(() => new Error('ID requis pour soumettre à l\'approbation'));
  }
  
  console.log(' Appel API submitToApprove:', `${this.API_URL}/${id}/submit`);
  
  // D'abord soumettre la demande
  return this.http.post<any>(`${this.API_URL}/${id}/submit`, {}).pipe(
    timeout(this.TIMEOUT_MS),
    switchMap((response) => {
      console.log('📡 Réponse submit:', response);
      //: Invalider le cache IMMÉDIATEMENT après la soumission
      this.cacheService.invalidatePurchaseRequests();
      this.cacheService.invalidateCache(`purchase-request-${id}`);
      // Recharger la demande mise à jour
      return this.getById(id);
    }),
    tap(request => {
      console.log(' Demande mise à jour après submit:', request);
      // Sauvegarder la nouvelle version
      this.cacheService.savePurchaseRequest(request.id!, request);
    }),
    catchError(error => {
      console.error(' Erreur submitToApprove:', error);
      return throwError(() => error);
    })
  );
}

  // ==================== MÉTHODES STATISTIQUES ====================

  getByProject(jobNo: string): Observable<PurchaseRequest[]> {
    return this.getAll({ jobNo });
  }

  getOpenRequests(): Observable<PurchaseRequest[]> {
    return this.getAll().pipe(
      map(requests => requests.filter(r => r.statut === 'Ouvert'))
    );
  }
}

export { PurchaseRequestService as va};