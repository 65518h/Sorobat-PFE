// src/app/modules/projects/services/project.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError, of, forkJoin } from 'rxjs';
import { map, catchError, switchMap, tap } from 'rxjs/operators';
import { Project } from '../models/project.model';
import { JobTaskService } from '../services/job-task.service';
import { JobTask } from '../../tasks/models/job-task.model';

@Injectable({
  providedIn: 'root'
})
export class ProjectService {
  
  private baseUrl = 'http://localhost:5227/api';
  private projectsUrl = `${this.baseUrl}/Projects`;

  constructor(
    private http: HttpClient,
    private jobTaskService: JobTaskService
  ) {}

  // =============== MÉTHODES PRINCIPALES ===============

  /**
   * GET /api/Projects - Récupère tous les projets
   */
  getProjects(): Observable<Project[]> {
    console.log('📡 Récupération de tous les projets...');
    
    return this.http.get<any[]>(this.projectsUrl).pipe(
      map(response => this.mapProjectsResponse(response)),
      switchMap(projects => {
        // Pour chaque projet, récupérer ses tâches pour calculer l'avancement
        const projectsWithTasks$ = projects.map(project => 
          this.jobTaskService.getTasksByProject(project.no).pipe(
            map(tasks => {
              project.taskCount = tasks.length;
              project.progress = this.calculateProjectProgress(tasks);
              return project;
            }),
            catchError(() => {
              // En cas d'erreur, retourner le projet sans tâches
              project.taskCount = 0;
              project.progress = 0;
              return of(project);
            })
          )
        );
        
        return forkJoin(projectsWithTasks$);
      }),
      catchError(this.handleError)
    );
  }

  /**
   * GET /api/Projects/{id} - Récupère un projet par son ID
   */
  getProjectById(id: string): Observable<Project | null> {
    console.log('📡 Récupération du projet:', id);
    
    return this.http.get<any>(`${this.projectsUrl}/${id}`).pipe(
      map(response => this.mapProjectResponse(response)),
      switchMap(project => 
        this.jobTaskService.getTasksByProject(project.no).pipe(
          map(tasks => {
            project.taskCount = tasks.length;
            project.progress = this.calculateProjectProgress(tasks);
            return project;
          }),
          catchError(() => {
            project.taskCount = 0;
            project.progress = 0;
            return of(project);
          })
        )
      ),
      catchError(() => of(null))
    );
  }

  /**
   * Récupère les tâches d'un projet
   */
  getProjectTasks(projectId: string): Observable<JobTask[]> {
    console.log('📡 Récupération des tâches du projet:', projectId);
    
    return this.jobTaskService.getTasksByProject(projectId).pipe(
      catchError(() => of([]))
    );
  }

  /**
   * Récupère un projet avec toutes ses tâches
   */
  getProjectWithTasks(id: string): Observable<{ project: Project; tasks: JobTask[] } | null> {
    console.log('📡 Récupération du projet avec ses tâches:', id);
    
    return forkJoin({
      project: this.getProjectById(id),
      tasks: this.getProjectTasks(id).pipe(catchError(() => of([])))
    }).pipe(
      map(({ project, tasks }) => {
        return project ? { project, tasks } : null;
      })
    );
  }

  /**
   * Crée un nouveau projet
   */
  createProject(project: Partial<Project>): Observable<Project> {
    console.log('📡 Création d\'un nouveau projet:', project);
    
    return this.http.post<any>(this.projectsUrl, this.mapToApiProject(project)).pipe(
      map(response => this.mapProjectResponse(response)),
      catchError(this.handleError)
    );
  }

  /**
   * Met à jour un projet
   */
  updateProject(id: string, changes: Partial<Project>): Observable<Project> {
    console.log('📡 Mise à jour du projet:', id, changes);
    
    return this.http.put<any>(`${this.projectsUrl}/${id}`, this.mapToApiProject(changes)).pipe(
      map(response => this.mapProjectResponse(response)),
      catchError(this.handleError)
    );
  }

  /**
   * Supprime un projet
   */
  deleteProject(id: string): Observable<boolean> {
    console.log('📡 Suppression du projet:', id);
    
    return this.http.delete<void>(`${this.projectsUrl}/${id}`).pipe(
      map(() => {
        console.log('✅ Projet supprimé avec succès');
        return true;
      }),
      catchError((error) => {
        console.error('❌ Erreur lors de la suppression:', error);
        return of(false);
      })
    );
  }

