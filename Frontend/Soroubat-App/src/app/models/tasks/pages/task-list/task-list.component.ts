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

import { JobTaskService } from '../../services/job-task';
import { JobTask } from '../../models/job-task.model';

@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [
    CommonModule,
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
    MatMenuModule
  ],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css']
})
export class TaskListComponent implements OnInit {
  displayedColumns: string[] = ['jobNo', 'taskNo', 'description', 'dateDebut', 'dateFin', 'status', 'progress', 'actions'];
  dataSource: MatTableDataSource<JobTask> = new MatTableDataSource<JobTask>([]);

  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  tasks: JobTask[] = [];

  constructor(private jobTaskService: JobTaskService) {}

  ngOnInit(): void {
    this.loadTasks();
  }

  loadTasks(): void {
    this.jobTaskService.getTasks().subscribe({
      next: (data) => {
        this.tasks = data;
        this.dataSource.data = data;
        this.dataSource.sort = this.sort;
        this.dataSource.paginator = this.paginator;
        console.log('✅ Tâches chargées:', this.tasks.length);
      },
      error: (err) => console.error('❌ Erreur:', err)
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
    return this.tasks.filter(t => {
      const progress = t.progressPct || 0;
      return progress > 0 && progress < 100;
    }).length;
  }

  getBlockedTasksCount(): number {
    return this.tasks.filter(t => t.isBlocked === true).length;
  }

  isOverdue(task: JobTask): boolean {
    // Vérifier que task.isBlocked existe et est true
    const isBlocked = task.isBlocked === true;
    
    // Vérifier que task.dateFin existe
    if (!task.dateFin) return false;
    
    // Vérifier que task.progressPct existe
    const progress = task.progressPct || 0;
    
    return !isBlocked && 
           progress < 100 && 
           new Date(task.dateFin) < new Date();
  }

  getStatusClass(task: JobTask): string {
    if (task.isBlocked === true) return 'status-blocked';
    const progress = task.progressPct || 0;
    
    if (progress === 100) return 'status-termine';
    if (this.isOverdue(task)) return 'status-en-retard';
    if (progress > 0) return 'status-en-cours';
    return 'status-a-venir';
  }

  getStatusText(task: JobTask): string {
    if (task.isBlocked === true) return 'Bloqué';
    const progress = task.progressPct || 0;
    
    if (progress === 100) return 'Terminé';
    if (this.isOverdue(task)) return 'En retard';
    if (progress > 0) return 'En cours';
    return 'À venir';
  }

  getProgressColor(task: JobTask): string {
    if (task.isBlocked === true) return 'warn';
    const progress = task.progressPct || 0;
    
    if (progress === 100) return 'primary';
    if (this.isOverdue(task)) return 'warn';
    return 'accent';
  }

  editTask(task: JobTask): void {
    console.log('Édition de la tâche:', task);
    // Implémenter la logique d'édition
  }

  viewTask(task: JobTask): void {
    console.log('Visualisation de la tâche:', task);
    // Implémenter la logique de visualisation
  }

  deleteTask(task: JobTask): void {
    if (confirm(`Supprimer la tâche ${task.taskNo} ?`)) {
      console.log('Suppression de la tâche:', task);
      // Implémenter la logique de suppression
    }
  }

  exportToCSV(): void {
    console.log('Export des tâches en CSV');
    // Implémenter l'export CSV
  }
}