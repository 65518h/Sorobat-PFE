// src/app/core/services/alerts-counter.service.ts

import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, interval } from 'rxjs';
import { AlertsService } from '../../models/alerts/services/alerts.service';

export interface AlertsCounts {
  gasoil: number;
  purchaseRequests: number;
  transfers: number;
  stock: number;
  vehicules: number;
  attendance: number;  // ✅ Remplacer siteManagement par attendance
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
    attendance: 0,  // ✅ Remplacer siteManagement
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
        // ✅ Compter les alertes NON LUES par domaine
        const counts: AlertsCounts = {
          gasoil: (alerts.gasoil || []).filter(a => !this.alertsService.isRead(a.id)).length,
          purchaseRequests: (alerts.purchaseRequests || []).filter(a => !this.alertsService.isRead(a.id)).length,
          transfers: (alerts.transfers || []).filter(a => !this.alertsService.isRead(a.id)).length,
          stock: (alerts.stock || []).filter(a => !this.alertsService.isRead(a.id)).length,
          vehicules: (alerts.vehicules || []).filter(a => !this.alertsService.isRead(a.id)).length,
          attendance: (alerts.attendance || []).filter(a => !this.alertsService.isRead(a.id)).length,  // ✅ attendance
          total: 0
        };
        
        // Calculer le total
        counts.total = counts.gasoil + counts.purchaseRequests + counts.transfers + 
                       counts.stock + counts.vehicules + counts.attendance;
        
        console.log('📊 Compteurs alertes mis à jour:', counts);
        this.countsSubject.next(counts);
      },
      error: (err) => {
        console.error('❌ Erreur chargement compteurs alertes:', err);
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
      case 'attendance': return counts.attendance;  // ✅ Remplacer siteManagement
      default: return 0;
    }
  }
  
  refresh(): void {
    console.log('🔄 Rafraîchissement des compteurs d\'alertes...');
    this.loadCounts();
  }
}