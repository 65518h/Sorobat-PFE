// src/app/modules/projects/services/project.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of, forkJoin, from } from 'rxjs';
import { map, catchError, tap, switchMap } from 'rxjs/operators';
import { Project } from '../models/project.model';
import { JobTask } from '../../tasks/models/job-task.model';
import { CacheService } from '../../../core/services/cache.service';
import { AppModeService } from '../../../core/services/app-mode.service';

@Injectable({
  providedIn: 'root'
})
export class ProjectService {
  
  private baseUrl = 'http://localhost:5227/api';
  private myProjectUrl = `${this.baseUrl}/SiteManagement/my-project`;
  private myTasksUrl = `${this.baseUrl}/SiteManagement/my-tasks`;

  // Clés de cache
  private readonly CACHE_KEY_PROJECT = 'my-project';
  private readonly CACHE_KEY_TASKS = 'my-tasks';
  private readonly CACHE_KEY_PROJECT_WITH_TASKS = 'my-project-with-tasks';

  constructor(
    private http: HttpClient,
    private cacheService: CacheService,
    private appMode: AppModeService
  ) {}

  /**
   *  Récupère le projet avec cache offline
   */
  getMyProject(): Observable<Project | null> {
    console.log(' Récupération du projet utilisateur:', this.myProjectUrl);
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_PROJECT)).pipe(
      switchMap(cachedProject => {
        // Utiliser le cache si disponible et en mode offline
        if (cachedProject && isOffline) {
          console.log(' Projet: Utilisation du cache offline');
          return of(cachedProject);
        }
        
        // Sinon, appeler l'API
        return this.http.get<any>(this.myProjectUrl).pipe(
          map((response: any): Project | null => {
            if (!response) return null;
            
            // Log pour debug - voir ce que le backend envoie
            console.log(' Réponse API projet:', {
              id: response.id,
              no: response.no,
              description: response.description,
              status: response.status,
              affectationMagasin: response.affectationMagasin,
              startingDate: response.startingDate,
              endingDate: response.endingDate
            });
            
            const project: Project = {
              id: response.id || '',
              no: response.no || '',
              description: response.description || '',
              status: response.status || 'Open',
              affectationMagasin: response.affectationMagasin || 'Non affecté',
              //  AJOUTER les dates
              startingDate: response.startingDate || null,
              endingDate: response.endingDate || null,
              taskCount: 0,
              progress: 0
            };
            
            // Sauvegarder en cache
            this.cacheService.saveToCache(this.CACHE_KEY_PROJECT, project);
            
            return project;
          }),
          catchError((error): Observable<null> => {
            console.error(' Erreur getMyProject:', error);
            
            // En cas d'erreur, essayer le cache
            if (cachedProject) {
              return of(cachedProject);
            }
            return of(null);
          })
        );
      })
    );
  }

  /**
   *  Récupère les tâches avec cache offline
   */
  getMyTasks(): Observable<JobTask[]> {
    console.log(' Récupération des tâches utilisateur:', this.myTasksUrl);
    
    const isOffline = this.appMode.isOffline;
    
    return from(this.cacheService.getFromCache(this.CACHE_KEY_TASKS)).pipe(
      switchMap(cachedTasks => {
        // Utiliser le cache si disponible et en mode offline
        if (cachedTasks && isOffline) {
          console.log(' Tâches: Utilisation du cache offline');
          return of(cachedTasks);
        }
        
        // Sinon, appeler l'API
        return this.http.get<any[]>(this.myTasksUrl).pipe(
          map((response: any[]): JobTask[] => {
            if (!Array.isArray(response)) return [];
            console.log(' Réponse API tâches:', response.length, 'tâches');
            const tasks = response.map(item => this.mapToJobTask(item));
            
            // Sauvegarder en cache
            this.cacheService.saveToCache(this.CACHE_KEY_TASKS, tasks);
            
            return tasks;
          }),
          catchError((error): Observable<JobTask[]> => {
            console.error(' Erreur getMyTasks:', error);
            
            // En cas d'erreur, essayer le cache
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
 *  Récupère le projet avec ses tâches (version optimisée avec cache)
 */
getMyProjectWithTasks(): Observable<{ project: Project | null; tasks: JobTask[] }> {
  console.log(' Récupération du projet et ses tâches...');
  
  const isOffline = this.appMode.isOffline;
  
  // Essayer de récupérer les données du cache d'abord
  return from(this.cacheService.getFromCache(this.CACHE_KEY_PROJECT_WITH_TASKS)).pipe(
    switchMap(cachedData => {
      // Utiliser le cache si disponible et en mode offline
      if (cachedData && isOffline) {
        console.log(' Projet+tâches: Utilisation du cache offline');
        return of(cachedData);
      }
      
      // Sinon, charger depuis l'API
      return forkJoin({
        project: this.getMyProject(),
        tasks: this.getMyTasks()
      }).pipe(
        map(({ project, tasks }) => {
          // Calculer l'avancement moyen du projet
          const avgProgress = this.calculateProjectProgress(tasks);
          
          //  Calculer le statut réel du projet basé sur les tâches
          const calculatedStatus = this.calculateProjectStatus(tasks);
          
          if (project) {
            project.progress = avgProgress;
            project.taskCount = tasks.length;
            project.status = calculatedStatus;  // ← Remplacer par le statut calculé
          }
          
          const result = { project, tasks };
          
          // Sauvegarder en cache
          this.cacheService.saveToCache(this.CACHE_KEY_PROJECT_WITH_TASKS, result);
          
          console.log(` Projet ${project?.no}: ${tasks.length} tâches, avancement = ${avgProgress}%, statut = ${calculatedStatus}`);
          console.log(`   - Terminées: ${tasks.filter(t => t.progressPct >= 100).length}`);
          console.log(`   - En cours: ${tasks.filter(t => t.progressPct > 0 && t.progressPct < 100).length}`);
          console.log(`   - En attente: ${tasks.filter(t => t.progressPct === 0).length}`);
          console.log(`   - Bloquées: ${tasks.filter(t => t.isBlocked).length}`);
          
          return result;
        }),
        catchError(error => {
          console.error(' Erreur getMyProjectWithTasks:', error);
          
          // En cas d'erreur, essayer le cache
          if (cachedData) {
            return of(cachedData);
          }
          return of({ project: null, tasks: [] });
        })
      );
    })
  );
}

  
/**
 *  Rafraîchit les données (force l'appel API)
 */
refreshProject(): Observable<{ project: Project | null; tasks: JobTask[] }> {
  console.log(' Rafraîchissement forcé du projet...');
  
  // Invalider le cache
  this.cacheService.invalidateCache(this.CACHE_KEY_PROJECT);
  this.cacheService.invalidateCache(this.CACHE_KEY_TASKS);
  this.cacheService.invalidateCache(this.CACHE_KEY_PROJECT_WITH_TASKS);
  
  // Recharger
  return forkJoin({
    project: this.getMyProject(),
    tasks: this.getMyTasks()
  }).pipe(
    map(({ project, tasks }) => {
      const avgProgress = this.calculateProjectProgress(tasks);
      const calculatedStatus = this.calculateProjectStatus(tasks);
      
      if (project) {
        project.progress = avgProgress;
        project.taskCount = tasks.length;
        project.status = calculatedStatus;
      }
      
      const result = { project, tasks };
      this.cacheService.saveToCache(this.CACHE_KEY_PROJECT_WITH_TASKS, result);
      
      console.log(` Rafraîchi - Projet ${project?.no}: statut = ${calculatedStatus}, avancement = ${avgProgress}%`);
      
      return result;
    }),
    catchError(error => {
      console.error(' Erreur refreshProject:', error);
      return of({ project: null, tasks: [] });
    })
  );
}
  /**
   * Calcule l'avancement du projet basé sur ses tâches
   */
  private calculateProjectProgress(tasks: JobTask[]): number {
    if (!tasks || tasks.length === 0) {
      return 0;
    }
    
    const totalProgress = tasks.reduce((sum, task) => sum + (task.progressPct || 0), 0);
    const averageProgress = totalProgress / tasks.length;
    
    return Math.round(averageProgress);
  }

  /**
   * Pour le dashboard - retourne un tableau avec le projet unique
   */
  getProjects(): Observable<Project[]> {
    return this.getMyProject().pipe(
      map(project => project ? [project] : [])
    );
  }

  getAllProjects(): Observable<Project[]> {
    return this.getProjects();
  }

  getProjectById(id: string): Observable<Project | null> {
    return this.getMyProject().pipe(
      map(project => project?.id === id ? project : null)
    );
  }

  getProjectOnly(): Observable<Project | null> {
    return this.getMyProject();
  }

  getTasksOnly(): Observable<JobTask[]> {
    return this.getMyTasks();
  }

  updateTaskProgress(taskId: string, progress: number): Observable<any> {
    console.log(` Mise à jour progression tâche ${taskId}: ${progress}%`);
    return of({ success: true });
  }

  /**
   *  Méthode pour précharger les données offline
   */
  async preloadForOffline(): Promise<boolean> {
    console.log(' Préchargement des données projet pour offline...');
    
    try {
      // Forcer le chargement depuis l'API
      const result = await this.getMyProjectWithTasks().toPromise();
      
      if (result) {
        console.log(' Données projet préchargées avec succès');
        return true;
      }
      return false;
    } catch (error) {
      console.error(' Erreur préchargement projet:', error);
      return false;
    }
  }

  private mapToJobTask(data: any): JobTask {
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
      description: data.description || '',
      status: status,
     
     
      progressPct: progress,
     
      isBlocked: isBlocked
    };
  }






/**
 *  Détermine le statut du projet en fonction de l'avancement des tâches
 */
private calculateProjectStatus(tasks: JobTask[]): string {
  if (!tasks || tasks.length === 0) {
    return 'En attente';
  }
  
  const totalTasks = tasks.length;
  const completedTasks = tasks.filter(t => (t.progressPct || 0) >= 100).length;
  const inProgressTasks = tasks.filter(t => {
    const progress = t.progressPct || 0;
    return progress > 0 && progress < 100;
  }).length;
  const blockedTasks = tasks.filter(t => t.isBlocked === true).length;
  
  // Si toutes les tâches sont terminées
  if (completedTasks === totalTasks) {
    return 'Terminé';
  }
  
  // Si des tâches sont bloquées
  if (blockedTasks > 0) {
    return 'Bloqué';
  }
  
  // Si au moins une tâche est en cours
  if (inProgressTasks > 0 || (completedTasks > 0 && completedTasks < totalTasks)) {
    return 'En cours';
  }
  
  // Si aucune tâche n'a commencé
  return 'En attente';
}
}