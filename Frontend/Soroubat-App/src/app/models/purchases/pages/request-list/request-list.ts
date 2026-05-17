// src/app/modules/purchases/pages/request-list/request-list.ts

import { Component, OnInit, OnDestroy, ViewChild, ChangeDetectorRef, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';
import { Subject, takeUntil, debounceTime, distinctUntilChanged, finalize, catchError, of, interval } from 'rxjs';

import { MatToolbarModule } from '@angular/material/toolbar';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule, MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ToastrService } from 'ngx-toastr';

import { PurchaseRequestService } from '../../services/purchase-request';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService, User } from '../../../../core/services/auth';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { SoundService } from '../../../../core/services/sound.service';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

import { 
  PurchaseRequest, 
  getStatusClassForBadge,
  getStatusLabelForBadge,
  formatAmount,
  formatDate,
  isOverdue
} from '../../models/purchase-request.model';

@Component({
  selector: 'app-request-list',
  templateUrl: './request-list.html',
  styleUrls: ['./request-list.css'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    RouterModule,
    MatToolbarModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatPaginatorModule,
    MatCheckboxModule,
    MatChipsModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ]
})
export class RequestListComponent implements OnInit, OnDestroy {
  
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild('requestsListSection') requestsListSection!: ElementRef;
  
  requests: PurchaseRequest[] = [];
  filteredRequests: PurchaseRequest[] = [];
  loading: boolean = false;
  error: string | null = null;
  
  filterForm: FormGroup;
  
  currentPage: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;
  
  selectedRequests: Set<string> = new Set();
  selectAll: boolean = false;
  filtersExpanded: boolean = true;
  
  currentUser: User | null = null;
  
  alertCount: number = 0;
  isReadOnly: boolean = false;
  
  // ✅ Variables pour le préchargement (LIMITÉ À 50)
  isPreloading: boolean = false;
  preloadProgress: number = 0;
  preloadCurrent: number = 0;
  preloadTotal: number = 0;
  preloadCompleted: boolean = false;
  private readonly MAX_PRELOAD = 50; // ✅ LIMITE À 50 DEMANDES
  
  private destroy$ = new Subject<void>();
  
  statsData = [
    { icon: 'description', value: 0, label: 'Total demandes', gradient: 'linear-gradient(135deg, #6366f1, #8b5cf6)', trend: 0 },
    { icon: 'pending', value: 0, label: 'En attente', gradient: 'linear-gradient(135deg, #f59e0b, #d97706)', trend: 0 },
    { icon: 'play_circle', value: 0, label: 'En cours', gradient: 'linear-gradient(135deg, #3b82f6, #2563eb)', trend: 0 },
    { icon: 'check_circle', value: 0, label: 'Traités', gradient: 'linear-gradient(135deg, #10b981, #059669)', trend: 0 },
    { icon: 'attach_money', value: 0, label: 'Montant total', gradient: 'linear-gradient(135deg, #8b5cf6, #7c3aed)', trend: 0 }
  ];
  
  private previousStatsData = {
    total: 0,
    open: 0,
    inProgress: 0,
    completed: 0
  };
  
  constructor(
    private purchaseRequestService: PurchaseRequestService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private alertsCounterService: AlertsCounterService,
    private fb: FormBuilder,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private soundService: SoundService,
    private toastr: ToastrService,
    private appMode: AppModeService,
    private offlineSync: OfflineSyncService
  ) {
    this.filterForm = this.fb.group({
      status: ['all'],
      jobNo: [''],
      dateFrom: [''],
      dateTo: [''],
      search: ['']
    });
  }
  
