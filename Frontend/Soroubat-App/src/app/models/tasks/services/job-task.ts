// src/app/modules/tasks/services/job-task.ts

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

  // Clé de cache
  private readonly CACHE_KEY_TASKS = 'my-tasks';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private appMode: AppModeService
  ) {}

  /**
   * GET - Récupère TOUTES les tâches avec cache offline
   */
  getMyTasks(): Observable<JobTask[]> {
    console.log('📡 GET my tasks:', this.myTasksUrl);
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_TASKS)).pipe(
      switchMap(cachedTasks => {
        // Utiliser le cache si disponible et en mode offline
        if (cachedTasks && isOffline) {
          console.log('📦 Tâches: Utilisation du cache offline');
          return of(cachedTasks);
        }
        
        // Sinon, appeler l'API
        return this.http.get<any[]>(this.myTasksUrl).pipe(
          map(data => this.mapTasksResponse(data)),
          tap(tasks => {
            console.log(`✅ ${tasks.length} tâches récupérées`);
            // Sauvegarder en cache
            this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
          }),
          catchError(error => {
            console.error('❌ Erreur getMyTasks:', error);
            // En cas d'erreur, utiliser le cache si disponible
            if (cachedTasks) {
              console.log('⚠️ Utilisation du cache (mode dégradé)');
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
   * Récupère les tâches d'un projet spécifique
   */
  getTasksByProjectId(projectId: string): Observable<JobTask[]> {
    return this.getMyTasks().pipe(
      map(tasks => tasks.filter(task => task.jobNo === projectId || task.id === projectId))
    );
  }

  /**
   * ✅ Met à jour la progression d'une tâche
   * - En ligne: appel API + cache
   * - Hors ligne: sauvegarde locale uniquement
   */
  updateTaskProgress(taskId: string, progress: number): Observable<any> {
    const url = this.updateProgressUrl(taskId);
    console.log('📡 Mise à jour progression:', { taskId, progress, url });
    
    const body = { progress: progress };
    
    // Si offline, sauvegarder localement uniquement
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Sauvegarde locale de la progression');
      this.saveProgressLocally(taskId, progress);
      return of({ success: true, offline: true, message: 'Sauvegardé localement' });
    }
    
    // Sinon, appeler l'API
    return this.http.patch(url, body).pipe(
      tap(response => {
        console.log('✅ Réponse reçue:', response);
        // Mettre à jour le cache après modification
        this.refreshCache();
      }),
      catchError(error => {
        console.error('❌ Erreur updateTaskProgress:', error);
        // En cas d'erreur API, sauvegarder localement
        this.saveProgressLocally(taskId, progress);
        return throwError(() => this.getErrorMessage(error));
      })
    );
  }

  /**
   * ✅ Sauvegarde la progression localement (hors ligne)
   */
  private saveProgressLocally(taskId: string, progress: number): void {
    localStorage.setItem(`task_progress_offline_${taskId}`, progress.toString());
    console.log(`💾 Progression sauvegardée localement: ${taskId} = ${progress}%`);
  }

  /**
   * ✅ Récupère la progression locale (hors ligne)
   */
  getLocalProgress(taskId: string): number | null {
    const stored = localStorage.getItem(`task_progress_offline_${taskId}`);
    if (stored !== null) {
      return parseInt(stored, 10);
    }
    return null;
  }

  /**
   * ✅ Applique les progressions locales aux tâches
   */
  applyLocalProgress(tasks: JobTask[]): JobTask[] {
    return tasks.map(task => {
      const localProgress = this.getLocalProgress(task.id);
      if (localProgress !== null && localProgress !== task.progressPct) {
        console.log(`🔄 Application progression locale pour ${task.taskNo}: ${localProgress}%`);
        return { ...task, progressPct: localProgress };
      }
      return task;
    });
  }

  /**
   * ✅ Rafraîchit le cache après modification
   */
  private refreshCache(): void {
    this.http.get<any[]>(this.myTasksUrl).pipe(
      map(data => this.mapTasksResponse(data)),
      tap(tasks => {
        this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
        console.log('💾 Cache des tâches mis à jour');
      })
    ).subscribe();
  }

  /**
   * ✅ Méthode pour précharger les tâches offline
   */
  async preloadForOffline(): Promise<boolean> {
    console.log('📦 Préchargement des tâches pour offline...');
    
    try {
      const tasks = await this.getAllTasks().toPromise();
      if (tasks) {
        await this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
        console.log('✅ Tâches préchargées avec succès');
        return true;
      }
      return false;
    } catch (error) {
      console.error('❌ Erreur préchargement tâches:', error);
      return false;
    }
  }

  /**
   * ✅ Supprime une tâche
   */
  deleteTask(taskId: string, taskNo: string): Observable<boolean> {
    const url = `${this.baseUrl}/SiteManagement/tasks/${taskId}`;
    
    if (this.appMode.isOffline) {
      console.log('📱 Mode offline - Suppression non disponible');
      return of(false);
    }
    
    return this.http.delete<void>(url).pipe(
      map(() => {
        console.log('✅ Tâche supprimée avec succès');
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

  private mapTaskResponse(data: any): JobTask {
    const progress = data.progressPct || 0;
    const isBlocked = data.isBlocked || false;
    
    let status = 'En attente';
    if (isBlocked) {
      status = 'Bloqué';
    } else if (progress >= 100) {
      status = 'Terminé';
    } else if (progress > 0) {
      status = 'En cours';
    }
    
    let taskProgressPct = data.taskProgressPct || 0;
    if (data.initialQuantity > 0 && data.quantityShipped > 0) {
      taskProgressPct = Math.round((data.quantityShipped / data.initialQuantity) * 100);
    }
    
    return {
      id: data.id || '',
      jobNo: data.jobNo || '',
      taskNo: data.taskNo || '',
      description: data.description || 'Sans description',
      status: status,
      dateDebut: data.dateDebut && data.dateDebut !== '0001-01-01T00:00:00' ? data.dateDebut : null,
      dateFin: data.dateFin && data.dateFin !== '0001-01-01T00:00:00' ? data.dateFin : null,
      progressPct: progress,
      taskProgressPct: taskProgressPct,
      quantityShipped: data.quantityShipped || 0,
      initialQuantity: data.initialQuantity || 0,
      initialUoM: data.initialUoM || '',
      initialAmount: data.initialAmount || 0,
      isBlocked: isBlocked
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

  private getErrorMessage(error: HttpErrorResponse): string {
    if (error.status === 0) {
      return 'Impossible de contacter le serveur. Vérifiez que le backend est démarré.';
    }
    if (error.status === 404) {
      return 'Tâche non trouvée. Vérifiez l\'identifiant de la tâche.';
    }
    if (error.status === 400) {
      return 'Données invalides. Vérifiez la progression (0-100).';
    }
    if (error.status === 500) {
      return 'Erreur interne du serveur.';
    }
    return error.message || 'Erreur de communication avec le serveur';
  }
}