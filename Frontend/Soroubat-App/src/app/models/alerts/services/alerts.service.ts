// src/app/models/alerts/services/alerts.service.ts

import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { BehaviorSubject, Observable, catchError, of, forkJoin, map } from 'rxjs';
import { Alert, AlertStats } from '../models/alerts.model';

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  pageSize: number;
  totalPages: number;
}

@Injectable({
  providedIn: 'root'
})
export class AlertsService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:5227/api/Alerts';
  
  private alertsSubject = new BehaviorSubject<Alert[]>([]);
  alerts$ = this.alertsSubject.asObservable();
  
  private readAlertIds = new Set<string>();
  
  // Cache des alertes par domaine
  private domainCache = new Map<string, { alerts: Alert[], timestamp: number }>();
  private cacheDuration = 60000; // 1 minute

  constructor() {
    this.loadReadStatus();
  }

  // ==================== DÉCODAGE XML ====================
  
  private decodeXmlString(str: string): string {
    if (!str) return str;
    
    const replacements: { [key: string]: string } = {
      '_x0020_': ' ',
      '_x0021_': '!',
      '_x0022_': '"',
      '_x0023_': '#',
      '_x0024_': '$',
      '_x0025_': '%',
      '_x0026_': '&',
      '_x0027_': "'",
      '_x0028_': '(',
      '_x0029_': ')',
      '_x002A_': '*',
      '_x002B_': '+',
      '_x002C_': ',',
      '_x002D_': '-',
      '_x002E_': '.',
      '_x002F_': '/',
      '_x0030_': '0',
      '_x0031_': '1',
      '_x0032_': '2',
      '_x0033_': '3',
      '_x0034_': '4',
      '_x0035_': '5',
      '_x0036_': '6',
      '_x0037_': '7',
      '_x0038_': '8',
      '_x0039_': '9',
      '_x003A_': ':',
      '_x003B_': ';',
      '_x003C_': '<',
      '_x003D_': '=',
      '_x003E_': '>',
      '_x003F_': '?',
      '_x0040_': '@',
      '_x005B_': '[',
      '_x005C_': '\\',
      '_x005D_': ']',
      '_x005E_': '^',
      '_x005F_': '_',
      '_x0060_': '`',
      '_x007B_': '{',
      '_x007C_': '|',
      '_x007D_': '}',
      '_x007E_': '~'
    };
    
    let result = str;
    for (const [encoded, decoded] of Object.entries(replacements)) {
      result = result.replace(new RegExp(encoded, 'g'), decoded);
    }
    
    return result;
  }

  private decodeAlert(alert: any): Alert {
    if (!alert) return alert;
    
    return {
      id: alert.id,
      type: this.decodeXmlString(alert.type),
      severity: alert.severity,
      title: this.decodeXmlString(alert.title),
      message: this.decodeXmlString(alert.message),
      relatedEntityNo: this.decodeXmlString(alert.relatedEntityNo || ''),
      relatedEntityId: alert.relatedEntityId || null,
      detectedAt: new Date(alert.detectedAt),
      read: this.isRead(alert.id)
    };
  }

  private decodeAlerts(alerts: any[]): Alert[] {
    if (!alerts || !Array.isArray(alerts)) return [];
    return alerts.map(alert => this.decodeAlert(alert));
  }

  // ==================== NOUVEAUX ENDPOINTS ====================
  
  // ✅ GET /api/Alerts/all
  getAllAlerts(): Observable<Alert[]> {
    return this.http.get<Alert[]>(`${this.apiUrl}/all`).pipe(
      map(alerts => this.decodeAlerts(alerts)),
      catchError(error => {
        console.error('❌ Erreur chargement toutes les alertes:', error);
        return of([]);
      })
    );
  }

  // ✅ GET /api/Alerts/purchase-requests
  getPurchaseRequestAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('purchaseRequests', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/purchase-requests`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // ✅ GET /api/Alerts/transfers
  getTransferAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('transfers', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/transfers`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // ✅ GET /api/Alerts/stock
  getStockAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('stock', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/stock`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // ✅ GET /api/Alerts/vehicules
  getVehiculeAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('vehicules', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/vehicules`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // ✅ GET /api/Alerts/gasoil
  getGasoilAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('gasoil', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/gasoil`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // ✅ GET /api/Alerts/attendance
  getAttendanceAlerts(forceRefresh: boolean = false): Observable<Alert[]> {
    return this.getCachedOrFetch('attendance', () => 
      this.http.get<Alert[]>(`${this.apiUrl}/attendance`).pipe(
        map(alerts => this.decodeAlerts(alerts))
      ), forceRefresh
    );
  }

  // Cache helper
  private getCachedOrFetch(key: string, fetchFn: () => Observable<Alert[]>, forceRefresh: boolean): Observable<Alert[]> {
    const cached = this.domainCache.get(key);
    const now = Date.now();
    
    if (!forceRefresh && cached && (now - cached.timestamp) < this.cacheDuration) {
      console.log(`📦 Cache hit pour ${key}`);
      return of(cached.alerts);
    }
    
    console.log(`📡 Fetch API pour ${key}`);
    return fetchFn().pipe(
      map(alerts => {
        this.domainCache.set(key, { alerts, timestamp: now });
        return alerts;
      }),
      catchError(error => {
        console.error(`Erreur chargement alertes ${key}:`, error);
        return of([]);
      })
    );
  }

  // ✅ Récupérer toutes les alertes par domaine (pour le dashboard)
  getAllAlertsByDomain(limitPerDomain?: number): Observable<{ [key: string]: Alert[] }> {
    const options = limitPerDomain ? { params: new HttpParams().set('limit', limitPerDomain.toString()) } : {};
    
    return forkJoin({
      purchaseRequests: this.http.get<Alert[]>(`${this.apiUrl}/purchase-requests`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      ),
      transfers: this.http.get<Alert[]>(`${this.apiUrl}/transfers`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      ),
      stock: this.http.get<Alert[]>(`${this.apiUrl}/stock`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      ),
      vehicules: this.http.get<Alert[]>(`${this.apiUrl}/vehicules`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      ),
      gasoil: this.http.get<Alert[]>(`${this.apiUrl}/gasoil`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      ),
      attendance: this.http.get<Alert[]>(`${this.apiUrl}/attendance`, options).pipe(
        map(alerts => this.decodeAlerts(alerts)),
        catchError(() => [])
      )
    });
  }

  // ==================== GESTION LECTURE (localStorage) ====================
  
  markAsRead(alertId: string): void {
    this.readAlertIds.add(alertId);
    localStorage.setItem('readAlerts', JSON.stringify([...this.readAlertIds]));
    this.alertsSubject.next([...this.alertsSubject.value]);
    
    // Mettre à jour le cache
    this.updateReadStatusInCache(alertId, true);
  }

  markAllAsRead(): void {
    const currentAlerts = this.alertsSubject.value;
    currentAlerts.forEach(alert => {
      this.readAlertIds.add(alert.id);
      this.updateReadStatusInCache(alert.id, true);
    });
    localStorage.setItem('readAlerts', JSON.stringify([...this.readAlertIds]));
    this.alertsSubject.next([...currentAlerts]);
  }

  isRead(alertId: string): boolean {
    return this.readAlertIds.has(alertId);
  }

  private updateReadStatusInCache(alertId: string, isRead: boolean): void {
    this.domainCache.forEach((cached, key) => {
      const alert = cached.alerts.find(a => a.id === alertId);
      if (alert) {
        alert.read = isRead;
      }
    });
  }

  getStats(alerts: Alert[]): AlertStats {
    return {
      total: alerts.length,
      critical: alerts.filter(a => a.severity === 'Critical').length,
      warning: alerts.filter(a => a.severity === 'Warning').length,
      info: alerts.filter(a => a.severity === 'Info').length
    };
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

  clearCache(): void {
    this.domainCache.clear();
    console.log('🗑️ Cache des alertes vidé');
  }

  refreshAllAlerts(): void {
    this.clearCache();
    this.getAllAlerts().subscribe(alerts => {
      this.alertsSubject.next(alerts);
    });
  }
}