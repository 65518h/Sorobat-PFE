// src/app/models/purchases/services/approval.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError, map, delay } from 'rxjs/operators';
import { ApprovalHistory, ApprovalRequest, ApprovalDecision } from '../models/approval.model';

@Injectable({
  providedIn: 'root'
})
export class ApprovalService {
  
  //  URL complète avec majuscules
  private readonly API_URL = 'http://localhost:5227/api/PurchaseRequest';

  constructor(private http: HttpClient) {}

  /**
   * Approuver une demande
   * @param documentNo Numéro de la demande
   * @param comment Commentaire optionnel
   */
  approveRequest(documentNo: string, comment?: string): Observable<void> {
    console.log('📡 Approbation demande:', documentNo, comment);
    
    const body: any = { decision: ApprovalDecision.APPROVED };
    if (comment) body.comment = comment;
    
    return this.http.post<void>(`${this.API_URL}/${documentNo}/approve`, body).pipe(
      catchError(error => {
        console.error(' Erreur approveRequest:', error);
        throw error;
      })
    );
  }

  /**
   * Refuser une demande
   * @param documentNo Numéro de la demande
   * @param reason Motif du refus
   */
  refuseRequest(documentNo: string, reason: string): Observable<void> {
    console.log(' Refus demande:', documentNo, reason);
    
    const body = { 
      decision: ApprovalDecision.REFUSED,
      reason: reason 
    };
    
    return this.http.post<void>(`${this.API_URL}/${documentNo}/refuse`, body).pipe(
      catchError(error => {
        console.error(' Erreur refuseRequest:', error);
        throw error;
      })
    );
  }

  /**
   * Approuver une ligne spécifique
   * @param lineId SystemId de la ligne
   * @param comment Commentaire optionnel
   */
  approveLine(lineId: string, comment?: string): Observable<void> {
    console.log(' Approbation ligne:', lineId, comment);
    
    const body: any = { decision: ApprovalDecision.APPROVED };
    if (comment) body.comment = comment;
    
    return this.http.post<void>(`${this.API_URL}/lines/${lineId}/approve`, body).pipe(
      catchError(error => {
        console.error(' Erreur approveLine:', error);
        throw error;
      })
    );
  }

  /**
   * Refuser une ligne
   * @param lineId SystemId de la ligne
   * @param reason Motif du refus
   */
  refuseLine(lineId: string, reason: string): Observable<void> {
    console.log(' Refus ligne:', lineId, reason);
    
    const body = {
      decision: ApprovalDecision.REFUSED,
      reason: reason
    };
    
    return this.http.post<void>(`${this.API_URL}/lines/${lineId}/refuse`, body).pipe(
      catchError(error => {
        console.error(' Erreur refuseLine:', error);
        throw error;
      })
    );
  }

  /**
   * Récupérer l'historique des validations
   * @param documentNo Numéro de la demande
   */
  getApprovalHistory(documentNo: string): Observable<ApprovalHistory[]> {
    console.log(' Historique validations:', documentNo);
    
    return this.http.get<ApprovalHistory[]>(`${this.API_URL}/${documentNo}/approvalHistory`).pipe(
      map(history => {
        //  Transformer les dates en objets Date
        return history.map(item => ({
          ...item,
          approvalDate: new Date(item.approvalDate)
        }));
      }),
      catchError(error => {
        console.error(' Erreur getApprovalHistory:', error);
        //  Retourner un tableau vide en cas d'erreur
        return of([]);
      })
    );
  }

  /**
   * Vérifier si une demande est déjà approuvée
   * @param documentNo Numéro de la demande
   */
  isApproved(documentNo: string): Observable<boolean> {
    return this.getApprovalHistory(documentNo).pipe(
      map(history => history.some(item => item.decision === ApprovalDecision.APPROVED)),
      catchError(() => of(false))
    );
  }

  /**
   * Récupérer la dernière approbation
   * @param documentNo Numéro de la demande
   */
  getLastApproval(documentNo: string): Observable<ApprovalHistory | null> {
    return this.getApprovalHistory(documentNo).pipe(
      map(history => history.length > 0 ? history[history.length - 1] : null)
    );
  }

  /**
   * Vérifier si l'utilisateur courant peut approuver
   * @param documentNo Numéro de la demande
   * @param userId ID de l'utilisateur
   */
  canApprove(documentNo: string, userId: string): Observable<boolean> {
    //  Logique à adapter selon vos règles métier
    return this.http.get<{ canApprove: boolean }>(`${this.API_URL}/${documentNo}/canApprove?userId=${userId}`).pipe(
      map(response => response.canApprove),
      catchError(() => of(false))
    );
  }

