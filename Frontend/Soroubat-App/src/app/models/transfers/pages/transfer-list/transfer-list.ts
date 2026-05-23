// src/app/models/transfers/pages/transfer-list/transfer-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Subject, takeUntil, finalize, catchError, of, interval } from 'rxjs';
import { ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';

import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatChipsModule } from '@angular/material/chips';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
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

interface FilterOptions {
  status: string;
  searchTerm: string;
  fromDate: Date | null;
  toDate: Date | null;
  chantier: string;
}

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
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
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
  
  // Filtres
  filterForm: FormGroup;
  showFilters: boolean = false;
  activeFilterCount: number = 0;
  
  // Liste des chantiers uniques pour le filtre
  chantiersList: string[] = [];
  
  private destroy$ = new Subject<void>();
  
  statsData = [
    { icon: 'local_shipping', value: 0, label: 'Total', color: '#6366f1', status: null },
    { icon: 'radio_button_unchecked', value: 0, label: 'Ouvert', color: '#f59e0b', status: 'Open' },
    { icon: 'local_shipping', value: 0, label: 'Expédié', color: '#3b82f6', status: 'Released' },
    { icon: 'check_circle', value: 0, label: 'Réceptionné', color: '#10b981', status: 'Received' }
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
    private offlineSync: OfflineSyncService,
    private fb: FormBuilder
  ) {
    this.filterForm = this.fb.group({
      status: [''],
      searchTerm: [''],
      fromDate: [null],
      toDate: [null],
      chantier: ['']
    });
  }
  
  ngOnInit(): void {
    // S'abonner au mode offline
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
    this.setupFilterSubscription();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private setupFilterSubscription(): void {
    this.filterForm.valueChanges
      .pipe(takeUntil(this.destroy$))
      .subscribe(() => {
        this.applyFilters();
      });
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
      this.toastr.info(` Vous avez ${this.alertCount} alerte(s) dans les ordres de transfert`, 'Alertes disponibles');
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
        console.error(' Erreur:', error);
        this.error = 'Erreur de connexion au serveur';
        return of([]);
      }),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: (transfers) => {
        console.log(` ${transfers?.length || 0} transferts reçus ${this.isReadOnly ? '(cache offline)' : '(API)'}`);
        this.transfers = transfers || [];
        this.extractChantiersList();
        this.applyFilters();
        this.updateStats();
        this.cdr.detectChanges();
      }
    });
  }
  
  private extractChantiersList(): void {
    const chantiers = new Set<string>();
    this.transfers.forEach(transfer => {
      if (transfer.chantierDestination) {
        chantiers.add(transfer.chantierDestination);
      }
      if (transfer.chantierOrigine) {
        chantiers.add(transfer.chantierOrigine);
      }
    });
    this.chantiersList = Array.from(chantiers).sort();
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
  
  applyFilters(): void {
    const filters = this.filterForm.value;
    let filtered = [...this.transfers];
    
    // Filtre par statut
    if (filters.status) {
      filtered = filtered.filter(t => t.status === filters.status);
    }
    
    // Filtre par recherche (numéro ou article)
    if (filters.searchTerm && filters.searchTerm.trim()) {
      const search = filters.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(t => 
        t.no?.toLowerCase().includes(search) ||
        t.transferLines?.some(line => line.itemNo?.toLowerCase().includes(search)) ||
        t.transferLines?.some(line => line.description?.toLowerCase().includes(search))
      );
    }
    
    // Filtre par date de début
    if (filters.fromDate) {
      const fromDate = new Date(filters.fromDate);
      fromDate.setHours(0, 0, 0, 0);
      filtered = filtered.filter(t => {
        if (!t.postingDate) return false;
        const postingDate = new Date(t.postingDate);
        postingDate.setHours(0, 0, 0, 0);
        return postingDate >= fromDate;
      });
    }
    
    // Filtre par date de fin
    if (filters.toDate) {
      const toDate = new Date(filters.toDate);
      toDate.setHours(23, 59, 59, 999);
      filtered = filtered.filter(t => {
        if (!t.postingDate) return false;
        const postingDate = new Date(t.postingDate);
        postingDate.setHours(0, 0, 0, 0);
        return postingDate <= toDate;
      });
    }
    
    // Filtre par chantier
    if (filters.chantier) {
      filtered = filtered.filter(t => 
        t.chantierDestination === filters.chantier || 
        t.chantierOrigine === filters.chantier
      );
    }
    
    this.filteredTransfers = filtered;
    this.totalItems = this.filteredTransfers.length;
    this.currentPage = 1;
    this.updateActiveFilterCount();
    this.updateStats();
    this.cdr.detectChanges();
  }
  
  filterByStatus(status: string | null): void {
    if (status === null) {
      this.filterForm.patchValue({ status: '' });
    } else {
      this.filterForm.patchValue({ status: status });
    }
    this.showFilters = true;
  }
  
  resetFilters(): void {
    this.filterForm.patchValue({
      status: '',
      searchTerm: '',
      fromDate: null,
      toDate: null,
      chantier: ''
    });
    this.showFilters = false;
    this.toastr.info('Filtres réinitialisés', 'Filtres');
  }
  
  private updateActiveFilterCount(): void {
    const filters = this.filterForm.value;
    let count = 0;
    if (filters.status) count++;
    if (filters.searchTerm && filters.searchTerm.trim()) count++;
    if (filters.fromDate) count++;
    if (filters.toDate) count++;
    if (filters.chantier) count++;
    this.activeFilterCount = count;
  }
  
  updateStats(): void {
    const filtered = this.filteredTransfers;
    this.statsData[0].value = filtered.length;
    this.statsData[1].value = filtered.filter(t => t.status === 'Open').length;
    this.statsData[2].value = filtered.filter(t => t.status === 'Released').length;
    this.statsData[3].value = filtered.filter(t => t.status === 'Received').length;
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
    return this.activeFilterCount > 0;
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
  
  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }
}

export { TransferListComponent as TransferList };