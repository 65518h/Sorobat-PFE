// src/app/modules/projects/pages/project-list/project-list.component.ts

import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

// Angular Material Imports
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
import { MatSnackBarModule, MatSnackBar } from '@angular/material/snack-bar';

import { ProjectService } from '../../services/project';
import { Project } from '../../models/project.model';

@Component({
  selector: 'app-project-list',
  standalone: true,
  imports: [
    CommonModule,
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
    MatSnackBarModule
  ],
  templateUrl: './project-list.html',
  styleUrls: ['./project-list.css']
})
export class ProjectListComponent implements OnInit, AfterViewInit {
  
  // Colonnes affichées
  displayedColumns: string[] = [
    'no', 
    'description', 
    'personResponsible', 
    'projectManager',
    'affectationMagasin',
    'progress', 
    'status', 
    'actions'
  ];
  
  // Data source pour le tableau
  dataSource: MatTableDataSource<Project> = new MatTableDataSource<Project>([]);
  
  // Liste complète des projets
  projects: Project[] = [];
  
  // Liste filtrée
  filteredProjects: Project[] = [];
  
  // Statistiques
  totalProjects: number = 0;
  activeProjects: number = 0;
  completedProjects: number = 0;
  suspendedProjects: number = 0;
  
  // Filtre actif
  currentFilter: string | null = null;

  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  constructor(
    private projectService: ProjectService,
    private snackBar: MatSnackBar,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadProjects();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  /**
   * Charge tous les projets
   */
  loadProjects(): void {
    this.projectService.getProjects().subscribe({
      next: (data) => {
        console.log('✅ Projets reçus:', data);
        this.projects = data;
        this.filteredProjects = data;
        this.dataSource.data = data;
        this.calculateStatistics();
        
        // Réappliquer le tri et la pagination après chargement
        setTimeout(() => {
          this.dataSource.sort = this.sort;
          this.dataSource.paginator = this.paginator;
        });
      },
      error: (err) => {
        console.error('❌ Erreur:', err);
        this.snackBar.open('Erreur lors du chargement des projets', 'Fermer', {
          duration: 3000,
          panelClass: ['error-snackbar']
        });
      }
    });
  }

  /**
   * Calcule les statistiques
   */
  calculateStatistics(): void {
    this.totalProjects = this.projects.length;
    this.activeProjects = this.projects.filter(p => this.getProjectStatus(p) === 'En cours').length;
    this.completedProjects = this.projects.filter(p => this.getProjectStatus(p) === 'Terminé').length;
    this.suspendedProjects = this.projects.filter(p => this.getProjectStatus(p) === 'Suspendu').length;
  }

  /**
   * Détermine le statut correct d'un projet basé sur sa progression
   */
  getProjectStatus(project: Project): string {
    // Si le projet a un statut explicite "Suspendu", on le garde
    if (project.status === 'Suspendu') return 'Suspendu';
    
    // Sinon, on détermine le statut basé sur la progression
    
    if (project.progress === 100) return 'Terminé';
    if (project.progress !== undefined && project.progress !== null && project.progress > 0) return 'En cours';
    return 'Open';  // Pour progression = 0
  }

  /**
   * Retourne la classe CSS pour le statut (pour l'affichage)
   */
  getStatusClass(status: string): string {
    switch(status) {
      case 'En cours': return 'status-en-cours';
      case 'Terminé': return 'status-termine';
      case 'Suspendu': return 'status-suspendu';
      case 'Open': return 'status-open';
      default: return 'status-default';
    }
  }

  /**
   * Retourne l'icône pour le statut
   */
  getStatusIcon(status: string): string {
    switch(status) {
      case 'En cours': return 'pending';
      case 'Terminé': return 'check_circle';
      case 'Suspendu': return 'pause_circle';
      case 'Open': return 'schedule';  // Icône horloge pour Open
      default: return 'help';
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
   * Applique le filtre de recherche
   */
  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
    this.filteredProjects = this.dataSource.filteredData;
  }

  /**
   * Filtre par statut (utilise le statut calculé)
   */
  filterByStatus(status: string | null): void {
    this.currentFilter = status;
    
    if (status === null || status === 'all') {
      this.dataSource.data = this.projects;
    } else if (status === 'En cours') {
      this.dataSource.data = this.projects.filter(p => this.getProjectStatus(p) === 'En cours');
    } else if (status === 'Terminé') {
      this.dataSource.data = this.projects.filter(p => this.getProjectStatus(p) === 'Terminé');
    } else if (status === 'Suspendu') {
      this.dataSource.data = this.projects.filter(p => this.getProjectStatus(p) === 'Suspendu');
    } else {
      this.dataSource.data = this.projects;
    }
    
    this.filteredProjects = this.dataSource.data;
  }

  /**
   * Gère le changement des filtres chips
   */
  onFilterChange(event: any): void {
    const selectedValues = event.value;
    
    if (selectedValues.length === 0) {
      this.dataSource.data = this.projects;
    } else {
      this.dataSource.data = this.projects.filter(p => {
        const projectStatus = this.getProjectStatus(p);
        return selectedValues.includes(projectStatus) || 
               (selectedValues.includes('retard') && (p.progress || 0) < 30 && p.progress !== undefined && p.progress !== null && p.progress > 0);
      });
    }
    
    this.filteredProjects = this.dataSource.data;
  }

  /**
   * Crée un nouveau projet
   */
  createProject(): void {
    this.router.navigate(['/projects/new']);
  }

  /**
   * Affiche les détails d'un projet
   */
  viewProject(projectNo: string): void {
    this.router.navigate(['/projects', projectNo]);
  }

  /**
   * Édite un projet
   */
  editProject(projectNo: string, event?: MouseEvent): void {
    if (event) {
      event.stopPropagation();
    }
    this.router.navigate(['/projects', projectNo, 'edit']);
  }

  /**
   * Supprime un projet
   */
  deleteProject(projectNo: string, event?: MouseEvent): void {
    if (event) {
      event.stopPropagation();
    }
    
    if (confirm(`Supprimer le projet ${projectNo} ?`)) {
      this.projectService.deleteProject(projectNo).subscribe({
        next: (success) => {
          if (success) {
            this.projects = this.projects.filter(p => p.no !== projectNo);
            this.dataSource.data = this.projects;
            this.calculateStatistics();
            this.snackBar.open('✅ Projet supprimé', 'Fermer', { duration: 2000 });
          }
        },
        error: (err) => {
          console.error('❌ Erreur:', err);
          this.snackBar.open('❌ Erreur lors de la suppression', 'Fermer', {
            duration: 3000,
            panelClass: ['error-snackbar']
          });
        }
      });
    }
  }

  /**
   * Exporte les données en CSV
   */
  exportToCSV(): void {
    const headers = ['N° Projet', 'Description', 'Responsable', 'Chef de projet', 'Magasin', 'Avancement', 'Statut'];
    const rows = this.filteredProjects.map(p => [
      p.no,
      p.description,
      p.personResponsible || 'Non assigné',
      p.projectManager || 'Non assigné',
      p.affectationMagasin || 'Non affecté',
      `${p.progress || 0}%`,
      this.getProjectStatus(p)  // Utilise le statut calculé
    ]);
    
    const csvContent = [headers.join(','), ...rows.map(row => row.join(','))].join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `projets_${new Date().toISOString().slice(0,10)}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
    
    this.snackBar.open('📁 Export CSV terminé', 'Fermer', { duration: 2000 });
  }
}