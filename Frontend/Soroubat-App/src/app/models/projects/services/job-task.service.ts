// modules/projects/services/job-task.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError, of } from 'rxjs';
import { map, catchError, tap } from 'rxjs/operators';
import { JobTask } from '../models/job-task.model';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  
  private baseUrl = 'http://localhost:5227/api';

  constructor(private http: HttpClient) {}

  /**
   * Récupérer les tâches d'un projet
   * GET /api/Projects/{projectId}/tasks
   */
  getTasksByProject(projectId: string): Observable<JobTask[]> {
    const url = `${this.baseUrl}/Projects/${encodeURIComponent(projectId)}/tasks`;
    console.log('📡 GET tasks:', url);
    
    return this.http.get<any[]>(url).pipe(
      map(data => this.mapTasksResponse(data)),
      catchError(error => {
        console.error('❌ Erreur getTasksByProject:', error);
        return of([]);
      })
    );
  }

  /**
   * ✅ METTRE À JOUR LA PROGRESSION D'UNE TÂCHE
   * Version CORRECTE basée sur le test Swagger
   * PATCH /api/Projects/update-progress
   */
  updateTaskProgress(jobNo: string, taskNo: string, progress: number): Observable<any> {
    // URL correcte d'après Swagger
    const url = `${this.baseUrl}/Projects/update-progress`;
    
    console.log('📡 Mise à jour progression:', {
      url,
      jobNo,
      taskNo,
      progress
    });
    
    // Corps de la requête conforme au test Swagger
    const body = {
      jobNo: jobNo,
      taskNo: taskNo,
      progress: progress
    };
    
    return this.http.patch(url, body).pipe(
      tap(response => console.log('✅ Réponse reçue:', response)),
      catchError(error => {
        console.error('❌ Erreur updateTaskProgress:', error);
        
        // Message d'erreur plus explicite
        let errorMessage = '❌ Erreur de mise à jour';
        if (error.status === 404) {
          errorMessage = '❌ API non trouvée';
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
   * Créer une tâche
   * POST /api/Projects/{projectId}/tasks
   */
  createTask(projectId: string, task: Partial<JobTask>): Observable<JobTask> {
    const url = `${this.baseUrl}/Projects/${encodeURIComponent(projectId)}/tasks`;
    console.log('📡 POST createTask:', url, task);
    
    return this.http.post<any>(url, task).pipe(
      tap(response => console.log('✅ Tâche créée:', response)),
      map(data => this.mapTaskResponse(data)),
      catchError(this.handleError)
    );
  }

  /**
   * Mettre à jour une tâche
   * PUT /api/Projects/{projectId}/tasks/{taskNo}
   */
  updateTask(projectId: string, taskNo: string, task: Partial<JobTask>): Observable<JobTask> {
    const url = `${this.baseUrl}/Projects/${encodeURIComponent(projectId)}/tasks/${encodeURIComponent(taskNo)}`;
    console.log('📡 PUT updateTask:', url, task);
    
    return this.http.put<any>(url, task).pipe(
      tap(response => console.log('✅ Tâche mise à jour:', response)),
      map(data => this.mapTaskResponse(data)),
      catchError(this.handleError)
    );
  }

  /**
   * Supprimer une tâche
   * DELETE /api/Projects/{projectId}/tasks/{taskNo}
   */
  deleteTask(projectId: string, taskNo: string): Observable<boolean> {
    const url = `${this.baseUrl}/Projects/${encodeURIComponent(projectId)}/tasks/${encodeURIComponent(taskNo)}`;
    console.log('📡 DELETE deleteTask:', url);
    
    return this.http.delete<void>(url).pipe(
      tap(() => console.log('✅ Tâche supprimée')),
      map(() => true),
      catchError(() => of(false))
    );
  }

  /**
   * Obtenir les statistiques des tâches d'un projet
   */
  getTasksStats(projectId: string): Observable<{
    total: number;
    completed: number;
    inProgress: number;
    blocked: number;
    overdue: number;
    averageProgress: number;
    totalAmount: number;
  }> {
    return this.getTasksByProject(projectId).pipe(
      map(tasks => {
        const completed = tasks.filter(t => t.progressPct === 100).length;
        const inProgress = tasks.filter(t => t.progressPct > 0 && t.progressPct < 100).length;
        const blocked = tasks.filter(t => t.isBlocked).length;
        const overdue = tasks.filter(t => this.isOverdue(t)).length;
        
        const totalProgress = tasks.reduce((sum, t) => sum + t.progressPct, 0);
        const averageProgress = tasks.length > 0 ? Math.round(totalProgress / tasks.length) : 0;
        const totalAmount = tasks.reduce((sum, t) => sum + (t.initialAmount || 0), 0);
        
        return {
          total: tasks.length,
          completed,
          inProgress,
          blocked,
          overdue,
          averageProgress,
          totalAmount
        };
      })
    );
  }

  /**
   * Vérifier si une tâche est en retard
   */
  isOverdue(task: JobTask): boolean {
    return !task.isBlocked && 
           task.progressPct < 100 && 
           !!task.dateFin && 
           new Date(task.dateFin) < new Date();
  }

  /**
   * Filtrer les tâches par statut
   */
  filterTasksByStatus(tasks: JobTask[], status: string): JobTask[] {
    switch (status) {
      case 'completed':
        return tasks.filter(t => t.progressPct === 100);
      case 'in-progress':
        return tasks.filter(t => t.progressPct > 0 && t.progressPct < 100);
      case 'blocked':
        return tasks.filter(t => t.isBlocked);
      case 'overdue':
        return tasks.filter(t => this.isOverdue(t));
      default:
        return tasks;
    }
  }

  // =============== MAPPING ===============

 private mapTaskResponse(data: any): JobTask {
  // Calculer l'avancement théorique seulement si les quantités sont valides
  let taskProgressPct = 0;
  
  if (data.initialQuantity && data.initialQuantity > 0) {
    taskProgressPct = ((data.quantityShipped || 0) / data.initialQuantity) * 100;
  }
  
  return {
    jobNo: data.jobNo || '',
    taskNo: data.taskNo || '',
    description: data.description || '',
    dateDebut: data.dateDebut,
    dateFin: data.dateFin,
    progressPct: data.progressPct || 0,
    taskProgressPct: taskProgressPct, // ← Calculé uniquement si quantité > 0
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

  private handleError(error: HttpErrorResponse): Observable<never> {
    console.error('❌ Erreur JobTaskService:', {
      status: error.status,
      message: error.message,
      url: error.url,
      error: error.error
    });
    
    let errorMessage = 'Erreur de communication avec le serveur';
    if (error.status === 404) {
      errorMessage = 'Ressource non trouvée';
    } else if (error.status === 400) {
      errorMessage = 'Requête invalide';
    } else if (error.status === 500) {
      errorMessage = 'Erreur interne du serveur';
    }
    
    return throwError(() => new Error(errorMessage));
  }
}