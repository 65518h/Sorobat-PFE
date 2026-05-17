// src/app/modules/equipment/pages/vehicule-pointage/detail/vehicule-pointage-detail.component.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef, ChangeDetectionStrategy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil } from 'rxjs';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatChipsModule } from '@angular/material/chips';
import { MatDividerModule } from '@angular/material/divider';
import { ToastrService } from 'ngx-toastr';

// Services
import { VehiculePointageService } from '../../../services/vehicule-pointage.service';
import { NotificationService } from '../../../../../core/services/notification';
import { AuthService } from '../../../../../core/services/auth';
import { AppModeService } from '../../../../../core/services/app-mode.service';
import { OfflineSyncService } from '../../../../../core/services/offline-sync.service';
import { OfflineHideActionsDirective } from '../../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../../core/directives/show-offline-message.directive';

// Models
import { 
  VehiculePointageHeader, 
  VehiculePointageLine,
  VehiculePointageSummary,
  calculateVehiculePointageSummary
} from '../../../models/vehicule-pointage.model';

@Component({
  selector: 'app-vehicule-pointage-detail',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatCardModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    MatChipsModule,
    MatDividerModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './vehicule-pointage-detail.html',
  styleUrls: ['./vehicule-pointage-detail.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class VehiculePointageDetailComponent implements OnInit, OnDestroy {
  
  pointage: VehiculePointageHeader | null = null;
  loading = false;
  errorMessage = '';
  pointageId: string | null = null;
  isReadOnly: boolean = false;
  
  // Filtre des véhicules
  vehiculeStatusFilter: string = 'all';
  filteredLines: VehiculePointageLine[] = [];
  
  // Colonnes du tableau
  displayedColumns: string[] = ['vehiculeNo', 'description', 'hoursWorked', 'startIndex', 'endIndex', 'distance', 'fuelConsumed', 'status'];
  
  // Données du tableau
  dataSource = new MatTableDataSource<VehiculePointageLine>([]);
  
  // Résumé
  summary: VehiculePointageSummary = {
    totalVehicules: 0,
    totalHours: 0,
    totalDistance: 0,
    totalFuel: 0,
    averageFuelConsumption: 0,
    totalEstimatedCost: 0,
    brokenVehicules: 0
  };
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private vehiculePointageService: VehiculePointageService,
    private notificationService: NotificationService,
    private authService: AuthService,
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
        console.log('🔔 Mode vehicule-pointage-detail:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.pointageId = this.route.snapshot.paramMap.get('id');
    console.log('📄 ID du pointage:', this.pointageId);
    
    if (this.pointageId) {
      this.loadPointage();
    } else {
      this.errorMessage = 'ID du pointage non trouvé';
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadPointage(): void {
    if (!this.pointageId) return;
    
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    this.vehiculePointageService.getHeaderById(this.pointageId).pipe(
      takeUntil(this.destroy$)
    ).subscribe({
      next: (data) => {
        console.log('📦 Pointage chargé:', data);
        this.pointage = data;
        this.dataSource.data = data.lines || [];
        this.filteredLines = data.lines || [];
        this.calculateSummary();
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement pointage', error);
        if (!this.isReadOnly) {
          this.errorMessage = 'Impossible de charger les détails du pointage';
        } else {
          this.toastr.warning('Pointage non disponible hors ligne', 'Mode lecture seule');
        }
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  calculateSummary(): void {
    if (!this.pointage?.lines || this.pointage.lines.length === 0) {
      this.summary = {
        totalVehicules: 0,
        totalHours: 0,
        totalDistance: 0,
        totalFuel: 0,
        averageFuelConsumption: 0,
        totalEstimatedCost: 0,
        brokenVehicules: 0
      };
      return;
    }
    
    this.summary = calculateVehiculePointageSummary(this.pointage.lines);
    console.log('📊 Résumé calculé:', this.summary);
  }
  
  // ==================== MÉTHODES DE FILTRE ====================
  
  applyVehiculeFilter(): void {
    if (!this.pointage?.lines) {
      this.filteredLines = [];
      return;
    }
    
    if (this.vehiculeStatusFilter === 'all') {
      this.filteredLines = [...this.pointage.lines];
    } else {
      this.filteredLines = this.pointage.lines.filter(line => 
        line.status === this.vehiculeStatusFilter
      );
    }
    
    this.cdr.detectChanges();
  }
  
  clearVehiculeFilter(): void {
    this.vehiculeStatusFilter = 'all';
    this.applyVehiculeFilter();
  }
  
  // ==================== STATUS HELPERS ====================
  
  getStatusClass(status: string | undefined): string {
    if (!status) return '';
    
    const statusLower = status.toLowerCase();
    
    switch (statusLower) {
      case 'brouillon':
        return 'status-draft';
      case 'ouvert':
        return 'status-open';
      case 'validé':
        return 'status-validated';
      case 'clôturé':
        return 'status-closed';
      default:
        return '';
    }
  }
  
  getStatusIcon(status: string | undefined): string {
    if (!status) return 'help_outline';
    
    const statusLower = status.toLowerCase();
    
    switch (statusLower) {
      case 'brouillon':
        return 'edit_note';
      case 'ouvert':
        return 'radio_button_unchecked';
      case 'validé':
        return 'check_circle';
      case 'clôturé':
        return 'lock';
      default:
        return 'help_outline';
    }
  }
  
  getVehiculeStatusClass(status: string | undefined): string {
    if (!status) return '';
    
    switch (status) {
      case 'Fonctionnel': return 'status-functional';
      case 'Panne': return 'status-broken';
      case 'Accident': return 'status-accident';      
      case 'Mauvais Temps': return 'status-bad-weather'; 
      case 'Réformé': return 'status-reformed';
      case 'Disponible': return 'status-available';
      default: return '';
    }
  }
  
  getVehiculeStatusIcon(status: string | undefined): string {
    if (!status) return 'help_outline';
    
    switch (status) {
      case 'Fonctionnel': return 'check_circle';
      case 'Panne': return 'error';
      case 'Accident': return 'warning';              
      case 'Mauvais Temps': return 'thunderstorm';    
      case 'Réformé': return 'delete_forever';
      case 'Disponible': return 'radio_button_checked';
      default: return 'help_outline';
    }
  }
  
  getVehiculeStatusLabel(status: string): string {
    switch (status) {
      case 'Fonctionnel': return 'Fonctionnel';
      case 'Panne': return 'En panne';
      case 'Accident': return 'Accident';
      case 'Mauvais Temps': return 'Mauvais Temps';
      case 'Disponible': return 'Disponible';
      case 'Réformé': return 'Réformé';
      default: return status;
    }
  }
  
  // ==================== MÉTHODES UTILITAIRES ====================
  
  calculateDistance(line: VehiculePointageLine): number {
    return Math.max(0, (line.endIndex || 0) - (line.startIndex || 0));
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '';
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }
  
  formatDateTime(date: string | Date | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '';
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
  
  formatNumber(value: number): string {
    return new Intl.NumberFormat('fr-FR').format(value);
  }
  
  // ==================== PERMISSIONS (avec offline) ====================
  
  canValidate(): boolean {
    if (this.isReadOnly) return false;
    return this.pointage?.status === 'Brouillon';
  }
  
  canClose(): boolean {
    if (this.isReadOnly) return false;
    return this.pointage?.status === 'Validé';
  }
  
  canEdit(): boolean {
    if (this.isReadOnly) return false;
    return this.pointage?.status === 'Brouillon';
  }
  
  canEditLines(): boolean {
    if (this.isReadOnly) return false;
    const status = (this.pointage?.status || '').toLowerCase();
    return status === 'brouillon' || status === 'ouvert';
  }
  
  // ==================== ACTIONS ====================
  
  validatePointage(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Validation indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.pointage?.id) return;
    
    if (confirm('Valider ce pointage ? Il ne pourra plus être modifié par la suite.')) {
      this.vehiculePointageService.validatePointage(this.pointage.id).subscribe({
        next: () => {
          this.notificationService.showSuccess('Pointage validé avec succès');
          this.loadPointage();
        },
        error: (error) => {
          console.error('Erreur validation', error);
          this.notificationService.showError('Erreur lors de la validation');
        }
      });
    }
  }
  
  closePointage(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Clôture indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.pointage?.id) return;
    
    if (confirm('Clôturer ce pointage ? Il sera définitivement verrouillé.')) {
      this.vehiculePointageService.closePointage(this.pointage.id).subscribe({
        next: () => {
          this.notificationService.showSuccess('Pointage clôturé avec succès');
          this.loadPointage();
        },
        error: (error) => {
          console.error('Erreur clôture', error);
          this.notificationService.showError('Erreur lors de la clôture');
        }
      });
    }
  }
  
  editPointage(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (this.pointage?.id) {
      this.router.navigate(['/equipment/pointage/edit', this.pointage.id]);
    }
  }
  
  editLine(line: VehiculePointageLine, index: number): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.canEditLines()) {
      this.notificationService.showWarning('Ce pointage ne peut plus être modifié');
      return;
    }
    
    console.log('📤 Passage des données de la ligne:', {
      vehiculeNo: line.vehiculeNo,
      description: line.description,
      hoursWorked: line.hoursWorked,
      startIndex: line.startIndex,
      endIndex: line.endIndex,
      fuelConsumed: line.fuelConsumed,
      status: line.status
    });
    
    this.router.navigate(['/equipment/pointage/edit-line', this.pointageId, line.id], {
      queryParams: {
        vehiculeNo: line.vehiculeNo || '',
        description: line.description || '',
        hoursWorked: line.hoursWorked || 0,
        startIndex: line.startIndex || 0,
        endIndex: line.endIndex || 0,
        fuelConsumed: line.fuelConsumed || 0,
        status: line.status || 'Fonctionnel',
        breakdownMotiv: line.breakdownMotiv || ''
      }
    });
  }
  
  deleteLine(line: VehiculePointageLine, index: number): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.canEditLines()) {
      this.notificationService.showWarning('Ce pointage ne peut plus être modifié');
      return;
    }
    
   
  }
  
  goBack(): void {
    this.router.navigate(['/equipment/pointages']);
  }
  
  printPointage(): void {
    window.print();
  }
}