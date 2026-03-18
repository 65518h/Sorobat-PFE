// src/app/modules/tasks/pages/task-list/task-list.component.ts

import { Component, OnInit, ViewChild } from '@angular/core';
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
export class TaskListComponent implements OnInit {
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
  
  // Nouvelle propriété pour le slider temporaire
  sliderTempValue: Map<string, number> = new Map();

  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  
  // Timeout pour éviter les appels multiples
  private sliderTimeout: any;

  constructor(
    private jobTaskService: JobTaskService,
    private snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.loadTasks();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

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

  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  getCompletedTasksCount(): number {
    return this.tasks.filter(t => t.progressPct === 100).length;
  }

  getInProgressTasksCount(): number {
    return this.tasks.filter(t => t.progressPct > 0 && t.progressPct < 100).length;
  }

  getBlockedTasksCount(): number {
    return this.tasks.filter(t => t.isBlocked === true).length;
  }

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
    const status = this.getStatusText(task);
    let tooltip = `Statut: ${status}\n`;
    
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

  getProgressColor(task: JobTask): string {
    if (task.isBlocked) return 'warn';
    if (task.progressPct === 100) return 'primary';
    if (this.isOverdue(task)) return 'warn';
    return 'accent';
  }

  getProgressGradient(task: JobTask): string {
    if (task.isBlocked) return 'linear-gradient(90deg, #ef4444, #f87171)';
    if (this.isOverdue(task)) return 'linear-gradient(90deg, #f59e0b, #fbbf24)';
    return 'linear-gradient(90deg, #3b82f6, #8b5cf6)';
  }

  viewTask(task: JobTask): void {
    console.log('Visualisation tâche:', task);
  }

  editTask(task: JobTask): void {
    console.log('Édition tâche:', task);
    this.snackBar.open(`Édition de ${task.taskNo}`, 'Fermer', { duration: 2000 });
  }

  deleteTask(task: JobTask): void {
    if (confirm(`Supprimer la tâche ${task.taskNo} ?`)) {
      this.jobTaskService.deleteTask(task.taskNo).subscribe({
        next: () => {
          this.tasks = this.tasks.filter(t => t.taskNo !== task.taskNo);
          this.dataSource.data = this.tasks;
          this.snackBar.open('✅ Tâche supprimée', 'Fermer', { duration: 2000 });
        },
        error: (err: any) => {
          console.error('❌ Erreur suppression:', err);
          this.snackBar.open('❌ Erreur lors de la suppression', 'Fermer', {
            duration: 3000,
            panelClass: ['error-snackbar']
          });
        }
      });
    }
  }

  exportToCSV(): void {
    const csvData = this.convertToCSV(this.tasks);
    const blob = new Blob([csvData], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `taches_${new Date().toISOString().slice(0,10)}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  }

  private convertToCSV(tasks: JobTask[]): string {
    const headers = ['Projet', 'Tâche', 'Description', 'Début', 'Fin', 'Quantité', 'Montant', 'Avancement', 'Statut'];
    const rows = tasks.map(t => [
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
    return [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
  }

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

  getComparisonText(task: JobTask): string {
    if (task.progressPct > task.taskProgressPct) {
      return `Avance (+${(task.progressPct - task.taskProgressPct).toFixed(1)}%)`;
    } else {
      return `Retard (-${(task.taskProgressPct - task.progressPct).toFixed(1)}%)`;
    }
  }

  getComparisonTooltip(task: JobTask): string {
    const diff = Math.abs(task.progressPct - task.taskProgressPct).toFixed(1);
    
    if (task.progressPct > task.taskProgressPct) {
      return `📈 Avance de ${diff}% par rapport à la quantité livrée\n` +
             `Saisi: ${task.progressPct}% | Théorique: ${task.taskProgressPct?.toFixed(1)}%`;
    } else if (task.progressPct < task.taskProgressPct) {
      return `📉 Retard de ${diff}% par rapport à la quantité livrée\n` +
             `Saisi: ${task.progressPct}% | Théorique: ${task.taskProgressPct?.toFixed(1)}%`;
    }
    return `✅ Avancement synchronisé avec la quantité livrée`;
  }

  getGapValue(task: JobTask): string {
    if (!task.taskProgressPct) return '0';
    const gap = task.progressPct - task.taskProgressPct;
    return (gap > 0 ? '+' : '') + gap.toFixed(1);
  }

  getGapColor(task: JobTask): string {
    if (!task.taskProgressPct) return 'transparent';
    const gap = task.progressPct - task.taskProgressPct;
    
    if (Math.abs(gap) < 5) {
      return 'linear-gradient(90deg, #fbbf24, #f59e0b)';
    } else if (gap > 0) {
      return 'linear-gradient(90deg, #34d399, #10b981)';
    } else {
      return 'linear-gradient(90deg, #f87171, #ef4444)';
    }
  }

  getConsumptionBarColor(task: JobTask): string {
    const consumptionPct = task.initialQuantity > 0 
      ? (task.quantityShipped / task.initialQuantity) * 100 
      : 0;
    
    if (consumptionPct > 100) {
      return 'linear-gradient(90deg, #ef4444, #f87171)';
    } else if (consumptionPct >= 80) {
      return 'linear-gradient(90deg, #fbbf24, #f59e0b)';
    } else {
      return 'linear-gradient(90deg, #3b82f6, #8b5cf6)';
    }
  }

  // ===== MÉTHODES DU SLIDER AMÉLIORÉES =====

  /**
   * Gestion du slider en temps réel - met à jour l'affichage seulement
   */
  onProgressSliderChange(task: JobTask, event: Event): void {
    const input = event.target as HTMLInputElement;
    const progress = parseInt(input.value, 10);
    
    // Stocker la valeur temporaire
    this.sliderTempValue.set(task.taskNo, progress);
    
    // Mise à jour visuelle immédiate
    task.progressPct = progress;
    
    // Mettre à jour la couleur du slider
    input.style.setProperty('--progress', progress + '%');
    
    console.log('🎚️ Slider change temporaire:', progress);
  }

  /**
   * Sauvegarde quand l'utilisateur relâche le slider (événement change)
   */
  onProgressSliderCommit(task: JobTask, event: Event): void {
    const input = event.target as HTMLInputElement;
    const progress = parseInt(input.value, 10);
    
    console.log('🖱️ Slider commit - Sauvegarde à', progress);
    
    // Nettoyer la valeur temporaire
    this.sliderTempValue.delete(task.taskNo);
    
    // Sauvegarder si différent
    if (task.progressPct !== progress) {
      this.updateProgress(task, progress);
    } else {
      this.updateProgress(task, progress);
    }
  }

  /**
   * Sauvegarde au relâchement de la souris (plus fiable)
   */
  onSliderMouseUp(task: JobTask, event: MouseEvent): void {
    const input = event.target as HTMLInputElement;
    const progress = parseInt(input.value, 10);
    
    console.log('🖱️ Mouse up - Sauvegarde à', progress);
    
    // Nettoyer la valeur temporaire
    this.sliderTempValue.delete(task.taskNo);
    
    this.updateProgress(task, progress);
  }

  /**
   * Sauvegarde après un délai (évite les appels multiples)
   */
  onSliderDebouncedChange(task: JobTask, event: Event): void {
    const input = event.target as HTMLInputElement;
    const progress = parseInt(input.value, 10);
    
    // Mise à jour visuelle
    task.progressPct = progress;
    input.style.setProperty('--progress', progress + '%');
    
    // Annuler le timeout précédent
    clearTimeout(this.sliderTimeout);
    
    // Nouveau timeout pour sauvegarder après 500ms d'inactivité
    this.sliderTimeout = setTimeout(() => {
      console.log('⏱️ Sauvegarde après délai:', progress);
      this.updateProgress(task, progress);
    }, 500);
  }

  /**
   * Version avec gestion du clavier
   */
  onSliderKeyUp(task: JobTask, event: KeyboardEvent): void {
    if (event.key === 'ArrowLeft' || event.key === 'ArrowRight' || 
        event.key === 'ArrowUp' || event.key === 'ArrowDown') {
      
      const input = event.target as HTMLInputElement;
      const progress = parseInt(input.value, 10);
      
      console.log('⌨️ Key up - Sauvegarde à', progress);
      
      // Annuler le timeout précédent
      clearTimeout(this.sliderTimeout);
      
      // Sauvegarde après un court délai
      this.sliderTimeout = setTimeout(() => {
        this.updateProgress(task, progress);
      }, 300);
    }
  }

  /**
   * Retourne la valeur actuelle du slider (temporaire ou réelle)
   */
  getSliderValue(task: JobTask): number {
    return this.sliderTempValue.get(task.taskNo) ?? task.progressPct;
  }

  /**
   * Met à jour la couleur de fond du slider
   */
 getSliderBackground(task: JobTask): string {
  return `linear-gradient(90deg, #3b82f6 0%, #3b82f6 ${task.progressPct}%, #e2e8f0 ${task.progressPct}%, #e2e8f0 100%)`;
}
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
    
    console.log('✅ Bouton custom cliqué');
    console.log('✅ Valeur reçue:', value);
    console.log('✅ Tâche:', task.taskNo);
    
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
  }

  /**
   * Sauvegarde la modification du progressPct
   */
  saveProgressEdit(task: JobTask, newValue: string): void {
    const newProgress = parseInt(newValue, 10);
    
    if (isNaN(newProgress) || newProgress < 0 || newProgress > 100) {
      this.snackBar.open('❌ Veuillez saisir un nombre entre 0 et 100', 'Fermer', {
        duration: 3000,
        panelClass: ['error-snackbar']
      });
      return;
    }

    this.updateProgress(task, newProgress);
    this.editingTaskId = null;
    this.originalProgress = null;
  }

  /**
   * Mise à jour rapide via les boutons
   */
  quickUpdateProgress(task: JobTask, newProgress: number, event?: MouseEvent): void {
    if (event) {
      event.stopPropagation();
    }
    
    if (newProgress === task.progressPct) {
      return;
    }
    
    if (newProgress === 100 && task.progressPct !== 100) {
      if (!confirm(`Marquer la tâche "${task.taskNo}" comme terminée (100%) ?`)) {
        return;
      }
    }
    
    this.updateProgress(task, newProgress);
  }

  /**
   * Version améliorée de updateProgress
   */
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
        
        // Nettoyer la valeur temporaire
        this.sliderTempValue.delete(task.taskNo);
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        task.progressPct = originalProgress;
        this.snackBar.open('❌ Erreur de mise à jour', 'Fermer', { 
          duration: 2000,
          panelClass: ['error-snackbar']
        });
      }
    });
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
      }
    }
    this.editingTaskId = null;
    this.tempProgressValue = 0;
    this.originalProgress = null;
  }


  // Dans votre TaskListComponent

