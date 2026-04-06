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
  openProjects: number = 0;
  
  // Filtres actifs
  activeFilters: string[] = [];
  activeFilter: string | null = null;

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
    this.openProjects = this.projects.filter(p => this.getProjectStatus(p) === 'Open').length;
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
    return 'Open';
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
      case 'Open': return 'schedule';
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
   * Retourne le dégradé pour la barre de progression
   */
  getProgressGradient(progress: number): string {
    if (progress >= 75) {
      return 'linear-gradient(90deg, #10b981, #34d399)';
    } else if (progress >= 40) {
      return 'linear-gradient(90deg, #3b82f6, #60a5fa)';
    } else if (progress >= 20) {
      return 'linear-gradient(90deg, #f59e0b, #fbbf24)';
    }
    return 'linear-gradient(90deg, #ef4444, #f87171)';
  }

  /**
   * Retourne les initiales d'un nom
   */
  getInitials(name: string | null): string {
    if (!name || name === 'Non assigné' || name === '') return '—';
    return name.charAt(0).toUpperCase();
  }

  /**
   * Calcule la progression moyenne
   */
  getAverageProgress(): number {
    if (!this.projects.length) return 0;
    const total = this.projects.reduce((sum, p) => sum + (p.progress || 0), 0);
    return Math.round(total / this.projects.length);
  }

  /**
   * Calcule le dasharray pour l'anneau de progression
   */
  getRingDasharray(value: number, total: number): string {
    const percent = total > 0 ? (value / total) * 100 : 0;
    const circumference = 2 * Math.PI * 15.9155;
    const dasharray = (percent / 100) * circumference;
    return `${dasharray} ${circumference}`;
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
   * Efface la recherche
   */
  clearSearch(input: HTMLInputElement): void {
    if (input) {
      input.value = '';
      this.dataSource.filter = '';
      this.filteredProjects = this.projects;
      this.filterByStatus(null);
    }
  }

  /**
   * Filtre par statut (utilise le statut calculé)
   */
  filterByStatus(status: string | null): void {
    this.activeFilter = status;
    
    if (status === null || status === 'all') {
      this.dataSource.data = this.projects;
      this.activeFilters = [];
    } else {
      this.dataSource.data = this.projects.filter(p => this.getProjectStatus(p) === status);
      this.activeFilters = [status];
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
        return selectedValues.includes(projectStatus);
      });
    }
    
    this.activeFilters = selectedValues;
    this.filteredProjects = this.dataSource.data;
  }

  /**
   * Vérifie si un filtre est actif
   */
  isFilterActive(value: string): boolean {
    return this.activeFilters.includes(value);
  }

  /**
   * Retourne le nombre d'éléments pour un filtre
   */
  getFilterCount(status: string): number {
    switch(status) {
      case 'En cours': return this.activeProjects;
      case 'Terminé': return this.completedProjects;
      case 'Suspendu': return this.suspendedProjects;
      case 'Open': return this.openProjects;
      default: return this.totalProjects;
    }
  }

  /**
   * Supprime un filtre spécifique
   */
  removeFilter(filter: string): void {
    this.activeFilters = this.activeFilters.filter(f => f !== filter);
    if (this.activeFilter === filter) {
      this.activeFilter = null;
    }
    this.filterByStatus(this.activeFilters.length === 1 ? this.activeFilters[0] : null);
  }

  /**
   * Efface tous les filtres
   */
  clearAllFilters(): void {
    this.activeFilters = [];
    this.activeFilter = null;
    this.dataSource.data = this.projects;
    this.filteredProjects = this.projects;
  }

  /**
   * Crée un nouveau projet
   */
  createProject(): void {
    this.router.navigate(['/projects/new']);
  }

  /**
   * Affiche les détails d'un projet - Utilise l'ID
   */
  viewProject(projectId: string): void {
    this.router.navigate(['/projects', projectId]);
  }

  /**
   * Édite un projet - Utilise l'ID
   */
  editProject(projectId: string, event?: MouseEvent): void {
    if (event) {
      event.stopPropagation();
    }
    this.router.navigate(['/projects', projectId, 'edit']);
  }

  /**
   * Supprime un projet - Utilise l'ID
   */
  deleteProject(projectId: string, event?: MouseEvent): void {
    if (event) {
      event.stopPropagation();
    }
    
    if (confirm(`Supprimer ce projet ?`)) {
      this.projectService.deleteProject(projectId).subscribe({
        next: (success) => {
          if (success) {
            this.projects = this.projects.filter(p => p.id !== projectId);
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
   * Affiche un menu contextuel
   */
  showMenu(event: MouseEvent, project: any): void {
    event.stopPropagation();
    // Implémenter le menu contextuel si nécessaire
  }

  /**
   * Exporte les données en CSV
   */
  exportToCSV(): void {
    const headers = ['ID', 'N° Projet', 'Description', 'Responsable', 'Chef de projet', 'Magasin', 'Avancement', 'Statut'];
    const rows = this.filteredProjects.map(p => [
      p.id,
      p.no,
      p.description,
      p.personResponsible || 'Non assigné',
      p.projectManager || 'Non assigné',
      p.affectationMagasin || 'Non affecté',
      `${p.progress || 0}%`,
      this.getProjectStatus(p)
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





  // Version alternative avec plus de variété et de couleurs vives
getAvatarGradient(name: string | null | undefined, type: 'primary' | 'secondary' = 'primary'): string {
  if (!name || name === 'Non assigné') {
    return 'linear-gradient(135deg, #64748b, #475569)';
  }

  // Palette plus large et plus vibrante
  const gradients = {
    primary: [
      'linear-gradient(135deg, #6366f1, #8b5cf6)',  // Indigo → Purple
      'linear-gradient(135deg, #3b82f6, #2dd4bf)',  // Blue → Teal
      'linear-gradient(135deg, #8b5cf6, #ec4899)',  // Purple → Pink
      'linear-gradient(135deg, #f59e0b, #ef4444)',  // Amber → Red
      'linear-gradient(135deg, #10b981, #06b6d4)',  // Emerald → Cyan
      'linear-gradient(135deg, #ef4444, #f97316)',  // Red → Orange
      'linear-gradient(135deg, #d946ef, #f43f5e)',  // Fuchsia → Rose
      'linear-gradient(135deg, #14b8a6, #3b82f6)',  // Teal → Blue
      'linear-gradient(135deg, #f43f5e, #eab308)',  // Rose → Yellow
      'linear-gradient(135deg, #06b6d4, #8b5cf6)',  // Cyan → Purple
      'linear-gradient(135deg, #84cc16, #10b981)',  // Lime → Emerald
      'linear-gradient(135deg, #0ea5e9, #6366f1)'   // Sky → Indigo
    ],
    secondary: [
      'linear-gradient(135deg, #ec4899, #be185d)',  // Pink → Dark Pink
      'linear-gradient(135deg, #7c3aed, #4c1d95)',  // Violet → Dark Violet
      'linear-gradient(135deg, #dc2626, #991b1b)',  // Red → Dark Red
      'linear-gradient(135deg, #ea580c, #9a3412)',  // Orange → Dark Orange
      'linear-gradient(135deg, #059669, #064e3b)',  // Emerald → Dark Emerald
      'linear-gradient(135deg, #4f46e5, #3730a3)',  // Indigo → Dark Indigo
      'linear-gradient(135deg, #0891b2, #164e63)',  // Cyan → Dark Cyan
      'linear-gradient(135deg, #d946ef, #a21caf)',  // Fuchsia → Dark Fuchsia
      'linear-gradient(135deg, #e11d48, #9f1239)',  // Rose → Dark Rose
      'linear-gradient(135deg, #ea580c, #c2410c)'   // Orange → Dark Orange
    ]
  };

  // Générer un hash à partir du nom
  let hash = 0;
  for (let i = 0; i < name.length; i++) {
    hash = ((hash << 5) - hash) + name.charCodeAt(i);
    hash = hash & hash;
  }

  const palette = type === 'primary' ? gradients.primary : gradients.secondary;
  const index = Math.abs(hash) % palette.length;
  
  return palette[index];
}








// Méthodes à ajouter dans votre composant TypeScript

// Couleurs d'avatar cohérentes par nom
getAvatarColor(name: string | null | undefined, type: 'primary' | 'secondary' = 'primary'): string {
  if (!name || name === 'Non assigné') {
    return '#9ca3af';
  }
  
  const colors = {
    primary: ['#3b82f6', '#8b5cf6', '#ec4899', '#f59e0b', '#10b981', '#06b6d4', '#ef4444', '#84cc16'],
    secondary: ['#6366f1', '#d946ef', '#f43f5e', '#eab308', '#14b8a6', '#0ea5e9', '#f97316', '#a855f7']
  };
  
  let hash = 0;
  for (let i = 0; i < name.length; i++) {
    hash = ((hash << 5) - hash) + name.charCodeAt(i);
    hash = hash & hash;
  }
  
  const palette = type === 'primary' ? colors.primary : colors.secondary;
  const index = Math.abs(hash) % palette.length;
  
  return palette[index];
}

// Classe CSS pour la barre de progression selon le pourcentage
getProgressClass(progress: number): string {
  if (progress < 30) return 'low';
  if (progress < 70) return 'medium';
  return 'high';
}

// Pagination (si vous voulez gérer côté frontend)
currentPage: number = 1;
itemsPerPage: number = 10;

get totalPages(): number {
  return Math.ceil(this.filteredProjects.length / this.itemsPerPage);
}

get paginatedProjects(): any[] {
  const start = (this.currentPage - 1) * this.itemsPerPage;
  return this.filteredProjects.slice(start, start + this.itemsPerPage);
}

nextPage(): void {
  if (this.currentPage < this.totalPages) {
    this.currentPage++;
  }
}

previousPage(): void {
  if (this.currentPage > 1) {
    this.currentPage--;
  }
}
}