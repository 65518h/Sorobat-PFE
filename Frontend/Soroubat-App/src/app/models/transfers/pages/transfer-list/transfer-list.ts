// src/app/models/transfers/pages/transfer-list/transfer-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Subject, takeUntil, finalize, catchError, of, interval } from 'rxjs';
import { ReactiveFormsModule } from '@angular/forms';

import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatChipsModule } from '@angular/material/chips';
import { ToastrService } from 'ngx-toastr';

import { TransferService } from '../../services/transfer.service';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService } from '../../../../core/services/auth';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';
import { TransferHeader, getTransferStatusClass, getTransferStatusLabel } from '../../models/transfer.model';

@Component({
  selector: 'app-transfer-list',
  templateUrl: './transfer-list.html',
  styleUrls: ['./transfer-list.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatPaginatorModule,
    MatChipsModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ]
})
export class TransferListComponent implements OnInit, OnDestroy {
  
  transfers: TransferHeader[] = [];
  filteredTransfers: TransferHeader[] = [];
  loading: boolean = false;
  error: string | null = null;
  
  currentPage: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;
  
  isAdmin: boolean = false;
  isReadOnly: boolean = false;
  
  alertCount: number = 0;
  
  private destroy$ = new Subject<void>();
  
  statsData = [
    { icon: 'local_shipping', value: 0, label: 'Total', color: '#6366f1' },
    { icon: 'radio_button_unchecked', value: 0, label: 'Ouvert', color: '#f59e0b' },
    { icon: 'local_shipping', value: 0, label: 'Expédié', color: '#3b82f6' },
    { icon: 'check_circle', value: 0, label: 'Réceptionné', color: '#10b981' }
  ];
  
  constructor(
    private transferService: TransferService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private alertsCounterService: AlertsCounterService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private toastr: ToastrService,
    private appMode: AppModeService,
    private offlineSync: OfflineSyncService
  ) {}
  
  ngOnInit(): void {
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode transfer-list:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.isAdmin = this.authService.isApprover();
    this.subscribeToAlertCounts();
    this.loadTransfers();
    this.startAutoRefresh();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private startAutoRefresh(): void {
    interval(120000).pipe(takeUntil(this.destroy$)).subscribe(() => {
      if (!this.loading && !this.isReadOnly) {
        this.alertsCounterService.refresh();
      }
    });
  }
  
  private subscribeToAlertCounts(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        this.alertCount = counts.transfers;
        this.cdr.detectChanges();
      });
  }
  
  navigateToAlerts(): void {
    if (this.isReadOnly) {
      this.toastr.info('Alertes indisponibles en mode hors ligne', 'Mode lecture seule');
      return;
    }
    
    if (this.alertCount > 0) {
      this.toastr.info(`🔍 Vous avez ${this.alertCount} alerte(s) dans les ordres de transfert`, 'Alertes disponibles');
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { filterDomain: 'transfers', source: 'transfers-page' }
    });
  }
  
  loadTransfers(): void {
    this.loading = true;
    this.error = null;
    this.cdr.detectChanges();
    
    this.transferService.getAll().pipe(
      takeUntil(this.destroy$),
      catchError((error) => {
        console.error('❌ Erreur:', error);
        this.error = 'Erreur de connexion au serveur';
        return of([]);
      }),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: (transfers) => {
        console.log(`📦 ${transfers?.length || 0} transferts reçus ${this.isReadOnly ? '(cache offline)' : '(API)'}`);
        this.transfers = transfers || [];
        this.filteredTransfers = [...this.transfers];
        this.totalItems = this.filteredTransfers.length;
        this.updateStats();
        this.cdr.detectChanges();
      }
    });
  }
  
  refresh(): void {
    if (this.isReadOnly) {
      this.toastr.info('Actualisation indisponible en mode hors ligne', 'Mode lecture seule');
      return;
    }
    this.transferService.clearCache();
    this.loadTransfers();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation');
  }
  
  createTransfer(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Création de transfert indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/transfers/new']);
  }
  
  updateStats(): void {
    this.statsData[0].value = this.filteredTransfers.length;
    this.statsData[1].value = this.filteredTransfers.filter(t => t.status === 'Open').length;
    this.statsData[2].value = this.filteredTransfers.filter(t => t.status === 'Released').length;
    this.statsData[3].value = this.filteredTransfers.filter(t => t.status === 'Received').length;
  }
  
  get paginatedTransfers(): TransferHeader[] {
    const start = (this.currentPage - 1) * this.pageSize;
    return this.filteredTransfers.slice(start, start + this.pageSize);
  }
  
  onPageChange(page: number, pageSize?: number): void {
    if (pageSize && pageSize !== this.pageSize) {
      this.pageSize = pageSize;
      this.currentPage = 1;
    } else {
      this.currentPage = page;
    }
    this.cdr.detectChanges();
  }
  
  viewTransfer(transfer: TransferHeader): void {
    if (transfer.id) {
      this.router.navigate(['/transfers', transfer.id]);
    }
  }
  
  hasActiveFilters(): boolean {
    return false;
  }
  
  getStatusClass(status: string | undefined): string {
    return getTransferStatusClass(status || '');
  }
  
  getStatusLabel(status: string | undefined): string {
    return getTransferStatusLabel(status || '');
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR');
  }
}

export { TransferListComponent as TransferList };