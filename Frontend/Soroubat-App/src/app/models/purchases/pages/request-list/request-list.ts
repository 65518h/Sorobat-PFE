// src/app/models/purchases/pages/request-list/request-list.ts

import { Component, OnInit, OnDestroy, ViewChild, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { ReactiveFormsModule, FormBuilder, FormGroup } from '@angular/forms';
import { Subject, takeUntil, debounceTime, distinctUntilChanged, finalize, catchError, of } from 'rxjs';

// Angular Material Modules
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule, MatPaginator } from '@angular/material/paginator';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';

import { PurchaseRequestService } from '../../services/purchase-request';
import { NotificationService } from '../../../../core/services/notification';
import { AuthService, User } from '../../../../core/services/auth';
import { 
  PurchaseRequest, 
  PurchaseRequestStatus, 
  getStatusClass,
  getStatusLabel
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
    MatTooltipModule
  ]
})
export class RequestListComponent implements OnInit, OnDestroy {
  
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  
  requests: PurchaseRequest[] = [];
  filteredRequests: PurchaseRequest[] = [];
  loading: boolean = false;  // ✅ Initialisé à false
  error: string | null = null;
  
  filterForm: FormGroup;
  statusOptions = Object.values(PurchaseRequestStatus);
  
  currentPage: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;
  
  selectedRequests: Set<string> = new Set();
  selectAll: boolean = false;
  filtersExpanded: boolean = true;
  
  displayedColumns: string[] = ['select', 'no', 'job', 'requester', 'type', 'orderDate', 'dueDate', 'amount', 'status', 'actions'];
  
  currentUser: User | null = null;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private purchaseRequestService: PurchaseRequestService,
    private notificationService: NotificationService,
    private authService: AuthService,
    private fb: FormBuilder,
    private router: Router,
    private cdr: ChangeDetectorRef  // ✅ Ajouter ChangeDetectorRef
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
    
    // ✅ Charger les données avec un petit délai pour éviter les problèmes de détection de changement
    setTimeout(() => {
      this.loadRequests();
    }, 0);
    
    this.setupFilters();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadRequests(): void {
    // ✅ Éviter les appels multiples
    if (this.loading) {
      console.log('⚠️ Chargement déjà en cours, ignoré');
      return;
    }
    
    console.log('🔄 loadRequests() appelé');
    this.loading = true;
    this.error = null;
    
    // ✅ Forcer la détection de changement
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
    
    console.log('📡 Filtres:', filters);
    
    // ✅ Vérifier si le service existe
    if (!this.purchaseRequestService || typeof this.purchaseRequestService.getAll !== 'function') {
      console.error('❌ Service PurchaseRequestService non disponible');
      this.loading = false;
      this.error = 'Service non disponible';
      this.cdr.detectChanges();
      return;
    }
    
    this.purchaseRequestService.getAll(filters)
      .pipe(
        takeUntil(this.destroy$),
        catchError((error) => {
          console.error('❌ Erreur dans le pipe catchError:', error);
          this.error = 'Erreur de connexion au serveur';
          this.requests = [];
          this.filteredRequests = [];
          this.totalItems = 0;
          return of([]); // ✅ Retourner un tableau vide
        }),
        finalize(() => {
          console.log('🏁 finalize() - Désactivation du loading');
          this.loading = false;
          this.cdr.detectChanges(); // ✅ Forcer la détection de changement
        })
      )
      .subscribe({
        next: (requests) => {
          console.log('✅ Données reçues:', requests?.length || 0);
          this.requests = requests || [];
          this.applyLocalFilters();
          this.cdr.detectChanges();
        },
        error: (error) => {
          // ✅ Ce bloc ne devrait plus être atteint à cause du catchError
          console.error('❌ Erreur dans subscribe error:', error);
          this.error = 'Erreur lors du chargement des demandes';
          this.loading = false;
          this.cdr.detectChanges();
        }
      });
  }
  
  refresh(): void {
    console.log('🔄 Rafraîchissement manuel');
    // ✅ Réinitialiser l'erreur avant rechargement
    this.error = null;
    this.loadRequests();
  }
  
