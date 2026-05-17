// src/app/models/tasks/services/job-task.ts

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { JobTask } from '../models/job-task.model';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  
  private baseUrl = 'http://localhost:5227/api';
  private myTasksUrl = `${this.baseUrl}/SiteManagement/my-tasks`;

  constructor(private http: HttpClient) {}

  getMyTasks(): Observable<JobTask[]> {
    console.log('📡 Récupération des tâches...');
    
    return this.http.get<any[]>(this.myTasksUrl).pipe(
      map((response: any[]): JobTask[] => {
        if (!Array.isArray(response)) return [];
        return response.map(item => this.mapToJobTask(item));
      }),
      catchError((error): Observable<JobTask[]> => {
        console.error('❌ Erreur getMyTasks:', error);
        return of([]);
      })
    );
  }

  getTasksByProjectId(projectId: string): Observable<JobTask[]> {
    console.log('📡 Récupération des tâches par projet:', projectId);
    return this.getMyTasks();
  }

  private mapToJobTask(data: any): JobTask {
    // Calculer le pourcentage d'avancement théorique
    let taskProgressPct = 0;
    if (data.initialQuantity && data.initialQuantity > 0 && data.quantityShipped) {
      taskProgressPct = Math.round((data.quantityShipped / data.initialQuantity) * 100);
    }
    
    // Déterminer le statut (obligatoire)
    const progress = data.progressPct || 0;
    let status = 'En attente';
    if (progress >= 100) status = 'Terminé';
    else if (progress > 0) status = 'En cours';
    
    return {
      id: data.id || '',
      jobNo: data.jobNo || '',
      taskNo: data.taskNo || '',
      description: data.description || '',
      dateDebut: data.dateDebut,
      dateFin: data.dateFin,
      progressPct: progress,
      taskProgressPct: taskProgressPct,
      quantityShipped: data.quantityShipped || 0,
      initialQuantity: data.initialQuantity || 0,
      initialUoM: data.initialUoM || '',
      initialAmount: data.initialAmount || 0,
      isBlocked: data.isBlocked || false,
      status: status  // ✅ status toujours présent
    };
  }
}