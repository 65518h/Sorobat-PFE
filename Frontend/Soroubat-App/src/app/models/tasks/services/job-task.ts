// src/app/modules/tasks/services/job-task.service.ts

import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError, of, from } from 'rxjs';
import { map, catchError, tap, switchMap } from 'rxjs/operators';
import { JobTask } from '../models/job-task.model';
import { CacheService } from '../../../core/services/cache.service';
import { AppModeService } from '../../../core/services/app-mode.service';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  
  private baseUrl = 'http://localhost:5227/api';
  private myTasksUrl = `${this.baseUrl}/SiteManagement/my-tasks`;
  private updateProgressUrl = (taskId: string) => `${this.baseUrl}/SiteManagement/tasks/${taskId}/progress`;

  private readonly CACHE_KEY_TASKS = 'my-tasks';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private appMode: AppModeService
  ) {}

  /**
   * Récupère TOUTES les tâches avec cache offline
   */
  getMyTasks(): Observable<JobTask[]> {
    console.log('📡 GET my tasks:', this.myTasksUrl);
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_TASKS)).pipe(
      switchMap(cachedTasks => {
        if (cachedTasks && isOffline) {
          console.log('📦 Tâches: Utilisation du cache offline');
          return of(cachedTasks);
        }
        
        return this.http.get<any[]>(this.myTasksUrl).pipe(
          map(data => this.mapTasksResponse(data)),
          tap(tasks => {
            console.log(`✅ ${tasks.length} tâches récupérées`);
            this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
          }),
          catchError(error => {
            console.error('❌ Erreur getMyTasks:', error);
            if (cachedTasks) {
              return of(cachedTasks);
            }
            return of([]);
          })
        );
      })
    );
  }

  /**
   * Alias pour getMyTasks
   */
  getAllTasks(): Observable<JobTask[]> {
    return this.getMyTasks();
  }

  /**
   * Met à jour la progression d'une tâche
   */
  updateTaskProgress(taskId: string, progress: number): Observable<any> {
    const url = this.updateProgressUrl(taskId);
    console.log('📡 Mise à jour progression:', { taskId, progress });
    
    const body = { progress: progress };
    
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Sauvegarde locale');
      this.saveProgressLocally(taskId, progress);
      return of({ success: true, offline: true });
    }
    
    return this.http.patch(url, body).pipe(
      tap(() => {
        console.log('✅ Progression mise à jour');
        this.refreshCache();
      }),
      catchError(error => {
        console.error('❌ Erreur updateTaskProgress:', error);
        this.saveProgressLocally(taskId, progress);
        return throwError(() => this.getErrorMessage(error));
      })
    );
  }

  private saveProgressLocally(taskId: string, progress: number): void {
    localStorage.setItem(`task_progress_offline_${taskId}`, progress.toString());
  }

  getLocalProgress(taskId: string): number | null {
    const stored = localStorage.getItem(`task_progress_offline_${taskId}`);
    return stored !== null ? parseInt(stored, 10) : null;
  }

  applyLocalProgress(tasks: JobTask[]): JobTask[] {
    return tasks.map(task => {
      const localProgress = this.getLocalProgress(task.id);
      if (localProgress !== null && localProgress !== task.progressPct) {
        return { ...task, progressPct: localProgress };
      }
      return task;
    });
  }

  private refreshCache(): void {
    this.http.get<any[]>(this.myTasksUrl).pipe(
      map(data => this.mapTasksResponse(data)),
      tap(tasks => {
        this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
      })
    ).subscribe();
  }

  /**
   * Supprime une tâche
   */
  deleteTask(taskId: string, taskNo: string): Observable<boolean> {
    const url = `${this.baseUrl}/SiteManagement/tasks/${taskId}`;
    
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Suppression non disponible');
      return of(false);
    }
    
    return this.http.delete<void>(url).pipe(
      map(() => {
        console.log('✅ Tâche supprimée');
        this.refreshCache();
        return true;
      }),
      catchError(error => {
        console.error('❌ Erreur suppression:', error);
        return of(false);
      })
    );
  }

  // =============== MAPPING ===============

  // src/app/modules/tasks/services/job-task.service.ts

private mapTaskResponse(data: any): JobTask {
  const progress = data.progressPct || 0;
  const isBlocked = data.isBlocked || false;
  
  // Calcul du statut
  let status = 'En attente';
  if (isBlocked) {
    status = 'Bloqué';
  } else if (progress >= 100) {
    status = 'Terminé';
  } else if (progress > 0) {
    status = 'En cours';
  }
  
  // ✅ Filtrer les dates invalides (0001-01-01T00:00:00)
  const isValidDate = (date: string): boolean => {
    if (!date) return false;
    // Vérifier si c'est la date par défaut .NET
    if (date === '0001-01-01T00:00:00') return false;
    if (date.startsWith('0001-01-01')) return false;
    
    const d = new Date(date);
    return !isNaN(d.getTime()) && d.getFullYear() > 1900;
  };
  
  return {
    id: data.id || '',
    jobNo: data.jobNo || '',
    taskNo: data.taskNo || '',
    description: data.description || 'Sans description',
   
    progressPct: progress,
    isBlocked: isBlocked,
    status: status
  };
}

  private mapTasksResponse(data: any[]): JobTask[] {
    if (!Array.isArray(data)) return [];
    return data.map(item => this.mapTaskResponse(item));
  }

  // =============== GESTION DES ERREURS ===============

  private getErrorMessage(error: HttpErrorResponse): string {
    if (error.status === 0) {
      return 'Impossible de contacter le serveur.';
    }
    if (error.status === 404) {
      return 'Tâche non trouvée.';
    }
    if (error.status === 400) {
      return 'Données invalides (0-100).';
    }
    if (error.status === 500) {
      return 'Erreur interne du serveur.';
    }
    return error.message || 'Erreur de communication';
  }




  /**
 * ✅ Méthode pour précharger les tâches pour le mode offline
 */
async preloadForOffline(): Promise<boolean> {
  console.log('📦 Préchargement des tâches pour offline...');
  
  try {
    const tasks = await this.getAllTasks().toPromise();
    if (tasks && tasks.length > 0) {
      await this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
      console.log('✅ Tâches préchargées avec succès');
      return true;
    }
    console.warn('⚠️ Aucune tâche à précharger');
    return false;
  } catch (error) {
    console.error('❌ Erreur préchargement tâches:', error);
    return false;
  }
}
}