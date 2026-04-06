// src/app/modules/tasks/pages/task-list/task-list.component.ts

import { Component, OnInit, ViewChild, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
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

import { JobTaskService } from '../../services/job-task';
import { JobTask } from '../../models/job-task.model';

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
    MatSnackBarModule
  ],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css']
})
export class TaskListComponent implements OnInit, OnDestroy {
  displayedColumns: string[] = [
    'jobNo', 
    'taskNo', 
    'description', 
    'dateDebut', 
    'dateFin', 
    'quantity',
    'amount',
    'status', 
    'progress', 
    'actions'
  ];
  
  dataSource: MatTableDataSource<JobTask> = new MatTableDataSource<JobTask>([]);
  tasks: JobTask[] = [];

  editingTaskId: string | null = null;
  tempProgressValue: number = 0;
  private originalProgress: number | null = null;
  
  sliderTempValue: Map<string, number> = new Map();

  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  
  private sliderTimeouts: Map<string, any> = new Map();

  constructor(
    private jobTaskService: JobTaskService,
    private snackBar: MatSnackBar,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.loadTasks();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  ngOnDestroy(): void {
    this.sliderTimeouts.forEach((timeout) => {
      clearTimeout(timeout);
    });
    this.sliderTimeouts.clear();
  }

  // ==================== CHARGEMENT ====================
  
  loadTasks(): void {
    this.jobTaskService.getAllTasks().subscribe({
      next: (data) => {
        this.tasks = data;
        this.dataSource.data = data;
        this.dataSource.sort = this.sort;
        this.dataSource.paginator = this.paginator;
        console.log('✅ Tâches chargées:', this.tasks.length);
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        this.snackBar.open('Erreur lors du chargement des tâches', 'Fermer', {
          duration: 3000,
          panelClass: ['error-snackbar']
        });
      }
    });
  }

  // ==================== FILTRES ====================

  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  clearSearch(input: HTMLInputElement): void {
    input.value = '';
    this.dataSource.filter = '';
  }

  filterByStatus(status: string): void {
    if (status === 'all') {
      this.dataSource.filter = '';
    } else {
      this.dataSource.filter = status;
    }
  }

  // ==================== STATISTIQUES ====================

  getCompletedTasksCount(): number {
    return this.tasks.filter(t => t.progressPct === 100).length;
  }

  getInProgressTasksCount(): number {
    return this.tasks.filter(t => t.progressPct > 0 && t.progressPct < 100).length;
  }

  getBlockedTasksCount(): number {
    return this.tasks.filter(t => t.isBlocked === true).length;
  }

  getCompletedPercentage(): number {
    if (this.tasks.length === 0) return 0;
    return (this.getCompletedTasksCount() / this.tasks.length) * 100;
  }

  getInProgressPercentage(): number {
    if (this.tasks.length === 0) return 0;
    return (this.getInProgressTasksCount() / this.tasks.length) * 100;
  }

  getBlockedPercentage(): number {
    if (this.tasks.length === 0) return 0;
    return (this.getBlockedTasksCount() / this.tasks.length) * 100;
  }

  // ==================== STATUTS ====================

  isOverdue(task: JobTask): boolean {
    if (!task.dateFin) return false;
    const isBlocked = task.isBlocked === true;
    const progress = task.progressPct || 0;
    return !isBlocked && progress < 100 && new Date(task.dateFin) < new Date();
  }

  getStatusClass(task: JobTask): string {
    if (task.isBlocked) return 'status-blocked';
    if (task.progressPct === 100) return 'status-termine';
    if (this.isOverdue(task)) return 'status-en-retard';
    if (task.progressPct > 0) return 'status-en-cours';
    return 'status-a-venir';
  }

  getStatusText(task: JobTask): string {
    if (task.isBlocked) return 'Bloqué';
    if (task.progressPct === 100) return 'Terminé';
    if (this.isOverdue(task)) return 'En retard';
    if (task.progressPct > 0) return 'En cours';
    return 'À venir';
  }

  getDetailedStatusTooltip(task: JobTask): string {
    let tooltip = `Statut: ${this.getStatusText(task)}\n`;
    
    if (task.isBlocked) {
      tooltip += `⛔ Cette tâche est bloquée\n`;
    } else if (task.progressPct === 100) {
      tooltip += `✅ Tâche terminée avec succès\n`;
    } else if (this.isOverdue(task)) {
      tooltip += `⚠️ Tâche en retard\n`;
      if (task.dateFin) {
        const dueDate = new Date(task.dateFin).toLocaleDateString('fr-FR');
        tooltip += `📅 Date d'échéance: ${dueDate}\n`;
      }
    }

    if (task.initialQuantity > 0) {
      tooltip += `\n📦 Quantité initiale: ${task.initialQuantity} ${task.initialUoM}\n`;
      tooltip += `🚚 Quantité livrée: ${task.quantityShipped} ${task.initialUoM}\n`;
      const consumptionPct = ((task.quantityShipped / task.initialQuantity) * 100).toFixed(1);
      tooltip += `📊 Taux de consommation: ${consumptionPct}%\n`;
    }
    
    tooltip += `\n📈 Avancement saisi: ${task.progressPct}%\n`;
    tooltip += `📐 Avancement théorique: ${task.taskProgressPct?.toFixed(1) || 0}%`;
    
    return tooltip;
  }

  // ==================== QUANTITÉ ====================

  getQuantityShippedTooltip(task: JobTask): string {
    const percentage = task.initialQuantity > 0 
      ? ((task.quantityShipped / task.initialQuantity) * 100).toFixed(1)
      : '0';
    
    let tooltip = `📦 Quantité livrée: ${task.quantityShipped} ${task.initialUoM}\n`;
    tooltip += `📊 Taux de consommation: ${percentage}%\n`;
    
    if (task.quantityShipped > task.initialQuantity) {
      const exceed = task.quantityShipped - task.initialQuantity;
      tooltip += `⚠️ Dépassement: +${exceed} ${task.initialUoM}`;
    } else if (task.quantityShipped === task.initialQuantity) {
      tooltip += `✅ Quantité initiale atteinte`;
    } else {
      const remaining = task.initialQuantity - task.quantityShipped;
      tooltip += `⏳ Restant à livrer: ${remaining} ${task.initialUoM}`;
    }
    
    return tooltip;
  }

  getConsumptionPercentage(task: JobTask): number {
    if (task.initialQuantity <= 0) return 0;
    return (task.quantityShipped / task.initialQuantity) * 100;
  }

  getConsumptionBarColor(task: JobTask): string {
    const pct = this.getConsumptionPercentage(task);
    if (pct > 100) return 'linear-gradient(90deg, #ef4444, #f87171)';
    if (pct >= 80) return 'linear-gradient(90deg, #fbbf24, #f59e0b)';
    return 'linear-gradient(90deg, #3b82f6, #8b5cf6)';
  }

  // ==================== AVANCEMENT THÉORIQUE ====================

  getComparisonText(task: JobTask): string {
    const theo = task.taskProgressPct || 0;
    const diff = Math.abs(task.progressPct - theo).toFixed(1);
    if (task.progressPct > theo) return `Avance (+${diff}%)`;
    return `Retard (-${diff}%)`;
  }

  getComparisonTooltip(task: JobTask): string {
    const theo = task.taskProgressPct || 0;
    const diff = Math.abs(task.progressPct - theo).toFixed(1);
    if (task.progressPct > theo) {
      return `📈 Avance de ${diff}% par rapport à la quantité livrée\nSaisi: ${task.progressPct}% | Théorique: ${theo.toFixed(1)}%`;
    } else if (task.progressPct < theo) {
      return `📉 Retard de ${diff}% par rapport à la quantité livrée\nSaisi: ${task.progressPct}% | Théorique: ${theo.toFixed(1)}%`;
    }
    return `✅ Avancement synchronisé avec la quantité livrée`;
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
    
    this.sliderTempValue.set(task.id, newValue);
    task.progressPct = newValue;
    this.cdr.detectChanges();
    
    if (this.sliderTimeouts.has(task.id)) {
      clearTimeout(this.sliderTimeouts.get(task.id));
    }
    
    const timeout = setTimeout(() => {
      this.jobTaskService.updateTaskProgress(task.id, newValue).subscribe({
        next: () => {
          this.snackBar.open(`✅ Avancement: ${newValue}%`, 'Fermer', { duration: 2000 });
          this.sliderTempValue.delete(task.id);
        },
        error: (err) => {
          console.error('❌ Erreur:', err);
          this.snackBar.open('❌ Erreur de sauvegarde', 'Fermer', { duration: 2000 });
          this.sliderTempValue.delete(task.id);
          this.cdr.detectChanges();
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
      this.snackBar.open('❌ Valeur invalide (0-100)', 'Fermer', { duration: 2000 });
      return;
    }
    
    this.updateProgress(task, newProgress);
    this.editingTaskId = null;
    this.tempProgressValue = 0;
  }

  quickUpdateProgress(task: JobTask, newProgress: number, event?: MouseEvent): void {
    if (event) event.stopPropagation();
    if (newProgress === task.progressPct) return;
    
    if (newProgress === 100 && task.progressPct !== 100) {
      if (!confirm(`Marquer "${task.taskNo}" comme terminée ?`)) return;
    }
    
    this.updateProgress(task, newProgress);
  }

  updateProgress(task: JobTask, newProgress: number): void {
    const originalProgress = task.progressPct;
    task.progressPct = newProgress;
    this.cdr.detectChanges();
    
    this.jobTaskService.updateTaskProgress(task.id, newProgress).subscribe({
      next: () => {
        const message = newProgress === 100 ? '✅ Tâche terminée !' : `📈 Avancement: ${newProgress}%`;
        this.snackBar.open(message, 'Fermer', { duration: 2000 });
        this.sliderTempValue.delete(task.id);
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        task.progressPct = originalProgress;
        this.snackBar.open('❌ Erreur de mise à jour', 'Fermer', { duration: 2000 });
        this.cdr.detectChanges();
      }
    });
  }

  cancelProgressEdit(event: Event): void {
    event.stopPropagation();
    if (this.editingTaskId && this.originalProgress !== null) {
      const task = this.tasks.find(t => t.id === this.editingTaskId);
      if (task) task.progressPct = this.originalProgress;
    }
    this.editingTaskId = null;
    this.tempProgressValue = 0;
    this.originalProgress = null;
    this.cdr.detectChanges();
  }

  // ==================== ACTIONS ====================

  viewTask(task: JobTask): void {
    console.log('Visualisation tâche:', task);
  }

  editTask(task: JobTask): void {
    console.log('Édition tâche:', task);
    this.snackBar.open(`Édition de ${task.taskNo}`, 'Fermer', { duration: 2000 });
  }

  deleteTask(task: JobTask): void {
    if (confirm(`Supprimer la tâche ${task.taskNo} ?`)) {
      this.jobTaskService.deleteTask(task.jobNo, task.taskNo).subscribe({
        next: (success) => {
          if (success) {
            this.tasks = this.tasks.filter(t => t.id !== task.id);
            this.dataSource.data = this.tasks;
            this.snackBar.open('✅ Tâche supprimée', 'Fermer', { duration: 2000 });
          }
        },
        error: (err) => {
          console.error('❌ Erreur suppression:', err);
          this.snackBar.open('❌ Erreur lors de la suppression', 'Fermer', { duration: 3000 });
        }
      });
    }
  }

  // ==================== EXPORT CSV ====================

  exportToCSV(): void {
    const headers = ['Projet', 'Tâche', 'Description', 'Début', 'Fin', 'Quantité', 'Montant', 'Avancement', 'Statut'];
    const rows = this.tasks.map(t => [
      t.jobNo,
      t.taskNo,
      t.description,
      t.dateDebut ? new Date(t.dateDebut).toLocaleDateString('fr-FR') : '',
      t.dateFin ? new Date(t.dateFin).toLocaleDateString('fr-FR') : '',
      `${t.initialQuantity} ${t.initialUoM}`,
      t.initialAmount.toString(),
      `${t.progressPct}%`,
      this.getStatusText(t)
    ]);
    
    const csv = [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `taches_${new Date().toISOString().slice(0,10)}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  }
}