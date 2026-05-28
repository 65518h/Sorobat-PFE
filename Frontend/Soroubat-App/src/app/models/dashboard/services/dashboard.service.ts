// src/app/modules/dashboard/services/dashboard.service.ts

import { Injectable } from '@angular/core';
import { Observable, of, forkJoin } from 'rxjs';
import { map, catchError, timeout } from 'rxjs/operators';
import { ProjectService } from '../../projects/services/project';
import { JobTask } from '../../tasks/models/job-task.model';
import { StockService } from '../../inventory/services/stock';
import { VehiculePointageService } from '../../equipment/services/vehicule-pointage.service';

// ─── Interfaces exportées ────────────────────────────────────────────────────

export interface DashboardKpi {
  activeProjects:    number;
  totalProjects:     number;
  tasksInProgress:   number;
  tasksOverdue:      number;
  tasksCompleted:    number;
  tasksTotal:        number;
  criticalStockCount:number;
  activeEngines:     number;
  tasksBlocked:      number;
}

export interface ProjectProgress {
  name:     string;
  progress: number;
  status:   string;
}

export interface TaskStatusCount {
  name:  string;
  value: number;
}

export interface TaskDetail {
  taskNo:      string;
  description: string;
  progressPct: number;
  isBlocked:   boolean;
  jobNo?:      string;
}

export interface OverdueTask {
  jobNo:       string;
  taskNo:      string;
  description: string;
  progressPct: number;
}

export interface Alert {
  type:     'retard' | 'stock' | 'vehicle';
  message:  string;
  severity: 'warning' | 'danger' | 'info';
}

export interface DashboardData {
  kpi:              DashboardKpi;
  projectsProgress: ProjectProgress[];
  tasksByStatus:    TaskStatusCount[];
  tasksDetail:      TaskDetail[];
  overdueTasks:     OverdueTask[];
  alerts:           Alert[];
}

@Injectable({ providedIn: 'root' })
export class DashboardService {

  constructor(
    private projectService:          ProjectService,
    private stockService:            StockService,
    private vehiculePointageService: VehiculePointageService
  ) {}

  private normalizeStatus(status: string): string {
    const s = (status || '').toLowerCase().trim();
    if (s === 'en cours' || s === 'open') return 'En cours';
    if (s === 'terminé'  || s === 'completed' || s === 'totallement pris en charge') return 'Terminé';
    if (s === 'suspendu' || s === 'suspended') return 'Suspendu';
    return status || 'Open';
  }

  private calculateProjectProgress(tasks: JobTask[]): number {
    if (!tasks?.length) return 0;
    const total = tasks.reduce((sum, t) => sum + (t.progressPct || 0), 0);
    return Math.round(total / tasks.length);
  }

  private getEmptyData(): DashboardData {
    return {
      kpi: {
        activeProjects: 0, totalProjects: 0,
        tasksInProgress: 0, tasksOverdue: 0,
        tasksCompleted: 0, tasksTotal: 0,
        criticalStockCount: 0, activeEngines: 0,
        tasksBlocked: 0
      },
      projectsProgress: [],
      tasksByStatus: [],
      tasksDetail: [],
      overdueTasks: [],
      alerts: []
    };
  }

  getDashboardData(): Observable<DashboardData> {
    const DEFAULT_TIMEOUT = 15000;
    const STOCK_TIMEOUT = 10000;

    return forkJoin({
      projectData: this.projectService.getMyProjectWithTasks().pipe(
        timeout(DEFAULT_TIMEOUT),
        catchError(err => { 
          console.error(' Erreur projet:', err); 
          return of({ project: null, tasks: [] }); 
        })
      ),
      stockData: this.loadStockData().pipe(
        timeout(STOCK_TIMEOUT),
        catchError(() => of({ criticalStockCount: 0, totalItems: 0 }))
      )
    }).pipe(
      map(({ projectData, stockData }) => {
        const { project, tasks } = projectData;

        if (!project) {
          console.warn(' Aucun projet trouvé');
          return this.getEmptyData();
        }

        const allTasks = tasks || [];

        const tasksCompleted  = allTasks.filter(t => (t.progressPct || 0) >= 100).length;
        const tasksBlocked    = allTasks.filter(t => t.isBlocked).length;
        const tasksNotStarted = allTasks.filter(t => !t.isBlocked && (t.progressPct || 0) === 0).length;
        const tasksInProgress = allTasks.filter(t => {
          const p = t.progressPct || 0;
          return !t.isBlocked && p > 0 && p < 100;
        }).length;

        const isProjectActive = project.status === 'En cours' || project.status === 'Open';
        const projectProgress = this.calculateProjectProgress(allTasks);

        const kpi: DashboardKpi = {
          activeProjects:     isProjectActive ? 1 : 0,
          totalProjects:      1,
          tasksInProgress,
          tasksOverdue:       0,
          tasksCompleted,
          tasksTotal:         allTasks.length,
          criticalStockCount: stockData.criticalStockCount || 0,
          activeEngines:      0,  // Les engins actifs sont calculés dans le Dashboard
          tasksBlocked,
        };

        const projectsProgress: ProjectProgress[] = [{
          name:     project.no,
          progress: projectProgress,
          status:   this.normalizeStatus(project.status)
        }];

        const tasksByStatus: TaskStatusCount[] = [
          { name: 'En cours',      value: tasksInProgress },
          { name: 'Terminées',     value: tasksCompleted  },
          { name: 'Bloquées',      value: tasksBlocked    },
          { name: 'Non démarrées', value: tasksNotStarted },
        ].filter(s => s.value > 0);

        const tasksDetail: TaskDetail[] = allTasks.slice(0, 50).map(t => ({
          taskNo:      t.taskNo,
          description: (t.description || t.taskNo).substring(0, 100),
          progressPct: t.progressPct || 0,
          isBlocked:   t.isBlocked || false,
          jobNo:       t.jobNo
        }));

        const overdueTasks: OverdueTask[] = [];
        const alerts: Alert[] = [];

        if (isProjectActive && projectProgress < 20 && allTasks.length > 0) {
          alerts.push({
            type:     'retard',
            message:  `Avancement très faible (${projectProgress}%) — Projet ${project.no}`,
            severity: 'danger'
          });
        }

        if (stockData.criticalStockCount > 0) {
          alerts.push({
            type:     'stock',
            message:  `${stockData.criticalStockCount} article(s) en stock critique`,
            severity: 'warning'
          });
        }

        console.log(' Dashboard chargé rapidement:', {
          projet: project.no,
          tâches: allTasks.length,
          enCours: tasksInProgress,
          terminées: tasksCompleted
        });

        return { kpi, projectsProgress, tasksByStatus, tasksDetail, overdueTasks, alerts };
      }),
      catchError(err => {
        console.error(' Dashboard error:', err);
        return of(this.getEmptyData());
      })
    );
  }

  private loadStockData(): Observable<{ criticalStockCount: number; totalItems: number }> {
    return this.stockService.getAllStock().pipe(
      timeout(10000),
      map(stock => {
        const items = stock || [];
        const lowStockCount = items.filter(i => i.quantity > 0 && i.quantity <= 5).length;
        const outOfStockCount = items.filter(i => i.quantity <= 0).length;
        return { 
          criticalStockCount: lowStockCount + outOfStockCount, 
          totalItems: items.length 
        };
      }),
      catchError(() => of({ criticalStockCount: 0, totalItems: 0 }))
    );
  }

  refreshDashboard(): Observable<DashboardData> {
    return this.getDashboardData();
  }
}