// src/app/modules/equipment/pages/vehicule-pointage/list/vehicule-pointage-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { finalize, Subject, takeUntil, interval } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatTableModule } from '@angular/material/table';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDialogModule, MatDialog } from '@angular/material/dialog';
import { ToastrService } from 'ngx-toastr';

// Services
import { VehiculePointageService } from '../../../services/vehicule-pointage.service';
import { AuthService } from '../../../../../core/services/auth';
import { NotificationService } from '../../../../../core/services/notification';
import { AlertsCounterService } from '../../../../../core/services/alerts-counter.service';
import { SoundService } from '../../../../../core/services/sound.service';
import { AppModeService } from '../../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../../core/directives/show-offline-message.directive';
import { ConfirmationDialogComponent, ConfirmationDialogData } from '../../../../../core/components/confirmation-dialog/confirmation-dialog.component';

// Models
import { 
  VehiculePointageHeader, 
  getPointageStatusClass,
  getPointageStatusIcon
} from '../../../models/vehicule-pointage.model';

@Component({
  selector: 'app-vehicule-pointage-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatTableModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatDialogModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './vehicule-pointage-list.html',
  styleUrls: ['./vehicule-pointage-list.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class VehiculePointageList implements OnInit, OnDestroy {
[x: string]: any;
  
  // Pointages
  pointages: VehiculePointageHeader[] = [];
  filteredPointages: VehiculePointageHeader[] = [];
  isReadOnly: boolean = false;
  
  // Compteur d'alertes
  alertCount: number = 0;
  
  // Statistiques
  stats = {
    totalPointages: 0,
    totalVehicules: 0,
    totalHours: 0,
    totalDistance: 0,
    totalFuel: 0,
    totalEstimatedCost: 0,
    draftCount: 0,
    validatedCount: 0,
    closedCount: 0,
    openCount: 0,
    cancelledCount: 0
  };
  
  // Chargement et erreurs
  loading = false;
  errorMessage = '';
  selectedTab = 0;
  
  // Filtres
  searchTerm: string = '';
  statusFilter: string = 'all';
  dateFrom: string = '';
  dateTo: string = '';
  filtersExpanded: boolean = false;
  
  // Pagination
  pageSize: number = 10;
  pageIndex: number = 0;
  
  // Math pour les templates
  Math = Math;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private router: Router,
    private vehiculePointageService: VehiculePointageService,
    private authService: AuthService,
    private notificationService: NotificationService,
    private alertsCounterService: AlertsCounterService,
    private toastr: ToastrService,
    private dialog: MatDialog,
    private soundService: SoundService,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService,
    private offlineSync: OfflineSyncService
  ) {}
  
  ngOnInit(): void {
    // S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('Mode vehicule-pointage-list:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.subscribeToAlertCounts();
    this.loadPointages();
    this.startAutoRefresh();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  // ==================== ALERTES ====================
  
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
        this.alertCount = counts.vehicules;
        this.cdr.detectChanges();
      });
  }
  
  /**
   * Navigation vers le centre d'alertes avec filtre engins
   */
  navigateToAlerts(): void {
    if (this.isReadOnly) {
      this.toastr.info('Alertes indisponibles en mode hors ligne', 'Mode lecture seule');
      return;
    }
    
    if (this.alertCount > 0) {
      this.soundService.playDefaultSound();
      this.toastr.info(
        `Vous avez ${this.alertCount} alerte(s) dans le pointage des engins`,
        'Alertes disponibles',
        {
          positionClass: 'toast-top-right',
          timeOut: 6000,
          closeButton: true,
          progressBar: true
        }
      );
    }
    
    this.router.navigate(['/alerts'], {
      queryParams: { 
        filterDomain: 'vehicules',
        source: 'vehicule-pointage-page'
      }
    });
  }
  
  // ==================== CHARGEMENT ====================
  
  /**
   * Charge la liste des pointages
   */
  loadPointages(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    this.vehiculePointageService.getMyPointagesWithCounts().pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (data) => {
        console.log(`${data?.length || 0} pointages reçus ${this.isReadOnly ? '(cache offline)' : '(API)'}`);
        this.pointages = data || [];
        this.calculateStats();
        this.applyFilters();
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('Erreur chargement pointages:', error);
        this.errorMessage = 'Impossible de charger la liste des pointages. Veuillez réessayer.';
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Rafraîchit la liste
   */
  refresh(): void {
    if (this.isReadOnly) {
      this.toastr.info('Actualisation indisponible en mode hors ligne', 'Mode lecture seule');
      return;
    }
    this.vehiculePointageService.clearCache();
    this.loadPointages();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation', {
      positionClass: 'toast-top-right',
      timeOut: 1500
    });
  }
  
  /**
   * Calcule les statistiques globales
   */
  calculateStats(): void {
    const totalVehicules = this.pointages.reduce((sum, p) => sum + (p.totalVehicules || 0), 0);
    const totalHours = this.pointages.reduce((sum, p) => sum + (p.totalHours || 0), 0);
    const totalDistance = this.pointages.reduce((sum, p) => sum + (p.totalDistance || 0), 0);
    const totalFuel = this.pointages.reduce((sum, p) => sum + (p.totalFuel || 0), 0);
    
    this.stats = {
      totalPointages: this.pointages.length,
      totalVehicules: totalVehicules,
      totalHours: totalHours,
      totalDistance: totalDistance,
      totalFuel: totalFuel,
      totalEstimatedCost: Math.round((totalFuel * 850) + (totalHours * 5000)),
      draftCount: this.pointages.filter(p => (p.status || '').toLowerCase() === 'brouillon').length,
      validatedCount: this.pointages.filter(p => (p.status || '').toLowerCase() === 'validé').length,
      closedCount: this.pointages.filter(p => (p.status || '').toLowerCase() === 'clôturé').length,
      openCount: this.pointages.filter(p => (p.status || '').toLowerCase() === 'ouvert').length,
      cancelledCount: this.pointages.filter(p => (p.status || '').toLowerCase() === 'annulé').length
    };
    
    console.log('Statistiques calculées:', this.stats);
  }
  
  /**
   * Vérifie si un pointage peut être modifié
   * Modifiable si statut est "Brouillon" ou "Ouvert"
   */
  canEdit(pointage: VehiculePointageHeader): boolean {
    if (this.isReadOnly) return false;
    const status = (pointage.status || '').toLowerCase();
    return status === 'brouillon' || status === 'ouvert';
  }
  
  /**
   * Vérifie si un pointage peut être supprimé
   * Supprimable si statut est "Brouillon" ou "Ouvert"
   */
  canDelete(pointage: VehiculePointageHeader): boolean {
    if (this.isReadOnly) return false;
    const status = (pointage.status || '').toLowerCase();
    return status === 'brouillon' || status === 'ouvert';
  }
  
  /**
   * Vérifie si un pointage peut être validé
   * Validable si statut est "Brouillon" ou "Ouvert"
   */
  canValidate(pointage: VehiculePointageHeader): boolean {
    if (this.isReadOnly) return false;
    const status = (pointage.status || '').toLowerCase();
    return status === 'brouillon' || status === 'ouvert';
  }
  
  /**
   * Retourne les éléments paginés
   */
  get paginatedPointages(): VehiculePointageHeader[] {
    const start = this.pageIndex * this.pageSize;
    const end = start + this.pageSize;
    return this.filteredPointages.slice(start, end);
  }
  
  /**
   * Applique les filtres à la liste des pointages
   */
  applyFilters(): void {
    let filtered = [...this.pointages];
    
    // Filtre par recherche
    if (this.searchTerm && this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(p => 
        p.documentNo?.toLowerCase().includes(term) ||
        p.jobNo?.toLowerCase().includes(term) ||
        p.jobDescription?.toLowerCase().includes(term)
      );
    }
    
    // Filtre par statut (select)
    if (this.statusFilter && this.statusFilter !== 'all') {
      filtered = filtered.filter(p => 
        (p.status || '').toLowerCase() === this.statusFilter.toLowerCase()
      );
    }
    
    // Filtre par onglet
    if (this.selectedTab === 1) {
      filtered = filtered.filter(p => {
        const status = (p.status || '').toLowerCase();
        return status === 'brouillon' || status === 'ouvert';
      });
    } else if (this.selectedTab === 2) {
      filtered = filtered.filter(p => (p.status || '').toLowerCase() === 'validé');
    } else if (this.selectedTab === 3) {
      filtered = filtered.filter(p => (p.status || '').toLowerCase() === 'clôturé');
    }
    
    // Filtre par date de début
    if (this.dateFrom) {
      const dateFrom = new Date(this.dateFrom);
      dateFrom.setHours(0, 0, 0, 0);
      filtered = filtered.filter(p => {
        const pointageDate = this.getFormattedDate(p.date);
        return pointageDate && pointageDate >= dateFrom;
      });
    }
    
    // Filtre par date de fin
    if (this.dateTo) {
      const dateTo = new Date(this.dateTo);
      dateTo.setHours(23, 59, 59, 999);
      filtered = filtered.filter(p => {
        const pointageDate = this.getFormattedDate(p.date);
        return pointageDate && pointageDate <= dateTo;
      });
    }
    
    this.filteredPointages = filtered;
    this.pageIndex = 0;
    this.cdr.detectChanges();
  }
  
  /**
   * Change l'onglet sélectionné
   */
  onTabChange(index: number): void {
    this.selectedTab = index;
    this.applyFilters();
  }
  
  /**
   * Efface la recherche
   */
  clearSearch(): void {
    this.searchTerm = '';
    this.applyFilters();
  }
  
  /**
   * Affiche/masque le panneau de filtres
   */
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
  }
  
  /**
   * Réinitialise tous les filtres
   */
  resetFilters(): void {
    this.searchTerm = '';
    this.statusFilter = 'all';
    this.dateFrom = '';
    this.dateTo = '';
    this.selectedTab = 0;
    this.applyFilters();
  }
  
  /**
   * Vérifie si des filtres sont actifs
   */
  hasActiveFilters(): boolean {
    return !!(this.searchTerm || 
      (this.statusFilter && this.statusFilter !== 'all') ||
      this.dateFrom ||
      this.dateTo ||
      this.selectedTab !== 0);
  }
  
  /**
   * Crée un nouveau pointage
   */
  createNewPointage(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Création de pointage indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/equipment/pointage/new']);
  }
  
  /**
   * Affiche les détails d'un pointage
   */
  viewPointage(pointage: VehiculePointageHeader): void {
    if (pointage.id) {
      this.router.navigate(['/equipment/pointage', pointage.id]);
    }
  }
  
  /**
   * Modifie un pointage
   */
  editPointage(pointage: VehiculePointageHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.canEdit(pointage)) {
      this.notificationService.showWarning(`Impossible de modifier un pointage avec le statut "${pointage.status}". Seuls les brouillons ou les pointages ouverts sont modifiables.`);
      return;
    }
    
    if (pointage.id) {
      this.router.navigate(['/equipment/pointage/edit', pointage.id]);
    }
  }
  
  // NOUVELLE METHODE validatePointage AVEC DIALOGUE DE CONFIRMATION
  validatePointage(pointage: VehiculePointageHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Validation indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.canValidate(pointage)) {
      this.notificationService.showWarning(`Impossible de valider un pointage avec le statut "${pointage.status}". Seuls les brouillons ou les pointages ouverts peuvent être validés.`);
      return;
    }
    
    // Boîte de dialogue de confirmation élégante pour la validation
    const dialogData: ConfirmationDialogData = {
      title: 'Valider le pointage',
      message: `Confirmez-vous la validation du pointage ${pointage.documentNo} ?\n\nUne fois validé, vous ne pourrez plus modifier ce pointage.`,
      confirmText: 'Valider',
      cancelText: 'Annuler',
      confirmColor: 'primary',
      cancelColor: 'basic'
    };
    
    const dialogRef = this.dialog.open(ConfirmationDialogComponent, {
      data: dialogData,
      width: '450px',
      panelClass: 'confirmation-dialog-panel',
      disableClose: true
    });
    
    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (!confirmed) return;
      
      this.loading = true;
      this.cdr.detectChanges();
      
      this.vehiculePointageService.validatePointage(pointage.id!).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          const index = this.pointages.findIndex(p => p.id === pointage.id);
          if (index !== -1) {
            this.pointages[index].status = 'Validé';
          }
          
          const filteredIndex = this.filteredPointages.findIndex(p => p.id === pointage.id);
          if (filteredIndex !== -1) {
            this.filteredPointages[filteredIndex].status = 'Validé';
          }
          
          this.calculateStats();
          this.applyFilters();
          this.cdr.detectChanges();
          
          this.notificationService.showSuccess(`Pointage ${pointage.documentNo} validé avec succès`);
          this.toastr.success(`Pointage ${pointage.documentNo} validé avec succès`, 'Validation réussie');
          this.soundService.playNotificationSound();
        },
        error: (error) => {
          console.error('Erreur validation', error);
          this.notificationService.showError('Erreur lors de la validation du pointage');
          this.toastr.error(`Erreur lors de la validation du pointage ${pointage.documentNo}`, 'Échec');
        }
      });
    });
  }
  
  // NOUVELLE METHODE deletePointage AVEC DIALOGUE DE CONFIRMATION
  deletePointage(pointage: VehiculePointageHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.canDelete(pointage)) {
      this.notificationService.showWarning(`Impossible de supprimer un pointage avec le statut "${pointage.status}". Seuls les brouillons ou les pointages ouverts peuvent être supprimés.`);
      return;
    }
    
    // Boîte de dialogue de confirmation élégante pour la suppression
    const dialogData: ConfirmationDialogData = {
      title: 'Supprimer le pointage',
      message: `Êtes-vous sûr de vouloir supprimer définitivement le pointage ${pointage.documentNo} ?\n\nCette action est irréversible.`,
      confirmText: 'Supprimer',
      cancelText: 'Annuler',
      confirmColor: 'warn',
      cancelColor: 'basic'
    };
    
    const dialogRef = this.dialog.open(ConfirmationDialogComponent, {
      data: dialogData,
      width: '450px',
      panelClass: 'confirmation-dialog-panel',
      disableClose: true
    });
    
    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (!confirmed) return;
      
      this.loading = true;
      this.cdr.detectChanges();
      
      this.vehiculePointageService.deleteHeader(pointage.id!).pipe(
        takeUntil(this.destroy$),
        finalize(() => {
          this.loading = false;
          this.cdr.detectChanges();
        })
      ).subscribe({
        next: () => {
          this.notificationService.showSuccess('Pointage supprimé avec succès');
       
          this.loadPointages();
          this.alertsCounterService.refresh();
        },
        error: (error) => {
          console.error('Erreur suppression', error);
          this.notificationService.showError('Erreur lors de la suppression');
          this.toastr.error(`Erreur lors de la suppression du pointage ${pointage.documentNo}`, 'Échec');
        }
      });
    });
  }
  
  /**
   * Retourne la classe CSS pour le statut du pointage
   */
  getStatusClass(status: string | undefined): string {
    return getPointageStatusClass(status || '');
  }
  
  /**
   * Retourne l'icône pour le statut du pointage
   */
  getStatusIcon(status: string | undefined): string {
    return getPointageStatusIcon(status || '');
  }
  
  /**
   * Retourne un objet Date formaté pour l'affichage
   */
  getFormattedDate(date: string | Date | undefined): Date | null {
    if (!date) return null;
    
    try {
      if (date instanceof Date && !isNaN(date.getTime())) {
        return date;
      }
      
      if (typeof date === 'string') {
        if (date.includes('/')) {
          const parts = date.split('/');
          if (parts.length === 3) {
            const day = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10) - 1;
            const year = parseInt(parts[2], 10);
            const parsedDate = new Date(year, month, day);
            if (!isNaN(parsedDate.getTime()) && parsedDate.getFullYear() > 1) {
              return parsedDate;
            }
          }
        }
        
        if (date.includes('-')) {
          const parsedDate = new Date(date);
          if (!isNaN(parsedDate.getTime()) && parsedDate.getFullYear() > 1) {
            return parsedDate;
          }
        }
      }
      
      return null;
    } catch (error) {
      console.error('Erreur formatage date:', error);
      return null;
    }
  }
  
  // ==================== METHODES DE PAGINATION ====================
  
  previousPage(): void {
    if (this.pageIndex > 0) {
      this.pageIndex--;
    }
  }
  
  nextPage(): void {
    if ((this.pageIndex + 1) * this.pageSize < this.filteredPointages.length) {
      this.pageIndex++;
    }
  }
  
  goToPage(page: number): void {
    this.pageIndex = page - 1;
  }
  
  onPageSizeChange(): void {
    this.pageIndex = 0;
    this.applyFilters();
  }
  
  getPageNumbers(): number[] {
    const totalPages = Math.ceil(this.filteredPointages.length / this.pageSize);
    const currentPage = this.pageIndex + 1;
    const pages: number[] = [];
    
    if (totalPages <= 7) {
      for (let i = 1; i <= totalPages; i++) {
        pages.push(i);
      }
    } else {
      pages.push(1);
      if (currentPage > 3) pages.push(-1);
      const start = Math.max(2, currentPage - 1);
      const end = Math.min(totalPages - 1, currentPage + 1);
      for (let i = start; i <= end; i++) pages.push(i);
      if (currentPage < totalPages - 2) pages.push(-1);
      pages.push(totalPages);
    }
    return pages;
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '—';
    
    try {
      const d = new Date(date);
      if (isNaN(d.getTime()) || d.getFullYear() === 1) return '—';
      
      const day = d.getDate().toString().padStart(2, '0');
      const month = (d.getMonth() + 1).toString().padStart(2, '0');
      const year = d.getFullYear();
      
      return `${day}/${month}/${year}`;
    } catch (error) {
      return '—';
    }
  }
}

export { VehiculePointageList as VehiculePointageListComponent };