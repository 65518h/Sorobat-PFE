// src/app/modules/attendance/pages/attendance-list/attendance-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Subject, takeUntil } from 'rxjs';
import { AttendanceService } from '../../services/attendance.service';
import { AttendanceHeader } from '../../models/attendance.model';
import { AuthService } from '../../../../core/services/auth';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

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
    MatCardModule,
    MatIconModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './attendance-list.html',
  styleUrls: ['./attendance-list.css']
})
export class AttendanceListComponent implements OnInit, OnDestroy {
  
  attendanceHeaders: AttendanceHeader[] = [];
  loading = false;
  errorMessage = '';
  currentJobNo: string = '';
  isReadOnly: boolean = false;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private attendanceService: AttendanceService,
    private authService: AuthService,
    private router: Router,
    private toastr: ToastrService,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService
  ) {}
  
  ngOnInit(): void {
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode attendance:', this.isReadOnly ? 'offline-readonly' : 'online');
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
    console.log('👤 Utilisateur récupéré:', user);
    
    if (user && user.projet) {
      this.currentJobNo = user.projet;
      console.log('📁 Projet associé:', this.currentJobNo);
      this.loadAttendance();
    } else {
      this.errorMessage = 'Aucun projet associé à votre compte';
      this.loading = false;
      this.cdr.detectChanges();
      console.warn('⚠️ Aucun projet trouvé pour cet utilisateur');
    }
  }
  
  loadAttendance(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    console.log('🔍 Chargement des pointages pour le projet:', this.currentJobNo);
    
    this.attendanceService.getAllHeaders()
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (data) => {
          console.log('✅ Pointages reçus:', data?.length || 0);
          this.attendanceHeaders = (data || [])
            .filter(h => h.jobNo === this.currentJobNo)
            .map(h => ({
              ...h,
              isOffline: h.id?.startsWith('offline_') || false
            }));
          
          this.loading = false;
          this.cdr.detectChanges();
          
          const offlineCount = this.attendanceHeaders.filter(h => h.isOffline === true).length;
          if (offlineCount > 0 && this.isReadOnly) {
            this.toastr.info(`📱 ${offlineCount} pointage(s) créé(s) localement`, 'Mode hors ligne', {
              timeOut: 4000
            });
          }
        },
        error: (error) => {
          console.error('❌ Erreur chargement pointages:', error);
          this.errorMessage = 'Impossible de charger les données de pointage. Veuillez réessayer.';
          this.loading = false;
          this.cdr.detectChanges();
          
          if (!this.isReadOnly) {
            this.toastr.error('Erreur de connexion au serveur', 'Erreur');
          }
        }
      });
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
  
  // ✅ Supprimer (caché offline)
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
    
    if (confirm(`Êtes-vous sûr de vouloir supprimer le pointage de ${attendance.month} ${attendance.year} ?`)) {
      this.attendanceService.deleteHeader(id)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.toastr.success(`Pointage supprimé avec succès`);
            this.loadAttendance();
          },
          error: (error) => {
            console.error('❌ Erreur suppression:', error);
            this.toastr.error('Erreur lors de la suppression');
          }
        });
    }
  }
  
  // ✅ Rafraîchir (caché offline)
  refresh(): void {
    if (this.loading) return;
    this.loadAttendance();
  }
  
  // ✅ Reconnaissance faciale (cachée offline)
  goToFaceRecognition(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Reconnaissance faciale indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    this.router.navigate(['/attendance', 'face']);
  }
  
  // ✅ Nouveau pointage (visible mais désactivé en offline readonly)
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
    return this.attendanceHeaders.reduce((sum, h) => sum + (h.totalStaff || 0), 0);
  }
  
  getAverageAttendanceRate(): number {
    if (this.attendanceHeaders.length === 0) return 0;
    const total = this.attendanceHeaders.reduce((sum, h) => sum + (h.attendanceRate || 0), 0);
    return Math.round(total / this.attendanceHeaders.length);
  }
  
  getUniqueMonthsCount(): number {
    const months = new Set(this.attendanceHeaders.map(h => `${h.month}-${h.year}`));
    return months.size;
  }
}