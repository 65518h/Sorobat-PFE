// src/app/modules/dashboard/services/dashboard.service.ts

import { Injectable } from '@angular/core';
import { Observable, forkJoin, of } from 'rxjs';
import { map, catchError, timeout, switchMap } from 'rxjs/operators';
import { ProjectService } from '../../projects/services/project';
import { JobTaskService } from '../../projects/services/job-task.service';
import { JobTask } from '../../projects/models/job-task.model';

export interface DashboardKpi {
  activeProjects: number;
  totalProjects: number;
  tasksInProgress: number;
  tasksOverdue: number;
  tasksCompleted: number;
  tasksTotal: number;
  criticalStockCount: number;
  activeEngines: number;
}

export interface ProjectProgress {
  name: string;
  progress: number;
  status: string;
}

export interface TaskStatusCount {
  name: string;
  value: number;
}

export interface BudgetData {
  projectName: string;
  budgetPrevu: number;
  budgetReel: number;
  progressPct: number;
}

export interface OverdueTask {
  jobNo: string;
  taskNo: string;
  description: string;
  dateFin: string | null;
  progressPct: number;
}

export interface Alert {
  type: 'retard' | 'budget' | 'stock';
  message: string;
  severity: 'warning' | 'danger';
}

export interface DashboardData {
  kpi: DashboardKpi;
  projectsProgress: ProjectProgress[];
  tasksByStatus: TaskStatusCount[];
  budgetData: BudgetData[];
  overdueTasks: OverdueTask[];
  alerts: Alert[];
}

@Injectable({ providedIn: 'root' })
export class DashboardService {

  private readonly ACTIVE_STATUSES    = ['open', 'en cours'];
  private readonly COMPLETED_STATUSES = ['terminé', 'completed'];
  private readonly SUSPENDED_STATUSES = ['suspendu', 'suspended'];

  constructor(
    private projectService: ProjectService,
    private jobTaskService: JobTaskService
  ) {}

  // ── Helpers statut ─────────────────────────────────────────────
  private normalizeStatus(status: string): string {
    const s = (status || '').toLowerCase().trim();
    if (this.ACTIVE_STATUSES.includes(s))    return 'En cours';
    if (this.COMPLETED_STATUSES.includes(s)) return 'Terminé';
    if (this.SUSPENDED_STATUSES.includes(s)) return 'Suspendu';
    return status;
  }

  private isActive(s: string):    boolean { return this.ACTIVE_STATUSES.includes((s||'').toLowerCase().trim()); }
  private isCompleted(s: string): boolean { return this.COMPLETED_STATUSES.includes((s||'').toLowerCase().trim()); }
  private isSuspended(s: string): boolean { return this.SUSPENDED_STATUSES.includes((s||'').toLowerCase().trim()); }

  // ── ✅ Détecte les dates invalides BC (0001-01-01T00:00:00) ────
  // BC envoie cette valeur quand aucune date n'est saisie → on l'ignore
  private isValidDate(date: string | null | undefined): boolean {
    if (!date) return false;
    const d = new Date(date);
    return !isNaN(d.getTime()) && d.getFullYear() >= 2000;
  }

  // ── ✅ Calcul budget réel depuis les montants BC ───────────────
  /**
   * Budget prévu = Σ initialAmount  (tâches avec montant > 0 uniquement)
   * Budget réel  = Σ (initialAmount × progressPct / 100)
   *
   * Exemple DESCHAMPS :
   *   1000 : 26.65 × 100% = 26.65 €
   *   1100 : 30    × 45%  = 13.50 €
   *   1110 : 616   × 54%  = 332.64 €
   *   1120 : 69    × 100% = 69.00 €
   *   ──────────────────────────────
   *   Prévu : 741.65 €  |  Réel : 441.79 €  |  59% consommé
   */
  private calculateBudget(tasks: JobTask[]): { budgetPrevu: number; budgetReel: number; progressPct: number } {
    const tasksWithBudget = tasks.filter(t => (t.initialAmount || 0) > 0);

    if (tasksWithBudget.length === 0) {
      return { budgetPrevu: 0, budgetReel: 0, progressPct: 0 };
    }

    const budgetPrevu = tasksWithBudget.reduce((sum, t) => sum + (t.initialAmount || 0), 0);
    const budgetReel  = tasksWithBudget.reduce(
      (sum, t) => sum + (t.initialAmount || 0) * ((t.progressPct || 0) / 100), 0
    );
    const progressPct = budgetPrevu > 0 ? Math.round((budgetReel / budgetPrevu) * 100) : 0;

    return {
      budgetPrevu: Math.round(budgetPrevu * 100) / 100,
      budgetReel:  Math.round(budgetReel  * 100) / 100,
      progressPct
    };
  }

  // ── ✅ Vérifie si une tâche est vraiment en retard ─────────────
  // Ignore les dates BC invalides (0001-01-01)
  private isTaskOverdue(task: JobTask): boolean {
    if (task.isBlocked)              return false;
    if ((task.progressPct || 0) >= 100) return false;
    if (!this.isValidDate(task.dateFin)) return false;  // ← date BC invalide ignorée
    return new Date(task.dateFin!) < new Date();
  }

