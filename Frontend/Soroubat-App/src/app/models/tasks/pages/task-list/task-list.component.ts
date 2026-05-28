// src/app/modules/tasks/pages/task-list/task-list.component.ts

import { Component, OnInit, ViewChild, OnDestroy, ChangeDetectorRef, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Subject, interval, takeUntil } from 'rxjs';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatSortModule, MatSort } from '@angular/material/sort';
import { MatPaginatorModule, MatPaginator } from '@angular/material/paginator';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatChipsModule } from '@angular/material/chips';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatMenuModule } from '@angular/material/menu';
import { MatSnackBarModule, MatSnackBar } from '@angular/material/snack-bar';
import { MatDividerModule } from '@angular/material/divider';
import { ToastrService } from 'ngx-toastr';

import { JobTaskService } from '../../services/job-task';
import { JobTask } from '../../models/job-task.model';
import { AlertsCounterService } from '../../../../core/services/alerts-counter.service';
import { SoundService } from '../../../../core/services/sound.service';
import { AppModeService } from '../../../../core/services/app-mode.service';
import { OfflineHideActionsDirective } from '../../../../core/directives/offline-hide-actions.directive';
import { ShowOfflineMessageDirective } from '../../../../core/directives/show-offline-message.directive';

@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [
    CommonModule,
    MatDividerModule,
    FormsModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatChipsModule,
    MatProgressBarModule,
    MatFormFieldModule,
    MatInputModule,
    MatTooltipModule,
    MatMenuModule,
    MatSnackBarModule,
    OfflineHideActionsDirective,
    ShowOfflineMessageDirective
  ],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css']
})
export class TaskListComponent implements OnInit, OnDestroy {
  // Colonnes affichées - sans dateFin
  displayedColumns: string[] = [
    'jobNo',        // Projet
    'taskNo',       // Tâche
    'description',  // Description
    'status',       // Statut
    'progress',     // Avancement
    'actions'       // Actions
  ];
  
  dataSource: MatTableDataSource<JobTask> = new MatTableDataSource<JobTask>([]);
  tasks: JobTask[] = [];

  // Recherche et filtres
  searchTerm: string = '';
  selectedStatusFilter: string = 'all';
  
  // Compteur d'alertes
  alertCount: number = 0;

  editingTaskId: string | null = null;
  tempProgressValue: number = 0;
  private originalProgress: number | null = null;
  
  sliderTempValue: Map<string, number> = new Map();

  // Mode offline
  isReadOnly: boolean = false;

  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild('tasksTable') tasksTable!: ElementRef;

  private sliderTimeouts: Map<string, any> = new Map();
  private destroy$ = new Subject<void>();

  constructor(
    private jobTaskService: JobTaskService,
    private snackBar: MatSnackBar,
    private alertsCounterService: AlertsCounterService,
    private toastr: ToastrService,
    private router: Router,
    private soundService: SoundService,
    private cdr: ChangeDetectorRef,
    private appMode: AppModeService
  ) {}

  ngOnInit(): void {
    this.appMode.mode$
      .pipe(takeUntil(this.destroy$))
      .subscribe(mode => {
        this.isReadOnly = mode === 'offline-readonly';
        console.log(' Mode tâches:', this.isReadOnly ? 'offline-readonly' : 'online');
        this.cdr.detectChanges();
      });
    

    this.loadTasks();
    this.startAutoRefresh();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
    this.sliderTimeouts.forEach((timeout) => {
      clearTimeout(timeout);
    });
    this.sliderTimeouts.clear();
  }

  // ==================== LOCALSTORAGE HELPERS ====================
  
  private saveProgressToLocalStorage(taskId: string, progress: number): void {
    localStorage.setItem(`task_progress_${taskId}`, progress.toString());
  }

  private getProgressFromLocalStorage(taskId: string): number | null {
    const stored = localStorage.getItem(`task_progress_${taskId}`);
    return stored !== null ? parseInt(stored, 10) : null;
  }

  private removeProgressFromLocalStorage(taskId: string): void {
    localStorage.removeItem(`task_progress_${taskId}`);
  }

  private clearAllProgressFromLocalStorage(): void {
    const keys = Object.keys(localStorage);
    keys.forEach(key => {
      if (key.startsWith('task_progress_')) {
        localStorage.removeItem(key);
      }
    });
  }

  // ==================== ALERTES ====================
  
