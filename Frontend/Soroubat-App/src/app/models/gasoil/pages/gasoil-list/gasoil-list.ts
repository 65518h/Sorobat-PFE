// src/app/modules/gasoil/pages/gasoil-list/gasoil-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil, interval, of } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDialogModule, MatDialog } from '@angular/material/dialog';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { ToastrService } from 'ngx-toastr';

// Services
import { GasoilService } from '../../services/gasoil.service';
import { AuthService } from '../../../../core/services/auth';
import { NotificationService } from '../../../../core/services/notification';
import { AlertService, Alert } from '../../../../core/services/alert.service';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { SoundService } from '../../../../core/services/sound.service';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

// Models
import { GasoilHeader, getGasoilStatusClass, getGasoilStatusIcon, getGasoilStatusLabel } from '../../models/gasoil.model';

@Component({
  selector: 'app-gasoil-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './gasoil-list.html',
  styleUrls: ['./gasoil-list.css']
})
export class GasoilListComponent implements OnInit, OnDestroy {
  
  headers: GasoilHeader[] = [];
  filteredHeaders: GasoilHeader[] = [];
  paginatedItems: GasoilHeader[] = [];
  loading = false;
  errorMessage = '';
  isReadOnly: boolean = false;
  
  // Pagination
  pageSize = 10;
  pageIndex = 0;
  totalItems = 0;
  
  // Filtres
  searchTerm: string = '';
  statusFilter: string = 'all';
  dateFrom: string = '';
  dateTo: string = '';
  filtersExpanded = false;
  
  // Statistiques
  stats = {
    totalDocuments: 0,
    totalQuantity: 0,
    pendingCount: 0,
    validatedCount: 0
  };
  
