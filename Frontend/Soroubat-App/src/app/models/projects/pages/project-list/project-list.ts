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
    blockedTasks: 0,
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
    // S'abonner au mode offline
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log(' Mode projet:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    
    this.loadMyProject();
  }
  
  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
  
  /**
   * Charge le projet avec gestion du cache offline
   */
  loadMyProject(): void {
    this.loading = true;
    this.errorMessage = '';
    this.cdr.detectChanges();
    
    this.projectService.getMyProjectWithTasks().pipe(
      takeUntil(this.destroy$),
      catchError(error => {
        console.error(' Erreur chargement projet:', error);
        this.errorMessage = 'Impossible de charger les informations du projet.';
        return of({ project: null, tasks: [] });
      })
    ).subscribe({
      next: ({ project, tasks }) => {
        if (project) {
          this.project = project;
          this.tasks = tasks;
          this.calculateStats();
          
          // Calculer l'avancement global si non fourni par le service
          if (!this.project.progress && this.stats.completionRate > 0) {
            this.project.progress = this.stats.completionRate;
          }
          
          console.log(' Projet chargé:', {
            no: project.no,
            description: project.description,
            status: project.status,
            affectationMagasin: project.affectationMagasin,
            startingDate: project.startingDate,
            endingDate: project.endingDate
          });
          console.log(' Tâches chargées:', tasks.length);
          tasks.forEach(task => {
            console.log(`  - Tâche ${task.taskNo}: ${task.description} (${task.progressPct}%)`);
          });
          
          // Afficher un message en mode offline
          if (this.isReadOnly) {
            this.notificationService.showInfo(' Mode hors ligne - Affichage des données en cache');
          }
        } else {
          this.errorMessage = 'Aucun projet associé à votre compte.';
        }
        this.loading = false;
        this.cdr.detectChanges();
      },
      error: (error) => {
        console.error(' Erreur chargement projet:', error);
        this.errorMessage = 'Impossible de charger les informations du projet.';
        this.loading = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  /**
   * Calcule les statistiques à partir des tâches (sans notion de retard)
   */
  calculateStats(): void {
    const totalTasks = this.tasks.length;
    
    // Tâches terminées (progress >= 100)
    const completedTasks = this.tasks.filter(t => (t.progressPct || 0) >= 100).length;
    
    // Tâches bloquées
    const blockedTasks = this.tasks.filter(t => t.isBlocked === true).length;
    
    // Tâches en cours (progress > 0 et progress < 100, non bloquées)
    const inProgressTasks = this.tasks.filter(t => {
      const progress = t.progressPct || 0;
      if (progress >= 100) return false;
      if (t.isBlocked) return false;
      return progress > 0 && progress < 100;
    }).length;
    
    // Tâches en attente (progress === 0, non bloquées)
    const pendingTasks = this.tasks.filter(t => {
      const progress = t.progressPct || 0;
      if (progress > 0) return false;
      if (t.isBlocked) return false;
      return progress === 0;
    }).length;
    
    // Taux de complétion
    const completionRate = totalTasks > 0 ? Math.round((completedTasks / totalTasks) * 100) : 0;
    
    // Avancement moyen
    const totalProgress = this.tasks.reduce((sum, t) => sum + (t.progressPct || 0), 0);
    const averageProgress = totalTasks > 0 ? Math.round(totalProgress / totalTasks) : 0;
    
    this.stats = {
      totalTasks,
      completedTasks,
      inProgressTasks,
      pendingTasks,
      blockedTasks,
      completionRate,
      averageProgress
    };
    
    console.log(' Statistiques calculées:', this.stats);
  }
  
  /**
   * Rafraîchir les données (désactivé en offline)
   */
  refresh(): void {
    if (this.isReadOnly) {
      this.notificationService.showWarning('Mode hors ligne - Rafraîchissement non disponible');
      return;
    }
    this.loadMyProject();
  }
  
  /**
   * Retourne la classe CSS pour le statut du projet
   */
  getStatusClass(status: string): string {
    const statusLower = (status || '').toLowerCase();
    switch(statusLower) {
      case 'terminé':
      case 'completed':
        return 'status-completed';
      case 'en cours':
      case 'in progress':
        return 'status-in-progress';
      case 'en attente':
      case 'pending':
        return 'status-pending';
      case 'bloqué':
      case 'blocked':
        return 'status-blocked';
      case 'suspendu':
      case 'suspended':
        return 'status-suspended';
      case 'open':
      case 'ouvert':
        return 'status-open';
      default:
        return 'status-default';
    }
  }
  
  /**
   * Retourne l'icône pour le statut du projet
   */
  getStatusIcon(status: string): string {
    const statusLower = (status || '').toLowerCase();
    switch(statusLower) {
      case 'terminé':
      case 'completed':
        return 'check_circle';
      case 'en cours':
      case 'in progress':
        return 'pending';
      case 'en attente':
      case 'pending':
        return 'hourglass_empty';
      case 'bloqué':
      case 'blocked':
        return 'block';
      case 'suspendu':
      case 'suspended':
        return 'pause_circle';
      case 'open':
      case 'ouvert':
        return 'schedule';
      default:
        return 'help_outline';
    }
  }
  
  /**
   * Retourne le libellé du statut
   */
  getStatusLabel(status: string): string {
    const statusLower = (status || '').toLowerCase();
    switch(statusLower) {
      case 'terminé':
      case 'completed':
        return 'Terminé';
      case 'en cours':
      case 'in progress':
        return 'En cours';
      case 'en attente':
      case 'pending':
        return 'En attente';
      case 'bloqué':
      case 'blocked':
        return 'Bloqué';
      case 'suspendu':
      case 'suspended':
        return 'Suspendu';
      case 'open':
      case 'ouvert':
        return 'Ouvert';
      default:
        return status || 'En cours';
    }
  }
  
  /**
   * Retourne la couleur de la barre de progression
   */
  getProgressColor(progress: number): string {
    if (progress >= 75) return 'primary';
    if (progress >= 30) return 'accent';
    return 'warn';
  }
  
  /**
   * Formate une date pour l'affichage
   */
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
  
  /**
   * Navigation vers la page des tâches
   */
  navigateToTasks(): void {
    this.router.navigate(['/tasks']);
  }
  
  /**
   * Navigation vers la page du stock
   */
  navigateToStock(): void {
    this.router.navigate(['/inventory/list']);
  }
  
  /**
   * Navigation vers la page du pointage
   */
  navigateToPointage(): void {
    this.router.navigate(['/equipment/pointages']);
  }
  
  /**
   * Navigation vers les détails du projet
   */
  viewProjectDetails(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.id]);
    }
  }
  
  /**
   * Vérifie si des tâches existent
   */
  hasTasks(): boolean {
    return this.tasks && this.tasks.length > 0;
  }
  
  /**
   * Retourne le pourcentage arrondi
   */
  getRoundedProgress(progress: number): string {
    return `${Math.round(progress)}%`;
  }
  
  /**
   * Retourne le nombre de tâches par statut (pour le tooltip)
   */
  getTasksByStatus(): string {
    let text = `${this.stats.completedTasks} terminées, ${this.stats.inProgressTasks} en cours, ${this.stats.pendingTasks} en attente`;
    if (this.stats.blockedTasks > 0) {
      text += `, ${this.stats.blockedTasks} bloquées`;
    }
    return text;
  }
  
  /**
   * Navigation vers la page des tâches avec filtre
   * @param filterType - Type de filtre: 'all', 'completed', 'in-progress', 'pending', 'blocked'
   */
  navigateToTasksWithFilter(filterType: string): void {
    let queryParams = {};
    
    switch(filterType) {
      case 'completed':
        queryParams = { filter: 'termine' };
        break;
      case 'in-progress':
        queryParams = { filter: 'en-cours' };
        break;
      case 'pending':
        queryParams = { filter: 'pending' };
        break;
      case 'blocked':
        queryParams = { filter: 'bloque' };
        break;
      case 'all':
      default:
        queryParams = {};
        break;
    }
    
    console.log(` Navigation vers tâches avec filtre: ${filterType}`, queryParams);
    this.router.navigate(['/tasks'], { queryParams });
  }
}

export { ProjectListComponent as pr};