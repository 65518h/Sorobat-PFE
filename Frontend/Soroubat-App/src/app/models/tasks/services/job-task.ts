// src/app/services/job-task.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin } from 'rxjs';
import { map, switchMap } from 'rxjs/operators';
import { JobTask } from '../models/job-task.model';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  private apiUrl = 'http://localhost:5227/api/Projects';

  constructor(private http: HttpClient) {}

  // Récupérer tous les projets
  getProjects(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  // Récupérer toutes les tâches
  getAllTasks(): Observable<JobTask[]> {
    return this.getProjects().pipe(
      switchMap(projects => {
        const tasksObservables = projects.map(project => 
          this.getTasksByProject(project.no)
        );
        return forkJoin(tasksObservables).pipe(
          map(tasksArrays => tasksArrays.flat())
        );
      })
    );
  }

  // Récupérer les tâches d'un projet
  getTasksByProject(jobNo: string): Observable<JobTask[]> {
    const encodedJobNo = encodeURIComponent(jobNo);
    return this.http.get<JobTask[]>(`${this.apiUrl}/${encodedJobNo}/tasks`);
  }

  // Mettre à jour la progression
  updateTaskProgress(jobNo: string, taskNo: string, progress: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/update-progress`, {
      jobNo: jobNo,
      taskNo: taskNo,
      progress: progress
    });
  }

  // ✅ Correction: retourne Observable<void>
  deleteTask(taskNo: string): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${taskNo}`);
  }
}