  /**
   * Récupérer les approbations en attente pour un utilisateur
   * @param userId ID de l'utilisateur
   */
  getPendingApprovals(userId: string): Observable<ApprovalHistory[]> {
    let params = new HttpParams().set('userId', userId).set('status', 'pending');
    
    return this.http.get<ApprovalHistory[]>(`${this.API_URL}/pending-approvals`, { params }).pipe(
      map(approvals => approvals.map(a => ({
        ...a,
        approvalDate: new Date(a.approvalDate)
      }))),
      catchError(error => {
        console.error(' Erreur getPendingApprovals:', error);
        return of([]);
      })
    );
  }

  /**
   * Soumettre une demande pour approbation
   * @param documentNo Numéro de la demande
   * @param approvers Liste des approbateurs
   */
  submitForApproval(documentNo: string, approvers: string[]): Observable<void> {
    console.log(' Soumission pour approbation:', documentNo, approvers);
    
    return this.http.post<void>(`${this.API_URL}/${documentNo}/submit`, { approvers }).pipe(
      catchError(error => {
        console.error(' Erreur submitForApproval:', error);
        throw error;
      })
    );
  }

  /**
   * Annuler une demande d'approbation
   * @param documentNo Numéro de la demande
   */
  cancelApproval(documentNo: string): Observable<void> {
    console.log(' Annulation approbation:', documentNo);
    
    return this.http.post<void>(`${this.API_URL}/${documentNo}/cancel-approval`, {}).pipe(
      catchError(error => {
        console.error(' Erreur cancelApproval:', error);
        throw error;
      })
    );
  }

  /**
   * Récupérer les statistiques d'approbation
   * @param userId ID de l'utilisateur (optionnel)
   */
  getApprovalStats(userId?: string): Observable<{
    pending: number;
    approved: number;
    rejected: number;
    total: number;
  }> {
    let params = new HttpParams();
    if (userId) params = params.set('userId', userId);
    
    return this.http.get<{
      pending: number;
      approved: number;
      rejected: number;
      total: number;
    }>(`${this.API_URL}/approval-stats`, { params }).pipe(
      catchError(error => {
        console.error(' Erreur getApprovalStats:', error);
        return of({ pending: 0, approved: 0, rejected: 0, total: 0 });
      })
    );
  }

  /**
   * Récupérer les notifications d'approbation pour un utilisateur
   * @param userId ID de l'utilisateur
   */
  getApprovalNotifications(userId: string): Observable<Array<{
    id: string;
    documentNo: string;
    message: string;
    date: Date;
    read: boolean;
  }>> {
    let params = new HttpParams().set('userId', userId);
    
    return this.http.get<any[]>(`${this.API_URL}/approval-notifications`, { params }).pipe(
      map(notifications => notifications.map(n => ({
        ...n,
        date: new Date(n.date)
      }))),
      catchError(error => {
        console.error(' Erreur getApprovalNotifications:', error);
        return of([]);
      })
    );
  }

  /**
   * Marquer une notification comme lue
   * @param notificationId ID de la notification
   */
  markNotificationAsRead(notificationId: string): Observable<void> {
    return this.http.patch<void>(`${this.API_URL}/notifications/${notificationId}/read`, {}).pipe(
      catchError(error => {
        console.error(' Erreur markNotificationAsRead:', error);
        throw error;
      })
    );
  }

  /**
   *  Version avec données mock pour le développement (si le backend n'est pas prêt)
   */
  getMockApprovalHistory(documentNo: string): Observable<ApprovalHistory[]> {
    // Données mock pour le développement
    const mockHistory: ApprovalHistory[] = [
      {
        id: '1',
        documentNo: documentNo,
        approverId: 'MARTIN',
        approverName: 'Martin Dupont',
        approvalDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000),
        decision: ApprovalDecision.APPROVED,
        comment: 'Demande validée - Conforme au budget',
        level: 1
      },
      {
        id: '2',
        documentNo: documentNo,
        approverId: 'DURAND',
        approverName: 'Sophie Durand',
        approvalDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000),
        decision: ApprovalDecision.APPROVED,
        comment: 'Approbation finale',
        level: 2
      }
    ];
    
    return of(mockHistory).pipe(delay(500));
  }

  /**
   *  Version avec données mock pour les approbations en attente
   */
  getMockPendingApprovals(userId: string): Observable<ApprovalHistory[]> {
    const mockPending: ApprovalHistory[] = [
      {
        id: '3',
        documentNo: 'PR-2024-005',
        approverId: userId,
        approverName: 'Utilisateur',
        approvalDate: new Date(),
        decision: ApprovalDecision.PENDING,
        comment: 'En attente de validation',
        level: 1
      }
    ];
    
    return of(mockPending).pipe(delay(500));
  }
}

export { ApprovalService as PurchaseApprovalService };