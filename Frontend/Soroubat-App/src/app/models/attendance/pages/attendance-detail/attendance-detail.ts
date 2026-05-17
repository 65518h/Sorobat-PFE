// src/app/modules/attendance/pages/attendance-detail/attendance-detail.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { Subject, takeUntil } from 'rxjs';
import { AttendanceService } from '../../services/attendance.service';
import { AttendanceHeader, AttendanceLine, getAttendanceStatusInfo } from '../../models/attendance.model';
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
  selector: 'app-attendance-detail',
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
  templateUrl: './attendance-detail.html',
  styleUrls: ['./attendance-detail.css']
})
export class AttendanceDetailComponent implements OnInit, OnDestroy {
  
  attendance: AttendanceHeader | null = null;
  loading = false;
  errorMessage = '';
  attendanceId: string = '';
  daysInMonth: number[] = [];
  isReadOnly: boolean = false;
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private attendanceService: AttendanceService,
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
        console.log('🔔 Mode detail attendance:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.attendanceId = this.route.snapshot.paramMap.get('id') || '';
    console.log('🔍 ID du pointage (GUID):', this.attendanceId);
    
    if (this.attendanceId) {
      this.loadAttendance();
    } else {
      this.errorMessage = 'Aucun pointage spécifié';
    }
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  loadAttendance(): void {
    if (!this.attendanceId) return;
    
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    console.log('📡 Chargement du pointage:', this.attendanceId);
    
    this.attendanceService.getFullAttendance(this.attendanceId)
      .pipe(takeUntil(this.destroy$))
      .subscribe({
        next: (data) => {
          console.log('✅ Pointage reçu:', data);
          
          this.attendance = {
            ...data,
            lines: data.employeeAttendanceLines || data.lines || []
          };
          
          this.initDaysInMonth();
          this.loading = false;
          this.cdr.detectChanges();
        },
        error: (error) => {
          console.error('❌ Erreur chargement pointage:', error);
          this.errorMessage = 'Impossible de charger les détails du pointage';
          this.loading = false;
          this.cdr.detectChanges();
        }
      });
  }
  
  private initDaysInMonth(): void {
    if (!this.attendance) return;
    
    const monthMap: Record<string, number> = {
      'Janvier': 31, 'Février': 28, 'Mars': 31, 'Avril': 30,
      'Mai': 31, 'Juin': 30, 'Juillet': 31, 'Août': 31,
      'Septembre': 30, 'Octobre': 31, 'Novembre': 30, 'Décembre': 31
    };
    
    let days = monthMap[this.attendance.month] || 30;
    
    if (this.attendance.month === 'Février' && this.isLeapYear(this.attendance.year)) {
      days = 29;
    }
    
    this.daysInMonth = Array.from({ length: days }, (_, i) => i + 1);
    console.log('📅 Jours du mois:', this.daysInMonth.length);
  }
  
  private isLeapYear(year: number): boolean {
    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
  }
  
  isWeekend(day: number): boolean {
    if (!this.attendance) return false;
    
    const date = new Date(this.attendance.year, this.getMonthIndex(this.attendance.month), day);
    const dayOfWeek = date.getDay();
    return dayOfWeek === 0 || dayOfWeek === 6;
  }
  
  private getMonthIndex(monthName: string): number {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months.indexOf(monthName);
  }
  
  getStatusInfo(code: string) {
    return getAttendanceStatusInfo(code);
  }
  
  getDayValue(line: AttendanceLine, day: number): string {
    const key = `day${day}` as keyof AttendanceLine;
    return (line[key] as string) || '';
  }
  
  getDetailedTooltip(line: AttendanceLine, day: number): string {
    const code = this.getDayValue(line, day);
    const statusInfo = this.getStatusInfo(code);
    const date = new Date(this.attendance!.year, this.getMonthIndex(this.attendance!.month), day);
    const dateStr = date.toLocaleDateString('fr-FR', { day: 'numeric', month: 'long' });
    
    if (code) {
      return `${dateStr} : ${statusInfo.label} (${code})`;
    }
    return `${dateStr} : Non renseigné`;
  }
  
  getTotalPresentClass(total: number | undefined): string {
    const value = total ?? 0;
    if (value >= 20) return 'excellent';
    if (value >= 15) return 'good';
    if (value >= 10) return 'average';
    return 'low';
  }
  
  goBack(): void {
    this.router.navigate(['/attendance']);
  }
  
  goToEdit(): void {
    if (this.attendance?.id) {
      if (this.isReadOnly) {
        this.toastr.info('📱 Mode hors ligne - Vous pouvez modifier les présences uniquement', 'Information', {
          timeOut: 3000
        });
      }
      this.router.navigate(['/attendance', 'edit', this.attendance.id]);
    }
  }
  
  deleteAttendance(): void {
    if (this.isReadOnly) {
      this.toastr.warning('Suppression indisponible en mode hors ligne', 'Action indisponible');
      return;
    }
    
    if (!this.attendanceId) return;
    
    const confirmMessage = `Êtes-vous sûr de vouloir supprimer le pointage de ${this.attendance?.month} ${this.attendance?.year} ?\n\nCette action est irréversible et supprimera également tous les employés associés.`;
    
    if (confirm(confirmMessage)) {
      this.loading = true;
      
      this.attendanceService.deleteHeader(this.attendanceId)
        .pipe(takeUntil(this.destroy$))
        .subscribe({
          next: () => {
            this.toastr.success('Pointage supprimé avec succès');
            this.router.navigate(['/attendance']);
            this.loading = false;
          },
          error: (error) => {
            console.error('❌ Erreur suppression:', error);
            this.toastr.error('Erreur lors de la suppression du pointage');
            this.loading = false;
          }
        });
    }
  }
  
  calculateStats(): { totalEmployees: number; totalPresent: number; totalAbsent: number; attendanceRate: number } {
    const lines = this.attendance?.lines || [];
    
    if (!lines || lines.length === 0) {
      return { totalEmployees: 0, totalPresent: 0, totalAbsent: 0, attendanceRate: 0 };
    }
    
    const totalEmployees = lines.length;
    let totalPresent = 0;
    let totalAbsent = 0;
    
    lines.forEach(line => {
      totalPresent += line.totalPresentDays ?? 0;
      totalAbsent += line.totalAbsentDays ?? 0;
    });
    
    const attendanceRate = totalEmployees > 0 ? (totalPresent / (totalPresent + totalAbsent)) * 100 : 0;
    
    return { totalEmployees, totalPresent, totalAbsent, attendanceRate };
  }
  
  retry(): void {
    this.loadAttendance();
  }
}