import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { JobTask } from '../models/job-task.model'; 

@Injectable({
  providedIn: 'root',
})
export class JobTaskService {
  private apiUrl = 'http://localhost:5227/api/JobTasks';

  constructor(private http: HttpClient) {}

  getTasks(): Observable<JobTask[]> {
    return this.http.get<JobTask[]>(this.apiUrl);
  }
}
