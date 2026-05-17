// src/app/shared/components/alerts-button/alerts-button.component.ts

import { Component, Input, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ToastrService } from 'ngx-toastr';

import { AlertsCounterService } from '../../../core/services/alerts-counter.service';

@Component({
  selector: 'app-alerts-button',
  standalone: true,
  imports: [CommonModule, MatIconModule, MatTooltipModule],
  template: `
    <button class="alerts-btn" 
            [class.has-alerts]="count > 0"
            (click)="navigateToAlerts()"
            [matTooltip]="getTooltipText()">
      <mat-icon>notifications_active</mat-icon>
      <span>{{ label }}</span>
      <span class="alert-badge" *ngIf="count > 0">
        {{ count > 99 ? '99+' : count }}
      </span>
    </button>
  `,
  styles: [`
    .alerts-btn {
      position: relative;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 20px;
      background: white;
      border: 1.5px solid #e5e7eb;
      border-radius: 12px;
      font-size: 14px;
      font-weight: 500;
      color: #4b5563;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    .alerts-btn:hover {
      border-color: #f59e0b;
      background: #fffbeb;
      transform: translateY(-2px);
    }
    .alerts-btn.has-alerts {
      border-color: #f59e0b;
      background: linear-gradient(135deg, #fffbeb, #fef3c7);
      color: #d97706;
    }
    .alerts-btn mat-icon {
      font-size: 20px;
      width: 20px;
      height: 20px;
    }
    .alert-badge {
      position: absolute;
      top: -6px;
      right: -6px;
      background: linear-gradient(135deg, #ef4444, #dc2626);
      color: white;
      font-size: 11px;
      font-weight: 700;
      min-width: 20px;
      height: 20px;
      border-radius: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 6px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.2);
      animation: pulse-badge 1.5s infinite;
    }
    @keyframes pulse-badge {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.1); }
    }
    @media (max-width: 768px) {
      .alerts-btn span:not(.alert-badge) {
        display: none;
      }
      .alerts-btn {
        padding: 10px;
      }
    }
  `]
})
export class AlertsButtonComponent implements OnInit, OnDestroy {
  
  @Input() domain: string = '';
  @Input() label: string = 'Alertes';
  @Input() showToast: boolean = true;
  
  count: number = 0;
  private destroy$ = new Subject<void>();
  
  constructor(
    private alertsCounterService: AlertsCounterService,
    private toastr: ToastrService,
    private router: Router
  ) {}
  
  ngOnInit(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        switch(this.domain) {
          case 'gasoil': this.count = counts.gasoil; break;
          case 'purchaseRequests': this.count = counts.purchaseRequests; break;
          case 'transfers': this.count = counts.transfers; break;
          case 'stock': this.count = counts.stock; break;
          case 'vehicules': this.count = counts.vehicules; break;
          case 'siteManagement': this.count = counts.siteManagement; break;
          default: this.count = 0;
        }
      });
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  getTooltipText(): string {
    if (this.count === 0) {
      return `Aucune alerte dans ${this.getDomainName()}`;
    }
    return `${this.count} alerte(s) non lue(s) dans ${this.getDomainName()}`;
  }
  
  private getDomainName(): string {
    const names: { [key: string]: string } = {
      gasoil: 'Gasoil',
      purchaseRequests: 'Demandes d\'achat',
      transfers: 'Ordres de transfert',
      stock: 'Stock',
      vehicules: 'Engins',
      siteManagement: 'Gestion de chantier'
    };
    return names[this.domain] || this.domain;
  }
  
  navigateToAlerts(): void {
    if (this.showToast && this.count > 0) {
      this.toastr.info(
        `🔍 Vous avez ${this.count} alerte(s) non lue(s) dans ${this.getDomainName()}`,
        'Alertes disponibles',
        {
          positionClass: 'toast-top-right',
          timeOut: 3000,
          closeButton: true
        }
      );
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { 
        filterDomain: this.domain,
        source: this.domain
      }
    });
  }
}