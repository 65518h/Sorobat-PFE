// modules/projects/pages/project-list/project-list.ts
import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { MatTableModule, MatTableDataSource } from '@angular/material/table';
import { MatSortModule, MatSort } from '@angular/material/sort';
import { MatPaginatorModule, MatPaginator } from '@angular/material/paginator';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatChipsModule, MatChipSelectionChange, MatChipListboxChange } from '@angular/material/chips';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatMenuModule } from '@angular/material/menu';

import { ProjectService } from '../../services/project';
import { Project } from '../../models/project.model';

@Component({
  selector: 'app-project-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressBarModule,
    MatChipsModule,
    MatFormFieldModule,
    MatInputModule,
    MatTooltipModule,
    MatMenuModule
  ],
  templateUrl: './project-list.html',
  styleUrls: ['./project-list.css']
})
export class ProjectListComponent implements OnInit, AfterViewInit {
  displayedColumns: string[] = ['number', 'name', 'customer', 'responsible', 'dates', 'progress', 'status', 'actions'];
  dataSource: MatTableDataSource<Project> = new MatTableDataSource<Project>([]);
  
  @ViewChild(MatSort) sort!: MatSort;
  @ViewChild(MatPaginator) paginator!: MatPaginator;

  projects: Project[] = [];
  filteredProjects: Project[] = [];
  isLoading = false;
  
  // Propriétés pour les filtres
  selectedFilters: string[] = [];

  constructor(
    private projectService: ProjectService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadProjects();
  }

  ngAfterViewInit(): void {
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }

  loadProjects(): void {
    this.isLoading = true;
    this.projectService.getProjects().subscribe({
      next: (data: Project[]) => {
        this.projects = data;
        this.filteredProjects = data;
        this.dataSource.data = data;
        this.isLoading = false;
        console.log('✅ Projets chargés:', this.projects.length);
      },
      error: (error: Error) => {
        console.error('❌ Erreur chargement projets:', error);
        this.isLoading = false;
      }
    });
  }

  // ✅ MÉTHODE AJOUTÉE POUR LA GESTION DES FILTRES
  onFilterChange(event: MatChipListboxChange): void {
  console.log('Filtre changé:', event);
  
  const selectedValues = event.value;
  
  if (!selectedValues || selectedValues.length === 0) {
    // Aucun filtre - afficher tous les projets
    this.dataSource.data = this.projects;
    return;
  }
  
  // Filtrer selon la première valeur sélectionnée (simplifié)
  const filter = selectedValues[0];
  
  switch (filter) {
    case 'Projets en cours':
      this.dataSource.data = this.projects.filter(p => p.status === 'En cours');
      break;
    case 'Projets terminés':
      this.dataSource.data = this.projects.filter(p => p.status === 'Terminé');
      break;
    case 'Projets suspendus':
      this.dataSource.data = this.projects.filter(p => p.status === 'Suspendu');
      break;
    case 'Retard d\'avancement':
      this.dataSource.data = this.projects.filter(p => 
        p.progress < 50 && p.status === 'En cours'
      );
      break;
    default:
      this.dataSource.data = this.projects;
  }
}

  // ✅ MÉTHODE POUR APPLIQUER LES FILTRES
  applyFilters(): void {
    if (this.selectedFilters.length === 0) {
      // Aucun filtre sélectionné
      this.dataSource.data = this.projects;
      return;
    }
    
    // Filtrer les projets selon les critères sélectionnés
    this.dataSource.data = this.projects.filter(project => {
      // Vérifier chaque filtre
      for (const filter of this.selectedFilters) {
        switch (filter) {
          case 'Projets en cours':
            if (project.status !== 'En cours') return false;
            break;
          case 'Projets terminés':
            if (project.status !== 'Terminé') return false;
            break;
          case 'Projets suspendus':
            if (project.status !== 'Suspendu') return false;
            break;
          case 'Retard d\'avancement':
            // Logique pour détecter les retards
            if (project.progress < 50 && project.status === 'En cours') {
              // Considérer comme en retard si progression < 50%
              return true;
            }
            return false;
        }
      }
      return true;
    });
  }

  // Getters pour les statistiques
  get totalProjects(): number {
    return this.projects.length;
  }

  get activeProjects(): number {
    return this.projects.filter(p => p.status === 'En cours').length;
  }

  get completedProjects(): number {
    return this.projects.filter(p => p.status === 'Terminé').length;
  }

  get suspendedProjects(): number {
    return this.projects.filter(p => p.status === 'Suspendu').length;
  }

  // Filtre par recherche
  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }

  // Filtre par statut
  filterByStatus(status: string): void {
    if (status === 'all') {
      this.dataSource.data = this.projects;
    } else {
      this.dataSource.data = this.projects.filter(p => p.status === status);
    }
  }

  // Actions
  viewProject(id: string): void {
    this.router.navigate(['/projects', id]);
  }

  createProject(): void {
    this.router.navigate(['/projects/new']);
  }

  editProject(id: string): void {
    this.router.navigate(['/projects', id, 'edit']);
  }

  deleteProject(id: string): void {
    if (confirm('Supprimer ce projet ?')) {
      this.projectService.deleteProject(id).subscribe({
        next: () => this.loadProjects(),
        error: (error: Error) => {
          console.error('❌ Erreur suppression:', error);
          alert('Erreur lors de la suppression');
        }
      });
    }
  }

  exportToCSV(): void {
    console.log('Export CSV');
    // Implémenter l'export CSV
  }

  getStatusClass(status: string): string {
    switch (status) {
      case 'En cours':
        return 'status-en-cours';
      case 'Terminé':
        return 'status-termine';
      case 'Suspendu':
        return 'status-suspendu';
      default:
        return '';
    }
  }

  getStatusIcon(status: string): string {
    switch (status) {
      case 'En cours':
        return 'pending';
      case 'Terminé':
        return 'check_circle';
      case 'Suspendu':
        return 'pause_circle';
      default:
        return 'help';
    }
  }
}