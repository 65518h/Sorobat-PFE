// src/app/core/services/alert.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Router } from '@angular/router';
import { BehaviorSubject, Observable, interval, Subject, catchError, of, map, takeUntil } from 'rxjs';
import { AuthService } from './auth';

export interface Alert {
  id: string;
  type: string;
  severity: 'Critical' | 'Warning' | 'Info';
  title: string;
  message: string;
  relatedEntityNo: string;
  relatedEntityId: string;
  detectedAt: Date;
}

export interface UnreadCount {
  critical: number;
  warning: number;
  info: number;
  total: number;
}

@Injectable({ providedIn: 'root' })
export class AlertService {
  private http = inject(HttpClient);
  private router = inject(Router);
  private authService = inject(AuthService);
  
  private apiUrl = 'http://localhost:5227/api/Alerts';
  private alertsSubject = new BehaviorSubject<Alert[]>([]);
  alerts$ = this.alertsSubject.asObservable();
  
  private readAlertIds = new Set<string>();
  private destroy$ = new Subject<void>();

  constructor() {
    this.loadReadStatus();
    this.loadRecentAlertsForNavbar();
    this.startPolling();
  }

  // Pour le navbar - charge uniquement les 10 dernières alertes
  loadRecentAlertsForNavbar(): void {
    this.getAllAlerts().pipe(
      map(alerts => {
        const sorted = alerts.sort((a, b) => 
          new Date(b.detectedAt).getTime() - new Date(a.detectedAt).getTime()
        );
        return sorted.slice(0, 10);
      }),
      catchError(error => {
        console.error('Erreur chargement alertes récentes:', error);
        return of([]);
      })
    ).subscribe(alerts => {
      this.alertsSubject.next(alerts);
      console.log(` ${alerts.length} alertes récentes chargées pour la notification`);
    });
  }

  // Récupère toutes les alertes (pour la page complète)
  getAllAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/all`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes:', error);
        return of([]);
      })
    );
  }

  //  NOUVEAU: Récupérer les alertes par domaine spécifique avec force refresh
  getPurchaseRequestAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/purchase-requests`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes purchase-requests:', error);
        return of([]);
      })
    );
  }

  getTransferAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/transfers`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes transfers:', error);
        return of([]);
      })
    );
  }

  getStockAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/stock`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes stock:', error);
        return of([]);
      })
    );
  }

  getVehiculeAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/vehicules`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes vehicules:', error);
        return of([]);
      })
    );
  }

  getGasoilAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/gasoil`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes gasoil:', error);
        return of([]);
      })
    );
  }

  getAttendanceAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/attendance`).pipe(
      catchError(error => {
        console.error(' Erreur chargement alertes attendance:', error);
        return of([]);
      })
    );
  }

  getSiteManagementAlerts(): Observable<Alert[]> {
    //  siteManagement est commenté dans le backend, retourner un tableau vide
    console.warn(' siteManagement n\'est plus disponible dans le backend');
    return of([]);
  }

  refreshRecentAlerts(): void {
    this.loadRecentAlertsForNavbar();
  }

  refreshAllAlerts(): void {
    this.getAllAlerts().pipe(
      catchError(error => {
        console.error('Erreur chargement alertes:', error);
        return of([]);
      })
    ).subscribe(alerts => {
      console.log(` ${alerts.length} alertes totales disponibles`);
    });
  }

  markAsRead(alertId: string): void {
    this.readAlertIds.add(alertId);
    localStorage.setItem('readAlerts', JSON.stringify([...this.readAlertIds]));
    const currentAlerts = this.alertsSubject.value;
    this.alertsSubject.next([...currentAlerts]);
  }

  markAllAsRead(): void {
    const currentAlerts = this.alertsSubject.value;
    currentAlerts.forEach(alert => this.readAlertIds.add(alert.id));
    localStorage.setItem('readAlerts', JSON.stringify([...this.readAlertIds]));
    this.alertsSubject.next([...currentAlerts]);
  }

  isRead(alertId: string): boolean {
    return this.readAlertIds.has(alertId);
  }

  getUnreadCount(): UnreadCount {
    const alerts = this.alertsSubject.value;
    const unreadAlerts = alerts.filter(a => !this.isRead(a.id));
    return {
      critical: unreadAlerts.filter(a => a.severity === 'Critical').length,
      warning: unreadAlerts.filter(a => a.severity === 'Warning').length,
      info: unreadAlerts.filter(a => a.severity === 'Info').length,
      total: unreadAlerts.length
    };
  }

  navigateToAlert(alert: Alert): void {
    const routes: Record<string, string> = {
      'TaskDelay': '/tasks',
      'TaskBlocked': '/tasks',
      'TaskNotStarted': '/tasks',
      'BudgetOverrun': '/projects',
      'PurchaseRequestRejected': '/purchases/requests',
      'PurchaseRequestPendingTooLong': '/purchases/requests',
      'PurchaseRequestOverdue': '/purchases/requests',
      'PurchaseRequestEmpty': '/purchases/requests',
      'TransferStuckInTransit': '/transfers',
      'TransferNotShipped': '/transfers',
      'TransferPartialReceipt': '/transfers',
      'TransferNoVehicle': '/transfers',
      'StockNégatif': '/inventory',
      'StockCritique': '/inventory',
      'StockDormant': '/inventory',
      'PointageNonValidé': '/equipment',
      'VehiculeSurutilisé': '/equipment',
      'IndexIncohérent': '/equipment',
      'PanneSansMotif': '/equipment',
      'ConsommationAnormale': '/equipment',
      'GasoilFicheNonValidée': '/gasoil',
      'GasoilIndexIncohérent': '/gasoil',
      'GasoilConsommationTotaleAnormale': '/gasoil',
      'GasoilLigneSansVéhicule': '/gasoil',
      'GasoilQuantitéLigneAnormale': '/gasoil'
    };
    
    const route = routes[alert.type] || '/dashboard';
    this.router.navigate([route], { queryParams: { highlight: alert.relatedEntityNo } });
  }

  navigateToAllAlerts(): void {
    this.router.navigate(['/alerts']);
  }

  private loadReadStatus(): void {
    const stored = localStorage.getItem('readAlerts');
    if (stored) {
      try {
        const ids = JSON.parse(stored);
        this.readAlertIds = new Set(ids);
      } catch (e) {
        console.error('Erreur chargement statuts de lecture:', e);
        this.readAlertIds = new Set();
      }
    }
  }

  private startPolling(): void {
    interval(180000).subscribe(() => {
      this.loadRecentAlertsForNavbar();
      console.log(' Rafraîchissement des alertes récentes...');
    });
  }
}