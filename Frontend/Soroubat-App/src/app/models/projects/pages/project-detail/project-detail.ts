// modules/projects/pages/project-detail/project-detail.ts
import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { ProjectService } from '../../services/project';
import { JobTask } from '../../models/task.model';

// Angular Material
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';  
import { MatFormFieldModule } from '@angular/material/form-field';  
import { MatInputModule } from '@angular/material/input';          

// Composants
import { TaskListComponent } from '../../components/task-list/task-list';

@Component({
  selector: 'app-project-detail',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    MatInputModule,
    MatButtonModule,
     MatProgressSpinnerModule,
    MatIconModule,
    MatFormFieldModule,
    MatProgressBarModule,
    MatTooltipModule,
    TaskListComponent
  ],
  templateUrl: './project-detail.html',
  styleUrls: ['./project-detail.css']
})
export class ProjectDetailComponent implements OnInit {
  project: any = null;
  tasks: JobTask[] = [];
  filteredTasks: JobTask[] = [];
  isLoading = true;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private projectService: ProjectService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    const projectId = this.route.snapshot.paramMap.get('id');
    console.log('🔍 ID du projet:', projectId);
    
    if (projectId) {
      this.loadProjectDetails(projectId);
    }
  }

  loadProjectDetails(projectId: string): void {
    this.isLoading = true;
    console.log('📡 Chargement du projet:', projectId);
    
    this.projectService.getProjectById(projectId).subscribe({
      next: (data) => {
        console.log('✅ Données reçues:', data);
        
        if (data) {
          this.project = data.project;
          this.tasks = data.tasks || [];
          this.filteredTasks = [...this.tasks];
          console.log('✅ Projet:', this.project);
          console.log('✅ Tâches:', this.tasks.length);
        } else {
          console.warn('⚠️ Aucune donnée trouvée');
        }
        
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        this.isLoading = false;
        this.cdr.detectChanges();
      }
    });
  }

  // ✅ Méthodes pour les statistiques
  getCompletedTasksCount(): number {
    return this.tasks?.filter(t => t.progressPct === 100).length || 0;
  }

  getInProgressTasksCount(): number {
    return this.tasks?.filter(t => t.progressPct > 0 && t.progressPct < 100).length || 0;
  }

  getOverdueTasksCount(): number {
    return this.tasks?.filter(t => 
      !t.isBlocked && 
      t.progressPct < 100 && 
      t.dateFin && new Date(t.dateFin) < new Date()
    ).length || 0;
  }

  // ✅ Couleur de la barre de progression
  getProgressColor(progress: number): string {
    if (progress === 100) return 'primary';
    if (progress > 0) return 'accent';
    return 'warn';
  }

  // ✅ Classes pour la timeline
  getTimelineMarkerClass(task: JobTask): string {
    if (task.isBlocked) return 'status-blocked';
    if (task.progressPct === 100) return 'status-completed';
    return 'status-progress';
  }

  // ✅ Classes pour le statut des tâches
  getTaskStatusClass(task: JobTask): string {
    if (task.isBlocked) return 'status-blocked';
    if (task.progressPct === 100) return 'status-completed';
    if (this.isOverdue(task)) return 'status-overdue';
    if (task.progressPct > 0) return 'status-progress';
    return 'status-pending';
  }

  // ✅ Texte du statut des tâches
  getTaskStatusText(task: JobTask): string {
    if (task.isBlocked) return 'Bloqué';
    if (task.progressPct === 100) return 'Terminé';
    if (this.isOverdue(task)) return 'En retard';
    if (task.progressPct > 0) return 'En cours';
    return 'À venir';
  }

  // ✅ Vérifier si une tâche est en retard
  isOverdue(task: JobTask): boolean {
    return !task.isBlocked && 
           task.progressPct < 100 && 
           !!task.dateFin && 
           new Date(task.dateFin) < new Date();
  }

  // ✅ Actions sur le projet
  editProject(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.id, 'edit']);
    }
  }

  addTask(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.id, 'tasks', 'new']);
    }
  }

  deleteProject(): void {
    if (this.project && confirm('Supprimer ce projet ?')) {
      this.projectService.deleteProject(this.project.id).subscribe({
        next: () => {
          console.log('✅ Projet supprimé');
          this.router.navigate(['/projects']);
        },
        error: (err) => {
          console.error('❌ Erreur suppression:', err);
          alert('Erreur lors de la suppression du projet');
        }
      });
    }
  }

  // ✅ Actions sur les tâches
  viewAllTasks(): void {
    if (this.project) {
      this.router.navigate(['/projects', this.project.id, 'tasks']);
    }
  }

  exportTasks(): void {
    console.log('📥 Export des tâches');
    // Implémenter l'export CSV/Excel
  }

  // ✅ Filtre de recherche pour les tâches
  applyTaskFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value.toLowerCase();
    this.filteredTasks = this.tasks.filter(task => 
      task.description.toLowerCase().includes(filterValue) ||
      (task.taskNo && task.taskNo.toLowerCase().includes(filterValue)) ||
      (task.responsible && task.responsible.toLowerCase().includes(filterValue))
    );
    this.cdr.detectChanges();
  }

  // ✅ Icône du statut (si nécessaire dans le template)
  getStatusIcon(status: string): string {
    switch (status) {
      case 'En cours': return 'pending';
      case 'Terminé': return 'check_circle';
      case 'Suspendu': return 'pause_circle';
      default: return 'help';
    }
  }

  // ✅ Navigation retour
  goBack(): void {
    this.router.navigate(['/projects']);
  }

  // ✅ Classe CSS pour le statut du projet
  getStatusClass(status: string): string {
    switch (status) {
      case 'En cours': return 'status-en-cours';
      case 'Terminé': return 'status-termine';
      case 'Suspendu': return 'status-suspendu';
      default: return '';
    }
  }
}