  private startAutoRefresh(): void {
    interval(120000).pipe(takeUntil(this.destroy$)).subscribe(() => {
      if (!this.dataSource.data.length) {
        this.alertsCounterService.refresh();
      }
    });
  }
  
  
  navigateToAlerts(): void {
    if (this.alertCount > 0) {
      this.soundService.playDefaultSound();
      this.toastr.info(
        `Vous avez ${this.alertCount} alerte(s) dans la gestion de chantier`,
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
        filterDomain: 'siteManagement',
        source: 'tasks-page'
      }
    });
  }

  // ==================== CHARGEMENT ====================
  
  loadTasks(): void {
    this.jobTaskService.getAllTasks().subscribe({
      next: (data) => {
        data.forEach(task => {
          const savedProgress = this.getProgressFromLocalStorage(task.id);
          if (savedProgress !== null) {
            task.progressPct = savedProgress;
          }
        });
        
        this.tasks = data;
        this.applyFilter();
        console.log(' Tâches chargées:', this.tasks.length);
        
        if (this.isReadOnly) {
          this.toastr.info('Mode hors ligne - Affichage des données en cache', 'Information', {
            positionClass: 'toast-top-right',
            timeOut: 3000
          });
        }
      },
      error: (err) => {
        console.error(' Erreur:', err);
        this.snackBar.open('Erreur lors du chargement des tâches', 'Fermer', {
          duration: 3000,
          panelClass: ['error-snackbar']
        });
      }
    });
  }

  refresh(): void {
    this.clearAllProgressFromLocalStorage();
    this.loadTasks();
    this.alertsCounterService.refresh();
    this.toastr.info('Rafraîchissement des données...', 'Actualisation', {
      positionClass: 'toast-top-right',
      timeOut: 1500
    });
  }

  // ==================== RECHERCHE ET FILTRES ====================

  applyFilter(): void {
    let filteredTasks = [...this.tasks];
    
    // Filtre par recherche textuelle
    if (this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase().trim();
      filteredTasks = filteredTasks.filter(task => 
        task.jobNo.toLowerCase().includes(term) ||
        task.taskNo.toLowerCase().includes(term) ||
        (task.description && task.description.toLowerCase().includes(term)) ||
        this.getStatusText(task).toLowerCase().includes(term)
      );
    }
    
    // Filtre par statut (supprimer 'retard')
    if (this.selectedStatusFilter !== 'all') {
      filteredTasks = filteredTasks.filter(task => {
        switch (this.selectedStatusFilter) {
          case 'en-cours':
            return task.progressPct > 0 && task.progressPct < 100;
          case 'termine':
            return task.progressPct === 100;
          default:
            return true;
        }
      });
    }
    
    this.dataSource.data = filteredTasks;
    
    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  clearSearch(): void {
    this.searchTerm = '';
    this.selectedStatusFilter = 'all';
    this.applyFilter();
  }

  filterByStatus(status: string): void {
    this.selectedStatusFilter = status;
    this.applyFilter();
  }

  scrollToTableAndFilterByStatus(status: string): void {
    this.filterByStatus(status);
    this.cdr.detectChanges();
    
    setTimeout(() => {
      if (this.tasksTable && this.tasksTable.nativeElement) {
        this.tasksTable.nativeElement.scrollIntoView({ 
          behavior: 'smooth', 
          block: 'start',
          inline: 'nearest'
        });
        
        this.tasksTable.nativeElement.classList.add('table-highlight');
        
        setTimeout(() => {
          this.tasksTable.nativeElement.classList.remove('table-highlight');
        }, 1000);
        
        const statusText = this.getStatusFilterText(status);
        this.toastr.success(` Affichage des tâches ${statusText}`, 'Filtre appliqué', {
          positionClass: 'toast-top-right',
          timeOut: 2000,
          progressBar: true
        });
      }
    }, 100);
  }

  private getStatusFilterText(status: string): string {
    const statusMap: { [key: string]: string } = {
      'all': 'totales',
      'termine': 'terminées',
      'en-cours': 'en cours'
    };
    return statusMap[status] || status;
  }

  // ==================== STATISTIQUES (sans En retard) ====================

  getCompletedTasksCount(): number {
    return this.tasks.filter(t => t.progressPct === 100).length;
  }

  getInProgressTasksCount(): number {
    return this.tasks.filter(t => t.progressPct > 0 && t.progressPct < 100).length;
  }

  getCompletedPercentage(): number {
    if (this.tasks.length === 0) return 0;
    return (this.getCompletedTasksCount() / this.tasks.length) * 100;
  }

  getInProgressPercentage(): number {
    if (this.tasks.length === 0) return 0;
    return (this.getInProgressTasksCount() / this.tasks.length) * 100;
  }

  // ==================== STATUTS (sans En retard) ====================

  getStatusClass(task: JobTask): string {
    if (task.progressPct === 100) return 'status-termine';
    if (task.progressPct > 0) return 'status-en-cours';
    return 'status-a-venir';
  }

  getStatusText(task: JobTask): string {
    if (task.progressPct === 100) return 'Terminé';
    if (task.progressPct > 0) return 'En cours';
    return 'À venir';
  }

  getDetailedStatusTooltip(task: JobTask): string {
    let tooltip = `Statut: ${this.getStatusText(task)}\n`;
    
    if (task.progressPct === 100) {
      tooltip += ` Tâche terminée avec succès\n`;
    } else if (task.progressPct > 0) {
      tooltip += ` Tâche en cours d'exécution\n`;
    } else {
      tooltip += ` Tâche non démarrée\n`;
    }
    
    tooltip += `\n Avancement: ${task.progressPct}%`;
    
    return tooltip;
  }

  // ==================== SLIDER ====================

  getSliderValue(task: JobTask): number {
    return this.sliderTempValue.get(task.id) ?? task.progressPct;
  }

  getSliderBackground(task: JobTask): string {
    const value = this.getSliderValue(task);
    return `linear-gradient(90deg, #3b82f6 0%, #3b82f6 ${value}%, #e2e8f0 ${value}%, #e2e8f0 100%)`;
  }

  onSliderChange(task: JobTask, event: Event): void {
    event.stopPropagation();
    
    const input = event.target as HTMLInputElement;
    const newValue = parseInt(input.value, 10);
    
    this.saveProgressToLocalStorage(task.id, newValue);
    this.sliderTempValue.set(task.id, newValue);
    task.progressPct = newValue;
    this.cdr.detectChanges();
    
    if (this.sliderTimeouts.has(task.id)) {
      clearTimeout(this.sliderTimeouts.get(task.id));
    }
    
    const timeout = setTimeout(() => {
      this.jobTaskService.updateTaskProgress(task.id, newValue).subscribe({
        next: () => {
          this.snackBar.open(` Avancement: ${newValue}%`, 'Fermer', { duration: 2000 });
          this.sliderTempValue.delete(task.id);
        },
        error: (err) => {
          console.error(' Erreur API:', err);
          this.snackBar.open(' Avancement sauvegardé localement uniquement', 'Fermer', { duration: 2000 });
          this.sliderTempValue.delete(task.id);
        }
      });
      this.sliderTimeouts.delete(task.id);
    }, 300);
    
    this.sliderTimeouts.set(task.id, timeout);
  }

  // ==================== MISE À JOUR AVANCEMENT ====================

  startProgressEdit(task: JobTask, event: MouseEvent): void {
    event.stopPropagation();
    this.editingTaskId = task.id;
    this.tempProgressValue = task.progressPct;
    this.originalProgress = task.progressPct;
  }

  saveProgressWithValue(task: JobTask, value: number, event: Event): void {
    event.stopPropagation();
    event.preventDefault();
    
    const newProgress = Number(value);
    
    if (isNaN(newProgress) || newProgress < 0 || newProgress > 100) {
      this.snackBar.open(' Valeur invalide (0-100)', 'Fermer', { duration: 2000 });
      return;
    }
    
    this.updateProgress(task, newProgress);
    this.editingTaskId = null;
    this.tempProgressValue = 0;
  }

  quickUpdateProgress(task: JobTask, newProgress: number, event?: MouseEvent): void {
    if (event) event.stopPropagation();
    if (newProgress === task.progressPct) return;
    this.updateProgress(task, newProgress);
  }

  updateProgress(task: JobTask, newProgress: number): void {
    const originalProgress = task.progressPct;
    
    this.saveProgressToLocalStorage(task.id, newProgress);
    task.progressPct = newProgress;
    this.cdr.detectChanges();
    
    this.jobTaskService.updateTaskProgress(task.id, newProgress).subscribe({
      next: () => {
        const message = newProgress === 100 ? ' Tâche terminée !' : ` Avancement: ${newProgress}%`;
        this.snackBar.open(message, 'Fermer', { duration: 2000 });
        this.sliderTempValue.delete(task.id);
        console.log(` Progression mise à jour: ${originalProgress}% → ${newProgress}%`);
      },
      error: (err) => {
        console.error(' Erreur API:', err);
        this.snackBar.open(' Avancement sauvegardé localement uniquement', 'Fermer', { duration: 3000 });
        this.cdr.detectChanges();
      }
    });
  }

  cancelProgressEdit(event: Event): void {
    event.stopPropagation();
    if (this.editingTaskId && this.originalProgress !== null) {
      const task = this.tasks.find(t => t.id === this.editingTaskId);
      if (task) {
        task.progressPct = this.originalProgress;
        this.saveProgressToLocalStorage(task.id, this.originalProgress);
      }
    }
    this.editingTaskId = null;
    this.tempProgressValue = 0;
    this.originalProgress = null;
    this.cdr.detectChanges();
  }

  // ==================== ACTIONS ====================

  viewTask(task: JobTask): void {
    console.log(' Visualisation tâche:', task.taskNo);
  }

  editTask(task: JobTask): void {
    console.log(' Édition tâche:', task.taskNo);
  }

  deleteTask(task: JobTask): void {
    if (confirm(`Supprimer la tâche ${task.taskNo} ?`)) {
      this.jobTaskService.deleteTask(task.id, task.taskNo).subscribe({
        next: (success) => {
          if (success) {
            this.tasks = this.tasks.filter(t => t.id !== task.id);
            this.applyFilter();
            this.removeProgressFromLocalStorage(task.id);
            this.snackBar.open(' Tâche supprimée', 'Fermer', { duration: 2000 });
          }
        },
        error: (err) => {
          console.error(' Erreur suppression:', err);
          this.snackBar.open(' Erreur lors de la suppression', 'Fermer', { duration: 3000 });
        }
      });
    }
  }
}

export { TaskListComponent as de};