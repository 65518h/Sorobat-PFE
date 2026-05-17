// modules/projects/components/task-list/task-list.component.ts
import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatChipsModule } from '@angular/material/chips';

@Component({
  selector: 'app-task-list',
  standalone: true,  // ← Important !
  imports: [
    CommonModule,
    MatTableModule,
    MatProgressBarModule,
    MatChipsModule
  ],
  templateUrl: './task-list.html',
  styleUrls: ['./task-list.css']
})
export class TaskListComponent {
  @Input() tasks: any[] = [];
  @Input() projectId: string = '';
  @Output() taskUpdated = new EventEmitter<void>();

  displayedColumns: string[] = ['taskNo', 'description', 'responsible', 'dates', 'progress', 'status'];

  getStatusClass(task: any): string {
    if (task.isBlocked) return 'status-blocked';
    if (task.progressPct === 100) return 'status-termine';
    if (task.progressPct > 0) return 'status-en-cours';
    return 'status-a-venir';
  }

  getStatusText(task: any): string {
    if (task.isBlocked) return 'Bloqué';
    if (task.progressPct === 100) return 'Terminé';
    if (task.progressPct > 0) return 'En cours';
    return 'À venir';
  }
}