  /**
   * Met à jour l'avancement d'un projet
   */
  updateProjectProgress(projectId: string, progress?: number): Observable<any> {
    console.log('📡 Mise à jour avancement projet:', projectId, progress);
    
    if (progress === undefined) {
      // Calcul automatique basé sur les tâches
      return this.jobTaskService.getTasksByProject(projectId).pipe(
        switchMap(tasks => {
          const avgProgress = this.calculateProjectProgress(tasks);
          
          return this.http.patch<any>(`${this.projectsUrl}/update-progress`, {
            jobNo: projectId,
            progress: avgProgress
          }).pipe(
            tap(() => console.log('✅ Avancement mis à jour:', avgProgress))
          );
        })
      );
    }
    
    // Mise à jour manuelle
    return this.http.patch<any>(`${this.projectsUrl}/update-progress`, {
      jobNo: projectId,
      progress
    }).pipe(
      tap(() => console.log('✅ Avancement mis à jour:', progress))
    );
  }

  /**
   * Obtenir les statistiques globales des projets
   */
  getProjectsStats(): Observable<{
    total: number;
    active: number;
    completed: number;
    suspended: number;
    averageProgress: number;
    totalTasks: number;
  }> {
    return this.getProjects().pipe(
      switchMap(projects => {
        // Récupérer toutes les tâches pour les statistiques
        const tasks$ = projects.map(p => 
          this.jobTaskService.getTasksByProject(p.no).pipe(catchError(() => of([])))
        );
        
        return forkJoin(tasks$).pipe(
          map(tasksArrays => {
            const allTasks = tasksArrays.flat();
            const totalTasks = allTasks.length;
            
            const active = projects.filter(p => p.status === 'En cours').length;
            const completed = projects.filter(p => p.status === 'Terminé').length;
            const suspended = projects.filter(p => p.status === 'Suspendu').length;
            
            const totalProgress = projects.reduce((sum, p) => sum + (p.progress || 0), 0);
            const averageProgress = projects.length > 0 ? Math.round(totalProgress / projects.length) : 0;
            
            return { 
              total: projects.length, 
              active, 
              completed, 
              suspended, 
              averageProgress,
              totalTasks
            };
          })
        );
      })
    );
  }

  // =============== MÉTHODES DE CALCUL ===============

  /**
   * Calcule l'avancement global du projet basé sur ses tâches
   */
  private calculateProjectProgress(tasks: JobTask[]): number {
    if (!tasks || tasks.length === 0) return 0;
    
    // Moyenne simple des progressions
    const sum = tasks.reduce((acc, task) => acc + (task.progressPct || 0), 0);
    return Math.round(sum / tasks.length);
  }

  // =============== MAPPING ===============

  /**
   * Mappe une réponse API (objet unique) vers le modèle Project
   */
  private mapProjectResponse(data: any): Project {
    return {
      no: data.no || data.id || data.jobNo || '',
      description: data.description || '',
      status: data.status || 'En cours',
      personResponsible: data.personResponsible || data.responsible || '',
      projectManager: data.projectManager || data.manager || '',
      affectationMagasin: data.affectationMagasin || data.magasin || '',
      taskCount: data.taskCount || 0,
      progress: data.progress || 0
    };
  }

  /**
   * Mappe un tableau de réponses API vers un tableau de Projects
   */
  private mapProjectsResponse(data: any[]): Project[] {
    if (!Array.isArray(data)) {
      console.warn('⚠️ La réponse API n\'est pas un tableau:', data);
      return [];
    }
    return data.map(item => this.mapProjectResponse(item));
  }

  /**
   * Mappe un objet Project vers le format attendu par l'API
   */
  private mapToApiProject(project: Partial<Project>): any {
    const apiProject: any = {};
    
    if (project.no !== undefined) apiProject.no = project.no;
    if (project.description !== undefined) apiProject.description = project.description;
    if (project.status !== undefined) apiProject.status = project.status;
    if (project.personResponsible !== undefined) apiProject.personResponsible = project.personResponsible;
    if (project.projectManager !== undefined) apiProject.projectManager = project.projectManager;
    if (project.affectationMagasin !== undefined) apiProject.affectationMagasin = project.affectationMagasin;
    if (project.progress !== undefined) apiProject.progress = project.progress;
    
    return apiProject;
  }

  // =============== GESTION DES ERREURS ===============

  /**
   * Gère les erreurs HTTP
   */
  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = 'Erreur de communication avec le serveur';
    
    if (error.error instanceof ErrorEvent) {
      // Erreur côté client
      errorMessage = `Erreur: ${error.error.message}`;
      console.error('❌ Erreur client:', error.error.message);
    } else {
      // Erreur côté serveur
      errorMessage = `Code: ${error.status}, Message: ${error.message}`;
      console.error('❌ Erreur serveur:', error.status, error.message);
      
      if (error.status === 0) {
        errorMessage = 'Impossible de contacter le serveur. Vérifiez que le backend est démarré.';
      } else if (error.status === 404) {
        errorMessage = 'Ressource non trouvée.';
      } else if (error.status === 500) {
        errorMessage = 'Erreur interne du serveur.';
      }
    }
    
    return throwError(() => new Error(errorMessage));
  }
}