// src/app/core/services/alerts-counter.service.ts

import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, interval, switchMap } from 'rxjs';
import { AlertsService } from '../../models/alerts/services/alerts.service';

export interface AlertsCounts {
  gasoil: number;
  purchaseRequests: number;
  transfers: number;
  stock: number;
  vehicules: number;
  siteManagement: number;
  total: number;
}

@Injectable({
  providedIn: 'root'
})
export class AlertsCounterService {
  
  private countsSubject = new BehaviorSubject<AlertsCounts>({
    gasoil: 0,
    purchaseRequests: 0,
    transfers: 0,
    stock: 0,
    vehicules: 0,
    siteManagement: 0,
    total: 0
  });
  
  counts$ = this.countsSubject.asObservable();
  
  constructor(private alertsService: AlertsService) {
    this.loadCounts();
    // Rafraîchir toutes les 2 minutes
    interval(120000).subscribe(() => this.loadCounts());
  }
  
  private loadCounts(): void {
    this.alertsService.getAllAlertsByDomain(100).subscribe({
      next: (alerts) => {
        const counts: AlertsCounts = {
          gasoil: alerts.gasoil.filter(a => !this.alertsService.isRead(a.id)).length,
          purchaseRequests: alerts.purchaseRequests.filter(a => !this.alertsService.isRead(a.id)).length,
          transfers: alerts.transfers.filter(a => !this.alertsService.isRead(a.id)).length,
          stock: alerts.stock.filter(a => !this.alertsService.isRead(a.id)).length,
          vehicules: alerts.vehicules.filter(a => !this.alertsService.isRead(a.id)).length,
          siteManagement: alerts.siteManagement.filter(a => !this.alertsService.isRead(a.id)).length,
          total: 0
        };
        counts.total = Object.values(counts).reduce((a, b) => a + b, 0) - counts.total;
        this.countsSubject.next(counts);
      },
      error: (err) => {
        console.error('Erreur chargement compteurs alertes:', err);
      }
    });
  }
  
  getCount(domain: string): number {
    const counts = this.countsSubject.value;
    switch(domain) {
      case 'gasoil': return counts.gasoil;
      case 'purchaseRequests': return counts.purchaseRequests;
      case 'transfers': return counts.transfers;
      case 'stock': return counts.stock;
      case 'vehicules': return counts.vehicules;
      case 'siteManagement': return counts.siteManagement;
      default: return 0;
    }
  }
  
  refresh(): void {
    this.loadCounts();
  }
}