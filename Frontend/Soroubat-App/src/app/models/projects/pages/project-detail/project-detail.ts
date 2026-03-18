// src/app/modules/projects/pages/project-detail/project-detail.component.ts

import { Component, OnInit, ChangeDetectorRef, ViewChild, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { forkJoin, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

// Services
import { ProjectService } from '../../services/project';
import { JobTaskService } from '../../services/job-task.service';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatPaginatorModule, MatPaginator } from '@angular/material/paginator';
import { MatSnackBarModule, MatSnackBar } from '@angular/material/snack-bar';
import { MatChipsModule } from '@angular/material/chips';
import { MatSortModule, MatSort } from '@angular/material/sort';
import { MatMenuModule } from '@angular/material/menu';
import { MatDividerModule } from '@angular/material/divider';

// Modèles
import { Project } from '../../models/project.model';
import { JobTask } from '../../../tasks/models/job-task.model';

@Component({
  selector: 'app-project-detail',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    FormsModule,
    MatCardModule,
    MatInputModule,
    MatButtonModule,
    MatProgressSpinnerModule,
    MatIconModule,
    MatFormFieldModule,
    MatProgressBarModule,
    MatTooltipModule,
    MatTableModule,
    MatPaginatorModule,
    MatSnackBarModule,
    MatChipsModule,
    MatSortModule,
    MatMenuModule,
    MatDividerModule
  ],
  templateUrl: './project-detail.html',
  styleUrls: ['./project-detail.css']
})
export class ProjectDetailComponent implements OnInit, OnDestroy {
  project: Project | null = null;
  tasks: JobTask[] = [];
  filteredTasks: JobTask[] = [];
  isLoading = true;
  
  // Filtres actifs pour les tâches
  activeTaskFilters: string[] = [];
  
  // DataSource pour le tableau des tâches
  tasksDataSource: MatTableDataSource<JobTask> = new MatTableDataSource<JobTask>([]);
  taskDisplayedColumns: string[] = ['taskNo', 'description', 'dateDebut', 'dateFin', 'quantity', 'amount', 'progress', 'status', 'actions'];
  
  // Pour le slider (debounce)
  private sliderTimeouts: Map<string, any> = new Map();
  editingTaskId: string | null = null;
  tempProgressValue: number = 0;
  private originalProgress: number | null = null;

  @ViewChild('taskPaginator') taskPaginator!: MatPaginator;
  @ViewChild(MatSort) taskSort!: MatSort;
  sliderTempValue: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private projectService: ProjectService,
    private jobTaskService: JobTaskService,
    private snackBar: MatSnackBar,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    const projectId = this.route.snapshot.paramMap.get('id');
    console.log('🔍 ID du projet reçu:', projectId);
    
