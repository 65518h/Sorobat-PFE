// src/app/models/transfers/pages/transfer-list/transfer-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Subject, takeUntil, finalize, catchError, of, interval, debounceTime, distinctUntilChanged } from 'rxjs';
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
import { SoundService } from '../../../../core/services/sound.service';
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
    { icon: 'local_shipping', value: 0, label: 'Lancé', color: '#3b82f6', status: 'Released' },
    { icon: 'check_circle', value: 0, label: 'Receptionne', color: '#10b981', status: 'Received' }
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
    private fb: FormBuilder,
    private soundService: SoundService
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
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('Mode transfer-list:', this.isReadOnly ? 'offline-readonly' : 'online');
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
    // ✅ Ajouter debounceTime pour éviter trop d'appels
    this.filterForm.valueChanges
      .pipe(
        debounceTime(300),
        distinctUntilChanged(),
        takeUntil(this.destroy$)
      )
      .subscribe(() => {
        this.currentPage = 1; // Reset à la première page quand les filtres changent
        this.applyFilters();
        this.cdr.detectChanges();
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
      this.soundService.playDefaultSound();
      this.toastr.info(
        `Vous avez ${this.alertCount} alerte(s) dans les ordres de transfert`,
        'Alertes disponibles',
        {
          positionClass: 'toast-top-right',
          timeOut: 5000,
          progressBar: true,
          closeButton: true
        }
      );
    } else {
      this.toastr.success(
        'Aucune alerte dans les ordres de transfert',
        'Tout est sous controle',
        {
          positionClass: 'toast-top-right',
          timeOut: 3000,
          progressBar: true
        }
      );
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
        console.error('Erreur:', error);
        this.error = 'Erreur de connexion au serveur';
        return of([]);
      }),
      finalize(() => {
        this.loading = false;
        this.cdr.detectChanges();
      })
    ).subscribe({
      next: (transfers) => {
        console.log(`${transfers?.length || 0} transferts recus ${this.isReadOnly ? '(cache offline)' : '(API)'}`);
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
    this.toastr.info('Rafraichissement des donnees...', 'Actualisation');
  }
  
  createTransfer(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Creation de transfert indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/transfers/new']);
  }
  
  applyFilters(): void {
  const filters = this.filterForm.value;
  let filtered = [...this.transfers];
  
  console.log('Application des filtres:', filters);
  
  // Filtre par statut
  if (filters.status && filters.status !== '') {
    filtered = filtered.filter(t => t.status === filters.status);
    console.log(`Filtre statut: ${filters.status} -> ${filtered.length} resultats`);
  }
  
  //  Filtre par recherche unique (inclut magasin origine)
  if (filters.searchTerm && filters.searchTerm.trim() !== '') {
    const search = filters.searchTerm.toLowerCase().trim();
    const beforeCount = filtered.length;
    filtered = filtered.filter(t => {
      // Recherche par numéro de transfert
      if (t.no?.toLowerCase().includes(search)) return true;
      
      // Recherche par magasin origine
      if (t.transferFromCode?.toLowerCase().includes(search)) return true;
      
      // Recherche par chantier origine
      if (t.chantierOrigine?.toLowerCase().includes(search)) return true;
      
      // Recherche par magasin destination
      if (t.transferToCode?.toLowerCase().includes(search)) return true;
      
      // Recherche par chantier destination
      if (t.chantierDestination?.toLowerCase().includes(search)) return true;
      
      // Recherche par code article dans les lignes
      if (t.transferLines?.some(line => line.itemNo?.toLowerCase().includes(search))) return true;
      
      // Recherche par description dans les lignes
      if (t.transferLines?.some(line => line.description?.toLowerCase().includes(search))) return true;
      
      return false;
    });
    console.log(`Filtre recherche: "${search}" -> ${filtered.length} resultats (avant: ${beforeCount})`);
  }
  
  // Filtre par date de début
  if (filters.fromDate) {
    const fromDate = new Date(filters.fromDate);
    fromDate.setHours(0, 0, 0, 0);
    const beforeCount = filtered.length;
    filtered = filtered.filter(t => {
      if (!t.postingDate) return false;
      const postingDate = new Date(t.postingDate);
      postingDate.setHours(0, 0, 0, 0);
      return postingDate >= fromDate;
    });
    console.log(`Filtre date debut: ${filters.fromDate} -> ${filtered.length} resultats (avant: ${beforeCount})`);
  }
  
  // Filtre par date de fin
  if (filters.toDate) {
    const toDate = new Date(filters.toDate);
    toDate.setHours(23, 59, 59, 999);
    const beforeCount = filtered.length;
    filtered = filtered.filter(t => {
      if (!t.postingDate) return false;
      const postingDate = new Date(t.postingDate);
      postingDate.setHours(0, 0, 0, 0);
      return postingDate <= toDate;
    });
    console.log(`Filtre date fin: ${filters.toDate} -> ${filtered.length} resultats (avant: ${beforeCount})`);
  }
  
  // Filtre par chantier (si utilisé)
  if (filters.chantier && filters.chantier !== '') {
    const beforeCount = filtered.length;
    filtered = filtered.filter(t => 
      t.chantierDestination === filters.chantier || 
      t.chantierOrigine === filters.chantier
    );
    console.log(`Filtre chantier: ${filters.chantier} -> ${filtered.length} resultats (avant: ${beforeCount})`);
  }
  
  this.filteredTransfers = filtered;
  this.totalItems = this.filteredTransfers.length;
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
    this.currentPage = 1;
    this.applyFilters();
    this.toastr.info('Filtres reinitialises', 'Filtres');
  }
  
  private updateActiveFilterCount(): void {
    const filters = this.filterForm.value;
    let count = 0;
    if (filters.status && filters.status !== '') count++;
    if (filters.searchTerm && filters.searchTerm.trim() !== '') count++;
    if (filters.fromDate) count++;
    if (filters.toDate) count++;
    if (filters.chantier && filters.chantier !== '') count++;
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
    if (isNaN(d.getTime())) return '';
    return d.toLocaleDateString('fr-FR');
  }
  
  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }
}

export { TransferListComponent as TransferList };