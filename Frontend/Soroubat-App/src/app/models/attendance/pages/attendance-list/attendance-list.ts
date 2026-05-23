// src/app/modules/attendance/pages/attendance-list/attendance-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Subject, takeUntil } from 'rxjs';
import { AttendanceService } from '../../services/attendance.service';
import { AttendanceHeader } from '../../models/attendance.model';
import { AuthService } from '../../../../core/services/auth';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';
import { ConfirmDialogComponent, ConfirmDialogData } from '../../components/confirm-dialog/confirm-dialog.component';
import { MatDialog } from '@angular/material/dialog';
import { AlertsButtonComponent } from '../../../../shared/components/alerts-button/alerts-button.component';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatTooltipModule } from '@angular/material/tooltip';

@Component({
  selector: 'app-attendance-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    OfflineHideActionsDirective,
    AlertsButtonComponent,
    ShowOfflineMessageDirective
  ],
  templateUrl: './attendance-list.html',
  styleUrls: ['./attendance-list.css']
})
export class AttendanceListComponent implements OnInit, OnDestroy {
  
  attendanceHeaders: AttendanceHeader[] = [];
  filteredHeaders: AttendanceHeader[] = [];
  loading = false;
  errorMessage = '';
  currentJobNo: string = '';
  isReadOnly: boolean = false;
  
  // Filtres
  searchTerm: string = '';
  filterMonth: string = 'all';
  filterYear: string = 'all';
  filterDocumentNo: string = '';
  filterMinEmployees: number | null = null;
  filterMaxEmployees: number | null = null;
  filtersExpanded: boolean = false;
  