// Map pour stocker les timeouts par tâche
private sliderTimeouts: Map<string, any> = new Map();

/**
 * Gestion du slider avec debounce - sauvegarde 300ms après le dernier mouvement
 */
onSliderChange(task: JobTask, event: Event): void {
  // Empêcher la propagation
  event.stopPropagation();
  
  const input = event.target as HTMLInputElement;
  const newValue = parseInt(input.value, 10);
  
  console.log('🎚️ Slider bougé à:', newValue, 'pour tâche', task.taskNo);
  
  // Mise à jour visuelle IMMÉDIATE
  task.progressPct = newValue;
  
  // Mettre à jour la couleur du slider
  input.style.setProperty('--progress', newValue + '%');
  
  // ANNULER LE TIMEOUT PRÉCÉDENT
  if (this.sliderTimeouts.has(task.taskNo)) {
    clearTimeout(this.sliderTimeouts.get(task.taskNo));
    console.log('⏱️ Timeout annulé pour', task.taskNo);
  }
  
  // CRÉER UN NOUVEAU TIMEOUT
  const timeout = setTimeout(() => {
    console.log('💾 DEBOUNCE - Sauvegarde pour', task.taskNo, ':', newValue);
    
    // Appel API pour sauvegarder
    this.jobTaskService.updateTaskProgress(task.jobNo, task.taskNo, newValue).subscribe({
      next: (response) => {
        console.log('✅ Sauvegarde réussie:', response);
        this.snackBar.open(`✅ Avancement: ${newValue}%`, 'Fermer', { 
          duration: 2000 
        });
      },
      error: (err) => {
        console.error('❌ Erreur sauvegarde:', err);
        this.snackBar.open('❌ Erreur de sauvegarde', 'Fermer', { 
          duration: 2000,
          panelClass: ['error-snackbar']
        });
        
        // Recharger les données pour resynchroniser
        this.loadTasks();
      }
    });
    
    // Nettoyer le timeout de la map
    this.sliderTimeouts.delete(task.taskNo);
  }, 300); // 300ms après le dernier mouvement
  
  // Stocker le timeout dans la map
  this.sliderTimeouts.set(task.taskNo, timeout);
}

/**
 * Méthode utilitaire pour le background du slider
 */


// Nettoyage des timeouts
ngOnDestroy(): void {
  console.log('🧹 Nettoyage des timeouts');
  this.sliderTimeouts.forEach((timeout, taskNo) => {
    clearTimeout(timeout);
  });
  this.sliderTimeouts.clear();
}

}