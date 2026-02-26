import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { JobTaskService } from './services/job-task';
import { JobTask } from './models/job-task.model';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './app.html', // Vérifie bien que c'est app.html et non app.component.html
  styleUrl: './app.scss',
})
export class AppComponent implements OnInit {
  tasks: JobTask[] = [];

  constructor(private jobTaskService: JobTaskService) {}

  ngOnInit(): void {
    this.jobTaskService.getTasks().subscribe({
      next: (data) => {
        this.tasks = data;
        console.log('Données reçues :', data);
      },
      error: (err) => console.error("Erreur de connexion à l'API .NET :", err),
    });
  }
}
