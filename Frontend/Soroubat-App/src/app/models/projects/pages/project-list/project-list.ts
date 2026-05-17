// src/app/modules/projects/pages/project-list/project-list.ts

import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subject, takeUntil, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

// Angular Material Imports
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDividerModule } from '@angular/material/divider';

import { ProjectService } from '../../services/project';
import { Project } from '../../models/project.model';
import { JobTask } from '../../../tasks/models/job-task.model';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { NotificationService } from '../../../../core/services/notification';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

@Component({
  selector: 'app-project-list',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatChipsModule,
    MatProgressBarModule,
    MatTooltipModule,
    MatDividerModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './project-list.html',
  styleUrls: ['./project-list.css']
})
export class ProjectListComponent implements OnInit, OnDestroy {
  
  project: Project | null = null;
  tasks: JobTask[] = [];
  loading = false;
  errorMessage = '';
  
  // Mode offline
  isReadOnly: boolean = false;
  
  stats = {
    totalTasks: 0,
    completedTasks: 0,
    inProgressTasks: 0,
    pendingTasks: 0,
    completionRate: 0,
    averageProgress: 0
  };
  
  private destroy$ = new Subject<void>();
  
  constructor(
    private projectService: ProjectService,
    private router: Router,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService,
    private notificationService: NotificationService
  ) {}
  
  ngOnInit(): void {
    // ✅ S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log('🔔 Mode projet:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.loadMyProject();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  /**
   * ✅ Charge le projet avec gestion du cache offline
   */
  loadMyProject(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    this.projectService.getMyProjectWithTasks().pipe(
      takeUntil(this.destroy$),
      catchError(error => {
        console.error('❌ Erreur chargement projet:', error);
        this.errorMessage = 'Impossible de charger les informations du projet.';
        return of({ project: null, tasks: [] });
      })
    ).subscribe({
      next: ({ project, tasks }) => {
        if (project) {
          this.project = project;
          this.tasks = tasks;
          this.calculateStats();
          console.log('✅ Projet chargé:', project);
          console.log('📋 Tâches chargées:', tasks.length);
          
          // Afficher un message en mode offline
          if (this.isReadOnly) {
            this.notificationService.showInfo('📱 Mode hors ligne - Affichage des données en cache');
          }
        } else {
          this.errorMessage = 'Aucun projet associé à votre compte.';
        }
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error('❌ Erreur chargement projet:', error);
        this.errorMessage = 'Impossible de charger les informations du projet.';
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Calcule les statistiques à partir des tâches
   */
  calculateStats(): void {
    const totalTasks = this.tasks.length;
    
    const completedTasks = this.tasks.filter(t => (t.progressPct || 0) >= 100).length;
    
    const inProgressTasks = this.tasks.filter(t => {
      const progress = t.progressPct || 0;
      return progress > 0 && progress < 100 && !t.isBlocked;
    }).length;
    
    const pendingTasks = this.tasks.filter(t => (t.progressPct || 0) === 0).length;
    
    const completionRate = totalTasks > 0 ? Math.round((completedTasks / totalTasks) * 100) : 0;
    
    const totalProgress = this.tasks.reduce((sum, t) => sum + (t.progressPct || 0), 0);
    const averageProgress = totalTasks > 0 ? Math.round(totalProgress / totalTasks) : 0;
    
    this.stats = {
      totalTasks,
      completedTasks,
      inProgressTasks,
      pendingTasks,
      completionRate,
      averageProgress
    };
    
    console.log('📊 Statistiques calculées:', this.stats);
  }
  
  /**
   * ✅ Rafraîchir les données (désactivé en offline)
   */
  refresh(): void {
    if (this.isReadOnly) {
      this.notificationService.showWarning('Mode hors ligne - Rafraîchissement non disponible');
      return;
    }
    this.loadMyProject();
  }
  
  getStatusClass(status: string): string {
    switch(status) {
      case 'Terminé':
      case 'Completed':
        return 'status-completed';
      case 'En cours':
      case 'In Progress':
        return 'status-in-progress';
      case 'Suspendu':
      case 'Suspended':
        return 'status-suspended';
      case 'Open':
      case 'Ouvert':
        return 'status-open';
      default:
        return 'status-default';
    }
  }
  
  getStatusIcon(status: string): string {
    switch(status) {
      case 'Terminé':
      case 'Completed':
        return 'check_circle';
      case 'En cours':
      case 'In Progress':
        return 'pending';
      case 'Suspendu':
      case 'Suspended':
        return 'pause_circle';
      case 'Open':
      case 'Ouvert':
        return 'schedule';
      default:
        return 'help_outline';
    }
  }
  
  getProgressColor(progress: number): string {
    if (progress >= 75) return 'primary';
    if (progress >= 30) return 'accent';
    return 'warn';
  }
  
  formatDate(date: string | Date | undefined): string {
    if (!date) return '—';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '—';
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  }
  
  formatDateTime(date: string | Date | undefined): string {
    if (!date) return '—';
    const d = new Date(date);
    if (isNaN(d.getTime())) return '—';
    return d.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  }
  
  navigateToTasks(): void {
    this.router.navigate(['/tasks']);
  }
  
  navigateToStock(): void {
    this.router.navigate(['/inventory/list']);
  }
  
  navigateToPointage(): void {
    this.router.navigate(['/equipment/pointages']);
  }
  
  viewProjectDetails(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.id]);
    }
  }
  
  getStatusLabel(status: string): string {
    switch(status) {
      case 'Terminé':
      case 'Completed':
        return 'Terminé';
      case 'En cours':
      case 'In Progress':
        return 'En cours';
      case 'Suspendu':
      case 'Suspended':
        return 'Suspendu';
      case 'Open':
      case 'Ouvert':
        return 'Ouvert';
      default:
        return status || 'Inconnu';
    }
  }
  
  hasTasks(): boolean {
    return this.tasks && this.tasks.length > 0;
  }
  
  getRoundedProgress(progress: number): string {
    return `${Math.round(progress)}%`;
  }
}