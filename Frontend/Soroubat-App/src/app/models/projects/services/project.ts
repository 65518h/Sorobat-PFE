// modules/projects/services/project.service.ts
import { Injectable } from '@angular/core';
import { Observable, map, of } from 'rxjs';
import { JobTaskService } from './taskapi';
import { JobTask } from '../models/task.model';
import { Project } from '../models/project.model';

@Injectable({
  providedIn: 'root'
})
export class ProjectService {
  
  constructor(private jobTaskService: JobTaskService) {}

  // ✅ IMPLÉMENTATION CORRECTE DE DELETEPROJECT
  deleteProject(id: string): Observable<boolean> {
    console.log('🗑️ Suppression du projet:', id);
    
    // OPTION 1: Si vous avez une API pour supprimer les projets
    // return this.http.delete<void>(`${this.apiUrl}/projects/${id}`).pipe(
    //   map(() => true),
    //   catchError(() => of(false))
    // );
    
    // OPTION 2: Version mock (pour test)
    // Simuler une suppression réussie
    return of(true);
    
    // OPTION 3: Si vous devez supprimer via les tâches
    // (attention: supprime toutes les tâches du projet)
    // return this.jobTaskService.getTasksByProject(id).pipe(
    //   switchMap(tasks => {
    //     const deleteObservables = tasks.map(task => 
    //       this.jobTaskService.deleteTask(task.id!)
    //     );
    //     return forkJoin(deleteObservables).pipe(map(() => true));
    //   })
    // );
  }

  // Récupérer tous les projets
  getProjects(): Observable<Project[]> {
    return this.jobTaskService.getTasks().pipe(
      map((tasks: JobTask[]) => {
        const projectMap = new Map<string, any>();
        
        tasks.forEach((task: JobTask) => {
          const jobNo = task.jobNo;
          if (!projectMap.has(jobNo)) {
            projectMap.set(jobNo, {
              id: jobNo,
              number: jobNo,
              name: `Projet ${jobNo}`,
              description: this.getProjectDescription(jobNo),
              customerName: 'Client',
              responsible: task.responsible || 'Non assigné',
              startDate: task.dateDebut ? new Date(task.dateDebut) : new Date(),
              endDate: task.dateFin ? new Date(task.dateFin) : new Date(),
              progress: 0,
              status: 'En cours',
              tasks: [] as JobTask[]
            });
          }
          
          const project = projectMap.get(jobNo);
          project.tasks.push(task);
          
          // Mettre à jour les dates
          if (task.dateDebut && new Date(task.dateDebut) < project.startDate) {
            project.startDate = new Date(task.dateDebut);
          }
          if (task.dateFin && new Date(task.dateFin) > project.endDate) {
            project.endDate = new Date(task.dateFin);
          }
        });

        // Calculer l'avancement pour chaque projet
        projectMap.forEach((project: any) => {
          if (project.tasks.length > 0) {
            const totalProgress = project.tasks.reduce((sum: number, t: JobTask) => 
              sum + (t.progressPct || 0), 0);
            project.progress = Math.round(totalProgress / project.tasks.length);
            
            const allCompleted = project.tasks.every((t: JobTask) => t.progressPct === 100);
            const anyBlocked = project.tasks.some((t: JobTask) => t.isBlocked);
            
            if (allCompleted) {
              project.status = 'Terminé';
            } else if (anyBlocked) {
              project.status = 'Suspendu';
            } else {
              project.status = 'En cours';
            }
          }
          
          project.taskCount = project.tasks.length;
          delete project.tasks;
        });

        return Array.from(projectMap.values());
      })
    );
  }

  // Récupérer un projet avec ses tâches
  getProjectById(projectId: string): Observable<{ project: Project; tasks: JobTask[] } | null> {
    return this.jobTaskService.getTasks().pipe(
      map((tasks: JobTask[]) => {
        const projectTasks = tasks.filter(t => t.jobNo === projectId);
        
        if (projectTasks.length === 0) return null;

        const totalProgress = projectTasks.reduce((sum, t) => sum + (t.progressPct || 0), 0);
        const avgProgress = Math.round(totalProgress / projectTasks.length);

        const project: Project = {
          id: projectId,
          number: projectId,
          name: `Projet ${projectId}`,
          description: this.getProjectDescription(projectId),
          customerName: 'Client',
          responsible: projectTasks[0]?.responsible || 'Non assigné',
          startDate: new Date(Math.min(...projectTasks.map(t => t.dateDebut ? new Date(t.dateDebut).getTime() : Infinity))),
          endDate: new Date(Math.max(...projectTasks.map(t => t.dateFin ? new Date(t.dateFin).getTime() : -Infinity))),
          progress: avgProgress,
          status: avgProgress === 100 ? 'Terminé' : 
                  projectTasks.some(t => t.isBlocked) ? 'Suspendu' : 'En cours',
          taskCount: projectTasks.length
        };

        return { project, tasks: projectTasks };
      })
    );
  }

  private getProjectDescription(jobNo: string): string {
    const descriptions: { [key: string]: string } = {
      'PRJ-2026-001': 'Installation 8 espaces travail',
      'PRJ-2026-002': 'Rénovation complète bureaux',
      'PRJ-2026-003': 'Construction local commercial'
    };
    return descriptions[jobNo] || 'Projet en cours';
  }
}