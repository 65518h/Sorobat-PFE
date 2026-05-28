//import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
//import { CommonModule } from '@angular/common';
//import { JobTaskService } from './services/job-task';
//import { JobTask } from './models/job-task.model';

//@Component({
  //selector: 'app-root',
  //standalone: true,
  //imports: [CommonModule],
  //templateUrl: './app.html',
  //styleUrl: './app.css',
//})
//export class AppComponent implements OnInit {
  //tasks: JobTask[] = [];

  //constructor(
   // private jobTaskService: JobTaskService,
    //private cdr: ChangeDetectorRef // Ajout du détecteur de changements
  //) {}

 // ngOnInit(): void {
   // this.loadTasks();
  //}

 // loadTasks(): void {
   // this.jobTaskService.getTasks().subscribe({
     // next: (data) => {
        // On utilise [...] pour créer une nouvelle référence mémoire
        // Cela aide Angular à voir que la variable 'tasks' a changé
      //  this.tasks = [...data]; 
        
       // console.log('Données chargées avec succès :', this.tasks.length, 'tâches');
        
        // On force le rendu immédiat du HTML
     //   this.cdr.detectChanges();
   //   },
     // error: (err) => {
      //  console.error("Erreur de connexion à l'API .NET :", err);
    //  },
   // });
 // }
//}



import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  templateUrl: './app.html',
  styleUrls: ['./app.css']
})
export class AppComponent {
  title = 'SOROUBAT';
}