    if (projectId) {
      this.loadProjectDetails(projectId);
    } else {
      this.isLoading = false;
      this.snackBar.open('ID de projet manquant', 'Fermer', {
        duration: 3000,
        panelClass: ['error-snackbar']
      });
    }
  }

  ngOnDestroy(): void {
    // Nettoyer tous les timeouts pour éviter les fuites mémoire
    this.sliderTimeouts.forEach(timeout => clearTimeout(timeout));
    this.sliderTimeouts.clear();
  }

  // =============== CHARGEMENT DES DONNÉES ===============

  loadProjectDetails(projectId: string): void {
    this.isLoading = true;
    console.log('📡 Chargement du projet:', projectId);
    
    forkJoin({
      projects: this.projectService.getProjects().pipe(
        catchError(err => {
          console.error('❌ Erreur chargement projets:', err);
          return of([]);
        })
      ),
      tasks: this.jobTaskService.getTasksByProject(projectId).pipe(
        catchError(err => {
          console.warn('⚠️ Erreur chargement tâches:', err);
          return of([]);
        })
      )
    }).subscribe({
      next: ({ projects, tasks }) => {
        // Filtrer le projet par son numéro
        this.project = projects.find(p => p.no === projectId) || null;
        this.tasks = tasks;
        this.filteredTasks = [...tasks];
        
        console.log('📊 Projets reçus:', projects.length);
        console.log('🔍 Projet trouvé?', this.project ? 'OUI' : 'NON');
        
        if (this.project) {
          console.log('✅ Projet chargé:', this.project);
          
          // Configuration du DataSource pour les tâches
          this.tasksDataSource.data = tasks;
          
          setTimeout(() => {
            this.tasksDataSource.paginator = this.taskPaginator;
            this.tasksDataSource.sort = this.taskSort;
          });
          
          // Configuration du filtre
          this.tasksDataSource.filterPredicate = (task: JobTask, filter: string) => {
            const searchStr = filter.toLowerCase();
            return task.description.toLowerCase().includes(searchStr) ||
                   task.taskNo.toLowerCase().includes(searchStr);
          };
        } else {
          console.warn('⚠️ Projet non trouvé avec l\'ID:', projectId);
          this.snackBar.open('Projet non trouvé', 'Fermer', {
            duration: 3000
          });
        }
        
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('❌ Erreur générale:', err);
        this.isLoading = false;
        this.snackBar.open('Erreur lors du chargement des données', 'Fermer', {
          duration: 3000,
          panelClass: ['error-snackbar']
        });
        this.cdr.detectChanges();
      }
    });
  }

  // =============== MÉTHODES POUR LE STATUT DU PROJET ===============

  getProjectStatus(project: Project): string {
    if (!project) return 'Open';
    
    if (project.status === 'Suspendu') return 'Suspendu';
    
    const progress = project.progress ?? 0;
    
    if (progress === 100) return 'Terminé';
    if (progress > 0) return 'En cours';
    return 'Open';
  }

  getStatusClass(status: string): string {
    switch(status) {
      case 'En cours': return 'status-en-cours';
      case 'Terminé': return 'status-termine';
      case 'Suspendu': return 'status-suspendu';
      case 'Open': return 'status-open';
      default: return 'status-default';
    }
  }

  getStatusIcon(status: string): string {
    switch(status) {
      case 'En cours': return 'pending';
      case 'Terminé': return 'check_circle';
      case 'Suspendu': return 'pause_circle';
      case 'Open': return 'schedule';
      default: return 'help';
    }
  }

  // =============== MÉTHODES POUR LES STATISTIQUES ===============

  getCompletedTasksCount(): number {
    return this.tasks?.filter(t => t.progressPct === 100).length || 0;
  }

  getInProgressTasksCount(): number {
    return this.tasks?.filter(t => t.progressPct > 0 && t.progressPct < 100 && !t.isBlocked).length || 0;
  }

  getBlockedTasksCount(): number {
    return this.tasks?.filter(t => t.isBlocked === true).length || 0;
  }

  getCompletedPercentage(): number {
    if (!this.tasks || this.tasks.length === 0) return 0;
    return Math.round((this.getCompletedTasksCount() / this.tasks.length) * 100);
  }

  getInProgressPercentage(): number {
    if (!this.tasks || this.tasks.length === 0) return 0;
    return Math.round((this.getInProgressTasksCount() / this.tasks.length) * 100);
  }

  // =============== MÉTHODES POUR LES DATES ===============

  getProjectStartDate(): Date | null {
    if (!this.tasks || this.tasks.length === 0) return null;
    
    const dates = this.tasks
      .map(t => t.dateDebut ? new Date(t.dateDebut) : null)
      .filter(d => d !== null) as Date[];
    
    return dates.length > 0 ? new Date(Math.min(...dates.map(d => d.getTime()))) : null;
  }

  getProjectEndDate(): Date | null {
    if (!this.tasks || this.tasks.length === 0) return null;
    
    const dates = this.tasks
      .map(t => t.dateFin ? new Date(t.dateFin) : null)
      .filter(d => d !== null) as Date[];
    
    return dates.length > 0 ? new Date(Math.max(...dates.map(d => d.getTime()))) : null;
  }

  // =============== MÉTHODES POUR LES TÂCHES ===============

  getTaskStatusClass(task: JobTask): string {
    if (task.isBlocked) return 'status-blocked';
    if (task.progressPct === 100) return 'status-termine';
    if (this.isTaskOverdue(task)) return 'status-en-retard';
    if (task.progressPct > 0) return 'status-en-cours';
    return 'status-a-venir';
  }

  getTaskStatusText(task: JobTask): string {
    if (task.isBlocked) return 'Bloqué';
    if (task.progressPct === 100) return 'Terminé';
    if (this.isTaskOverdue(task)) return 'En retard';
    if (task.progressPct > 0) return 'En cours';
    return 'À venir';
  }

  getTaskStatusIcon(task: JobTask): string {
    if (task.isBlocked) return 'block';
    if (task.progressPct === 100) return 'check_circle';
    if (this.isTaskOverdue(task)) return 'warning';
    if (task.progressPct > 0) return 'pending';
    return 'schedule';
  }

  isTaskOverdue(task: JobTask): boolean {
    return !task.isBlocked && 
           task.progressPct < 100 && 
           !!task.dateFin && 
           new Date(task.dateFin) < new Date();
  }

  // =============== MÉTHODES POUR LE SLIDER (CORRIGÉES) ===============

  onSliderChange(task: JobTask, event: Event): void {
    event.stopPropagation();
    const input = event.target as HTMLInputElement;
    const newValue = parseInt(input.value, 10);
    
    // Sauvegarder la valeur d'origine AVANT de modifier
    const originalValue = task.progressPct;
    
    console.log('🎚️ Slider change - de', originalValue, 'à', newValue);
    
    // Mise à jour visuelle immédiate
    task.progressPct = newValue;
    
    // Forcer la détection de changements pour l'affichage
    this.cdr.detectChanges();
    
    // Annuler le timeout précédent pour cette tâche
    if (this.sliderTimeouts.has(task.taskNo)) {
      clearTimeout(this.sliderTimeouts.get(task.taskNo));
    }
    
    // Créer un nouveau timeout pour sauvegarder après 300ms
    const timeout = setTimeout(() => {
      console.log('💾 Sauvegarde après délai pour', task.taskNo, ':', newValue);
      // Passer la valeur d'origine pour comparaison
      this.updateTaskProgressWithOriginal(task, newValue, originalValue);
      this.sliderTimeouts.delete(task.taskNo);
    }, 300);
    
    this.sliderTimeouts.set(task.taskNo, timeout);
  }

  quickUpdateProgress(task: JobTask, newProgress: number, event: MouseEvent): void {
    event.stopPropagation();
    
    if (newProgress === task.progressPct) {
      console.log('ℹ️ Même valeur, pas de mise à jour');
      return;
    }
    
    if (newProgress === 100 && task.progressPct !== 100) {
      if (!confirm(`Marquer la tâche "${task.taskNo}" comme terminée (100%) ?`)) {
        return;
      }
    }
    
    console.log('⚡ Mise à jour rapide:', newProgress);
    this.updateProgress(task, newProgress);
  }

  // Nouvelle méthode qui garde la trace de la valeur d'origine
  updateTaskProgressWithOriginal(task: JobTask, newProgress: number, originalValue: number): void {
    if (newProgress === originalValue) {
      console.log('ℹ️ Même valeur, pas de mise à jour');
      return;
    }
    
    console.log('📡 Mise à jour de', originalValue, 'à', newProgress);

    this.jobTaskService.updateTaskProgress(task.jobNo, task.taskNo, newProgress).subscribe({
      next: (response) => {
        console.log('✅ Mise à jour réussie:', response);
        
        let message = '';
        if (newProgress === 100) {
          message = '✅ Tâche terminée !';
        } else if (newProgress > originalValue) {
          message = `📈 Avancement: ${newProgress}%`;
        } else {
          message = `📉 Avancement: ${newProgress}%`;
        }
        
        this.snackBar.open(message, 'Fermer', { duration: 2000 });
        
        // Nettoyer le mode édition si nécessaire
        if (this.editingTaskId === task.taskNo) {
          this.editingTaskId = null;
          this.tempProgressValue = 0;
          this.originalProgress = null;
        }
        
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        
        // Rollback
        task.progressPct = originalValue;
        this.cdr.detectChanges();
        
        this.snackBar.open('❌ Erreur de mise à jour', 'Fermer', { 
          duration: 2000,
          panelClass: ['error-snackbar']
        });
        
        if (this.editingTaskId === task.taskNo) {
          this.editingTaskId = null;
          this.tempProgressValue = 0;
          this.originalProgress = null;
        }
      }
    });
  }

  // Dans task-list.component.ts

