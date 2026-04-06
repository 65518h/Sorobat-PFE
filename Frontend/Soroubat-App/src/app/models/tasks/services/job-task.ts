// src/app/modules/tasks/services/job-task.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError, of, forkJoin } from 'rxjs';
import { map, catchError, switchMap, tap } from 'rxjs/operators';
import { JobTask } from '../models/job-task.model';
import { ProjectService } from '../../projects/services/project';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  
  // URL - SiteManagement
  private baseUrl = 'http://localhost:5227/api';
  private siteManagementUrl = `${this.baseUrl}/SiteManagement`;

  constructor(
    private http: HttpClient,
    private projectService?: ProjectService // Optionnel pour éviter les dépendances circulaires
  ) {}

  /**
   * GET /api/SiteManagement - Récupère tous les projets (via ProjectService)
   * Ou utilise directement l'API
   */
  getProjects(): Observable<any[]> {
    return this.http.get<any[]>(this.siteManagementUrl).pipe(
      catchError(this.handleError)
    );
  }

  /**
   * GET /api/SiteManagement/{jobNo}/tasks - Récupère les tâches d'un projet
   */
  getTasksByProject(jobNo: string): Observable<JobTask[]> {
    const encodedJobNo = encodeURIComponent(jobNo);
    const url = `${this.siteManagementUrl}/${encodedJobNo}/tasks`;
    
    console.log('📡 GET tasks by project:', url);
    
    return this.http.get<any[]>(url).pipe(
      map(data => this.mapTasksResponse(data)),
      catchError(error => {
        console.error('❌ Erreur getTasksByProject:', error);
        return of([]);
      })
    );
  }

  /**
   * GET /api/SiteManagement/{jobNo}/tasks/{taskNo} - Récupère une tâche spécifique
   */
  getTaskById(jobNo: string, taskNo: string): Observable<JobTask | null> {
    const encodedJobNo = encodeURIComponent(jobNo);
    const encodedTaskNo = encodeURIComponent(taskNo);
    const url = `${this.siteManagementUrl}/${encodedJobNo}/tasks/${encodedTaskNo}`;
    
    return this.http.get<any>(url).pipe(
      map(data => this.mapTaskResponse(data)),
      catchError(() => of(null))
    );
  }

  /**
   * GET /api/SiteManagement - Récupère TOUTES les tâches de tous les projets
   */
  getAllTasks(): Observable<JobTask[]> {
    console.log('📡 Récupération de toutes les tâches...');
    
    return this.getProjects().pipe(
      switchMap(projects => {
        if (!projects || projects.length === 0) {
          return of([]);
        }
        
        const tasksObservables = projects.map(project => 
          this.getTasksByProject(project.no).pipe(
            catchError(() => of([]))
          )
        );
        
        return forkJoin(tasksObservables).pipe(
          map(tasksArrays => tasksArrays.flat())
        );
      }),
      catchError(error => {
        console.error('❌ Erreur getAllTasks:', error);
        return of([]);
      })
    );
  }

  /**
   * PATCH /api/SiteManagement/update-progress - Met à jour la progression d'une tâche
   * ✅ UTILISE L'ID DE LA TÂCHE (SystemId)
   */
  updateTaskProgress(taskId: string, progress: number): Observable<any> {
    const url = `${this.siteManagementUrl}/update-progress`;
    
    console.log('📡 Mise à jour progression:', { 
      url, 
      taskId, 
      progress 
    });
    
    const body = {
      id: taskId,      // ← SystemId de Business Central
      progress: progress
    };
    
    return this.http.patch(url, body).pipe(
      tap(response => console.log('✅ Réponse reçue:', response)),
      catchError(error => {
        console.error('❌ Erreur updateTaskProgress:', error);
        
        let errorMessage = '❌ Erreur de mise à jour';
        if (error.status === 404) {
          errorMessage = '❌ Tâche non trouvée';
        } else if (error.status === 400) {
          errorMessage = '❌ Données invalides';
        } else if (error.status === 500) {
          errorMessage = '❌ Erreur serveur';
        }
        
        return throwError(() => new Error(errorMessage));
      })
    );
  }

  /**
   * Version alternative avec jobNo et taskNo (pour compatibilité)
   * Récupère d'abord l'id de la tâche puis appelle updateTaskProgress
   */
  updateTaskProgressByJobAndTask(jobNo: string, taskNo: string, progress: number): Observable<any> {
    console.log('📡 Mise à jour par jobNo/taskNo:', { jobNo, taskNo, progress });
    
    return this.getTasksByProject(jobNo).pipe(
      map(tasks => tasks.find(t => t.taskNo === taskNo)),
      switchMap(task => {
        if (!task) {
          throw new Error(`Tâche non trouvée: ${jobNo} - ${taskNo}`);
        }
        return this.updateTaskProgress(task.id, progress);
      }),
      catchError(error => {
        console.error('❌ Erreur updateTaskProgressByJobAndTask:', error);
        return throwError(() => error);
      })
    );
  }

  /**
   * DELETE /api/SiteManagement/{jobNo}/tasks/{taskNo} - Supprime une tâche
   */
  deleteTask(jobNo: string, taskNo: string): Observable<boolean> {
    const encodedJobNo = encodeURIComponent(jobNo);
    const encodedTaskNo = encodeURIComponent(taskNo);
    const url = `${this.siteManagementUrl}/${encodedJobNo}/tasks/${encodedTaskNo}`;
    
    console.log('📡 DELETE task:', url);
    
    return this.http.delete<void>(url).pipe(
      map(() => {
        console.log('✅ Tâche supprimée avec succès');
        return true;
      }),
      catchError(error => {
        console.error('❌ Erreur suppression:', error);
        return of(false);
      })
    );
  }

  /**
   * DELETE /api/SiteManagement/tasks/{taskId} - Supprime une tâche par son ID
   */
  deleteTaskById(taskId: string): Observable<boolean> {
    const url = `${this.siteManagementUrl}/tasks/${encodeURIComponent(taskId)}`;
    
    console.log('📡 DELETE task by id:', url);
    
    return this.http.delete<void>(url).pipe(
      map(() => {
        console.log('✅ Tâche supprimée avec succès');
        return true;
      }),
      catchError(error => {
        console.error('❌ Erreur suppression:', error);
        return of(false);
      })
    );
  }

  /**
   * POST /api/SiteManagement/{jobNo}/tasks - Crée une nouvelle tâche
   */
  createTask(jobNo: string, task: Partial<JobTask>): Observable<JobTask> {
    const encodedJobNo = encodeURIComponent(jobNo);
    const url = `${this.siteManagementUrl}/${encodedJobNo}/tasks`;
    
    console.log('📡 POST create task:', url, task);
    
    return this.http.post<any>(url, task).pipe(
      map(data => this.mapTaskResponse(data)),
      catchError(this.handleError)
    );
  }

  /**
   * PUT /api/SiteManagement/{jobNo}/tasks/{taskNo} - Met à jour une tâche
   */
  updateTask(jobNo: string, taskNo: string, task: Partial<JobTask>): Observable<JobTask> {
    const encodedJobNo = encodeURIComponent(jobNo);
    const encodedTaskNo = encodeURIComponent(taskNo);
    const url = `${this.siteManagementUrl}/${encodedJobNo}/tasks/${encodedTaskNo}`;
    
    console.log('📡 PUT update task:', url, task);
    
    return this.http.put<any>(url, task).pipe(
      map(data => this.mapTaskResponse(data)),
      catchError(this.handleError)
    );
  }

  // =============== MAPPING ===============

  private mapTaskResponse(data: any): JobTask {
    return {
      id: data.id || data.Id || '',                    // ← SystemId de BC
      jobNo: data.jobNo || '',
      taskNo: data.taskNo || '',
      description: data.description || '',
      dateDebut: data.dateDebut || null,
      dateFin: data.dateFin || null,
      progressPct: data.progressPct || data.progress || 0,
      taskProgressPct: data.taskProgressPct || 0,
      quantityShipped: data.quantityShipped || 0,
      initialQuantity: data.initialQuantity || 0,
      initialUoM: data.initialUoM || '',
      initialAmount: data.initialAmount || 0,
      isBlocked: data.isBlocked || false
    };
  }

  private mapTasksResponse(data: any[]): JobTask[] {
    if (!Array.isArray(data)) {
      console.warn('⚠️ mapTasksResponse: data n\'est pas un tableau', data);
      return [];
    }
    return data.map(item => this.mapTaskResponse(item));
  }

  // =============== GESTION DES ERREURS ===============

  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = 'Erreur de communication avec le serveur';
    
    if (error.error instanceof ErrorEvent) {
      errorMessage = `Erreur: ${error.error.message}`;
      console.error('❌ Erreur client:', error.error.message);
    } else {
      console.error('❌ Erreur serveur:', {
        status: error.status,
        message: error.message,
        url: error.url,
        error: error.error
      });
      
      if (error.status === 0) {
        errorMessage = 'Impossible de contacter le serveur. Vérifiez que le backend est démarré.';
      } else if (error.status === 404) {
        errorMessage = 'Ressource non trouvée.';
      } else if (error.status === 400) {
        errorMessage = 'Requête invalide.';
      } else if (error.status === 500) {
        errorMessage = 'Erreur interne du serveur.';
      }
    }
    
    return throwError(() => new Error(errorMessage));
  }
}