  // Années disponibles
  availableYears: number[] = [];
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private attendanceService: AttendanceService,
    private authService: AuthService,
    private router: Router,
    private toastr: ToastrService,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService,
    private dialog: MatDialog
  ) {}
  
  ngOnInit(): void {
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log(' Mode attendance:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.loadUserProject();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  private loadUserProject(): void {
    this.loading = true;
    this.cdr.detectChanges();
    
    const user = this.authService.getUser();
    console.log(' Utilisateur récupéré:', user);
    
    if (user && user.projet) {
      this.currentJobNo = user.projet;
      console.log(' Projet associé:', this.currentJobNo);
      this.loadAttendance();
    } else {
      this.errorMessage = 'Aucun projet associé à votre compte';
      this.loading = false;
      this.cdr.detectChanges();
      console.warn(' Aucun projet trouvé pour cet utilisateur');
    }
  }
  
  loadAttendance(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    console.log(' Chargement des pointages pour le projet:', this.currentJobNo);
    
    this.attendanceService.getAllHeaders()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (data) => {
          console.log(' Pointages reçus:', data?.length || 0);
          this.attendanceHeaders = (data || [])
            .filter(h => h.jobNo === this.currentJobNo)
            .map(h => ({
              ...h,
              isOffline: h.id?.startsWith('offline_') || false
            }));
          
          // Extraire les années disponibles
          const years = new Set<number>();
          this.attendanceHeaders.forEach(h => {
            if (h.year) years.add(h.year);
          });
          this.availableYears = Array.from(years).sort((a, b) => b - a);
          
          this.applyFilters();
          this.loading = false;
          this.cdr.detectChanges();
          
          const offlineCount = this.attendanceHeaders.filter(h => h.isOffline === true).length;
          if (offlineCount > 0 && this.isReadOnly) {
            this.toastr.info(` ${offlineCount} pointage(s) créé(s) localement`, 'Mode hors ligne', {
              timeOut: 4000
            });
          }
        },
        error: (error) => {
          console.error(' Erreur chargement pointages:', error);
          this.errorMessage = 'Impossible de charger les données de pointage. Veuillez réessayer.';
          this.loading = false;
          this.cdr.detectChanges();
          
          if (!this.isReadOnly) {
            this.toastr.error('Erreur de connexion au serveur', 'Erreur');
          }
        }
      });
  }
  
  // ✅ Appliquer les filtres
  applyFilters(): void {
    let filtered = [...this.attendanceHeaders];
    
    // Filtre par recherche textuelle (numéro de pointage, mois, année)
    if (this.searchTerm && this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      filtered = filtered.filter(h => 
        h.no?.toLowerCase().includes(term) ||
        h.month?.toLowerCase().includes(term) ||
        h.year?.toString().includes(term)
      );
    }
    
    // Filtre par mois
    if (this.filterMonth !== 'all') {
      filtered = filtered.filter(h => h.month === this.filterMonth);
    }
    
    // Filtre par année
    if (this.filterYear !== 'all') {
      filtered = filtered.filter(h => h.year === parseInt(this.filterYear));
    }
    
    // Filtre par numéro de document
    if (this.filterDocumentNo && this.filterDocumentNo.trim()) {
      const docTerm = this.filterDocumentNo.toLowerCase().trim();
      filtered = filtered.filter(h => 
        h.no?.toLowerCase().includes(docTerm)
      );
    }
    
    // Filtre par nombre d'employés (min)
    if (this.filterMinEmployees !== null && this.filterMinEmployees > 0) {
      filtered = filtered.filter(h => (h.totalStaff || 0) >= this.filterMinEmployees!);
    }
    
    // Filtre par nombre d'employés (max)
    if (this.filterMaxEmployees !== null && this.filterMaxEmployees > 0) {
      filtered = filtered.filter(h => (h.totalStaff || 0) <= this.filterMaxEmployees!);
    }
    
    this.filteredHeaders = filtered;
    this.cdr.detectChanges();
  }
  
  // ✅ Effacer la recherche
  clearSearch(): void {
    this.searchTerm = '';
    this.applyFilters();
  }
  
  // ✅ Réinitialiser tous les filtres
  resetFilters(): void {
    this.searchTerm = '';
    this.filterMonth = 'all';
    this.filterYear = 'all';
    this.filterDocumentNo = '';
    this.filterMinEmployees = null;
    this.filterMaxEmployees = null;
    this.applyFilters();
    this.toastr.info('Filtres réinitialisés', 'Filtres');
  }
  
  // ✅ Vérifier si des filtres sont actifs
  hasActiveFilters(): boolean {
    return !!(this.searchTerm || 
      this.filterMonth !== 'all' ||
      this.filterYear !== 'all' ||
      this.filterDocumentNo ||
      this.filterMinEmployees !== null ||
      this.filterMaxEmployees !== null);
  }
  
  // ✅ Afficher/masquer les filtres avancés
  toggleFilters(): void {
    this.filtersExpanded = !this.filtersExpanded;
  }
  
  // ✅ Voir détails (toujours visible)
  viewDetail(attendance: AttendanceHeader): void {
    console.log('🔍 Voir détail:', attendance);
    const id = attendance.id;
    if (id) {
      this.router.navigate(['/attendance', id]);
    } else {
      this.toastr.error('Impossible d\'afficher les détails');
    }
  }
  
  // ✅ Modifier (caché offline)
  goToEdit(attendance: AttendanceHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Modification indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const id = attendance.id;
    if (id && !id.startsWith('offline_')) {
      this.router.navigate(['/attendance', 'edit', id]);
    } else if (id && id.startsWith('offline_')) {
      this.toastr.warning('Ce pointage temporaire sera synchronisé automatiquement en ligne', 'Information');
    }
  }
  
  // ✅ Supprimer avec dialogue de confirmation
  deleteAttendance(attendance: AttendanceHeader): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    const id = attendance.id;
    if (!id) {
      this.toastr.error('Pointage invalide');
      return;
    }
    
    const dialogData: ConfirmDialogData = {
      title: 'Supprimer le pointage',
      message: `Êtes-vous sûr de vouloir supprimer le pointage de ${attendance.month} ${attendance.year} ?\n\n⚠️ Cette action est irréversible.`,
      confirmText: 'Supprimer',
      cancelText: 'Annuler',
      confirmColor: 'warn'
    };
    
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: dialogData,
      width: '450px',
      panelClass: 'confirm-dialog-panel',
      disableClose: true
    });
    
    dialogRef.afterClosed().subscribe((confirmed: boolean) => {
      if (!confirmed) return;
      
      this.attendanceService.deleteHeader(id)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.toastr.success(`Pointage supprimé avec succès`);
            this.loadAttendance();
          },
          error: (error) => {
            console.error('❌ Erreur suppression:', error);
            const errorMessage = error.error?.message || 'Erreur lors de la suppression';
            this.toastr.error(errorMessage, 'Erreur');
          }
        });
    });
  }
  
  // ✅ Rafraîchir (caché offline)
  refresh(): void {
    if (this.loading) return;
    this.loadAttendance();
  }
  
  // ✅ Nouveau pointage
  goToNew(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Création de pointage indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/attendance', 'new']);
  }
  
  getMonthName(month: string): string {
    const months: Record<string, string> = {
      'Janvier': 'Janvier', 'Février': 'Février', 'Mars': 'Mars',
      'Avril': 'Avril', 'Mai': 'Mai', 'Juin': 'Juin',
      'Juillet': 'Juillet', 'Août': 'Août', 'Septembre': 'Septembre',
      'Octobre': 'Octobre', 'Novembre': 'Novembre', 'Décembre': 'Décembre'
    };
    return months[month] || month;
  }
  
  retry(): void {
    this.loadUserProject();
  }
  
  getTotalEmployees(): number {
    return this.filteredHeaders.reduce((sum, h) => sum + (h.totalStaff || 0), 0);
  }
  
  getUniqueMonthsCount(): number {
    const months = new Set(this.filteredHeaders.map(h => `${h.month}-${h.year}`));
    return months.size;
  }
}