  // Alertes contextuelles
  contextualAlerts: Alert[] = [];
  alertCount: number = 0;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private gasoilService: GasoilService,
    private authService: AuthService,
    private notificationService: NotificationService,
    private alertService: AlertService,
    private alertsCounterService: AlertsCounterService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private dialog: MatDialog,
    private soundService: SoundService,
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
        console.log('🔔 Mode gasoil-list:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.loadGasoil();
    this.loadContextualAlerts();
    this.subscribeToAlertCounts();
    this.startAutoRefresh();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private startAutoRefresh(): void {
    interval(120000).pipe(takeUntil(this.destroy$)).subscribe(() => {
      if (!this.loading && !this.isReadOnly) {
        this.loadGasoil();
        this.loadContextualAlerts();
      }
    });
  }
  
  private subscribeToAlertCounts(): void {
    this.alertsCounterService.counts$
      .pipe(takeUntil(this.destroy$))
      .subscribe(counts => {
        this.alertCount = counts.gasoil;
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
      this.toastr.info(`🔍 Vous avez ${this.alertCount} alerte(s) dans la partie Gasoil`, 'Alertes disponibles');
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { filterDomain: 'gasoil', source: 'gasoil-page' }
    });
  }
  
  // src/app/modules/gasoil/pages/gasoil-list/gasoil-list.ts

// Modifier la méthode loadGasoil()
loadGasoil(): void {
  this.loading = true;
  this.errorMessage = '';
  this.cdr.detectChanges();
  
  // ✅ Si mode offline, ne pas forcer le refresh, utiliser le cache
  const forceRefresh = this.isReadOnly ? false : true;
  
  this.gasoilService.getAll(forceRefresh).subscribe({
    next: (data: GasoilHeader[]) => {
      console.log(`📦 ${data?.length || 0} fiches reçues ${this.isReadOnly ? '(cache offline)' : '(API)'}`);
      this.headers = data || [];
      this.filteredHeaders = [...this.headers];
      this.applyFilters();
      this.calculateStats();
      this.loading = false;
      this.cdr.detectChanges();
    },
    error: (error) => {
      console.error('❌ Erreur chargement:', error);
      this.errorMessage = 'Impossible de charger les fiches gasoil.';
      this.loading = false;
      this.cdr.detectChanges();
    }
  });
}
  
  refresh(): void {
    if (this.isReadOnly) {
      this.toastr.info('Actualisation indisponible en mode hors ligne', 'Mode lecture seule');
      return;
    }
    this.gasoilService.clearCache();
    this.loadGasoil();
    this.loadContextualAlerts();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation');
  }
  
  createNew(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Création de fiche indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/gasoil/new']);
  }
  
  loadContextualAlerts(): void {
    this.alertService.getGasoilAlerts().pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (alerts) => {
        this.contextualAlerts = alerts;
        this.cdr.detectChanges();
        console.log(`✅ ${alerts.length} alertes gasoil chargées`);
      },
      error: (error) => {
        console.error('❌ Erreur chargement alertes gasoil:', error);
      }
    });
  }
  
  calculateStats(): void {
    this.stats = {
      totalDocuments: this.filteredHeaders.length,
      totalQuantity: this.filteredHeaders.reduce((sum, h) => sum + this.getTotalQuantity(h), 0),
      pendingCount: this.filteredHeaders.filter(h => h.status === 'En cours').length,
      validatedCount: this.filteredHeaders.filter(h => h.status === 'Valider').length
    };
    this.cdr.detectChanges();
  }
  
  applyFilters(): void {
    let filtered = [...this.headers];
    
    if (this.searchTerm && this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(h => 
        h.documentNo?.toLowerCase().includes(term) ||
        h.fileNo?.toLowerCase().includes(term) ||
        h.locationCode?.toLowerCase().includes(term)
      );
    }
    
    if (this.statusFilter && this.statusFilter !== 'all') {
      filtered = filtered.filter(h => h.status === this.statusFilter);
    }
    
    if (this.dateFrom) {
      const fromDate = new Date(this.dateFrom);
      fromDate.setHours(0, 0, 0, 0);
      filtered = filtered.filter(h => {
        if (!h.date) return false;
        return new Date(h.date) >= fromDate;
      });
    }
    
    if (this.dateTo) {
      const toDate = new Date(this.dateTo);
      toDate.setHours(23, 59, 59, 999);
      filtered = filtered.filter(h => {
        if (!h.date) return false;
        return new Date(h.date) <= toDate;
      });
    }
    
    this.filteredHeaders = filtered;
    this.totalItems = filtered.length;
    this.pageIndex = 0;
    this.updatePagination();
    this.calculateStats();
  }
  
  resetFilters(): void {
    this.searchTerm = '';
    this.statusFilter = 'all';
    this.dateFrom = '';
    this.dateTo = '';
    this.applyFilters();
    this.toastr.info('Filtres réinitialisés', 'Filtres');
  }
  
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
  }
  
  onSearch(): void {
    this.applyFilters();
  }
  
  clearSearch(): void {
    this.searchTerm = '';
    this.applyFilters();
  }
  
  private updatePagination(): void {
    const start = this.pageIndex * this.pageSize;
    const end = start + this.pageSize;
    this.paginatedItems = this.filteredHeaders.slice(start, end);
  }
  
  firstPage(): void {
    this.pageIndex = 0;
    this.updatePagination();
  }
  
  lastPage(): void {
    this.pageIndex = this.getTotalPages() - 1;
    this.updatePagination();
  }
  
  previousPage(): void {
    if (this.pageIndex > 0) {
      this.pageIndex--;
      this.updatePagination();
    }
  }
  
  nextPage(): void {
    if (this.pageIndex < this.getTotalPages() - 1) {
      this.pageIndex++;
      this.updatePagination();
    }
  }
  
  goToPage(page: number): void {
    this.pageIndex = page;
    this.updatePagination();
  }
  
  getTotalPages(): number {
    return Math.ceil(this.totalItems / this.pageSize);
  }
  
  getVisiblePages(): number[] {
    const totalPages = this.getTotalPages();
    const currentPage = this.pageIndex + 1;
    const pages: number[] = [];
    
    if (totalPages <= 7) {
      for (let i = 1; i <= totalPages; i++) pages.push(i);
    } else {
      if (currentPage <= 4) {
        for (let i = 1; i <= 5; i++) pages.push(i);
        pages.push(-1);
        pages.push(totalPages);
      } else if (currentPage >= totalPages - 3) {
        pages.push(1);
        pages.push(-1);
        for (let i = totalPages - 4; i <= totalPages; i++) pages.push(i);
      } else {
        pages.push(1);
        pages.push(-1);
        for (let i = currentPage - 1; i <= currentPage + 1; i++) pages.push(i);
        pages.push(-1);
        pages.push(totalPages);
      }
    }
    return pages;
  }
  
  onPageSizeChange(): void {
    this.pageIndex = 0;
    this.updatePagination();
  }
  
  viewDetail(header: GasoilHeader): void {
    if (header.id) {
      console.log('🔍 Navigation vers détail:', header.documentNo);
      this.router.navigate(['/gasoil', header.id]);
    }
  }
  
  editGasoil(header: GasoilHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (header.id && header.status !== 'Valider') {
      this.router.navigate(['/gasoil/edit', header.id]);
    } else if (header.status === 'Valider') {
      this.notificationService.showWarning('Cette fiche est déjà validée et ne peut pas être modifiée');
    }
  }
  
  deleteGasoil(header: GasoilHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (header.status === 'Valider') {
      this.notificationService.showWarning('Les fiches validées ne peuvent pas être supprimées');
      return;
    }
    
    if (confirm(`Supprimer la fiche ${header.documentNo} ?`)) {
      this.gasoilService.delete(header.id!).subscribe({
        next: () => {
          this.notificationService.showSuccess('Fiche supprimée avec succès');
          this.loadGasoil();
        },
        error: (error) => {
          console.error('Erreur suppression:', error);
          this.notificationService.showError('Erreur lors de la suppression');
        }
      });
    }
  }
  
  validateGasoil(header: GasoilHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Validation indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (header.status === 'Valider') {
      this.notificationService.showWarning('Cette fiche est déjà validée');
      return;
    }
    
    if (confirm(`Valider la fiche ${header.documentNo} ?`)) {
      this.gasoilService.validate(header.id!).subscribe({
        next: () => {
          this.notificationService.showSuccess('Fiche validée avec succès');
          this.loadGasoil();
        },
        error: (error) => {
          console.error('Erreur validation:', error);
          this.notificationService.showError('Erreur lors de la validation');
        }
      });
    }
  }
  
  getStatusClass(status: string | undefined): string {
    return getGasoilStatusClass(status);
  }
  
  getStatusIcon(status: string | undefined): string {
    return getGasoilStatusIcon(status);
  }
  
  getStatusLabel(status: string | undefined): string {
    return getGasoilStatusLabel(status);
  }
  
  formatDate(date: string | Date | undefined): Date | string {
    if (!date) return '—';
    return new Date(date);
  }
  
  getTotalQuantity(header: GasoilHeader): number {
    return header.gasoilLines?.reduce((sum, l) => sum + (l.quantity || 0), 0) || 0;
  }


  
}