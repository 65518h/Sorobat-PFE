// src/app/modules/projects/services/project.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError, of, forkJoin } from 'rxjs';
import { map, catchError, switchMap } from 'rxjs/operators';
import { Project } from '../models/project.model';
import { JobTaskService } from './job-task.service';
import { JobTask } from '../../tasks/models/job-task.model';

@Injectable({
  providedIn: 'root'
})
export class ProjectService {
  
  private baseUrl = 'http://localhost:5227/api';
  private siteManagementUrl = `${this.baseUrl}/SiteManagement`;

  constructor(
    private http: HttpClient,
    private jobTaskService: JobTaskService
  ) {}

  // =============== MÉTHODES PRINCIPALES ===============

  /**
   * GET /api/SiteManagement - Récupère tous les projets
   */
  getProjects(): Observable<Project[]> {
    console.log('📡 Récupération de tous les projets...');
    
    return this.http.get<any[]>(this.siteManagementUrl).pipe(
      map(response => this.mapProjectsResponse(response)),
      switchMap(projects => {
        const projectsWithTasks$ = projects.map(project => 
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
        );
        return forkJoin(projectsWithTasks$);
      }),
      catchError(this.handleError)
    );
  }

  /**
   * GET /api/SiteManagement/{id} - Récupère un projet par son ID
   */
  getProjectById(id: string): Observable<Project | null> {
    console.log('📡 Récupération du projet par ID:', id);
    
    return this.http.get<any>(`${this.siteManagementUrl}/${id}`).pipe(
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
  getProjectTasks(jobNo: string): Observable<JobTask[]> {
    console.log('📡 Récupération des tâches du projet:', jobNo);
    return this.jobTaskService.getTasksByProject(jobNo);
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
      map(({ project, tasks }) => project ? { project, tasks } : null)
    );
  }

  /**
   * POST /api/SiteManagement - Crée un nouveau projet
   */
  createProject(project: Partial<Project>): Observable<Project> {
    console.log('📡 Création d\'un nouveau projet:', project);
    
    return this.http.post<any>(this.siteManagementUrl, this.mapToApiProject(project)).pipe(
      map(response => this.mapProjectResponse(response)),
      catchError(this.handleError)
    );
  }

  /**
   * PUT /api/SiteManagement/{id} - Met à jour un projet
   */
  updateProject(id: string, changes: Partial<Project>): Observable<Project> {
    console.log('📡 Mise à jour du projet:', id, changes);
    
    return this.http.put<any>(`${this.siteManagementUrl}/${id}`, this.mapToApiProject(changes)).pipe(
      map(response => this.mapProjectResponse(response)),
      catchError(this.handleError)
    );
  }

  /**
   * DELETE /api/SiteManagement/{id} - Supprime un projet
   */
  deleteProject(id: string): Observable<boolean> {
    console.log('📡 Suppression du projet:', id);
    
    return this.http.delete<void>(`${this.siteManagementUrl}/${id}`).pipe(
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
   * PATCH /api/SiteManagement/update-progress - Met à jour l'avancement d'un projet
   */
  updateProjectProgress(projectId: string, progress?: number): Observable<any> {
    console.log('📡 Mise à jour avancement projet:', projectId, progress);
    
    if (progress === undefined) {
      return this.jobTaskService.getTasksByProject(projectId).pipe(
        switchMap(tasks => {
          const avgProgress = this.calculateProjectProgress(tasks);
          return this.http.patch<any>(`${this.siteManagementUrl}/update-progress`, {
            id: projectId,
            progress: avgProgress
          });
        })
      );
    }
    
    return this.http.patch<any>(`${this.siteManagementUrl}/update-progress`, {
      id: projectId,
      progress
    });
  }

  /**
   * Archive un projet
   */
  archiveProject(projectId: string): Observable<boolean> {
    console.log('📡 Archivage du projet:', projectId);
    
    return this.updateProject(projectId, { status: 'Archivé' }).pipe(
      map(() => true),
      catchError(() => of(false))
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

  private calculateProjectProgress(tasks: JobTask[]): number {
    if (!tasks || tasks.length === 0) return 0;
    const sum = tasks.reduce((acc, task) => acc + (task.progressPct || 0), 0);
    return Math.round(sum / tasks.length);
  }

  // =============== MAPPING ===============

  private mapProjectResponse(data: any): Project {
    return {
      id: data.id || data.Id || data.systemId || '',
      no: data.no || data.No || data.jobNo || '',
      description: data.description || '',
      status: data.status || 'Open',
      personResponsible: data.personResponsible || data.responsible || null,
      projectManager: data.projectManager || data.manager || null,
      affectationMagasin: data.affectationMagasin || data.magasin || null,
      taskCount: data.taskCount || 0,
      progress: data.progress || 0,
      createdAt: data.createdAt || new Date().toISOString()
    };
  }

  private mapProjectsResponse(data: any[]): Project[] {
    if (!Array.isArray(data)) {
      console.warn('⚠️ La réponse API n\'est pas un tableau:', data);
      return [];
    }
    return data.map(item => this.mapProjectResponse(item));
  }

  private mapToApiProject(project: Partial<Project>): any {
    const apiProject: any = {};
    
    if (project.id !== undefined) apiProject.id = project.id;
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

  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = 'Erreur de communication avec le serveur';
    
    if (error.error instanceof ErrorEvent) {
      errorMessage = `Erreur: ${error.error.message}`;
      console.error('❌ Erreur client:', error.error.message);
    } else {
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