updateProgress(task: JobTask, newProgress: number): void {
  const originalProgress = task.progressPct;
  
  if (newProgress === originalProgress) {
    console.log('ℹ️ Même valeur, pas de mise à jour');
    return;
  }
  
  console.log('📡 Mise à jour de', originalProgress, 'à', newProgress);
  
  // Mise à jour optimiste
  task.progressPct = newProgress;

  this.jobTaskService.updateTaskProgress(task.jobNo, task.taskNo, newProgress).subscribe({
    next: (response) => {
      console.log('✅ Mise à jour réussie:', response);
      
      let message = '';
      if (newProgress === 100) {
        message = '✅ Tâche terminée !';
      } else if (newProgress > originalProgress) {
        message = `📈 Avancement: ${newProgress}%`;
      } else {
        message = `📉 Avancement: ${newProgress}%`;
      }
      
      this.snackBar.open(message, 'Fermer', { duration: 2000 });
      
      // ✅ FORCER LA DÉTECTION DE CHANGEMENTS
      this.cdr.detectChanges();
      
      // Nettoyer la valeur temporaire
      this.sliderTempValue.delete(task.taskNo);
    },
    error: (err) => {
      console.error('❌ Erreur:', err);
      
      // Rollback
      task.progressPct = originalProgress;
      
      // ✅ FORCER LA DÉTECTION DE CHANGEMENTS même en erreur
      this.cdr.detectChanges();
      
      this.snackBar.open('❌ Erreur de mise à jour', 'Fermer', { 
        duration: 2000,
        panelClass: ['error-snackbar']
      });
    }
  });
}

  // =============== FILTRES DES TÂCHES ===============

  applyTaskFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.tasksDataSource.filter = filterValue.trim().toLowerCase();
    
    if (this.tasksDataSource.paginator) {
      this.tasksDataSource.paginator.firstPage();
    }
  }

  onTaskFilterChange(event: any): void {
    this.activeTaskFilters = event.value;
    this.applyTaskFilters();
  }

  applyTaskFilters(): void {
    if (this.activeTaskFilters.length === 0 || this.activeTaskFilters.includes('all')) {
      this.tasksDataSource.data = this.tasks;
    } else {
      this.tasksDataSource.data = this.tasks.filter(task => {
        return this.activeTaskFilters.some(filter => {
          if (filter === 'inprogress') return task.progressPct > 0 && task.progressPct < 100 && !task.isBlocked;
          if (filter === 'completed') return task.progressPct === 100;
          if (filter === 'blocked') return task.isBlocked;
          if (filter === 'overdue') return this.isTaskOverdue(task);
          return false;
        });
      });
    }
    
    if (this.tasksDataSource.paginator) {
      this.tasksDataSource.paginator.firstPage();
    }
  }

  resetTaskFilters(): void {
    this.activeTaskFilters = [];
    this.tasksDataSource.data = this.tasks;
    if (this.tasksDataSource.paginator) {
      this.tasksDataSource.paginator.firstPage();
    }
  }

  filterTasks(type: string): void {
    if (type === 'all') {
      this.tasksDataSource.data = this.tasks;
    } else if (type === 'completed') {
      this.tasksDataSource.data = this.tasks.filter(t => t.progressPct === 100);
    } else if (type === 'inprogress') {
      this.tasksDataSource.data = this.tasks.filter(t => t.progressPct > 0 && t.progressPct < 100);
    } else if (type === 'blocked') {
      this.tasksDataSource.data = this.tasks.filter(t => t.isBlocked);
    }
    
    if (this.tasksDataSource.paginator) {
      this.tasksDataSource.paginator.firstPage();
    }
  }

  // =============== COULEURS ===============

  getProgressColor(progress: number): string {
    if (progress >= 75) return 'primary';
    if (progress >= 30) return 'accent';
    return 'warn';
  }

  getSliderBackground(task: JobTask): string {
    return `linear-gradient(90deg, #3b82f6 0%, #3b82f6 ${task.progressPct}%, #e2e8f0 ${task.progressPct}%, #e2e8f0 100%)`;
  }

  // =============== ACTIONS SUR LES TÂCHES ===============

  viewTask(task: JobTask): void {
    this.router.navigate(['/tasks', task.taskNo]);
  }

  editTask(task: JobTask): void {
    this.router.navigate(['/tasks', task.taskNo, 'edit']);
  }

  // =============== ACTIONS SUR LE PROJET ===============

  editProject(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.no, 'edit']);
    }
  }

  addTask(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.no, 'tasks', 'new']);
    }
  }

  deleteProject(): void {
    if (this.project && confirm('Êtes-vous sûr de vouloir supprimer ce projet ?')) {
      this.projectService.deleteProject(this.project.no).subscribe({
        next: (success) => {
          if (success) {
            this.snackBar.open('✅ Projet supprimé avec succès', 'Fermer', {
              duration: 2000
            });
            this.router.navigate(['/projects']);
          } else {
            this.snackBar.open('❌ Erreur lors de la suppression', 'Fermer', {
              duration: 3000,
              panelClass: ['error-snackbar']
            });
          }
        },
        error: (err) => {
          console.error('❌ Erreur suppression:', err);
          this.snackBar.open('Erreur lors de la suppression', 'Fermer', {
            duration: 3000,
            panelClass: ['error-snackbar']
          });
        }
      });
    }
  }

  viewAllTasks(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.no, 'tasks']);
    }
  }

  exportTasks(): void {
    if (!this.tasks || this.tasks.length === 0) {
      this.snackBar.open('Aucune tâche à exporter', 'Fermer', {
        duration: 2000
      });
      return;
    }
    
    const headers = ['N° Tâche', 'Description', 'Début', 'Fin', 'Quantité', 'Unité', 'Montant', 'Avancement', 'Statut', 'Bloqué'];
    const rows = this.tasks.map(t => [
      t.taskNo,
      t.description,
      t.dateDebut ? new Date(t.dateDebut).toLocaleDateString('fr-FR') : '',
      t.dateFin ? new Date(t.dateFin).toLocaleDateString('fr-FR') : '',
      t.initialQuantity?.toString() || '0',
      t.initialUoM || '',
      t.initialAmount?.toString() || '0',
      `${t.progressPct}%`,
      this.getTaskStatusText(t),
      t.isBlocked ? 'Oui' : 'Non'
    ]);
    
    const csvContent = [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    
    link.setAttribute('href', url);
    link.setAttribute('download', `taches_${this.project?.no}_${new Date().toISOString().slice(0,10)}.csv`);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    this.snackBar.open('📥 Export CSV réalisé avec succès', 'Fermer', {
      duration: 2000
    });
  }

  // =============== NAVIGATION ===============

  goBack(): void {
    this.router.navigate(['/projects']);
  }

  refresh(): void {
    if (this.project) {
      this.loadProjectDetails(this.project.no);
      this.snackBar.open('🔄 Données actualisées', 'Fermer', {
        duration: 2000
      });
    }
  }

  // =============== GESTION DE L'ÉDITION PERSONNALISÉE ===============

  /**
   * Démarre l'édition avec la valeur actuelle
   */
  startProgressEdit(task: JobTask, event: MouseEvent): void {
    event.stopPropagation();
    console.log('🔧 Démarrage édition pour:', task.taskNo);
    this.editingTaskId = task.taskNo;
    this.tempProgressValue = task.progressPct;
    this.originalProgress = task.progressPct;
  }

  /**
   * Sauvegarde avec la valeur de tempProgressValue
   */
  saveProgressWithValue(task: JobTask, value: number, event: Event): void {
    event.stopPropagation();
    event.preventDefault();
    
    console.log('✅ Bouton cliqué - Valeur reçue:', value);
    
    const newProgress = Number(value);
    
    if (isNaN(newProgress)) {
      this.snackBar.open('❌ Veuillez entrer un nombre valide', 'Fermer', { duration: 2000 });
      return;
    }
    
    if (newProgress < 0 || newProgress > 100) {
      this.snackBar.open('❌ Le pourcentage doit être entre 0 et 100', 'Fermer', { duration: 2000 });
      return;
    }
    
    console.log('📊 Nouvelle progression:', newProgress);
    
    this.updateProgress(task, newProgress);
    this.editingTaskId = null;
    this.tempProgressValue = 0;
    this.originalProgress = null;
  }

  /**
   * Annule l'édition
   */
  cancelProgressEdit(event: Event): void {
    event.stopPropagation();
    console.log('❌ Annulation édition');
    
    if (this.editingTaskId && this.originalProgress !== null) {
      const task = this.tasks.find(t => t.taskNo === this.editingTaskId);
      if (task) {
        task.progressPct = this.originalProgress;
        this.cdr.detectChanges();
      }
    }
    this.editingTaskId = null;
    this.tempProgressValue = 0;
    this.originalProgress = null;
  }
}