  // ── Fallback vide ──────────────────────────────────────────────
  private getEmptyData(): DashboardData {
    return {
      kpi: {
        activeProjects: 0, totalProjects: 0,
        tasksInProgress: 0, tasksOverdue: 0,
        tasksCompleted: 0, tasksTotal: 0,
        criticalStockCount: 0, activeEngines: 0
      },
      projectsProgress: [],
      tasksByStatus:    [],
      budgetData:       [],   // ✅ toujours un tableau
      overdueTasks:     [],
      alerts:           []
    };
  }

  // ── Chargement principal ───────────────────────────────────────
  getDashboardData(): Observable<DashboardData> {

    return this.projectService.getProjects().pipe(
      timeout(5000),
      catchError(err => { console.error('❌ Projects:', err); return of([]); }),

      switchMap(projects => {
        if (!projects || projects.length === 0) return of(this.getEmptyData());

        const taskRequests = projects.map((p: any) =>
          this.jobTaskService.getTasksByProject(p.no).pipe(
            catchError(() => of([] as JobTask[]))
          )
        );

        return forkJoin(taskRequests).pipe(
          map((allTasksArrays: JobTask[][]) => {

            // ── Compteurs projets ────────────────────────────────
            const activeProjects    = projects.filter((p: any) => this.isActive(p.status)).length;
            const completedProjects = projects.filter((p: any) => this.isCompleted(p.status)).length;
            const suspendedProjects = projects.filter((p: any) => this.isSuspended(p.status)).length;

            // ── Compteurs tâches ─────────────────────────────────
            const allTasks       = allTasksArrays.flat();
            const totalTasks     = allTasks.length;
            const tasksInProgress = allTasks.filter(t => (t.progressPct||0) > 0 && (t.progressPct||0) < 100).length;
            const tasksCompleted  = allTasks.filter(t => (t.progressPct||0) === 100).length;

            // ✅ Retard : ignore les dates BC invalides (0001-01-01)
            const tasksOverdue = allTasks.filter(t => this.isTaskOverdue(t)).length;

            // ── KPI ──────────────────────────────────────────────
            const kpi: DashboardKpi = {
              activeProjects,
              totalProjects:      projects.length,
              tasksInProgress,
              tasksOverdue,       // 0 si toutes les dates sont 0001-01-01
              tasksCompleted,
              tasksTotal:         totalTasks,
              criticalStockCount: 0,
              activeEngines:      0
            };

            // ── Bar chart ────────────────────────────────────────
            const projectsProgress: ProjectProgress[] = projects.map((p: any) => ({
              name:     p.no,
              progress: p.progress || 0,
              status:   this.normalizeStatus(p.status)
            }));

            // ── Donut ────────────────────────────────────────────
            const tasksByStatus: TaskStatusCount[] = [
              { name: 'En cours',  value: tasksInProgress },
              { name: 'Terminées', value: tasksCompleted  },
              { name: 'Bloquées',  value: allTasks.filter(t => t.isBlocked).length }
            ];

            // ── 💰 Budget réel depuis les montants BC ─────────────
            const budgetData: BudgetData[] = projects.map((p: any, i: number) => {
              const budget = this.calculateBudget(allTasksArrays[i] || []);
              console.log(`💰 Budget ${p.no}:`, {
                prévu: budget.budgetPrevu + ' €',
                réel:  budget.budgetReel  + ' €',
                pct:   budget.progressPct + '%'
              });
              return { projectName: p.no, ...budget };
            });

            // ── Tâches en retard (top 5) ─────────────────────────
            // ✅ Filtre les dates BC invalides
            const overdueTasks: OverdueTask[] = allTasks
              .filter(t => this.isTaskOverdue(t))
              .slice(0, 5)
              .map(t => ({
                jobNo:       t.jobNo,
                taskNo:      t.taskNo,
                description: t.description,
                dateFin:     this.isValidDate(t.dateFin) ? t.dateFin || null : null,
                progressPct: t.progressPct
              }));

            // ── Alertes ───────────────────────────────────────────
            const alerts: Alert[] = [];

            projects.forEach((p: any) => {
              if (this.isActive(p.status) && (p.progress || 0) < 30) {
                alerts.push({
                  type:     'retard',
                  message:  `Projet ${p.no} — avancement faible (${p.progress || 0}%)`,
                  severity: 'warning'
                });
              }
            });

            budgetData.forEach(b => {
              if (b.budgetPrevu > 0 && b.progressPct > 100) {
                alerts.push({
                  type:     'budget',
                  message:  `Projet ${b.projectName} — budget dépassé (${b.progressPct}%)`,
                  severity: 'danger'
                });
              }
            });

            console.log('✅ Dashboard OK:', {
              projets: projects.length, actifs: activeProjects,
              tâches: totalTasks, enCours: tasksInProgress,
              enRetard: tasksOverdue, budget: budgetData.length
            });

            return { kpi, projectsProgress, tasksByStatus, budgetData, overdueTasks, alerts };
          })
        );
      }),

      catchError(err => {
        console.error('🔥 Dashboard error:', err);
        return of(this.getEmptyData());
      })
    );
  }
}