  applyLocalFilters(): void {
    let filtered = [...this.requests];
    
    const dateFrom = this.filterForm.get('dateFrom')?.value;
    if (dateFrom) {
      const fromDate = new Date(dateFrom);
      fromDate.setHours(0, 0, 0, 0);
      filtered = filtered.filter(r => new Date(r.orderDate) >= fromDate);
    }
    
    const dateTo = this.filterForm.get('dateTo')?.value;
    if (dateTo) {
      const toDate = new Date(dateTo);
      toDate.setHours(23, 59, 59, 999);
      filtered = filtered.filter(r => new Date(r.orderDate) <= toDate);
    }
    
    const searchTerm = this.filterForm.get('search')?.value?.toLowerCase();
    if (searchTerm) {
      filtered = filtered.filter(r => 
        r.no?.toLowerCase().includes(searchTerm) ||
        r.jobNo?.toLowerCase().includes(searchTerm) ||
        r.jobDescription?.toLowerCase().includes(searchTerm) ||
        r.requesterId?.toLowerCase().includes(searchTerm)
      );
    }
    
    this.filteredRequests = filtered;
    this.totalItems = filtered.length;
    this.currentPage = 1;
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
  
  get paginatedRequests(): PurchaseRequest[] {
    const start = (this.currentPage - 1) * this.pageSize;
    return this.filteredRequests.slice(start, start + this.pageSize);
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
  
  toggleSelect(request: PurchaseRequest): void {
    if (this.selectedRequests.has(request.id)) {
      this.selectedRequests.delete(request.id);
    } else {
      this.selectedRequests.add(request.id);
    }
    this.updateSelectAll();
    this.cdr.detectChanges();
  }
  
  toggleSelectAll(): void {
    if (this.selectAll) {
      this.selectedRequests.clear();
    } else {
      this.paginatedRequests.forEach(r => this.selectedRequests.add(r.id));
    }
    this.updateSelectAll();
    this.cdr.detectChanges();
  }
  
  updateSelectAll(): void {
    this.selectAll = this.paginatedRequests.length > 0 && 
      this.paginatedRequests.every(r => this.selectedRequests.has(r.id));
  }
  
  createNewRequest(): void {
    this.router.navigate(['/purchases/request/new']);
  }
  
  viewRequest(id: string): void {
    this.router.navigate(['/purchases/request', id]);
  }
  
  editRequest(id: string): void {
    this.router.navigate(['/purchases/request', id, 'edit']);
  }
  
  deleteRequest(request: PurchaseRequest): void {
    if (request.status !== PurchaseRequestStatus.OPEN) {
      this.notificationService.showWarning('Seules les demandes ouvertes peuvent être supprimées');
      return;
    }
    
    if (confirm(`Supprimer la demande ${request.no} ?`)) {
      this.loading = true;
      this.cdr.detectChanges();
      
      this.purchaseRequestService.delete(request.id)
        .pipe(
          takeUntil(this.destroy$),
          finalize(() => {
            this.loading = false;
            this.cdr.detectChanges();
          })
        )
        .subscribe({
          next: () => {
            this.notificationService.showSuccess('Demande supprimée');
            this.loadRequests();
          },
          error: (error) => {
            console.error('Erreur suppression', error);
            this.notificationService.showError('Impossible de supprimer la demande');
          }
        });
    }
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
  
  applyFilters(): void {
    this.applyLocalFilters();
    this.cdr.detectChanges();
  }
  
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
    this.cdr.detectChanges();
  }
  
  getStatusCount(status: string): number {
    return this.requests.filter(r => r.status === status).length;
  }
  
  getTotalAmount(): number {
    return this.requests.reduce((sum, r) => sum + (r.amount || 0), 0);
  }
  
  generateOrders(): void {
    if (this.selectedRequests.size === 0) return;
    
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
  
  getStatusClass(status: string): string {
    return getStatusClass(status);
  }
  
  getStatusLabel(status: string): string {
    return getStatusLabel(status);
  }
  
  formatDate(date: Date | string): string {
    if (!date) return '';
    const d = new Date(date);
    return d.toLocaleDateString('fr-FR');
  }
  
  formatAmount(amount: number): string {
    return new Intl.NumberFormat('fr-FR', { 
      minimumFractionDigits: 2, 
      maximumFractionDigits: 2 
    }).format(amount) + ' FCFA';
  }
  
  isOverdue(dueDate: Date | string): boolean {
    if (!dueDate) return false;
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const due = new Date(dueDate);
    due.setHours(0, 0, 0, 0);
    return due < today;
  }
  
  canEdit(request: PurchaseRequest): boolean {
    const isApprover = this.authService.isApprover();
    const userId = this.authService.getUserId();
    return request.status === PurchaseRequestStatus.OPEN && 
           (request.requesterId === userId || isApprover);
  }
  
  canDelete(request: PurchaseRequest): boolean {
    const userId = this.authService.getUserId();
    return request.status === PurchaseRequestStatus.OPEN && 
           request.requesterId === userId;
  }

















  // Vérifie si des filtres sont actifs
hasActiveFilters(): boolean {
  const status = this.filterForm.get('status')?.value;
  const jobNo = this.filterForm.get('jobNo')?.value;
  const dateFrom = this.filterForm.get('dateFrom')?.value;
  const dateTo = this.filterForm.get('dateTo')?.value;
  const search = this.filterForm.get('search')?.value;
  
  return status !== 'all' || jobNo || dateFrom || dateTo || search;
}

// Supprime un filtre spécifique
removeFilter(fieldName: string): void {
  if (fieldName === 'status') {
    this.filterForm.patchValue({ status: 'all' });
  } else {
    this.filterForm.patchValue({ [fieldName]: '' });
  }
  this.applyFilters();
}

// Formatage court pour les dates
formatDateShort(date: string): string {
  if (!date) return '';
  const d = new Date(date);
  return d.toLocaleDateString('fr-FR');
}
















// Données pour les statistiques
statsData = [
  { icon: 'description', iconClass: 'total', value: 0, label: 'Total demandes' },
  { icon: 'pending', iconClass: 'open', value: 0, label: 'En attente' },
  { icon: 'play_circle', iconClass: 'progress', value: 0, label: 'En cours' },
  { icon: 'check_circle', iconClass: 'complete', value: 0, label: 'Traités' },
  { icon: 'attach_money', iconClass: 'amount', value: 0, label: 'Montant total' }
];

// Mettre à jour les statistiques
updateStats(): void {
  this.statsData[0].value = this.totalItems;
  this.statsData[1].value = this.getStatusCount('Ouvert');
  this.statsData[2].value = this.getStatusCount('Lancé');
  this.statsData[3].value = this.getStatusCount('Totallement Pris En Charge');
  this.statsData[4].value = this.getTotalAmount();
}

// Appeler updateStats() après chaque chargement de données
}

