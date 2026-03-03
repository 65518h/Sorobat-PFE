// services/job-task.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JobTask } from '../models/task.model';

@Injectable({
  providedIn: 'root'
})
export class JobTaskService {
  private apiUrl = 'http://localhost:5227/api/JobTasks';

  constructor(private http: HttpClient) {}

  getTasks(): Observable<JobTask[]> {
    return this.http.get<JobTask[]>(this.apiUrl);
  }

  getTaskById(id: string): Observable<JobTask> {
    return this.http.get<JobTask>(`${this.apiUrl}/${id}`);
  }

  getTasksByProject(projectId: string): Observable<JobTask[]> {
    return this.http.get<JobTask[]>(`${this.apiUrl}/project/${projectId}`);
  }

  // ✅ AJOUTER CES MÉTHODES MANQUANTES
  updateTaskProgress(id: string, progress: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/${id}/progress`, progress, {
      headers: { 'Content-Type': 'application/json' }
    });
  }

  updateTask(id: string, task: Partial<JobTask>): Observable<JobTask> {
    return this.http.put<JobTask>(`${this.apiUrl}/${id}`, task);
  }

  deleteTask(id: string): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }

  createTask(task: Partial<JobTask>): Observable<JobTask> {
    return this.http.post<JobTask>(this.apiUrl, task);
  }
}