  ngOnInit(): void {
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode request-list:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.currentUser = this.authService.getCurrentUser();
    
    if (!this.currentUser) {
      this.currentUser = {
        id: 'dev-user',
        username: 'dev',
        role: 'DEVELOPER',
        name: 'Développeur',
        isApprover: true
      };
    }
    
    this.subscribeToAlertCounts();
    
    setTimeout(() => {
      this.loadRequests();
    }, 0);
    
    this.setupFilters();
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
        this.alertCount = counts.purchaseRequests;
        this.cdr.detectChanges();
      });
  }
  
  // ✅ MÉTHODE DE PRÉCHARGEMENT - LIMITÉE AUX 50 DEMANDES LES PLUS RÉCENTES
  async preloadRecentRequestDetails(requests: PurchaseRequest[]): Promise<void> {
    // Ne précharger qu'une seule fois
    if (this.preloadCompleted) {
      console.log('ℹ️ Préchargement déjà effectué');
      return;
    }
    
    if (!this.offlineSync.isOnline) {
      console.log('⚠️ Hors ligne - Pas de préchargement');
      return;
    }
    
    if (this.isPreloading) {
      console.log('⏳ Préchargement déjà en cours...');
      return;
    }
    
    // ✅ TRIER PAR DATE DÉCROISSANTE (les plus récentes d'abord)
    const sortedRequests = [...requests].sort((a, b) => {
      const dateA = a.orderDate ? new Date(a.orderDate).getTime() : 0;
      const dateB = b.orderDate ? new Date(b.orderDate).getTime() : 0;
      return dateB - dateA;
    });
    
    // ✅ PRENDRE SEULEMENT LES 50 PREMIÈRES
    const requestsToPreload = sortedRequests.slice(0, this.MAX_PRELOAD).filter(r => r.id);
    
    if (requestsToPreload.length === 0) {
      console.log('ℹ️ Aucune demande à précharger');
      this.preloadCompleted = true;
      return;
    }
    
    this.isPreloading = true;
    this.preloadTotal = requestsToPreload.length;
    this.preloadCurrent = 0;
    this.preloadProgress = 0;
    this.cdr.detectChanges();
    
    
    
    
    let successCount = 0;
    let failCount = 0;
    
    // Traitement par lots pour ne pas surcharger l'API
    const batchSize = 5;
    for (let i = 0; i < requestsToPreload.length; i += batchSize) {
      const batch = requestsToPreload.slice(i, i + batchSize);
      
      const promises = batch.map(async (request) => {
        if (request.id) {
          try {
            await this.purchaseRequestService.getById(request.id).toPromise();
            successCount++;
            console.log(`✅ [${successCount + failCount}/${requestsToPreload.length}] Préchargé: ${request.no}`);
          } catch (err) {
            console.warn(`⚠️ Échec préchargement ${request.no}:`, err);
            failCount++;
          }
        }
      });
      
      await Promise.all(promises);
      
      this.preloadCurrent = Math.min(i + batchSize, requestsToPreload.length);
      this.preloadProgress = (this.preloadCurrent / this.preloadTotal) * 100;
      this.cdr.detectChanges();
      
      console.log(`📦 Batch ${Math.floor(i / batchSize) + 1}/${Math.ceil(requestsToPreload.length / batchSize)} terminé (${this.preloadCurrent}/${this.preloadTotal})`);
    }
    
    console.log(`✅ Préchargement terminé: ${successCount} succès, ${failCount} échecs`);
    
    
    
    
    this.isPreloading = false;
    this.preloadCompleted = true;
    this.cdr.detectChanges();
  }
  
  navigateToAlerts(): void {
    if (this.isReadOnly) {
      this.toastr.info('Alertes indisponibles en mode hors ligne', 'Mode lecture seule');
      return;
    }
    
    if (this.alertCount > 0) {
      this.soundService.playDefaultSound();
      this.toastr.info(`🔍 Vous avez ${this.alertCount} alerte(s) dans les demandes d'achat`, 'Alertes disponibles');
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { filterDomain: 'purchaseRequests', source: 'purchase-requests-page' }
    });
  }
  
  scrollToRequestsList(statIndex: number): void {
    this.applyFilterByStat(statIndex);
    
    setTimeout(() => {
      if (this.requestsListSection && this.requestsListSection.nativeElement) {
        this.requestsListSection.nativeElement.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
        
        this.requestsListSection.nativeElement.classList.add('highlight-list');
        setTimeout(() => {
          this.requestsListSection.nativeElement.classList.remove('highlight-list');
        }, 1500);
      }
    }, 200);
  }
  
  private applyFilterByStat(statIndex: number): void {
    switch (statIndex) {
      case 0:
        this.filterForm.patchValue({ status: 'all' });
        this.applyFilters();
        
        break;
      case 1:
        this.filterForm.patchValue({ status: 'Open' });
        this.applyFilters();
        this.toastr.info('Affichage des demandes en attente', '⏳ En attente');
        break;
      case 2:
        this.filterForm.patchValue({ status: 'Released' });
        this.applyFilters();
        this.toastr.info('Affichage des demandes en cours', '🔄 En cours');
        break;
      case 3:
        this.filterForm.patchValue({ status: 'Completed' });
        this.applyFilters();
        this.toastr.info('Affichage des demandes traitées', '✅ Traitées');
        break;
      case 4:
        this.filterForm.patchValue({ status: 'all' });
        this.applyFilters();
        this.toastr.info('Affichage de toutes les demandes', '💰 Vue générale');
        break;
      default:
        break;
    }
    this.cdr.detectChanges();
  }
  
  loadRequests(): void {
    if (this.loading) return;
    
    this.loading = true;
    this.error = null;
    this.cdr.detectChanges();
    
    const filters: any = {};
    
    if (this.filterForm.get('status')?.value !== 'all') {
      filters.status = this.filterForm.get('status')?.value;
    }
    
    const jobNo = this.filterForm.get('jobNo')?.value;
    if (jobNo) filters.jobNo = jobNo;
    
    const isApprover = this.authService.isApprover();
    if (!isApprover && this.currentUser) {
      filters.requesterId = this.currentUser.id || this.currentUser.username;
    }
    
    this.purchaseRequestService.getAll(filters)
      .pipe(
        takeUntil(this.destroy$),
        catchError((error) => {
          console.error('❌ Erreur:', error);
          this.error = 'Erreur de connexion au serveur';
          this.requests = [];
          this.filteredRequests = [];
          this.totalItems = 0;
          return of([]);
        }),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      )
      .subscribe({
        next: (requests) => {
          console.log('✅ Demandes reçues:', requests?.length || 0);
          this.requests = requests || [];
          this.applyLocalFilters();
          this.updateStats();
          
          // ✅ PRÉCHARGER UNIQUEMENT LES 50 DEMANDES LES PLUS RÉCENTES
          if (this.offlineSync.isOnline && this.requests.length > 0 && !this.preloadCompleted) {
            this.preloadRecentRequestDetails(this.requests);
          }
          
          this.cdr.detectChanges();
        },
        error: (error) => {
          console.error('❌ Erreur:', error);
          this.error = 'Erreur lors du chargement des demandes';
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
    // ✅ Réinitialiser le flag pour permettre un nouveau préchargement si nécessaire
    this.preloadCompleted = false;
    this.error = null;
    this.loadRequests();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation');
  }
  
  applyLocalFilters(): void {
    let filtered = [...this.requests];
    
    const dateFrom = this.filterForm.get('dateFrom')?.value;
    if (dateFrom) {
      const fromDate = new Date(dateFrom);
      fromDate.setHours(0, 0, 0, 0);
      filtered = filtered.filter(r => {
        if (!r.orderDate) return false;
        return new Date(r.orderDate) >= fromDate;
      });
    }
    
    const dateTo = this.filterForm.get('dateTo')?.value;
    if (dateTo) {
      const toDate = new Date(dateTo);
      toDate.setHours(23, 59, 59, 999);
      filtered = filtered.filter(r => {
        if (!r.orderDate) return false;
        return new Date(r.orderDate) <= toDate;
      });
    }
    
    const searchTerm = this.filterForm.get('search')?.value?.toLowerCase();
    if (searchTerm) {
      filtered = filtered.filter(r => 
        (r.no || '').toLowerCase().includes(searchTerm) ||
        (r.jobNo || '').toLowerCase().includes(searchTerm) ||
        (r.jobDescription || '').toLowerCase().includes(searchTerm) ||
        (r.requesterId || '').toLowerCase().includes(searchTerm)
      );
    }
    
    this.filteredRequests = filtered;
    this.totalItems = filtered.length;
    this.currentPage = 1;
    this.updateStats();
    this.updateSelectAll();
  }
  
  setupFilters(): void {
    this.filterForm.valueChanges
      .pipe(
        debounceTime(500),
        distinctUntilChanged(),
        takeUntil(this.destroy$)
      )
      .subscribe(() => {
        this.applyLocalFilters();
        this.cdr.detectChanges();
      });
  }
  
  applyFilters(): void {
    this.applyLocalFilters();
    this.cdr.detectChanges();
  }
  
  resetFilters(): void {
    this.filterForm.reset({
      status: 'all',
      jobNo: '',
      dateFrom: '',
      dateTo: '',
      search: ''
    });
    this.applyLocalFilters();
    this.cdr.detectChanges();
  }
  
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
    this.cdr.detectChanges();
  }
  
  hasActiveFilters(): boolean {
    const status = this.filterForm.get('status')?.value;
    const jobNo = this.filterForm.get('jobNo')?.value;
    const dateFrom = this.filterForm.get('dateFrom')?.value;
    const dateTo = this.filterForm.get('dateTo')?.value;
    const search = this.filterForm.get('search')?.value;
    
    return status !== 'all' || jobNo || dateFrom || dateTo || search;
  }
  
  get activeFiltersCount(): number {
    let count = 0;
    const status = this.filterForm.get('status')?.value;
    const jobNo = this.filterForm.get('jobNo')?.value;
    const dateFrom = this.filterForm.get('dateFrom')?.value;
    const dateTo = this.filterForm.get('dateTo')?.value;
    const search = this.filterForm.get('search')?.value;
    
    if (status && status !== 'all') count++;
    if (jobNo) count++;
    if (dateFrom) count++;
    if (dateTo) count++;
    if (search) count++;
    
    return count;
  }
  
  removeFilter(fieldName: string): void {
    if (fieldName === 'status') {
      this.filterForm.patchValue({ status: 'all' });
    } else {
      this.filterForm.patchValue({ [fieldName]: '' });
    }
    this.applyFilters();
  }
  
  get paginatedRequests(): PurchaseRequest[] {
    const start = (this.currentPage - 1) * this.pageSize;
    return this.filteredRequests.slice(start, start + this.pageSize);
  }
  
  onPageChange(event: PageEvent): void {
    this.currentPage = event.pageIndex + 1;
    this.pageSize = event.pageSize;
    this.updateSelectAll();
    this.cdr.detectChanges();
  }
  
  toggleSelect(request: PurchaseRequest): void {
    const identifier = request.id || request.no;
    if (!identifier) return;
    if (this.selectedRequests.has(identifier)) {
      this.selectedRequests.delete(identifier);
    } else {
      this.selectedRequests.add(identifier);
    }
    this.updateSelectAll();
    this.cdr.detectChanges();
  }
  
  toggleSelectAll(): void {
    if (this.selectAll) {
      this.selectedRequests.clear();
    } else {
      this.paginatedRequests.forEach(r => {
        const identifier = r.id || r.no;
        if (identifier) this.selectedRequests.add(identifier);
      });
    }
    this.updateSelectAll();
    this.cdr.detectChanges();
  }
  
  clearSelection(): void {
    this.selectedRequests.clear();
    this.selectAll = false;
    this.cdr.detectChanges();
  }
  
  updateSelectAll(): void {
    const validIdentifiers = this.paginatedRequests.filter(r => r.id || r.no).length;
    this.selectAll = validIdentifiers > 0 && this.paginatedRequests.every(r => {
      const identifier = r.id || r.no;
      return identifier && this.selectedRequests.has(identifier);
    });
  }
  
  createNewRequest(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Création de demande indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/purchases/request/new']);
  }
  
  viewRequest(request: PurchaseRequest): void {
    const id = request.id;
    if (!id) {
      console.error('❌ Aucun ID valide:', request);
      this.notificationService.showError('Impossible d\'ouvrir cette demande');
      return;
    }
    this.router.navigate(['/purchases/request', id]);
  }
  
  editRequest(request: PurchaseRequest): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const id = request.id;
    if (!id) {
      this.notificationService.showError('Impossible de modifier cette demande');
      return;
    }
    if (!this.canEdit(request)) {
      this.notificationService.showWarning('Cette demande ne peut pas être modifiée');
      return;
    }
    this.router.navigate(['/purchases/request', id, 'edit']);
  }
  
  deleteRequest(request: PurchaseRequest): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const id = request.id;
    if (!id) {
      this.notificationService.showError('Impossible de supprimer cette demande');
      return;
    }
    if (!this.canDelete(request)) {
      this.notificationService.showWarning('Seules les demandes ouvertes peuvent être supprimées');
      return;
    }
    if (confirm(`Supprimer la demande ${request.no} ?`)) {
      this.loading = true;
      this.cdr.detectChanges();
      
      this.purchaseRequestService.delete(id).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          const index = this.requests.findIndex(r => r.id === id);
          if (index !== -1) {
            this.requests.splice(index, 1);
          }
          const filteredIndex = this.filteredRequests.findIndex(r => r.id === id);
          if (filteredIndex !== -1) {
            this.filteredRequests.splice(filteredIndex, 1);
          }
          this.totalItems = this.filteredRequests.length;
          const maxPage = Math.ceil(this.totalItems / this.pageSize);
          if (this.currentPage > maxPage && maxPage > 0) {
            this.currentPage = maxPage;
          }
          this.selectedRequests.delete(id);
          this.updateSelectAll();
          this.updateStats();
          this.cdr.detectChanges();
          this.notificationService.showSuccess('Demande supprimée');
        },
        error: (error) => {
          console.error('Erreur suppression', error);
          this.notificationService.showError('Impossible de supprimer la demande');
        }
      });
    }
  }
  
  generateOrders(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Génération de commande indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (this.selectedRequests.size === 0) return;
    
    const selectedIds = Array.from(this.selectedRequests);
    console.log('Demandes sélectionnées (IDs):', selectedIds);
    
    this.notificationService.showConfirmation({
      title: 'Génération de commandes',
      message: `Générer les commandes fournisseur pour ${this.selectedRequests.size} demande(s) ?`,
      confirmText: 'Générer',
      cancelText: 'Annuler'
    }).subscribe(confirmed => {
      if (confirmed) {
        this.notificationService.showSuccess('Commandes générées avec succès');
        this.selectedRequests.clear();
        this.loadRequests();
      }
    });
  }
  
  updateStats(): void {
    this.statsData[0].value = this.filteredRequests.length;
    this.statsData[1].value = this.filteredRequests.filter(r => r.status === 'Ouvert' || r.status === 'Open').length;
    this.statsData[2].value = this.filteredRequests.filter(r => r.status === 'Released' || r.status === 'En cours').length;
    this.statsData[3].value = this.filteredRequests.filter(r => r.status === 'Totallement Pris En Charge' || r.status === 'Completed').length;
    this.statsData[4].value = this.filteredRequests.reduce((sum, r) => sum + (r.amount || 0), 0);
    
    this.calculateTrends();
  }
  
  calculateTrends(): void {
    this.statsData[0].trend = this.calculateTrend(this.statsData[0].value as number, this.previousStatsData.total);
    this.statsData[1].trend = this.calculateTrend(this.statsData[1].value as number, this.previousStatsData.open);
    this.statsData[2].trend = this.calculateTrend(this.statsData[2].value as number, this.previousStatsData.inProgress);
    this.statsData[3].trend = this.calculateTrend(this.statsData[3].value as number, this.previousStatsData.completed);
    
    this.previousStatsData = {
      total: this.statsData[0].value as number,
      open: this.statsData[1].value as number,
      inProgress: this.statsData[2].value as number,
      completed: this.statsData[3].value as number
    };
  }
  
  calculateTrend(current: number, previous: number): number {
    if (previous === 0) return current > 0 ? 100 : 0;
    return Math.round(((current - previous) / previous) * 100);
  }
  
  getStatusClassForBadge(status: string | undefined): string {
    return getStatusClassForBadge(status);
  }
  
  getStatusLabelForBadge(status: string | undefined): string {
    return getStatusLabelForBadge(status);
  }
  
  canEdit(request: PurchaseRequest): boolean {
    return request.status === 'Ouvert' || request.status === 'Open';
  }
  
  canDelete(request: PurchaseRequest): boolean {
    return request.status === 'Ouvert' || request.status === 'Open';
  }
  
  canRelease(request: PurchaseRequest): boolean {
    return request.status === 'Ouvert' || request.status === 'Open';
  }
  
  releaseRequest(request: PurchaseRequest): void {
    if (this.isReadOnly) {
      this.toastr.warning('Action indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const id = request.id;
    if (!id) {
      this.notificationService.showError('Impossible de lancer cette demande');
      return;
    }
    
    if (!this.canRelease(request)) {
      this.notificationService.showWarning(`Cette demande ne peut pas être lancée`);
      return;
    }
    
    if (confirm(`Lancer la demande ${request.no} ?`)) {
      this.loading = true;
      this.cdr.detectChanges();
      
      this.purchaseRequestService.submitToApprove(id).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          const newStatus = 'Released';
          
          const index = this.requests.findIndex(r => r.id === id);
          if (index !== -1) {
            this.requests[index].status = newStatus;
          }
          
          const filteredIndex = this.filteredRequests.findIndex(r => r.id === id);
          if (filteredIndex !== -1) {
            this.filteredRequests[filteredIndex].status = newStatus;
          }
          
          this.updateStats();
          this.cdr.detectChanges();
          this.toastr.success(`✅ Demande ${request.no} lancée avec succès !`, 'Demande envoyée');
          this.soundService.playNotificationSound();
        },
        error: (error) => {
          console.error('Erreur lancement', error);
          this.notificationService.showError('Impossible de lancer la demande');
          this.toastr.error(`❌ Erreur lors du lancement de la demande ${request.no}`, 'Échec');
        }
      });
    }
  }
  
  formatDate(date: string | Date | undefined): string {
    return formatDate(date);
  }
  
  formatDateShort(date: string | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR', { day: '2-digit', month: '2-digit' });
  }
  
  formatAmount(amount: number | undefined): string {
    return formatAmount(amount || 0);
  }
  
  isOverdue(dueDate: string | Date | undefined): boolean {
    return isOverdue(dueDate);
  }
}

export { RequestListComponent as RequestList };